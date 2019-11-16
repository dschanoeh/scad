include <common.scad>
use <../../libs/screws_and_nuts/screws_and_nuts.scad>
$fn=50;


difference() {
    // seal
    real_seal_width=seal_width-1;
    side_to_seal=(strength-real_seal_width)/2;
    translate([0,seal_depth/2+case_depth/2-back_strength,case_height/2])
        rotate([90,0,0])
            linear_extrude(seal_depth*0.85) {
                difference() {
                    square([case_width-2*side_to_seal,case_height-2*side_to_seal],center=true);
                    square([case_width-2*side_to_seal-2*real_seal_width,case_height-2*side_to_seal-2*real_seal_width],center=true);
                }
            }
            
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
}