
use <../../external/dotSCAD/src/rounded_cube.scad>
use <../../libs/screws_and_nuts/screws_and_nuts.scad>
include <common.scad>

$fn=50;



make_back=false;


difference() {
    translate([0,0,case_height/2])
    difference() {
        // hull
        rounded_cube([case_width, case_depth, case_height], rounding, center = true);
        // inside volume
        rounded_cube([inside_width, inside_depth, inside_height], rounding, center = true);
    }
    
    // chassis
    chassis_center_height = case_height-top_to_chassis_center;
    translate([0,strength-case_depth/2,chassis_center_height])
        rotate([90,0,0])
            linear_extrude(strength)
                circle(d=chassis_cutout_d);
    
    translate([0,mill_depth-case_depth/2,chassis_center_height])
        rotate([90,0,0])
            linear_extrude(mill_depth)                
                circle(d=chassis_mill_d);
    
    // cover pin holes
    translate([case_width/2-side_to_cover_pin,cover_pin_hole_length-case_depth/2,side_to_cover_pin])
        rotate([90,0,0])
            linear_extrude(cover_pin_hole_length)
                circle(d=cover_pin_d+cover_pin_clearance);
    translate([case_width/2-side_to_cover_pin,cover_pin_hole_length-case_depth/2,case_height-side_to_cover_pin])
        rotate([90,0,0])
            linear_extrude(cover_pin_hole_length)
                circle(d=cover_pin_d+cover_pin_clearance);
    translate([-case_width/2+side_to_cover_pin,cover_pin_hole_length-case_depth/2,side_to_cover_pin])
        rotate([90,0,0])
            linear_extrude(cover_pin_hole_length)
                circle(d=cover_pin_d+cover_pin_clearance);
    translate([-case_width/2+side_to_cover_pin,cover_pin_hole_length-case_depth/2,case_height-side_to_cover_pin])
        rotate([90,0,0])
            linear_extrude(cover_pin_hole_length)
                circle(d=cover_pin_d+cover_pin_clearance);
    
    //chassis screw holes
    distance = cos(45)*chassis_screw_pos_d/2;
    translate([distance,strength-case_depth/2,chassis_center_height+distance])
        rotate([90,0,0])
            nut_and_screw_hole_m4(combined_lenght=strength, nut_diameter=7, nut_height=3);
    translate([distance,strength-case_depth/2,chassis_center_height-distance])
        rotate([90,0,0])
            nut_and_screw_hole_m4(combined_lenght=strength, nut_diameter=7, nut_height=3);
    translate([-distance,strength-case_depth/2,chassis_center_height+distance])
        rotate([90,0,0])
            nut_and_screw_hole_m4(combined_lenght=strength, nut_diameter=7, nut_height=3);
    translate([-distance,strength-case_depth/2,chassis_center_height-distance])
        rotate([90,0,0])
            nut_and_screw_hole_m4(combined_lenght=strength, nut_diameter=7, nut_height=3);
    
    // terminal
    translate([0,case_depth/2,bottom_to_terminal_center])
        rotate([90,0,0])
            linear_extrude(strength)
                circle(d=terminal_cutout_d);
    
    // terminal screw holes
    translate([terminal_hole_spacing/2,case_depth/2-strength,bottom_to_terminal_center+terminal_hole_spacing/2])
        rotate([-90,0,0])
            nut_and_screw_hole_m4(combined_lenght=strength, nut_diameter=7, nut_height=3);
    translate([terminal_hole_spacing/2,case_depth/2-strength,bottom_to_terminal_center-terminal_hole_spacing/2])
        rotate([-90,0,0])
            nut_and_screw_hole_m4(combined_lenght=strength, nut_diameter=7, nut_height=3);
    translate([-terminal_hole_spacing/2,case_depth/2-strength,bottom_to_terminal_center+terminal_hole_spacing/2])
        rotate([-90,0,0])
            nut_and_screw_hole_m4(combined_lenght=strength, nut_diameter=7, nut_height=3);
    translate([-terminal_hole_spacing/2,case_depth/2-strength,bottom_to_terminal_center-terminal_hole_spacing/2])
        rotate([-90,0,0])
            nut_and_screw_hole_m4(combined_lenght=strength, nut_diameter=7, nut_height=3);
    
    // back screw holes and nut channels
    side_offset = case_width/2-strength/2;
    top_offset = case_height-strength;
    
    translate([side_offset,case_depth/2,top_offset])
        rotate([-90,0,0])
                screw_and_nut_channel(screw_head_h=4, screw_head_d=8, screw_l=23, screw_d=4, center_from_side=5,nut_width=7, nut_height=3, nut_from_end=5, clearance=0.3);
    translate([-side_offset,case_depth/2,top_offset])
        rotate([-90,180,0])
                screw_and_nut_channel(screw_head_h=4, screw_head_d=8, screw_l=23, screw_d=4, center_from_side=5,nut_width=7, nut_height=3, nut_from_end=5, clearance=0.3);
    translate([side_offset,case_depth/2,strength])
        rotate([-90,0,0])
                screw_and_nut_channel(screw_head_h=4, screw_head_d=8, screw_l=23, screw_d=4, center_from_side=5,nut_width=7, nut_height=3, nut_from_end=5, clearance=0.3);
    translate([-side_offset,case_depth/2,strength])
        rotate([-90,180,0])
                screw_and_nut_channel(screw_head_h=4, screw_head_d=8, screw_l=23, screw_d=4, center_from_side=5,nut_width=7, nut_height=3, nut_from_end=5, clearance=0.3);
             
    // seal
    side_to_seal=(strength-seal_width)/2;
    translate([0,seal_depth/2+case_depth/2-back_strength,case_height/2])
        rotate([90,0,0])
            linear_extrude(seal_depth*0.7) {
                difference() {
                    square([case_width-2*side_to_seal,case_height-2*side_to_seal],center=true);
                    square([case_width-2*side_to_seal-2*seal_width,case_height-2*side_to_seal-2*seal_width],center=true);
                }
            }
    
    if(!make_back) { // remove back
        translate([0,case_depth/2-back_strength/2,0])
            linear_extrude(case_height)
                square([case_width,back_strength],center=true);
    } else {  // remove front
        translate([0,-back_strength/2,0])
            linear_extrude(case_height)
                square([case_width,case_depth-back_strength],center=true);
    }
}
