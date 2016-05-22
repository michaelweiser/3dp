use <rounded_rectangle.scad>;

function openbeam_clip_outer_width(beam_width, thickness) =
	beam_width + 2*thickness;

module openbeam_clip_cross(beam_width, rounding, thickness) {
	difference() {
		outer_width = openbeam_clip_outer_width(beam_width = beam_width,
			thickness = thickness);

		// since clip is open at the bottom, remove one thickness and
		// move down by half of that to be back in center
		translate([0, thickness/2, 0])
			rounded_rectangle(width = outer_width,
				height = outer_width - thickness,
				rounding = rounding + thickness);

		// make inner rectangle higher than outer by one thickness
		// (to be on the safe side) and shift down by
		// half of that to be centered with the outer again
		translate([0, -thickness/2, 0])
			rounded_rectangle(width = beam_width,
				height = beam_width + thickness,
				rounding = rounding);
	}
}

module openbeam_clip_stay(slot_width = 3.2, protrusion = 0.75) {
	square([slot_width, protrusion], center = true);
}

module openbeam_clip(beam_width = 15, height = 15,
		beam_slot_width = 3.2, stay_protrusion = 1,
		rounding = 1, thickness = 1.5,
		epsilon = 0.25) {
	cbw = beam_width + 2*epsilon;
	outer_width = openbeam_clip_outer_width(beam_width = cbw, thickness = thickness);

	// move back into center after extrude but put top onto y as base-line
	// for attaching things to it
	translate([0, -outer_width/2, -height/2])
		linear_extrude(height)
			union() {
				openbeam_clip_cross(beam_width = cbw,
					rounding = rounding,
					thickness = thickness);

				// add in the stays
				stay_position = cbw/2 - stay_protrusion/2;
				cbsw = beam_slot_width - 2*epsilon;
				for (stay_angle =[-90:90:90])
					rotate([0, 0, stay_angle])
						translate([0, stay_position, 0])
						openbeam_clip_stay(slot_width = cbsw,
							protrusion = stay_protrusion);
			}
}

openbeam_clip();
