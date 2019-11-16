// inside measurements
inside_width=102;
inside_depth=140;
inside_height=140;

strength = 10;

chassis_cutout_d = 78;
chassis_mill_d = 94;
top_to_chassis_center = 70;
chassis_screw_pos_d = 85;
mill_depth = 3;

terminal_cutout_d = 51;
terminal_hole_spacing = 45;
terminal_screw_d = 2.5;
bottom_to_terminal_center = 60;

case_width=inside_width+2*strength;
case_depth=inside_depth+2*strength;
case_height=inside_height+2*strength;

seal_depth=2;
seal_width=strength*0.65;

rounding=4;
back_strength = strength+rounding;

cover_side_strength=5;
cover_strength=2.6;
cover_pin_d=5;
cover_pin_clearance=0.3;
cover_pin_hole_length=5;
cover_pin_length=10;
side_to_cover_pin=rounding+cover_side_strength+cover_pin_d/2;
