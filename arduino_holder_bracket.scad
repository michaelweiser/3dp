cutting_epsilon = 0.05;

module arduino_holder_bracket(beam_width = 15,
		hole_diameter = 3,
		nut_width = 5.5,
		nut_height = 2.5,
		nut_cradle = true,
		thickness = 1.5,
		epsilon = 0.1) {
	rotate([90, 0, 0])
		union() {
			bracket_height = 2.75*beam_width;
			chd = hole_diameter + 2*epsilon;
			translate([0, beam_width/2, 0])
				difference() {
					cube([thickness, beam_width + thickness, beam_width],
						center = true);

					translate([0, thickness/2, 0])
						rotate([0, 90, 0])
							cylinder(d = chd, h = thickness + cutting_epsilon,
								center = true,
								$fn = 32);
				}

			cnw = nut_width + 2*epsilon;
			mounting_hole_offset = thickness/2 + 0.125*beam_width;
			translate([bracket_height/2, 0, 0])
				difference() {
					union() {
						cube([bracket_height + thickness, thickness, beam_width],
							center = true);
						if (nut_cradle)
							rotate([90, 0, 0])
								translate([mounting_hole_offset, 0, -nut_height/2 - thickness/2])
									difference() {
										hull()
											for (f = [-1, 1, 2])
												translate([f, 0, 0])
													cylinder(d = nut_width + 2*thickness, h = nut_height,
														center = true, $fn = 6);
										hull()
											for (f = [-1, 1, 2])
												translate([f, 0, 0])
													cylinder(d = nut_width, h = nut_height + cutting_epsilon,
														center = true, $fn = 6);
								}
					}

					translate([mounting_hole_offset, 0, 0])
						rotate([90, 0, 0])
							hull()
								for (f = [-1, 1, 2])
									translate([f, 0, 0])
										cylinder(d = chd, h = thickness + cutting_epsilon,
											center = true,
											$fn = 32);
				}
		}
}

arduino_holder_bracket();
