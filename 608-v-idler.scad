$fn = 32;

// 608
bearing_width = 7;
bearing_dia = 22;
outer_dia = 30;
inner_dia = 25;

module half() {
	cylinder(d1 = outer_dia, d2 = inner_dia,
		h = bearing_width/2,
		center = true);
}

difference() {
	union() {
		translate([0, 0, -bearing_width/4])
			half();
		translate([0, 0, bearing_width/4])
			rotate([180, 0, 0])
				half();
	}

	cylinder(d = bearing_dia, h = 2.1*bearing_width,
		center = true);
}
