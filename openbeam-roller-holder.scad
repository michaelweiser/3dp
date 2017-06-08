$fn = 16;

openbeam_width = 15;
width = 10;
height = 30;
thickness = 2;
axle_dia = 8;
bearing_width = 7;
clip_dia = 5;
clip_height = 2;
screw_dia = 3+0.2;
bearing_spacer_height = 0.4;

module bracket1_bearing_arm() {
	difference() {
		union() {
			translate([0, 0, -thickness/2])
				union() {
					cube([width, height, thickness], center = true);
					translate([0, -height/2, 0])
						cylinder(d = width, h = thickness, center = true);
				}

			translate([0, -height/2, 0]) {
				cylinder(d = axle_dia*1.1, h = bearing_spacer_height);
				translate([0, 0, bearing_spacer_height])
					cylinder(d = axle_dia, h = bearing_width/2);
			}
		}

		// screw hole through clip
		translate([0, -height/2, -thickness - 0.5])
			cylinder(d = screw_dia, h = thickness + bearing_spacer_height + bearing_width/2 + 1);
	}
}

module bracket1_openbeam_socket() {
	difference() {
		cube([width, openbeam_width, bearing_width+thickness+2*bearing_spacer_height],
			center = true);

		// clip
		translate([0, 0, bearing_width/2 + thickness/2 + bearing_spacer_height - clip_height/2])
			cylinder(d = clip_dia, h = clip_height+0.4, center = true);

		// screw hole
		translate([0, 0, bearing_spacer_height])
			rotate([0, 90, 0])
				cylinder(d = screw_dia, h = width + 2, center = true);
	}
}

module bracket1() {
	union() {
		translate([0, -height/2, 0])
			bracket1_bearing_arm();
		translate([0, openbeam_width/2, bearing_width/2-thickness/2+bearing_spacer_height])
			bracket1_openbeam_socket();
	}
}

module bracket2_bearing_arm() {
	difference() {
		union() {
			translate([0, 0, -thickness/2])
				union() {
					cube([width, height, thickness], center = true);
					translate([0, -height/2, 0])
						cylinder(d = width, h = thickness, center = true);
				}

			translate([0, -height/2, 0]) {
				cylinder(d = axle_dia*1.1, h = bearing_spacer_height);
				translate([0, 0, bearing_spacer_height])
					cylinder(d = axle_dia, h = bearing_width/2);
			}
		}

		// screw hole through clip
		translate([0, -height/2, -thickness - 0.5])
			cylinder(d = screw_dia, h = thickness + bearing_spacer_height + bearing_width/2 + 1);
	}
}

module bracket2_openbeam_socket() {
	union() {
		cube([width, openbeam_width, thickness], center = true);
		// clip
		translate([0, 0, thickness/2])
			cylinder(d = clip_dia - 0.2, h = clip_height);

		translate([openbeam_width/2, openbeam_width/2 + thickness/2, bearing_width/2 + bearing_spacer_height])
			rotate([90, 0, 0])
				difference() {
					cube([width + openbeam_width, bearing_width + thickness + bearing_spacer_height*2, thickness], center = true);
					translate([width/2, 0, 0])
						cylinder(d = screw_dia, h = thickness+1, center = true);
				}
	}
}

module bracket2() {
	union() {
		translate([0, -height/2, 0])
			bracket2_bearing_arm();
		translate([0, openbeam_width/2, -thickness/2])
			bracket2_openbeam_socket();
	}
}

translate([-width/2 - 4, 0, 0])
	bracket1();

translate([width/2 + 4, 0, 0])
	bracket2();
