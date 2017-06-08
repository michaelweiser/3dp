$fn = 16;

d = 114;
length = 84;
rounding = 15;
thickness = 3;
eyelet_dia = 10;

front_mount_height = 11;
front_mount_width = 20;
nema_width = 42.5;

screw_dia = 3;

module rounded_extruded_triagle(d1 = 110, d2 = 15, h = 3) {
	minkowski() {
		cylinder(d = d2, h = h/2, center = true);
		cylinder(d = d1, h = h/2, $fn = 3, center = true);
	}
}

module eyelet(d = 10, h = 3) {
	difference() {
		cylinder(d = d, h = h, center = true);
		cylinder(d = d - 1.5*h, h = h+1, center = true);
	}
}

difference() {
	rounded_extruded_triagle(d1 = d, d2 = rounding,
		h = thickness);
	rounded_extruded_triagle(d1 = d, d2 = rounding - 2*thickness,
		h = thickness+1);
}

for (a = [0:120:360])
	translate([(d/2+thickness/2)*sin(90+a), (d/2+thickness/2)*cos(90+a), 0]) eyelet();

translate([-length/2-thickness-eyelet_dia/2+1+(d/2+thickness/2)*sin(90), 0, 0]) {
	cube([length + 2*thickness, thickness, thickness], center = true);

	// front mount plate
	front_mount_plate_width = front_mount_width + 2*screw_dia;
	front_mount_plate_height = front_mount_height + screw_dia + thickness;
	translate([length/2 + thickness/2, 0, front_mount_plate_height/2 - thickness/2]) {
		difference() {
			cube([thickness, front_mount_plate_width, front_mount_plate_height], center = true);
			for (a = [-1:2:1])
				translate([0, a*front_mount_width/2, front_mount_height/2 + thickness/2 - screw_dia/2])
					rotate([0, 90, 0])
						cylinder(d = screw_dia + 0.2, h = thickness + 1, center = true);
		}
	}

	// rear fixings
	translate([-length/2 - thickness, 0, 0]) {
		union() {
			cube([3*thickness, nema_width, thickness], center = true);
			for (a = [-1:2:1]) {
				translate([0, a*(-nema_width/2 - thickness/2), thickness])
					cube([3*thickness, thickness, 3*thickness], center = true);
				translate([-thickness, a*(-nema_width/2 + thickness), thickness])
					cube([thickness, 2*thickness, 3*thickness], center = true);
				translate([eyelet_dia/2, a*(-nema_width/2 - thickness + eyelet_dia/2), 0])
					eyelet();
			}
		}
	}
}
