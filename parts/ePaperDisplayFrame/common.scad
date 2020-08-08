/* Settings */
$fn = 36;

display_height=111.5;
display_width=171;

sides_to_visible=3.1;
bottom_to_visible=9;

frame_border=12;
strength=2;
display_depth=1.4;

cable_cutout_width=28;
cable_cutout_height=2;

hat_standoff_y_distance=23;
hat_standoff_x_distance=58;
hat_standoff_height=4.5;
hat_standoff_from_display_bottom=17;
hat_standoff_radius=3;
hat_hole_diameter=3;
hat_top_height=3;

esp_standoff_y_distance=51;
esp_standoff_x_distance=23.5;
esp_standoff_height=5;
esp_standoff_from_display_bottom=15;
esp_standoff_from_center=-60;
esp_standoff_radius=1.5;
esp_hole_diameter=2.5;
esp_top_height=3;

foot_length=50;
foot_angle=65;
foot_from_side=10;

/* Computed dimensions */
inner_width=display_width-2*sides_to_visible;
inner_height=display_height-sides_to_visible-bottom_to_visible;

total_width=inner_width+2*frame_border;
total_height=inner_height+2*frame_border;

foot_height=tan(foot_angle)*foot_length;


module display_cutout() {
    translate([0,sides_to_visible/2-bottom_to_visible/2,-display_depth])
        linear_extrude(display_depth)
            square([display_width, display_height],true);
}

module cable_cutout() {
    translate([0,-cable_cutout_height/2-display_height/2+sides_to_visible/2-bottom_to_visible/2,-display_depth-strength])
        linear_extrude(strength+display_depth)
            square([cable_cutout_width,cable_cutout_height],true);
}

module hat_standoffs() {
    z_offset = -display_depth-strength;
    x_offset = hat_standoff_x_distance/2;
    y_offset = -display_height/2+hat_standoff_from_display_bottom;
    
    translate([x_offset,y_offset,z_offset])
    rotate([180,0,0])
        standoff(hat_standoff_radius, hat_standoff_height, hat_hole_diameter/2, hat_top_height);
    translate([x_offset,y_offset+hat_standoff_y_distance,z_offset])
    rotate([180,0,0])
        standoff(hat_standoff_radius, hat_standoff_height, hat_hole_diameter/2, hat_top_height);
    translate([-x_offset,y_offset,z_offset])
    rotate([180,0,0])
        standoff(hat_standoff_radius, hat_standoff_height, hat_hole_diameter/2, hat_top_height);
    translate([-x_offset,y_offset+hat_standoff_y_distance,z_offset])
    rotate([180,0,0])
        standoff(hat_standoff_radius, hat_standoff_height, hat_hole_diameter/2, hat_top_height);
    
    translate([x_offset,0,z_offset])
        linear_extrude(strength)
            square([hat_standoff_radius*2,total_height],true);
    
    translate([-x_offset,0,z_offset])
        linear_extrude(strength)
            square([hat_standoff_radius*2,total_height],true);
}

module esp_standoffs() {
    z_offset = -display_depth-strength;
    x_offset = esp_standoff_x_distance/2;
    y_offset = -display_height/2+esp_standoff_from_display_bottom;
    
    translate([esp_standoff_from_center+x_offset,y_offset,z_offset])
    rotate([180,0,0])
        standoff(esp_standoff_radius, esp_standoff_height, esp_hole_diameter/2, esp_top_height);
    translate([esp_standoff_from_center+x_offset,y_offset+esp_standoff_y_distance,z_offset])
    rotate([180,0,0])
        standoff(esp_standoff_radius, esp_standoff_height, esp_hole_diameter/2, esp_top_height);
    translate([esp_standoff_from_center-x_offset,y_offset,z_offset])
    rotate([180,0,0])
        standoff(esp_standoff_radius, esp_standoff_height, esp_hole_diameter/2, esp_top_height);
    translate([esp_standoff_from_center-x_offset,y_offset+esp_standoff_y_distance,z_offset])
    rotate([180,0,0])
        standoff(esp_standoff_radius, esp_standoff_height, esp_hole_diameter/2, esp_top_height);
    
    translate([esp_standoff_from_center+x_offset,0,z_offset])
        linear_extrude(strength)
            square([esp_standoff_radius*2,total_height],true);
    
    translate([esp_standoff_from_center-x_offset,0,z_offset])
        linear_extrude(strength)
            square([esp_standoff_radius*2,total_height],true);
}

module standoff(bottom_radius, bottom_height, top_radius, top_height) {
    linear_extrude(bottom_height)
        circle(r=bottom_radius);
    translate([0,0,bottom_height])
        linear_extrude(top_height)
        circle(r=top_radius);
}

module feet() {
    translate([total_width/2-foot_from_side-strength,-total_height/2,-display_depth-strength])
        rotate([90-foot_angle,0,0])
        rotate([0,90,0])
            foot();
    
    translate([-total_width/2+foot_from_side,-total_height/2,-display_depth-strength])
        rotate([90-foot_angle,0,0])
        rotate([0,90,0])
            foot();
}

module foot() {
    b1=[0,0];
    b2=[foot_length,0];
    b3=[foot_length,foot_height];
    
    linear_extrude(strength)
    polygon([b1,b2,b3]);
}