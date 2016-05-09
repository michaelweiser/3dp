$fn = 32;

cutting_epsilon = 0.01;

module cutout_rounding_cutter(rounding = 5, height = 10) {
	difference() {
		// take a cylinder out of a cube to get a cutter that can cut
		// bevels
		cube([rounding, rounding, height], center = true);
		translate([-rounding/2, -rounding/2, 0])
			cylinder(d = rounding, h = height + 2*cutting_epsilon, center = true);
	}
}

module shaft_cutout_cutter(width, diameter, slot_height = 0,
		rounding = 0, rounding_height = 0) {
	// cutout for shaft
	hull() {
		cylinder(h = width, d = diameter, center = true);
		if (slot_height > 0) {
			translate([0, slot_height, 0])
				cube([diameter, 1, width], center = true);
		}
	}

	// round the cutout for the shaft
	if (slot_height > 0 && rounding > 0) {
		rounding_height = rounding_height == -1 ? slot_height : rounding_height;
		translate([0, rounding_height, 0]) {
			translate([-rounding/2, 0, 0])
				cutout_rounding_cutter(rounding, width);
			translate([rounding/2, 0, 0])
				mirror([1, 0, 0])
					cutout_rounding_cutter(rounding, width);
		}
	}
}

module bearing_holder(outer_diameter = 22, width = 7, thickness = 2,
		clip_cutting_factor = 0.1, shaft_diameter = 8,
		bottom_shaft_hole = true, top_shaft_hole = true,
		bottom_shaft_slot = true, top_shaft_slot = true,
		shaft_slots_rounded = true,
		epsilon = 0.25) {
	cw = width + 2*epsilon;
	cod = outer_diameter + 2*epsilon;
	csd = shaft_diameter + 2*epsilon;

	diameter_overall = cod + 2*thickness;
	width_overall = cw + 2*thickness;
	clip_cutting_pos = cod * clip_cutting_factor;
	difference() {
		// flow holder and socket into each other
		hull() {
			// outer casing for holding the bearing
			cylinder(h = width_overall, d = diameter_overall, center = true);

			// socket that is one thickness thick and overall
			// diameter and it's own thickness below the holder
			translate([0, -diameter_overall/2 - thickness/2, 0])
				cube([diameter_overall, thickness, width_overall], center = true);
		}

		// cutout the size of the actual bearing
		#cylinder(h = cw, d = cod, center = true);

		// cutout so that bearing can be clipped into holder
		clip_cutter_height = diameter_overall / 2;
		translate([0, clip_cutter_height / 2 + clip_cutting_pos, 0])
			cube([diameter_overall, clip_cutter_height, cw],
				center = true);

		shaft_slot_height = diameter_overall/2;
		shaft_slot_rounding = shaft_slots_rounded ? csd : 0;
		shaft_slot_rounding_height = cod/2;
		if (bottom_shaft_hole) {
			bottom_shaft_slot_height = bottom_shaft_slot ? shaft_slot_height : 0;
			translate([0, 0, -width_overall/2 + thickness/2])
				shaft_cutout_cutter(width = thickness + 2*cutting_epsilon,
					diameter = csd,
					slot_height = bottom_shaft_slot_height,
					rounding = shaft_slot_rounding,
					rounding_height = shaft_slot_rounding_height);
		}

		if (top_shaft_hole) {
			top_shaft_slot_height = top_shaft_slot ? shaft_slot_height : 0;
			translate([0, 0, width_overall/2 - thickness/2])
				shaft_cutout_cutter(width = thickness + 2*cutting_epsilon,
					diameter = csd,
					rounding = shaft_slot_rounding,
					slot_height = top_shaft_slot_height,
					rounding = shaft_slot_rounding,
					rounding_height = shaft_slot_rounding_height);
		}
	}
}

bearing_holder();
