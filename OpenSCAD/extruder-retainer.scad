// ========================================================================================
// Robori Mendel
// Extruder retainer
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 1 May 2015 - Increase thickness
// 2014 - First version
// ========================================================================================

use <extruder-block.scad>;

$fn = 25;

extruder_retainer();


module extruder_retainer()
{
	add_t = 0.5;
	
	difference()
	{
		union()
		{
			// base
			cube([31, 22, 6 + add_t]);
			translate([10, -4, 0]) cylinder(h=6 + add_t, r=10, center=false);
			translate([2, -14, 0]) cube([8, 6, 6 + add_t]);
		}
		// circle
		translate([10, 22, -1]) cylinder(h=6 + 2, r=16 + 1, center=false);
		// corners
		translate([31, 17.48, -1]) rotate([0, 0, 47.86]) cube([8, 8, 6 + 2]);
		translate([25.74, 0, -1]) rotate([0, 0, -45]) cube([8, 8, 6 + 2]);
		translate([8.47, 0, -1]) rotate([0, 0, 131.7]) cube([13, 13, 6 + 2]);
		// motor mount hole
		translate([25.5, 6.5, -1]) motor_mount_hole();
		// retainer
		translate([10, -4, -1]) cylinder(h=6 + 2, r=4, center=false);
		translate([0, -8, -1]) cube([10, 8, 6 + 2]);
		translate([0, -14, -1]) cube([2, 14, 6 + 2]);
	}
}
