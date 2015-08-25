// ========================================================================================
// Robori Mendel
// Extruder large gear
// GNU GPL v3
// Note :
// - Need MCAD library installed (included in OpenSCAD distribution by default)
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 2014 - First version
// ========================================================================================

include <MCAD/involute_gears.scad>;
include <library/library_3d.scad>;

$fn = 25;

extruder_large_gear();


module extruder_large_gear()
{
	hub_t = 9;
	nut_size = 5 + 0.25;
	nut_h = 0.8*nut_size;

	difference()
	{
		gear(number_of_teeth = 47,
			  circular_pitch = 200,
			  gear_thickness = 5,
			  rim_thickness = 6,
			  rim_width = 3,
			  hub_thickness = hub_t,
			  hub_diameter = 15,
			  bore_diameter = 5.5,
			  circles = 5);
		translate([0, 0, hub_t - nut_h + 0.02]) lib3d_hex_nut_recess(nut_size);
		// testing nut recess
		//translate([0, 0, -1]) cylinder(h=6 + 1 + 0.2, r=30, center=false);
	}
}
