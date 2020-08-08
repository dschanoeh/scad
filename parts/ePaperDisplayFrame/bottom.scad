include <common.scad>

bottom();

module bottom() {
    difference() {
        translate([0,0,-display_depth-strength])
            linear_extrude(strength) {
                difference() {
                    square([total_width, total_height],true);
                }
            }
        translate([0,0,-display_depth-strength])
            linear_extrude(strength)
                square([inner_width, inner_height],true);
        cable_cutout();
    }
    hat_standoffs();
    esp_standoffs();
    feet();  
}