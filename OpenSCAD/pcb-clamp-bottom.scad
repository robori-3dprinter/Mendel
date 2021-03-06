// ========================================================================================
// Robori Mendel
// Bottom clamp for RAMPS stack
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 15 Feb 2015 - First version
// ========================================================================================

include <library/component.scad>

$fn = 25;

pcb_clamp_bottom();

module pcb_clamp_bottom()
{
	in_dia = 8 + 0.4;	// 2015-05-17 : increase dia by 0.4mm
	out_dia = 16;
	leg_length = 11;
	leg_space = 7;
	height = 13.17;
	screw_dia = 3 + 0.4;
	screw_dist_from_end = 5.5;

	plate_h = 6;

	difference()
	{
		union()
		{
			// clamp
			clamp(in_dia, out_dia, leg_length, leg_space, height, screw_dia, screw_dist_from_end);
			// plate
			translate([in_dia/2, -in_dia/2 - leg_length, 0]) cube([plate_h, 34.13, 13.17]);
		}
		// clamp screw hole
		translate([0, -in_dia/2 - leg_length + screw_dist_from_end, height/2]) rotate([0, 90, 0]) cylinder(r=screw_dia/2, h=out_dia + plate_h, center=false);
		// pcb screw hole
		translate([in_dia/2 - 1, 12.54, height/2]) rotate([0, 90, 0]) cylinder(r=screw_dia/2, h=plate_h + 2, center=false);
	}
}
