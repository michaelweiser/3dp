$fn = 32;
use <bearing_holder.scad>;

cutting_epsilon = 0.01;

module socket(width = 15, length = 30, thickness = 2,
		screw_size = 3, epsilon = 0.25) {
	difference() {
		cube([length, width, thickness], center = true);

		if (screw_size > 0) {
			css = screw_size + 2*epsilon;
			cutting_height = thickness + 2 * cutting_epsilon;
			translate([-length/2 + css * 2, 0, 0])
				cylinder(d = css, h = cutting_height, center = true);
			translate([length/2 - css * 2, 0, 0])
				cylinder(d = css, h = cutting_height, center = true);
		}
	}
}

module spool_holder(thickness = 2,
		socket_width = 15, socket_length = 50,
		holder_angle = 30,
		bearing_diameter = 22, bearing_width = 7, shaft_diameter = 8,
		screw_size = 3,
		epsilon = 0.25) {
	union() {
		rotate([90, 0, holder_angle])
			bearing_holder(outer_diameter = bearing_diameter,
				width = bearing_width,
				thickness = thickness,
				shaft_diameter = shaft_diameter,
				top_shaft_hole = false,
				epsilon = epsilon);

		// put socket below holder, holder extends half of bearing
		// diameter plus epsilon plus two thicknesses below center,
		// socket is also centered, so we have to move it down 2.5
		// thicknesses, but we go up once thickness to have holder and
		// socket start on the build plate.
		translate([0, 0, -bearing_diameter/2 - epsilon - 1.5*thickness])
			socket(width = socket_width,
				length = socket_length,
				thickness = thickness,
				screw_size = screw_size,
				epsilon = epsilon);
	}
}

spool_holder();
// spin second holder by 180 degrees to get shaft cutout on inner side
translate([0, 30, 0])
	spool_holder(holder_angle = 180 - 30);
