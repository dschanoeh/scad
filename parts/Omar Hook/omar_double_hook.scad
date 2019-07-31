
width=5;
depth=3;
length=40; // of the straight part

top_diameter=6.1;  //6.1mm for the thick bars, 3.3mm for the thin ones
top_angle=180;

bottom_diameter=20;
bottom_angle=180;
second_attachment_angle=125;

bar_separation=13.5;

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

module second_bar_attachment() {
  translate([width/2,top_diameter/2+depth/2,length-bar_separation])
  rotate([90,0,-90])
  union() {
      rotate_extrude(angle=second_attachment_angle) {
        translate([top_diameter/2,0,0])
        square([depth,width],false);
      }
      rotate_extrude(angle=-second_attachment_angle) {
        translate([top_diameter/2,0,0])
        square([depth,width],false);
      }
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
second_bar_attachment();