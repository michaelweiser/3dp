cutting_epsilon = 0.05;

module hella4570_holder_frame(inner_width, inner_height, height, thickness) {
	difference() {
		cube([inner_width + 2*thickness,
			inner_height + 4*thickness,
			height], center = true);
		translate([0, 0, thickness/2 + cutting_epsilon/2])
			cube([inner_width, inner_height + 2*thickness + cutting_epsilon,
				height - thickness],
				center = true);
		cube([inner_width, inner_height, height + cutting_epsilon],
			center = true);
	}
}

module hella4570_holder_mount(width, inner_height, thickness, hole_diameter) {
	difference() {
		height = inner_height + 4*thickness + 2*width;
		cube([thickness, height, width],
			center = true);
		for (f = [-1:2:1])
			translate([0, f * (height/2 - width/2), 0])
			rotate([0, 90, 0])
				cylinder(d = hole_diameter, h = thickness + cutting_epsilon,
					center = true,
					$fn = 32);
	}
}

module hella4570_holder(inner_width = 22.1,
	inner_height = 44.1,
	height = 10,
	thickness = 2,
	mount_hole_diameter = 3,
	epsilon = 0.1) {
	ciw = inner_width + 2*epsilon;
	cih = inner_height + 2*epsilon;
	cmhd = mount_hole_diameter + 2*epsilon;

	union() {
		hella4570_holder_frame(inner_width = ciw,
			inner_height = cih,
			height = height,
			thickness = thickness);

		translate([ciw/2 + 1.5*thickness, 0, 0])
			hella4570_holder_mount(width = height,
				inner_height = cih,
				thickness = thickness,
				hole_diameter = cmhd);
	}
}

hella4570_holder();
