$fn = 32;

module spool(d = 200, h = 5) {
	cylinder(d = d, h = h, center = true);
}

module b608(d = 22, width = 7, id = 8) {
	difference() {
		cylinder(d = d, h = width, center = true);
		cylinder(d = id, h = width+0.1, center = true);
	}
}

module half(dist = 100, bd = 22, bid = 8, bw = 7, thick = 2, spool_dia = 200) {
	spool_round = spool_dia - 2*thick;
	edge_round = bd + 2*thick;

	length = dist + bd + 2*thick;
	height = bd + 3*thick;
	width = thick + bw/2;
	difference() {
		translate([0, -thick/2, 0])
			cube([length, height, width], center = true);

		// cut off roundings
		translate([0, spool_dia/2, 0])
			cylinder(d = spool_round, h = height + 0.1, center = true);
		erc = edge_round/2 + 0.1;
		translate([-length/2 + erc/2, erc/2, 0])
			rotate([0, 0, 90])
				difference() {
					cube([erc + 0.1, erc + 0.1, width + 0.1], center = true);
					translate([-erc/2, -erc/2, 0])
						cylinder(d = edge_round, h = width + 0.2, center = true);
				}
		translate([length/2 - erc/2, erc/2, 0])
			difference() {
				cube([erc + 0.1, erc + 0.1, width + 0.1], center = true);
				translate([-erc/2, -erc/2, 0])
					cylinder(d = edge_round, h = width + 0.2, center = true);
			}

		// cut out a cutout
		difference() {
			cube([dist - bd - 2*thick, bd, width + 0.1], center = true);
			cut_spool_dia = spool_dia + 2*thick;
			translate([0, spool_dia/2, 0])
				cylinder(d = cut_spool_dia, h = width + 0.1, center = true);
		}

		// cut out space for bearing
		translate([0, 0, thick/2])
			cube([length + 0.1, height - thick + 0.1,
				width - thick + 0.1], center = true);

		// cut out bearing axle
		for (a = [-1:2:1])
			translate([a*dist/2, 0, 0])
				cylinder(d = bid, h = height + 0.1, center = true);
	}
}

translate([0, 100, 3]) %spool();
translate([-50, 0, 3]) %b608();
translate([50, 0, 3]) %b608();

half();
