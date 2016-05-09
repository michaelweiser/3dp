// based on: https://github.com/jcrocholl/kossel/blob/master/extruder.scad

function filament_guide_pushfit_hole_diameter(pushfit_hole_diameter, epsilon) =
	pushfit_hole_diameter + 2*epsilon;

function filament_guide_path_diameter(filament_diameter,
		filament_play_factor, epsilon) =
	filament_diameter * filament_play_factor + 2*epsilon;

function filament_guide_width(pushfit_hole_diameter, filament_diameter,
		filament_play_factor, epsilon, thickness) =
	let(fpd = filament_guide_path_diameter(filament_diameter,
		filament_play_factor, epsilon))
	let(phd = filament_guide_pushfit_hole_diameter(pushfit_hole_diameter,
		epsilon))
	max(fpd, phd) + 2*thickness;

module filament_guide(length = 10,
		filament_diameter = 1.75,
		filament_play_factor = 1.1,
		pushfit_hole_diameter = 4.6,
		thickness = 1.5,
		epsilon = 0.25) {
	width = filament_guide_width(pushfit_hole_diameter, filament_diameter,
		filament_play_factor, epsilon, thickness);

	// put on zero-line on y axis for attaching to things
	translate([0, width/2, 0])
		difference() {
			//pushfit/pneufit mount
			cube([width, width, length], center=true, $fn=8);

			//filament path chamfer
			translate([0, 0, length/2 - 1]) #
				cylinder(h = 3, r1 = 0.5, r2 = 3,
				center = true, $fn = 12);

			//filament path
			#cylinder(h = length + 1,
				d = filament_guide_path_diameter(filament_diameter,
					filament_play_factor, epsilon),
				center = true, $fn=12);

			//pushfit/pneufit mount
			translate([0, 0, -length/2 + 2]) #
				cylinder(d = filament_guide_pushfit_hole_diameter(pushfit_hole_diameter,
						epsilon),
					h = 5, center = true, $fn=12);
		}
}

filament_guide();
