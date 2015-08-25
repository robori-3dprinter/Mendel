// ========================================================================================
// Robori Mendel
// LCD clamp left and right for RepRapDiscount 2004 smart controller
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 22 May 2015 - First version
// ========================================================================================

include <library/component.scad>
include <library/library_3d.scad>

$fn = 30;

clamp_body_l = 10;
clamp_body_w = 57.5;
clamp_foot_l = clamp_body_l;
clamp_foot_w = (clamp_body_l + 2.87169)*sin(45);
clamp_h = 8;
clamp_screw_d = 3 + 0.4;
clamp_lcd_screw_d = 3 + 0.8;
clamp_lcd_screw_dist = 3.6;
clamp_dist = 38.25;

clamp_left_slot_l = 3.2 + 0.8;
clamp_left_slot_w = 26.4 + 2*2;
clamp_left_slot_center_y = 9.25 + 26.4/2;

clamp_right_slot_l = 3.2;
clamp_right_slot_w = 15	;
clamp_right_slot_center_y = 18.75 + 15/2;

// Uncomment each one to generate left or right clamp
//lcd_clamp_left();
lcd_clamp_right();

module lcd_clamp_left()
{
	difference()
	{
		lcd_clamp();
		// lcd screw holes
		translate([-1, clamp_lcd_screw_dist, clamp_lcd_screw_dist]) rotate([0, 90, 0]) cylinder(r=clamp_lcd_screw_d/2, h=clamp_body_l + 2, center=false);
		translate([-1, clamp_body_w - clamp_lcd_screw_dist, clamp_lcd_screw_dist]) rotate([0, 90, 0]) cylinder(r=clamp_lcd_screw_d/2, h=clamp_body_l + 2, center=false);
		// lcd nut recesses
		translate([clamp_body_l + 0.05, clamp_lcd_screw_dist, clamp_lcd_screw_dist]) rotate([0, -90, 0]) rotate([0, 0, 90]) lib3d_hex_nut_recess(clamp_lcd_screw_d);
		translate([clamp_body_l + 0.05, clamp_body_w - clamp_lcd_screw_dist, clamp_lcd_screw_dist]) rotate([0, -90, 0]) rotate([0, 0, 90]) lib3d_hex_nut_recess(clamp_lcd_screw_d);
		// slot
		translate([-1, clamp_left_slot_center_y - clamp_left_slot_w/2, -1]) cube([clamp_left_slot_l + 1, clamp_left_slot_w, clamp_h + 2]);
	}
}

module lcd_clamp_right()
{
	difference()
	{
		lcd_clamp();
		// lcd screw holes
		translate([-1, clamp_lcd_screw_dist, clamp_h - clamp_lcd_screw_dist]) rotate([0, 90, 0]) cylinder(r=clamp_lcd_screw_d/2, h=clamp_body_l + 2, center=false);
		translate([-1, clamp_body_w - clamp_lcd_screw_dist, clamp_h - clamp_lcd_screw_dist]) rotate([0, 90, 0]) cylinder(r=clamp_lcd_screw_d/2, h=clamp_body_l + 2, center=false);
		// lcd nut recesses
		translate([clamp_body_l + 0.05, clamp_lcd_screw_dist, clamp_h - clamp_lcd_screw_dist]) rotate([0, -90, 0]) rotate([0, 0, 90]) lib3d_hex_nut_recess(clamp_lcd_screw_d);
		translate([clamp_body_l + 0.05, clamp_body_w - clamp_lcd_screw_dist, clamp_h - clamp_lcd_screw_dist]) rotate([0, -90, 0]) rotate([0, 0, 90]) lib3d_hex_nut_recess(clamp_lcd_screw_d);
		// slot
		translate([-1, clamp_right_slot_center_y - clamp_right_slot_w/2, -1]) cube([clamp_right_slot_l + 1, clamp_right_slot_w, clamp_h + 2]);
	}
}

module lcd_clamp()
{
	in_dia = 8;
	out_dia = 8 + 2*3.5;
	leg_length = 8;
	leg_space = 7;
	height = clamp_h;
	screw_dia = clamp_screw_d;
	screw_dist_from_end = 4.5;

	union()
	{
		// body
		cube([clamp_body_l, clamp_body_w, clamp_h]);
		// foot
		difference()
		{
			rotate([0, 0, 45]) translate([0, -clamp_foot_w + 0.01, 0]) cube([clamp_foot_l, clamp_foot_w, clamp_h]);
			translate([clamp_body_l, -clamp_foot_w + 5, -1]) cube([10, clamp_foot_w, clamp_h + 2]);
		}
		// clamp
		translate([clamp_body_l + in_dia/2, clamp_dist, 0]) rotate([0, 0, 90]) clamp(in_dia, out_dia, leg_length, leg_space, height, screw_dia, screw_dist_from_end);
	}
}
