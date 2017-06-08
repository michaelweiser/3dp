use <OpenSCAD-Arduino-Mounting-Library/arduino.scad>;
use <rounded_rectangle.scad>;

cutting_epsilon = 0.05;

module arduino_holder_base(width, length, height, rounding, recess, brim_width) {
	difference() {
		linear_extrude(height)
			rounded_rectangle(width = length,
				height = width,
				rounding = rounding);

		translate([0, 0, height - recess])
			linear_extrude(recess + cutting_epsilon)
				rounded_rectangle(width = length - 2*brim_width,
					height = width - 2*brim_width,
					rounding = rounding - brim_width);
	}
}

module arduino_holder_mount(thickness, width, height, hole_offset, hole_diameter) {
	union() {
		difference() {
			translate([0, height/2 - thickness/2, 0])
				cube([width, thickness, height], center = true);

			// mount hole
			translate([-thickness/2,
					height/2 - thickness/2,
					height/2 - hole_offset])
				rotate([90, 0, 0])
					cylinder(d = hole_diameter,
						h = thickness + cutting_epsilon,
						$fn = 32,
						center = true);
		}

		// stabilizer
		translate([width/2 - thickness/2, 0, 0])
			difference() {
				cube([thickness, height, height], center = true);
				translate([-thickness/2 - cutting_epsilon/2, -height/2, height/2])
				rotate([0, 90, 0])
					cylinder(r = height - thickness,
						h = thickness + cutting_epsilon,
						$fn = 32);
			}
	}
}

// bad interface on arduino mounting library, need to specify numeric values due to scoping:
//
// boardtype:
//  NG = 0;
//  DIECIMILA = 1;
//  DUEMILANOVE = 2;
//  UNO = 3;
//  LEONARDO = 4;
//  MEGA = 5;
//  MEGA2560 = 6;
//  DUE = 7;
//  YUN = 8;
//  INTELGALILEO = 9;
//  TRE = 10;
//  ETHERNET = 11;
//
// mounttype:
//  TAP == 0
//  PIN == 1
module arduino_holder(boardtype = 6,
		mounttype = 0,
		board_hole_radius = 1.6,
		standoff_height = 3,
		base_height = 3,
		base_recess = 2,
		base_rounding = 3,
		oversize = 5,
		ramps_additional_width = 10,
		mount_thickness = 3,
		extrusion_width = 15,
		mount_width = 15,
		mount_height = 0,
		mount_hole_diameter = 3.2,
		mount_hole_offset = 0) {
	mount_height = mount_height == 0 ? 1.75 * extrusion_width : mount_height;
	mount_hole_offset = mount_hole_offset == 0 ? extrusion_width * 0.25 : mount_hole_offset;

	union() {
		dimensions = boardDimensions(boardType = boardtype);
		board_width = dimensions[0] + ramps_additional_width;
		board_length = dimensions[1];
		base_width = board_width + oversize + mount_thickness;
		base_length = board_length + oversize + 2 * mount_thickness;

		arduino_holder_base(width = base_width,
			length = base_length,
			height = base_height,
			recess = base_recess,
			brim_width = 2*mount_thickness,
			rounding = base_rounding);

		translate([base_length/2 - mount_width/2,
				base_width/2 - mount_height/2,
				mount_height/2])
			arduino_holder_mount(thickness = mount_thickness,
				width = mount_width,
				height = mount_height,
				hole_offset = mount_hole_offset,
				hole_diameter = mount_hole_diameter);

		translate([-base_length/2 + mount_width/2,
				base_width/2 - mount_height/2,
				mount_height/2])
			mirror([1, 0, 0])
				arduino_holder_mount(thickness = mount_thickness,
					width = mount_width,
					height = mount_height,
					hole_offset = mount_hole_offset,
					hole_diameter = mount_hole_diameter);

		translate([board_length/2 - 5, -board_width/2, base_height - base_recess]) {
			rotate([0, 0, 90]) {
				standoffs(boardType = boardtype,
					mountType = mounttype,
					height = standoff_height,
					holeRadius = board_hole_radius,
					topRadius = board_hole_radius + 1,
					bottomRadius =  board_hole_radius + 2);

				translate([0, 0, standoff_height])
					%arduino(boardType = boardtype);
				}
		}
	}
}

arduino_holder();
