include <dimensions.scad>

$fn = 75;
ball_size = 17; // FTM-350 swivel mount takes a 17mm ball

// Defaults are for an M3 nut
module nut_trap (w=5.5, h=3) {
        cylinder(r = w / 2 / cos(180 / 6) + 0.05, h=h, $fn=6);
}

difference() {    
    union() {
        // Mounting plate
        translate([0,0,20]) rotate([90,0,0]) cylinder(3,r=18,center=true);
        // Ball support
        translate([0,0,20]) rotate([0,270,90]) linear_extrude(height=19, scale=0.3) {
            scale([1.0,0.5,1.0]) circle(18, center = true);
        }
        
        // Ball
        translate([0,-25,20]) sphere(ball_size/2);        
    }
    
    translate([-13,0,20]) rotate([90,0,0]) nut_trap(w=5.55);    
    translate([13,0,20]) rotate([90,0,0]) nut_trap(w=5.55); 
    translate([-13,0,20]) rotate([90,0,0]) cylinder(5,r=1.75,center=true);    
    translate([13,0,20]) rotate([90,0,0]) cylinder(5,r=1.75,center=true);
}
