// ========================================================================================
// Robori Mendel
// Shared modules for Y motor mount parts
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 28 Jan 2015 - First version
// ========================================================================================

module belt_guide_bushing()
{
	// 2015-05-17 : increase height by 0.25mm
	linear_extrude(height=1 + 0.25 + 0.25, center=false, convexity=10) import(file="../dxf/y-motor-mount.dxf", layer="belt-guide-bushing-profile");
}

module bearing_bushing()
{
	bb_h = 3 + 0.25;
	bb_id = 5 + 0.5;
	bb_od1 = bb_id + 2*3;
	bb_od2 = bb_id + 2*1.5;
	
	difference()
	{
		cylinder(h=bb_h, r1=bb_od1/2, r2=bb_od2/2, center=false);
		translate([0, 0, -1]) cylinder(h=bb_h + 2, r=bb_id/2, center=false);
	}
}

// base h = 5
// bushing h = 16
module y_motor_mount_base()
{
	idler_d = 5 + 0.5;

	translate([0, 0, -3]) difference()
	{
		union()
		{
			// Original :
			//   base h = 8
			//   bushing h = 16
			import("reprappro-y-motor-mount-1off.stl");
			// Fill screw holes
			translate([-7, -25, 3]) cube([6, 6, 5]);
			translate([0, 17, 3]) cube([10, 10, 5]);
			translate([17, -8, 3]) cube([10, 10, 5]);
			translate([31, 5, 3]) cube([6, 6, 5]);
		}
		// Base h = 5
		translate([-35, -35, -1]) cube([100, 80, 3 + 1]);
		// Remove bushings
		translate([-30, -5, 8]) cube([20, 20, 16 + 1]);
		translate([-12, -30, 8]) cube([20, 20, 16 + 1]);
		translate([20, 0, 8]) cube([20, 20, 16 + 1]);
		// Motor screw slots
		translate([21.59, -3.81, 3 - 1]) rotate([0, 0, 53.77]) motor_screw_slot();
		translate([-21.59, 3.81, 3 - 1]) rotate([0, 0, 53.77]) motor_screw_slot();
		// Idler bearing screw hole
		translate([30.83, 10.02, 3 - 1]) cylinder(h=5 + 2, r=idler_d/2, center=false);
	}
}

module motor_screw_slot()
{
	base_h = 5;
	d = 3 + 0.5;
	l = 7;
	x = l/2 - d/2;

	union()
	{
		translate([-x, -d/2, 0]) cube([l - d, d, base_h + 2]);
		translate([x, 0, 0]) cylinder(h=base_h + 2, r=d/2, center=false);
		translate([-x, 0, 0]) cylinder(h=base_h + 2, r=d/2, center=false);
	}
}
