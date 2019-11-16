use <case.scad>
use <../../libs/screws_and_nuts/screws_and_nuts.scad>
include <common.scad>

$fn=50;

inside_d = 123;
outside_d = 151;

seal_strength=1.2;

distance = cos(45)*(outside_d-14)/2;

difference() {
    linear_extrude(seal_strength)
        difference() {
            circle(d=outside_d);
            circle(d=inside_d);
        }

    translate([distance,distance,0])
        screw_hole(7, seal_strength, 0);
    translate([distance,-distance,0])
        screw_hole(7, seal_strength, 0);
    translate([-distance,distance,0])
        screw_hole(7, seal_strength, 0);
    translate([-distance,-distance,0])
        screw_hole(7, seal_strength, 0);
}

