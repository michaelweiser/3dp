$fn = 32;
use <openbeam_clip.scad>;
use <tube_holder.scad>;

module openbeam_tube_clip(beam_width = 15, height = 5,
		tube_diameter = 6, clip_factor = 0.6,
		tube_holder_angle = 45,
		thickness = 1.5, epsilon = 0.25) {
	union() {
		openbeam_clip(beam_width = beam_width,
			height = tube_holder_base_length(
				tube_diameter = tube_diameter,
				angle = tube_holder_angle,
				clip_factor = clip_factor),
			thickness = thickness,
			epsilon = 0.25);

		rotate([0, 90, 0])
			tube_holder(tube_diameter = tube_diameter,
				clip_factor = clip_factor,
				holder_width = height,
				angle = tube_holder_angle,
				thickness = thickness);
	}
}

openbeam_tube_clip();
