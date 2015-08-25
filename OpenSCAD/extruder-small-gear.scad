// ========================================================================================
// Robori Mendel
// Extruder small gear
// GNU GPL v3
// Derived from :
// - RepRapPro Mendel's extruder small gear
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 23 Jul 2015 - Reduce inner diameter
// ========================================================================================

$fn = 40;

extruder_small_gear();

// original in_dia = 5.2
// height = 14
module extruder_small_gear()
{
	in_dia = 5.4;

	union()
	{
		translate([0, 0, 14]) import("reprappro-small-gear-1off.stl");
		difference()
		{
			cylinder(h=14, r=5.2/2 + 1, center=false);
			translate([0, 0, -1]) cylinder(h=14 + 2, r=in_dia/2, center=false);
		}
	}
}
