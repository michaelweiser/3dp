use <isosceles_trapezoid.scad>;

// derive bevel width from thickness so that actual bevel thickness equals
// thickness
function tie_clip_holder_outer_length(clip_width, angle, thickness) =
	let(bevel_width = sin(angle)*thickness)
	clip_width + 2*bevel_width;

function tie_clip_holder_outer_height(clip_height, thickness) =
	clip_height + thickness;

// allow users to query the base width of the holder so they know what room
// they must make for attaching it somewhere
function tie_clip_holder_base_length(clip_width, clip_height, angle, thickness) =
	let(bevel_width = tie_clip_holder_outer_height(clip_height, thickness)/tan(angle))
	tie_clip_holder_outer_length(clip_width, angle, thickness) + 2*bevel_width;

module tie_clip_holder(holder_width = 5,
		clip_width = 5, clip_height = 2, thickness = 1.5, angle = 45) {
	outer_height = tie_clip_holder_outer_height(clip_height, thickness);

	// move to a zero line in y direction and otherwise in center
	// so we can put it on top of other stuff
	translate([0, outer_height/2, -holder_width/2])
		linear_extrude(holder_width)
			difference() {
				outer_length = tie_clip_holder_outer_length(clip_width,
					angle, thickness);

				// beveled for more technical look and better
				// overhang printing
				isosceles_trapezoid(d = outer_length, h = outer_height,
					angle = angle);
				translate([0, -thickness/2, 0])
					isosceles_trapezoid(d = clip_width,
						h = clip_height, angle = angle);

			}
}

tie_clip_holder();
