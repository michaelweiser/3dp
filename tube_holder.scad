$fn = 32;

use <isosceles_trapezoid.scad>;

function tube_holder_outer_length(tube_diameter) = tube_diameter;

// derive bevel width from thickness so that actual bevel thickness equals
// thickness
function tube_holder_outer_height(tube_diameter, clip_factor) =
	tube_diameter/2 * (1 + clip_factor);

// allow users to query the base width of the holder so they know what room
// they must make for attaching it somewhere
function tube_holder_base_length(tube_diameter, angle, clip_factor) =
	let(bevel_width = tube_holder_outer_height(tube_diameter, clip_factor) / tan(angle))
	tube_holder_outer_length(tube_diameter) + 2*bevel_width;

module tube_holder(holder_width = 5, tube_diameter = 6, clip_factor = 0.3,
		thickness = 1.5, angle = 45) {
	outer_height = tube_holder_outer_height(tube_diameter, clip_factor);

	// move to a zero line in y direction and otherwise in center
	// so we can put it on top of other stuff
	translate([0, tube_diameter/2, -holder_width/2])
		linear_extrude(holder_width)
			difference() {
				// beveled for more technical look and better
				// overhang printing
				translate([0, -tube_diameter/2 + outer_height/2, 0])
					isosceles_trapezoid(d = tube_holder_outer_length(tube_diameter),
						h = outer_height, angle = angle);
				circle(d = tube_diameter);
			}
}

tube_holder();
