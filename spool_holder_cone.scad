// cone for centering filament spool on holder axle by skykai

h=25;           // height
baseR=29;       // base radius
topR=24;        // top radius
holeR=4.1;      // radius of the hole in the middle
wallT=4;        // thickness of the walls
$fn=100;

translate([-baseR-5,0,0])         //full cone
cone(h,baseR,topR,holeR,wallT);

translate([0,-baseR-15,0])       //half cone
halfCone(h, baseR, topR, holeR, wallT);

module halfCone(h, baseR, topR, holeR, wallT){
    union(){
        difference(){
            union(){
                cone(h,baseR,topR,holeR,wallT);
                translate([0,-wallT/2,0])
                rotate([90,-90,0])
                linear_extrude(wallT/2){
                    polygon([[0,holeR],[0,baseR-wallT],[h,topR-wallT],[h,holeR]]);
                }
                translate([0,-wallT,0])
                rotate([-90,-90,0])
                linear_extrude(wallT/2){
                    polygon([[0,holeR],[0,baseR-wallT],[h,topR-wallT],[h,holeR]]);
                }
            }
            translate([(baseR+10)*-1,0,-5])
            cube([2*baseR+10,2*baseR+10,h+10]);
        }
    }
}

module cone(h, baseR, topR, holeR, wallT){

    union(){
        difference(){
            cylinder(h=h,r1=baseR,r2=topR);
            alpha=atan((baseR-topR)/h);
            rPlus=(tan(alpha)*(h+1))-baseR+topR;
            outerRnew=(baseR-wallT)+rPlus;
            innerRnew=(topR-wallT)-rPlus;
            translate([0,0,-1])
            cylinder(h=h+2,r1=outerRnew,r2=innerRnew);
        }
        intersection(){
            difference(){
                union(){
                    cylinder(h,r=holeR+wallT);
                    translate([0,0,h/2])
                    cube([2*baseR,wallT,h],true);
                    translate([0,0,h/2])
                    cube([wallT,2*baseR,h],true);
                }
                translate([0,0,-5])
                cylinder(h + 10,r=holeR);
            }
            cylinder(h=h,r1=baseR,r2=topR);
        }
    }
}
