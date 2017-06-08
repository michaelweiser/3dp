$fn = 16;

union() {
	rotate([0, 90, 0])
		difference() {
			cube([6, 26, 2], center = true);
			for (a = [-1:2:1]) {
				translate([0, -10 * a, 0])
					cylinder(d = 3.2, h= 3, center = true);
			}
		}

	translate([0, 0, -1.5])
		difference() {
			cylinder(d = 15, h = 3, center = true);
			cylinder(d = 12, h = 3.2, center = true);
			translate([-10, 0, 0])
				cube([20, 20, 4], center = true);
		}
}
