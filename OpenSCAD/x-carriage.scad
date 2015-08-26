// ========================================================================================
// Robori Mendel
// X carriage
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 30 Jan 2015 - First version
// ========================================================================================

include <library/library_3d.scad>
include <x-axis-data.scad>

lib3d_fn = 25;
$fn=25;

x_carriage();

// X carriage LM8UU holder modification
xc_lm8uu_holder_h = lm8uu_holder_h/2 + belt_rod_h;

// Plate
plate_l = lm8uu_holder_l;
plate_w = rod_dist + LM8UU_OD + 2*lm8uu_holder_wall_t - lm8uu_holder_w;
plate_h = 5;

// Hot end
hot_end_l = 13 + 11;		// heatsink + fan
hot_end_w = 40;

// X carriage
x_carriage_l = 2*hot_end_l + plate_l + 2*2;
x_carriage_w = plate_w + lm8uu_holder_w;

// Hot end mounting
mounting_l = 10;
mounting_w = x_carriage_w - 2*lm8uu_holder_w + 2*1;
mounting_h = xc_lm8uu_holder_h - 15;			// Hot end total h = 25, below x carriage = 10
mounting_bowden_end_d = 5 + 1;
mounting_screw_d = 3 + 0.3;
mounting_spring_washer_d = 6 + 1;
mounting_spring_washer_h = 1;

// Belt clamp
clamp_l = 3.5;
clamp_w = 6 + 3 + 3 + 4;	// belt + space + screw + spare
clamp_h = 12;
clamp_slot_l = 2.01 + 0.3;
clamp_screw_d = 3 + 0.4;	// hole = clamp_screw_d, nut recess = clamp_screw_d + 0.3 (added in code)

// Fan frame
frame_l = 10;
frame_w = 40;
frame_h = 5;

module x_carriage()
{
	plate_x = (x_carriage_l - plate_l)/2;
	mounting_cut_w = x_carriage_w - 2*lm8uu_holder_w - 2;
	lm8uu_holder_cut_l = plate_l/2 - (x_carriage_l - 2*lm8uu_holder_l)/2;

	union()
	{
		difference()
		{
			union()
			{
				// Plate
				translate([plate_x, lm8uu_holder_w - 0.05, 0]) cube([plate_l, plate_w, plate_h]);
				// Fan frame
				translate([plate_x + 0.05, x_carriage_w/2 - frame_w/2, 0]) rotate([0, -135, 0]) translate([0, 0, -frame_h]) cube([frame_l, frame_w, frame_h]);
				// LM8UU holder additions
				if (lm8uu_holder_cut_l <= 0)
				{
					translate([plate_x + lm8uu_holder_cut_l - 0.05, x_carriage_w - lm8uu_holder_w, 0]) cube([-lm8uu_holder_cut_l + 2*0.05, lm8uu_holder_w, plate_h]);
					translate([plate_x + plate_l - 0.05, x_carriage_w - lm8uu_holder_w, 0]) cube([-lm8uu_holder_cut_l + 2*0.05, lm8uu_holder_w, plate_h]);
				}
			}
			// LM8UU holder cuts
			if (lm8uu_holder_cut_l > 0)
			{
				translate([plate_x - 1 + 0.05, x_carriage_w - lm8uu_holder_w - 0.05, -1]) cube([lm8uu_holder_cut_l + 1, lm8uu_holder_w + 1, plate_h + 2]);
				translate([plate_x + plate_l - lm8uu_holder_cut_l - 0.05, x_carriage_w - lm8uu_holder_w - 0.05, -1]) cube([lm8uu_holder_cut_l + 1, lm8uu_holder_w + 1, plate_h + 2]);
			}
			// Hot end mounting cut right
			//translate([plate_x - 1, x_carriage_w/2 - mounting_cut_w/2, -1]) cube([mounting_l, mounting_cut_w, plate_h + 2]);
			// Hot end mounting cut left
			translate([plate_x + plate_l - mounting_l + 1, x_carriage_w/2 - mounting_cut_w/2, -1]) cube([mounting_l, mounting_cut_w, plate_h + 2]);
			// Fan
			translate([plate_x + 0.05, x_carriage_w/2 - frame_w/2, 0]) rotate([0, -135, 0]) translate([0, 0, -frame_h])
			{
				// Fan circle
				translate([FAN40_L/2, FAN40_L/2, -1]) cylinder(r=FAN40_ID/2, h=frame_h + 2, center=false);
				// Screw holes
				translate([FAN40_SCREW_FROM_EDGE, FAN40_SCREW_FROM_EDGE, -1]) cylinder(r=FAN40_SCREW_D/2, h=frame_h + 2, center=false);
				translate([FAN40_SCREW_FROM_EDGE, frame_w - FAN40_SCREW_FROM_EDGE, -1]) cylinder(r=FAN40_SCREW_D/2, h=frame_h + 2, center=false);
				// Washer slots
				translate([FAN40_SCREW_FROM_EDGE, FAN40_SCREW_FROM_EDGE, -5 + 0.05]) cylinder(r=WASHER_M3_OD/2 + 1, h=5, center=false);
				translate([FAN40_SCREW_FROM_EDGE, frame_w - FAN40_SCREW_FROM_EDGE, -5 + 0.05]) cylinder(r=WASHER_M3_OD/2 + 1, h=5, center=false);
			}
		}
		// Hot end mounting right
		//translate([plate_x + mounting_l, x_carriage_w/2 - mounting_w/2, 0]) mirror([1, 0, 0]) hot_end_mounting();
		// Hot end mounting left
		translate([plate_x + plate_l - mounting_l, x_carriage_w/2 - mounting_w/2, 0]) hot_end_mounting();
		// Belt clamp
		translate([x_carriage_l/2, x_carriage_w, 0]) belt_clamp();
		// LM8UU holders
		translate([lm8uu_holder_l, x_carriage_w - lm8uu_holder_w, 0]) mirror([1, 0, 0]) xc_lm8uu_holder();
		translate([x_carriage_l - lm8uu_holder_l, x_carriage_w - lm8uu_holder_w, 0]) xc_lm8uu_holder();
		translate([(x_carriage_l - lm8uu_holder_l)/2, 0, 0]) xc_lm8uu_holder();
	}
}

module belt_clamp()
{
	screw_y = 6 + 3 + clamp_screw_d/2;

	difference()
	{
		union()
		{
			// Clamps
			translate([clamp_slot_l/2, 0, 0]) cube([clamp_l, clamp_w, clamp_h]);
			translate([clamp_slot_l/2 + clamp_l/2, clamp_w, 0]) cylinder(r=clamp_l/2, h=clamp_h, center=false);
			translate([-clamp_slot_l/2 - clamp_l, 0, 0]) cube([clamp_l, clamp_w, clamp_h]);
			translate([-clamp_slot_l/2 - clamp_l/2, clamp_w, 0]) cylinder(r=clamp_l/2, h=clamp_h, center=false);
			// Connector
			translate([-clamp_l - clamp_slot_l/2, -4, 0]) cube([2*clamp_l + clamp_slot_l, 4 + 0.1, clamp_h]);
			// Screw recess
			translate([clamp_slot_l/2 + clamp_l - 0.1, screw_y - 4.5, 0]) difference()
			{
				cube([3.5, 9, clamp_h]);
				translate([-0.1, 4.5, clamp_h/2]) rotate([0, 90, 0]) rotate([0, 0, 90]) lib3d_hex_nut_recess(clamp_screw_d + 0.3);
				translate([2, 4.5, clamp_h/2]) rotate([0, 90, 0]) rotate([0, 0, 90]) lib3d_hex_nut_recess(clamp_screw_d + 0.3);
			}
		}
		// Screw hole
		translate([-clamp_slot_l/2 - clamp_l - 1, screw_y, clamp_h/2]) rotate([0, 90, 0]) cylinder(r=clamp_screw_d/2, h=2*clamp_l+clamp_slot_l + 2, center=false);
	}
}

module hot_end_mounting()
{
	mounting_y = 4;

	translate([mounting_l, mounting_w/2, 0]) rotate([0, 0, 90]) difference()
	{
		translate([mounting_w/2, 0, 0]) rotate([0, 0, 90]) cube([mounting_l, mounting_w, mounting_h]);
		// Bowden end slot
		translate([0, mounting_y, -1]) slot(mounting_bowden_end_d, mounting_l, mounting_h);
		// Screw slots
		translate([7.5, mounting_y, -1]) slot(mounting_screw_d, mounting_l, mounting_h);
		translate([-7.5, mounting_y, -1]) slot(mounting_screw_d, mounting_l, mounting_h);
		// Spring washer recess
		translate([7.5, mounting_y, mounting_h - mounting_spring_washer_h]) cylinder(r=mounting_spring_washer_d/2, h=mounting_spring_washer_h + 1, center=false);
		translate([-7.5, mounting_y, mounting_h - mounting_spring_washer_h]) cylinder(r=mounting_spring_washer_d/2, h=mounting_spring_washer_h + 1, center=false);
	}
}

module slot(dia, width, height)
{
	union()
	{
		cylinder(r=dia/2, h=height + 2, center=false);
		translate([-dia/2, -width, 0]) cube([dia, width, height + 2]);
	}
}

module xc_lm8uu_holder()
{
	delta_h = xc_lm8uu_holder_h - lm8uu_holder_h;

	union()
	{
		cube([lm8uu_holder_l, lm8uu_holder_w, delta_h + 0.1]);
		translate([0, 0, delta_h]) lm8uu_holder();
	}
}
