use <openbeam_clip.scad>;
use <filament_guide.scad>;

module openbeam_tube_clip(beam_width = 15,
		pushfit_hole_diameter = 4.6,
		filament_diameter = 1.75,
		filament_play_factor = 1.2,
		guide_slant = 15,
		thickness = 1.5,
		epsilon = 0.25) {
	union() {
		height = filament_guide_width(pushfit_hole_diameter, filament_diameter,
			filament_play_factor, epsilon, thickness);
		openbeam_clip(beam_width = beam_width,
			height = height,
			thickness = thickness,
			epsilon = 0.25);

		guide_displacement = sin(guide_slant) * beam_width/2 + thickness;
		translate([0, guide_displacement, 0])
			rotate([0, 90, guide_slant])
			filament_guide(width = height,
				length = beam_width,
				epsilon = epsilon);
		hull() {
			translate([0, guide_displacement, 0])
				rotate([0, 0, guide_slant])
					cube([beam_width, 0.01, height], center = true);
			translate([0, -thickness, 0])
				cube([beam_width, 0.01, height], center = true);
		}
	}
}

openbeam_tube_clip();
