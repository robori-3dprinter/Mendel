// ========================================================================================
// Robori Mendel
// Extruder bearing cover
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 2014 - First version
// ========================================================================================

include <library/library_3d.scad>;

$fn = 25;

extruder_bearing_cover();

module extruder_bearing_cover()
{
	difference()
	{
		union()
		{
			difference()
			{
				// block
				lib3d_round_cube(21.12, 42 + 3 + 3, 6, 3, false, false, true, true);
				// idler adjuster cut
				translate([-1, -1, -1]) cube([3.5 + 1, 14 + 3 + 1, 6 + 2]);
				translate([3.5, 14 + 3, -1]) rotate([0, 0, 104.04]) cube([15, 15, 6 + 2]);
			}
			// bearing housing
			translate([9.87, 21 + 3, 0]) cylinder(h=9.25, r=9, center=false);
		}
		// bearing housing
		translate([9.87, 21 + 3, -1]) cylinder(h=9.25 + 2, r=5.5, center=false);
		translate([9.87, 21 + 3, 4.25]) cylinder(h=5 + 1, r=7 + 0.15, center=false);
		// tongue slot
		translate([12.25 - 0.1, 33.2 + 3 - 0.3, -1]) cube([8 + 0.2 + 1, 4 + 0.6, 6 + 2]);
		// screw holes
		translate([9.87, 2.75 + 3, -1]) cylinder(h=6 + 2, r=1.5 + 0.4, center=false);
		translate([9.87, 39.25 + 3, -1]) cylinder(h=6 + 2, r=1.5 + 0.4, center=false);
		// nut recesses : disabled due to tongue slot
		//translate([9.87, 2.75, -0.02]) lib3d_hex_nut_recess(3 + 0.4);
		//translate([9.87, 39.25, -0.02]) lib3d_hex_nut_recess(3 + 0.4);
	}
}
