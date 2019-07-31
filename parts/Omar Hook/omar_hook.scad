
width=5;
depth=3;
length=40; // of the straight part

top_diameter=6.1;  //6.1mm for the thick bars, 3.3mm for the thin ones
top_angle=210;

bottom_diameter=20;
bottom_angle=200;

$fa=1;
$fs=0.5;

module center() {
  linear_extrude(length)
  square([width,depth],true);
};

module top() {
  translate([width/2,top_diameter/2+depth/2,length])
  rotate([90,0,-90])
  rotate_extrude(angle=top_angle) {
    translate([top_diameter/2,0,0])
    square([depth,width],false);
  }
}; 

module bottom() {
  translate([width/2,-bottom_diameter/2-depth/2,0])
  rotate([-90,0,90])
  rotate_extrude(angle=bottom_angle) {
    translate([bottom_diameter/2,0,0])
    square([depth,width],false);
  }
};

center();
top();
bottom();