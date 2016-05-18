// based on: https://www.thingiverse.com/thing:783810

// make circles higher resolution
$fn = 32;

module stay(thickness = 0.5, bulging = 1.2, protrusion = 2, slant = 14) {
	// slant the stay for clipping into beam
	rotate([0, 0, slant])
		// use hull of two circles as cross-section of stay
		hull() {
			circle(r=thickness, center=true);
			translate([0, -protrusion, 0])
				// stay is bulging a bit at the inner end -
				// because we can! :)
				circle(r=thickness * bulging, center=true);
		}
}

module half_clip(width = 10,
		flex_channel_radius = 0.6,
		stay_thickness = 0.3, stay_pressure_fudge = 0.35,
		plate_thickness = 1.5,
		ob_channel_width = 3.2) {
	difference() {
		union() {
			// backing plate
			square([width/2, plate_thickness]);
			// stay that clips into channel
			translate([ob_channel_width/2 - stay_thickness - stay_pressure_fudge, 0, 0])
				stay(stay_thickness);
		}

		// cut-out in backing plate and stay to allow flexing
		circle(r=flex_channel_radius, center=true);
	}
}

module clip(width = 10, height = 5) {
	linear_extrude(height)
		union() {
			// two half-clips back-to-back
			half_clip(width);
			mirror([1, 0, 0])
				half_clip(width);
		}
}

clip();
