garmin_width=53.5;
garmin_depth=20.5;
sensor_width=34.5;
sensor_depth=11.5;
band_width=32.5;
cable_width=4;

hook_size=4;
minkowski_radius=1;
strength=1.5;
height=40;
pole_strength=3;
top_width=15;
top_hole_diameter_inside=7;
top_hole_diameter_outside=10;

$fn=72;
pole_length=2*hook_size+band_width+cable_width-minkowski_radius;
container_depth=3*strength+garmin_depth+sensor_depth;

// Pole
minkowski() {
    union() {
        translate([container_depth,0,pole_strength/2]) {
            rotate([0,90,0])
            linear_extrude(pole_length) {
                square([pole_strength,pole_strength-minkowski_radius*2],true);
            }
        }
        translate([container_depth+band_width+hook_size/2,0,pole_strength]) {
            linear_extrude(hook_size) {
                square([hook_size-minkowski_radius*2,pole_strength-minkowski_radius*2], true);
            }
        }
        
        translate([container_depth+band_width+hook_size+cable_width+hook_size/2,0,pole_strength]) {
            linear_extrude(hook_size) {
                square([hook_size-minkowski_radius*2,pole_strength-minkowski_radius*2], true);
            }
        }
    }
    cylinder(r=minkowski_radius,h=1);
}

// Boxes
translate([garmin_depth/2+strength,0,0])
    rounded_box(garmin_width, garmin_depth, height, strength, minkowski_radius);
translate([garmin_depth+2*strength+sensor_depth/2,0,0])
    rounded_box(sensor_width, sensor_depth, height, strength, minkowski_radius);

// Holder
difference() {
    translate([strength/2,0,height+strength])
        linear_extrude(top_width)
            square([strength, top_width],true);
    
    translate([strength/4,0,height+strength+top_width/2])
        rotate([0,-90,0])
            cylinder(h=strength/2,d=top_hole_diameter_inside,center=true);
    
    translate([strength*0.75,0,height+strength+top_width/2])
        rotate([0,-90,0])
            cylinder(h=strength/2,d=top_hole_diameter_outside,center=true);
}

module rounded_box(inside_width, inside_depth, inside_height, strength, radius) {
    difference() {
        minkowski() {
            linear_extrude(inside_height+strength)
                square([inside_depth+2*(strength-radius),inside_width+2*(strength-radius)], true);
            cylinder(r=radius,h=1);
        }
        translate([0,0,strength]) {
            minkowski() {
                linear_extrude(inside_height)
                    square([inside_depth-2*radius,inside_width-2*radius], true);
                cylinder(r=radius,h=1);
            }
        }
    }
}
