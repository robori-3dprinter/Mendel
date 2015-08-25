// ========================================================================================
// Robori Mendel
// LCD cover for RepRapDiscount 2004 smart controller
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 22 May 2015 - First version
// ========================================================================================

include <library/library_3d.scad>

$fn = 30;

cover_l = 151 + 2;
cover_w = 64 + 2 + 2.5;	
cover_h = 14;
cover_r = 1.5;
cover_wall_t = 2.5;
cover_front_t = 2.5;
cover_pillar_t = 2.5;
cover_screw_d = 3 + 1;

cover_screen_l = 97 + 2*1;
cover_screen_w = 40 + 2*1.2;

cover_buzz_l = 11.5;
cover_buzz_w = 2;

cover_encoder_d = 15 + 2;
cover_reset_d = 3.5;


lcd_cover();

module lcd_cover()
{
	// screw
	screw_dist = 2.6 + 1;
	lcd_pcb_excess = 8.5 + 1 + 2.5;
	screw1 = [screw_dist, cover_w - screw_dist, 0];
	screw2 = [cover_l - screw_dist, cover_w - screw_dist, 0];
	screw3 = [screw_dist, lcd_pcb_excess + screw_dist - 1, 0];
	screw4 = [cover_l - screw_dist, lcd_pcb_excess + screw_dist - 1, 0];

	// screen
	screen_center_x = 14.25 + 1 + 97/2;
	screen_center_y = 11 + 1 + 2.5 + 40/2;

	// buzz
	buzz_center_x = 136.5 + 1;
	buzz_center_y = 45 + lcd_pcb_excess;
	buzz_space_y = 2;

	// encoder
	encoder_x = 137.5 + 1;
	encoder_y = 25.5 + lcd_pcb_excess;

	// reset
	reset_x = 137 + 1;
	reset_y = 9 + lcd_pcb_excess;

	translate([0, cover_w, cover_h]) rotate([180, 0, 0]) difference()
	{
		union()
		{
			difference()
			{
				// block
				lib3d_round_cube(cover_l, cover_w, cover_h, cover_r, left_top=true, left_bottom=true, right_top=true, right_bottom=true);
				// wall : 4 sides
				//translate([cover_wall_t, cover_wall_t, -cover_front_t]) cube([cover_l - 2*cover_wall_t, cover_w - 2*cover_wall_t, cover_h]);
				// wall : bottom only
				translate([cover_wall_t, cover_wall_t, -cover_front_t]) cube([cover_l - 2*cover_wall_t, cover_w, cover_h]);
				translate([-1, lcd_pcb_excess + screw_dist - 1, -cover_front_t]) cube([cover_l + 2, cover_w, cover_h]);
			}
			// pillars
			translate(screw1) cylinder(r=cover_screw_d/2 + cover_pillar_t, h=cover_h, center=false);
			translate(screw2) cylinder(r=cover_screw_d/2 + cover_pillar_t, h=cover_h, center=false);
			translate(screw3) cylinder(r=cover_screw_d/2 + cover_pillar_t, h=cover_h, center=false);
			translate(screw4) cylinder(r=cover_screw_d/2 + cover_pillar_t, h=cover_h, center=false);
		}
		// screw holes
		translate([screw1[0], screw1[1], -1]) cylinder(r=cover_screw_d/2, h=cover_h + 2, center=false);
		translate([screw2[0], screw2[1], -1]) cylinder(r=cover_screw_d/2, h=cover_h + 2, center=false);
		translate([screw3[0], screw3[1], -1]) cylinder(r=cover_screw_d/2, h=cover_h + 2, center=false);
		translate([screw4[0], screw4[1], -1]) cylinder(r=cover_screw_d/2, h=cover_h + 2, center=false);
		// cut screw hole block excesses
		translate([-5, cover_w, -1]) cube([cover_l + 2*5, 10, cover_h + 2]);	// top
		translate([-10, -5, -1]) cube([10, cover_w + 2*5, cover_h + 2]);		// left
		translate([cover_l, -5, -1]) cube([10, cover_w + 2*5, cover_h + 2]);	// right
		// screen
		translate([screen_center_x - cover_screen_l/2, screen_center_y - cover_screen_w/2, -1]) cube([cover_screen_l, cover_screen_w, cover_h + 2]);
		// buzz
		translate([buzz_center_x - cover_buzz_l/2, buzz_center_y - buzz_space_y/2 - cover_buzz_w, -1]) cube([cover_buzz_l, cover_buzz_w, cover_h + 2]);
		translate([buzz_center_x - cover_buzz_l/2, buzz_center_y + buzz_space_y/2, -1]) cube([cover_buzz_l, cover_buzz_w, cover_h + 2]);
		// encoder
		translate([encoder_x, encoder_y, -1]) cylinder(r=cover_encoder_d/2, h=cover_h + 2, center=false);
		// reset
		translate([reset_x, reset_y, -1]) cylinder(r=cover_reset_d/2, h=cover_h + 2, center=false);
	}
}
