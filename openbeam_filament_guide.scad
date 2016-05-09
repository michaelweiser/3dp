$fn = 32;
use <openbeam_clip.scad>;
use <filament_guide.scad>;

module openbeam_tube_clip(beam_width = 15,
		pushfit_hole_diameter = 4.6,
		filament_diameter = 1.75,
		filament_play_factor = 1.1,
		thickness = 1.5,
		epsilon = 0.25) {
	union() {
		height = filament_guide_width(pushfit_hole_diameter, filament_diameter,
			filament_play_factor, epsilon, thickness);
		openbeam_clip(beam_width = beam_width,
			height = height,
			thickness = thickness,
			epsilon = 0.25);

		translate([0, filament_guide_width(height)/2, 0])
			rotate([0, 90, 0])
			filament_guide(width = height,
				length = beam_width,
				epsilon = epsilon);
	}
}

openbeam_tube_clip();
