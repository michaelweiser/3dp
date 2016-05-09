$fn = 32;
use <openbeam_clip.scad>;
use <tie_clip_holder.scad>;

module openbeam_tie_clip_clip(beam_width = 15, height = 5,
		tie_clip_width = 5, tie_clip_height = 2,
		tie_clip_holder_angle = 45,
		thickness = 1.5, epsilon = 0.25) {
	union() {
		openbeam_clip(beam_width = beam_width,
			height = tie_clip_holder_base_length(
				clip_width = tie_clip_width,
				clip_height = tie_clip_height,
				angle = tie_clip_holder_angle,
				thickness = thickness),
			thickness = thickness,
			epsilon = 0.25);

		rotate([0, 90, 0])
			tie_clip_holder(clip_width = tie_clip_width,
				clip_height = tie_clip_height,
				holder_width = height,
				thickness = thickness,
				angle = tie_clip_holder_angle);
	}
}

openbeam_tie_clip_clip();
