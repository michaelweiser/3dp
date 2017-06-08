openbeam_width = 15;
extrude_height = 5;
delta = 0.1;
$fn = 16;

module wing(width = 10, length = 70, height = 10,
        rot = 60,
        groovewidth = 5, groovedia = 8, grooverim = 3) {
    rotate([0, 0, 180-rot])
        difference() {
            translate([-width/2, 0, -height/2])
                cube([width, length, height]);
            translate([0,
                length - groovewidth/2 - grooverim, 0])
                rotate([-90, 0, 0]) {
                    difference() {
                        cube([width + delta,
                            height + delta,
                            groovewidth],
                            center = true);
                        cylinder(d = groovedia,
                            h = groovewidth + delta,
                            center = true);
                        translate([0, height/2, 0])
                            cube([groovedia,
                                height,
                                groovewidth + delta],
                                center = true);
                    }
                }
            }
}

module centerpiece(height = 5) {
    // derived from original kossel frame top
    union() {
        intersection() {
            translate([0, -10, 0])
                cube([100, 30, height+1],
                    center = true);
            translate([0, 22, 0])
                cylinder(r=40, h=height,
                    center=true, $fn=60);
            translate([0, -37, 0])
                rotate([0, 0, 30])
                    cylinder(r=50, h=height+1,
                        center=true, $fn=6);
        }
        translate([0, 38, 0])
            intersection() {
                difference() {
                    rotate([0, 0, -90])
                        cylinder(r=85, h=height,
                            center=true, $fn=3);
                    rotate([0, 0, -90])
                        cylinder(r=55, h=height+1,
                            center=true, $fn=3);

                    // screw holes (best guess,
                    // nonscientific placement)
                    for(a = [-1:2:1]) {
                        translate([-25*a, -26, 0])
                            cylinder(d = 3.2,
                                h = height + delta,
                                center = true);
                    }
                }

                // cut v of openbeam-emulating triangle
                translate([0, -20, 0])
                    cube([100, 40, height+1],
                        center=true);
                // square cut openbeam fingers
                translate([0, -55, 0])
                    rotate([0, 0, 30])
                        cylinder(r=50, h=height+1,
                            center=true, $fn=6);
            }
    }
}

module openbeam_cutout(width = 15, height) {
    union() {
        cube([width + delta,
            width + delta,
            height + delta],
            center = true);
        //translate([0, -width/2, 0])
        //    cube([width/2, width/2, height + delta],
        //        center = true);
    }
}

difference() {
    union() {
        centerpiece(height = extrude_height);
        wing(height = extrude_height);
        wing(height = extrude_height, rot=-60);
    }
    openbeam_cutout(width = openbeam_width,
        height = extrude_height);
}
