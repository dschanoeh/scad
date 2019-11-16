include <common.scad>
$fn=100;

pin_spacing_h=case_height-2*side_to_cover_pin;
pin_spacing_w=case_width-2*side_to_cover_pin;
translate([-pin_spacing_w/2,pin_spacing_h/2,cover_strength])
    linear_extrude(cover_pin_length)
        circle(d=cover_pin_d);
translate([-pin_spacing_w/2,-pin_spacing_h/2,cover_strength])
    linear_extrude(cover_pin_length)
        circle(d=cover_pin_d);
translate([pin_spacing_w/2,pin_spacing_h/2,cover_strength])
    linear_extrude(cover_pin_length)
        circle(d=cover_pin_d);
translate([pin_spacing_w/2,-pin_spacing_h/2,cover_strength])
    linear_extrude(cover_pin_length)
        circle(d=cover_pin_d);
        
cover_outside_w=cover_side_strength*2+pin_spacing_w+cover_pin_d;
cover_outside_h=cover_side_strength*2+pin_spacing_h+cover_pin_d;
cover_inside_w=pin_spacing_w-cover_pin_d;
cover_inside_h=pin_spacing_h-cover_pin_d;

centerpoint_h = -1* (case_height/2-top_to_chassis_center);

linear_extrude(cover_strength) {
    
    difference() {
        union() {
            translate([0,centerpoint_h,0])
                circle(d=chassis_mill_d+cover_strength+2);
            square([cover_strength,pin_spacing_h],center=true);
        }
        translate([0,centerpoint_h,0])
            circle(d=chassis_mill_d);
    }
    minkowski() {
        difference() {
            square([cover_outside_w-8,cover_outside_h-8],center=true);
            square([cover_inside_w+8,cover_inside_h+8],center=true);
        }
        circle(r=4);
    }
}