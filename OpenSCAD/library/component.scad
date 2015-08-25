// ========================================================================================
// Robori Mendel
// RP library
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 31 Jan 2015 - First version
// ========================================================================================

include <component-data.scad>

component_fn = 25;

// Rod clamp
module clamp(in_dia, out_dia, leg_length, leg_space, height, screw_dia, screw_dist_from_end)
{
	difference()
	{
		union()
		{
			cylinder(h=height, r=out_dia/2, center=false, $fn=component_fn);
			translate([-out_dia/2, -in_dia/2 - leg_length, 0]) cube([out_dia, in_dia/2 + leg_length, height]);
		}
		// hole
		translate([0, 0, -1]) cylinder(h=height + 2, r=in_dia/2, center=false, $fn=component_fn);
		// leg space
		translate([-leg_space/2, -in_dia/2 - leg_length - 1, -1]) cube([leg_space, in_dia/2 + leg_length + 1, height + 2]);
		// screw hole
		translate([-out_dia/2 - 1, -in_dia/2 - leg_length + screw_dist_from_end, height/2]) rotate([0, 90, 0]) cylinder(h=out_dia + 2, r=screw_dia/2, center=false, $fn=component_fn);
	}
}

// LM8UU holder
lm8uu_holder_wall_t = 3;
lm8uu_holder_cone_l = 2;
lm8uu_holder_slot_w = 9;
lm8uu_holder_id = LM8UU_OD - 0.1;
lm8uu_holder_l = LM8UU_L + lm8uu_holder_cone_l;
lm8uu_holder_w = LM8UU_OD + 2*lm8uu_holder_wall_t;
lm8uu_holder_h = LM8UU_OD + 2*lm8uu_holder_cone_l;

module lm8uu_holder()
{
	cone_d1 = 0;
	cone_d2 = LM8UU_OD + 2*lm8uu_holder_cone_l;
	cone_h = cone_d2/2;

	difference()
	{
		// Block
		cube([lm8uu_holder_l, lm8uu_holder_w, lm8uu_holder_h]);
		// Cylinder
		translate([-1, lm8uu_holder_w/2, lm8uu_holder_cone_l + LM8UU_OD/2]) rotate([0, 90, 0]) cylinder(r=lm8uu_holder_id/2, h=lm8uu_holder_l + 2, center=false, $fn=component_fn);
		// Cone
		translate([lm8uu_holder_l - cone_h + 0.01, lm8uu_holder_w/2, lm8uu_holder_cone_l + LM8UU_OD/2]) rotate([0, 90, 0]) cylinder(r1=cone_d1/2, r2=cone_d2/2, h=cone_h, center=false, $fn=component_fn);
		// Slot
		translate([-1, lm8uu_holder_w/2 - lm8uu_holder_slot_w/2, lm8uu_holder_h - lm8uu_holder_cone_l*2 - 1]) cube([lm8uu_holder_l + 2, lm8uu_holder_slot_w, lm8uu_holder_cone_l*2 + 2]);
	}
}
