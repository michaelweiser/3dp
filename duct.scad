module duct_form() {
	// let square and circle shaped ends flow into each other
	hull() {
		cube([10, 20, 1], center = true);
		translate([0, 0, -20])
			cylinder(d = 30, h = 1, center = true);
	}
}

module duct() {
	// hollow out the interiour to get a duct
	difference() {
		duct_form();
		scale([0.9, 0.9, 1.01])
			duct_form();
	}
}

// skew
multmatrix(m = [[1, 0, 0.5, 0],
[0, 1, 0, 0],
[0, 0, 1, 0],
[0, 0, 0, 1],
]) duct();
