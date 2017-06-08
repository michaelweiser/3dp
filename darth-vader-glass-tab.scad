$fn = 32;

width = 20;
openbeam_width = 15;
screw_dia = 3;
screw_head_dia = 5.5;
screw_delta = 0.1;
thickness = 3;
play = 1;

cutter_delta = 0.01;

module openbeams() {
	translate([0, 0, -openbeam_width])
		#cube([100, openbeam_width, openbeam_width], center=true);
	translate([0, 0, openbeam_width])
		#cube([100, openbeam_width, openbeam_width], center=true);
}

%openbeams();

module hinge() {
	difference() {
		// blank
		cube([width + 2*thickness, 2*screw_dia + play, openbeam_width + thickness + play], center = true);

		// drill holes
		for (a = [-1:2:1])
			translate([a*(width/2 - screw_dia), 0, -thickness/2 - play/2]) {
				rotate([90, 0, 0])
					cylinder(d = screw_dia + 2*screw_delta,
						h = 2*(screw_dia + thickness + cutter_delta), center = true);
				translate([0, thickness/2, 0])
					rotate([90, 0, 0])
						cylinder(d = screw_head_dia + 2*screw_delta,
							h = 2*(screw_dia + cutter_delta), center = true);
			}
		translate([0, play/2, openbeam_width/2 + thickness/2 + play/2 - screw_dia])
			rotate([0, 90, 0])
				cylinder(d = screw_dia + 2*screw_delta,
					h = width + 2*thickness + cutter_delta, center = true);

		// cut down to size
		translate([0, 0, openbeam_width/2 + thickness - screw_dia - thickness/2])
			cube([width,
				2*screw_dia + cutter_delta + play,
				2*screw_dia + cutter_delta + play], center = true);
		translate([0, thickness/2, -1.5*thickness - play/2])
			cube([width + 2*thickness + cutter_delta,
				2*screw_dia + cutter_delta,
				openbeam_width - 2*screw_dia + cutter_delta], center = true);
	}
}

translate([0, openbeam_width/2 + play/2 + screw_dia, openbeam_width + thickness/2 + play/2])
	hinge();

//rotate([90, 0, 0]) hinge();

module bracket() {
	difference() {
		union() {
			difference() {
				cube([width,
					openbeam_width + thickness + 2*play + 2*screw_dia,
					3*openbeam_width + thickness + play - 1], center = true);
				translate([0, thickness/2, -thickness/2])
					cube([width + cutter_delta,
						openbeam_width + 2*play + 2*screw_dia + cutter_delta,
						3*openbeam_width + play - 1 + cutter_delta], center = true);
			}
			translate([0, openbeam_width/2 + thickness/2 + play,
					1.5*openbeam_width + play/2 + thickness/2 - screw_dia - 0.5])
				cube([width, 2*screw_dia, 2*screw_dia], center = true);
		}

		translate([0, openbeam_width/2 + thickness/2 + play,
				1.5*openbeam_width + play/2 + thickness/2 - screw_dia - 0.5])
			rotate([0, 90, 0])
				cylinder(d = screw_dia + 2*screw_delta, h = width + 2*thickness + cutter_delta, center = true);
	}
}

translate([0, -thickness/2 + screw_dia, play/2 + thickness/2 + 0.5])
	bracket();

//rotate([90, 90, 0]) bracket();
