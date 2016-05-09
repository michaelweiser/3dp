module isosceles_trapezoid(d = 5, angle = 45, h = 1, height = 1) {
	bevel_width = h/tan(angle);
	base_width = d + 2*bevel_width;
	scale_x = base_width/d;

	// turn back into 2D primitive
	projection()
		// turn flat on x plane
		rotate([90, 0, 0])
			// move back into center
			translate([0, 0, -h/2])
				// extrude with scaling into trapezoid
				linear_extrude(height = h, scale=[scale_x, 1])
					square([d, 1], center = true);
}

isosceles_trapezoid();