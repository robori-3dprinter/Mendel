// ========================================================================================
// Robori Mendel
// Filament holder clamp rear
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 17 Jun 2015 - First version
// ========================================================================================

include <library/library_3d.scad>
include <library/component.scad>

$fn = 40;
lib3d_fn = 40;
component_fn = 40;

// rod holder
holder_l = 15;
holder_w = 15;
holder_h = 15;
holder_id = 8 + 0.6;
holder_r = 2;

// clamp
clamp_id = 8 + 0.4;
clamp_od = 8 + 2*3;
clamp_leg_length = 8;
clamp_leg_space = 7;
clamp_h = 15;
clamp_screw_d = 3 + 0.4;
clamp_screw_dist = 4.5;

filament_holder_clamp();

module filament_holder_clamp()
{
	difference()
	{
		union()
		{
			// rod holder block
			translate([-holder_l/2, 0, holder_h]) rotate([0, 90, 0]) lib3d_round_cube(holder_h, holder_w, holder_l, holder_r, true, true, true, true);
			// clamp
			translate([0, -clamp_id/2, 0]) clamp(clamp_id, clamp_od, clamp_leg_length, clamp_leg_space, clamp_h, clamp_screw_d, clamp_screw_dist);
		}
		// rod holder hole 
		translate([-holder_l/2 - 1, holder_w/2, holder_h/2]) rotate([0, 90, 0]) cylinder(r=holder_id/2, h=holder_l + 2, center=false);
	}
}
