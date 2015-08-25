// ========================================================================================
// Robori Mendel
// Endstop holder
// GNU GPL v3
// Derived from :
// - Prusa i3's endstop holder
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 17 May 2015 - Modify original screw holes to use 2mm screws
// ========================================================================================

$fn = 30;

microswitch_screw_d = 2 + 0.5;

endstop_holder();

module endstop_holder()
{
	rotate([90, 0, 0]) translate([0, 0, -18]) difference()
	{
		union()
		{
			// prusa i3 endstop holder
			translate([0, 0, 18]) rotate([-90, 0, 0]) import("prusa-i3-endstop-holder-3.stl");
			// cover the original microswitch screw holes
			translate([20, 1, 0]) cube([18, 8, 4]);
		}
		// microswitch screw holes
		translate([25.75, 5, -1]) cylinder(r=microswitch_screw_d/2, h=4 + 2, center=false);
		translate([35.25, 5, -1]) cylinder(r=microswitch_screw_d/2, h=4 + 2, center=false);
	}
}

// Code to create projection of prusa i3 endstop holder
//projection(cut=true) translate([0, 0, 18 - 0.1]) rotate([-90, 0, 0]) import("prusa-i3-endstop-holder-3.stl");
