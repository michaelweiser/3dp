thickness = 4;  // 1mm thicker than linear rail.
width = 15;  // Same as vertical extrusion.
height = 15;

m3_wide_radius = 2.85/2 + 0.1 + 0.2;

module endstop() {
  difference() {
    union() {
      cube([width, thickness, height], center=true);
      translate([0, 2, 0])
        cube([2.5, thickness, height], center=true);
    }
    translate([0, 0, 3]) rotate([90, 0, 0]) {
      cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);
      translate([0, 0, -thickness/2]) scale([1, 1, -1])
        cylinder(r1=m3_wide_radius, r2=7, h=4, $fn=24);
    }
    translate([0, -3-thickness/2, -3]) rotate([0, 180, 0]) {
      for (x = [-6.5/2, 6.5/2]) {
        translate([x, 0, 0]) rotate([90, 0, 0])
          cylinder(r=2/2, h=40, center=true, $fn=12);
      }
    }
  }
}

translate([0, 0, height/2]) endstop();
