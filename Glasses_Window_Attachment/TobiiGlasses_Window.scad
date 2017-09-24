/* Tobii Glasses 2 Window with
 * LED Holders for NeoPixel Stripes (left/right)
 * by tcs - 2017
*/
$fn=360; // fancy circles

material_thickness = 2; // 2mm

module rounded_square(d,r) {
    minkowski() {
        translate([r,r]) square([d[0]-2*r, d[1]-2*r]);
        circle(r);
    }
}

// replacement glasses
module glasses(){
    difference(){
        union(){
            color("LightSkyBlue", 1)
                rounded_square([135,40],5);
            color("Gray", 1){
                translate([52,39.9])
                    square([5,1.5]);
                translate([77,39.9])
                    square([5,1.5]);  
            }
        }
        translate([67,36])
            circle(r=5);
        translate([62,36]) //63.75
            square([10,5]); //8.5
        translate([64.5,24])
            square([5,3]);     
        translate([67,14.5])
            circle(r=10);
        translate([67,0])
            projection()
                rotate([270,0,0])
                    cylinder(h=15, r1=15, r2=10);
    }
    color("Gray", 1){
        translate([64.5,26])
            square([5,1]);
    }
}

// glasses with connectors
module glasses_with_connectors(){
    difference(){
        union(){
            color("LightSkyBlue", 1)
                rounded_square([135,40],5);
            color("Gray", 1){
                translate([52,39.9])
                    square([5,1.5]);
                translate([77,39.9])
                    square([5,1.5]);  
            }
        }
        translate([67,36])
            circle(r=5);
        translate([62,36]) //63.75
            square([10,5]); //8.5
        translate([64.5,24])
            square([5,3]);     
        translate([67,14.5])
            circle(r=10);
        translate([67,0])
            projection()
                rotate([270,0,0])
                    cylinder(h=15, r1=15, r2=10);
        // led holder connection
        translate([2,10.5])
            square([1.5,5]);
        translate([2,25.5])
            square([1.5,5]);
        translate([131.5,10.5])
            square([1.5,5]);
        translate([131.5,25.5])
            square([1.5,5]);
    }
    color("Gray", 1){
        translate([64.5,26])
            square([5,1]);
    }
}

// Led-Holders medium
module led_holders_medium(){
    color("LightSkyBlue", 1){
        translate([-12,5]){
            translate([-2,5])
                square([2.1,5]);
            translate([-2,20])
                square([2.1,5]);
            rounded_square([10,30],1);
        }
        translate([137,5]){
            translate([10,5])
                square([2,5]);
            translate([10,20])
                square([2,5]);
            rounded_square([10,30],1);
        }
    }
}

// Led-Holders large
module led_holders_large(){
    color("LightSkyBlue", 1){
        translate([-12,2.5]){
            translate([-2,7.5])
                square([2.1,5]);
            translate([-2,22.5])
                square([2.1,5]);
            rounded_square([10,35],1);
        }
        translate([137,2.5]){
            translate([10,7.5])
                square([2,5]);
            translate([10,22.5])
                square([2,5]);
            rounded_square([10,35],1);
        }
    }
}

// choose modules:
glasses_with_connectors();
led_holders_large();
