use <case.scad>
use <../../libs/nut_trap/nut_trap.scad>
include <common.scad>

$fn=50;

inside_d = chassis_screw_pos_d-6.2;
outside_d = chassis_screw_pos_d+6.2;

seal_strength=2.4;

distance = cos(45)*chassis_screw_pos_d/2;

difference() {
    linear_extrude(seal_strength)
        difference() {
            circle(d=outside_d);
            circle(d=inside_d);
        }

    translate([distance,distance,0])
        screw_hole_m4(seal_strength);
    translate([distance,-distance,0])
        screw_hole_m4(seal_strength);
    translate([-distance,distance,0])
        screw_hole_m4(seal_strength);
    translate([-distance,-distance,0])
        screw_hole_m4(seal_strength);
}