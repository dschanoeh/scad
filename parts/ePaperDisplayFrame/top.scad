include <common.scad>

top();

module top() {
    difference() {
        union() {
            linear_extrude(strength) {
                difference() {
                    square([total_width, total_height],true);
                    square([inner_width, inner_height],true);
                }
            }
            
            translate([0,0,-display_depth]) {
                linear_extrude(display_depth) {
                    square([total_width, total_height],true);
                }
            }
        };
        
        display_cutout();
        cable_cutout();
    }
}