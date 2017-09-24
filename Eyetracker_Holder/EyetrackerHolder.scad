//material: 2-3mm plywood
$fn=50; //number of fragments in 360 degrees
//39mm anstand löcher innen
//3mm Lochdurchmesser
//3mm loch tiefe
//4mm gabel über Eyetracker

//distanz eyetracker ambiglasses

projection() rotate([90,0,0]){
    union(){
        cylinder(h=2, d=2.6);
        translate([-1.5,-1.4,2])
            cube([5,3,39]);
        translate([0,0,39+2])
            cylinder(h=2, d=2.6);
        translate([0,-1.5,39+2-5])
            cube([15,3,5]);
        translate([15,-1.5,39-5])
            cube([2,3,7]);
    }

    translate([5,-1.5,20])
    difference(){
        cube([13.5,3,12]);
        translate([2,0,0])
            cube([4,3,10]);
        translate([8.5,0,7])
            cube([3,3,5]);
    }
}