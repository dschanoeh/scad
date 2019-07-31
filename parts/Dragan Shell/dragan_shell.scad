include <../../external/dotSCAD/src/rounded_cube.scad>;

$fn=60;

// Part dimensions
inside_height=116.5;
inside_width=72.5;
inside_depth=52.5;
hole_diameter=29;
strength=3;
corner_radius=2;
foot_length=1.5;

outside_width=inside_width+2*strength;
outside_height=inside_height+strength;
outside_depth=inside_depth+2*strength;


// Create the outer body and subtract inside dimensions and hole
difference() {
    union() {
        // Body
        translate([0,0,outside_height/2])
            rounded_cube(size=[outside_depth,outside_width,outside_height],
                corner_r=corner_radius,
                center=true);
        // Feet
        offset=strength-corner_radius;
        translate([inside_depth/2+offset,inside_width/2+offset,0])
            foot();
        translate([inside_depth/2+offset,-inside_width/2-offset,0])
            foot();
        translate([-inside_depth/2-offset,inside_width/2+offset,0])
            foot();
        translate([-inside_depth/2-offset,-inside_width/2-offset,0])
            foot();
    }
    
    translate([0,0,inside_height/2-foot_length])
        cube([inside_depth,inside_width,inside_height+foot_length],center=true);
    
    translate([0,0,outside_height/2])
        cylinder(h=outside_height, d=hole_diameter,center=true);
}

module foot() {
    translate([0,0,corner_radius/2-foot_length/2])
    cylinder(h=foot_length+corner_radius, d=2*corner_radius,center=true);
}

