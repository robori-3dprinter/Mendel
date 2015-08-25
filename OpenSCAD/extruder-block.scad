// ========================================================================================
// Robori Mendel
// Extruder block
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 1 May 2015 - Increase plate thickness
// ========================================================================================

include <library/library_3d.scad>;

$fn = 30;
lib3d_fn = 30;

// Add plate thickness
add_t = 0.5;
union()
{
	extruder_block();
	translate([0, 0, -add_t + 0.01]) linear_extrude(height=add_t, convexity=10) import(file="extruder-block-projection.dxf", layer="0");
}

// Create 2D projection to be exported into DXF
//projection(cut=true) translate([0, 0, -0.1]) extruder_block();


module extruder_block()
{
	rotate([180, 0, 180]) union()
	{
		base();
		translate([22.5, 51, 0]) clamp();
		translate([44.74 + 1.5, 28, 0]) idler_mount();
		translate([44.74 + 1.5, -3, 0]) idler_adjuster();
	}
}

module idler_adjuster()
{
	nut_size = 3 + 0.8;
	nut_h = 0.8*nut_size;
	recess_h = 7;
	count = floor(recess_h/nut_h);

	difference()
	{
		// block
		translate([0, 0, -24.25]) lib3d_round_cube(21.12, 14 + 3, 24.25, 3, false, false, false, true);
		// bearing housing
		translate([9.87, 21 + 3, -24.25 - 1]) cylinder(h=24.25 + 2, r=9 + 0.3, center=false);
		// angle cut
		translate([17.4, 14 + 3, -24.25 - 1]) rotate([0, 0, -25]) cube([5, 5, 24.25 + 2]);
		// screw hole
		translate([9.87, 2.75 + 3, -24.25 - 1 - 0.5]) cylinder(h=20.5 + 1 + add_t, r=1.5 + 0.4, center=false);
		translate([9.87, 2.75 + 3, -3.75 + add_t]) cylinder(h=3.75 + 1 - add_t, r=2.25 + 0.75, center=false);
		// idler screw holes
		translate([-1, 8.5 + 3, -4.75]) rotate([0, 90, 0]) cylinder(h=21.12 + 2, r=2, center=false);
		translate([-1, 8.5 + 3, -19.75]) rotate([0, 90, 0]) cylinder(h=21.12 + 2, r=2, center=false);
		// idler nut recesses
		for (i = [0 : 1 : count - 1])
		{
			translate([i*nut_h - (i + 1)*0.02, 8.5 + 3, -4.75]) rotate([90, 0, 90]) lib3d_hex_nut_recess(nut_size);
			translate([i*nut_h - (i + 1)*0.02, 8.5 + 3, -19.75]) rotate([90, 0, 90]) lib3d_hex_nut_recess(nut_size);
		}
		translate([recess_h - nut_h, 8.5 + 3, -4.75]) rotate([90, 0, 90]) lib3d_hex_nut_recess(nut_size);
		translate([recess_h - nut_h, 8.5 + 3, -19.75]) rotate([90, 0, 90]) lib3d_hex_nut_recess(nut_size);
		// filament hole
		translate([16.25, -1, -12.25]) rotate([-90, 0, 0]) cylinder(h=14 + 3 + 2, r=1.25, center=false);
		// cut length
		translate([-1, -1, -24.25 -1]) cube([3.5 + 1, 14 + 3 + 2, 24.25 + 2]);
	}
}

module idler_mount()
{
	difference()
	{
		union()
		{
			// block
			translate([0, 0, -24.25]) cube([21.12, 14 + 3, 24.25]);
			// mount
			translate([17.4, 0, -24.25]) lib3d_round_cube(21.58, 17, 24.25, 5, false, false, true, false);
		}
		// bearing housing
		translate([9.87, -7, -24.25 - 1]) cylinder(h=24.25 + 2, r=9 + 0.3, center=false);
		// mount
		// 2015-05-13 : adjust idler position 0.5mm to center MK7 drive gear
		translate([21.12, 0, -7.75 - 0.5 - 0.5]) lib3d_round_cube(13, 13, 7.75 + 0.5 + 1, 2, true, false, true, false);
		translate([21.12, 0, -24.25 - 1 + 0.5]) lib3d_round_cube(13, 13, 7.5 - 0.5 + 1, 2, true, false, true, false);
		// mount hole
		translate([26.62, 7.5, -9 - 7.75 - 0.5 - 0.5]) cylinder(h=9, r=1.5 + 0.4, center=false);
		// angle cut
		translate([17.4, 0, -24.25 - 1]) rotate([0, 0, -65]) cube([10, 25, 24.25 + 2]);
		// screw hole
		translate([9.87, 11.25, -24.25 - 1 - 0.5]) cylinder(h=20.5 + 1 + add_t, r=1.5 + 0.4, center=false);
		translate([9.87, 11.25, -3.75 + add_t]) cylinder(h=3.75 + 1 - add_t, r=2.25 + 0.75, center=false);
		// bowden start slot
		translate([16.25, 17, -13.25]) rotate([90, 0, 0]) cylinder(h=13 + 1, r=3.5, center=false);
		translate([16.25, -1, -12.25]) rotate([-90, 0, 0]) cylinder(h=4 + 2, r1=2.25, r2=0.75, center=false);
		// tongue slot
		translate([12.25 - 0.1, 5.2 - 0.3, -24.25 - 1]) cube([8 + 0.2, 4 + 0.6, 15.8 + 1]);
	}
}

module clamp()
{
	translate([0, 0, -30]) difference()
	{
		// block
		union()
		{
			cylinder(h=30, r=8, center=false);
			translate([-8, 0, 0]) cube([16, 16, 30]);
		}
		// threaded rod slot
		translate([0, 0, -1]) cylinder(h=30 + 2, r=4 + 0.25, center=false);
		translate([-4, 0, -1]) cube([8 + 0.5, 16 + 1, 30 + 2]);
		// screw holes
		translate([0, 11.5, 5.5]) rotate([0, 90, 0]) cylinder(h=18 + 2, r=1.5 + 0.5, center=true);
		translate([0, 11.5, 24.5]) rotate([0, 90, 0]) cylinder(h=18 + 2, r=1.5 + 0.5, center=true);
	}
}

module base()
{
	difference()
	{
		union()
		{
			// plate
			translate([0, 0, -6]) cube([44.74 + 1.5, 42, 6]);
			// clamp base
			translate([0, 42 - 0.1, -6]) cube([41, 9.5 + 0.1, 6]);
			// bearing housing
			translate([44.74 + 1.5 - 1, 11.76, -6]) cube([21.12 + 1, 18.47, 6]);
			translate([54.61 + 1.5, 21, -8]) cylinder(h=8, r=9 + 0.35, center=false);
		}
		// clamp base
		translate([41, 42, -6 - 1]) rotate([0, 0, 45]) cube([15, 15, 6 + 2]);
		translate([13.5, 51.5, -6 - 1]) rotate([0, 0, 135]) cube([15, 20, 6 + 2]);
		translate([18.5, 47, -6 - 1]) cube([8 + 2, 8, 6 + 2]);
		// corner
		translate([4, 0, -6 - 1]) rotate([0, 0, 135]) cube([6, 6, 6 + 2]);
		// circle
		translate([22.5, 21, -6 - 1]) cylinder(h=6 + 2, r=16, center=false);
		// mount holes
		translate([7, 36.5, -6 - 1]) motor_mount_hole();
		translate([7, 5.5, -6 - 1]) motor_mount_hole();
		translate([38, 36.5, -6 - 1]) motor_mount_hole();
		// retainer slot
		translate([20.08, 0, -6 - 1]) rotate([0, 0, 41.7]) cube([10, 12, 6 + 2]);
		translate([44.74 + 1.5, 14, -6 - 1]) rotate([0, 0, 137.86]) cube([12, 12, 6 + 2]);
		translate([20.08, -1, -6 - 1]) cube([24.65 + 1.5 + 3.5 + 0.03, 14 + 1, 6 + 2]);
		// bearing housing
		translate([54.61 + 1.5, 21, -8 - 1]) cylinder(h=8 + 2, r=5.5, center=false);
		translate([54.61 + 1.5, 21, -8 - 3]) cylinder(h=8, r=7 + 0.15, center=false);
	}
}

module motor_mount_hole()
{
	union()
	{
		translate([1.5 - 0.25, 0, 0]) cylinder(h=6 + 2, r=1.5 + 0.25, center=false);
		translate([-1.5 + 0.25, 0, 0]) cylinder(h=6 + 2, r=1.5 + 0.25, center=false);
		translate([-1.5, -1.5 - 0.25, 0]) cube([3, 3 + 0.5, 6 + 2]);
	}
}
