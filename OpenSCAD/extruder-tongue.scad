// ========================================================================================
// Robori Mendel
// Extruder tongue
// GNU GPL v3
// Derived from :
// - RepRapPro Mendel's extruder tongue
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 23 Jul 2015 - Minor dimensional adjustments
// ========================================================================================

$fn = 30;

extruder_tongue();

module extruder_tongue()
{
	slot_l = 4 + 0.2;
	level_w = 8 - 0.2;

	difference()
	{
		union()
		{
			translate([-level_w/2, 0, 0]) cube([level_w, 23.8, 3.6]);
			translate([0, 23.8, 0]) cylinder(h=3.6, r=level_w/2, center=false);
		}
		// hole
		translate([0, 23.8, -1]) cylinder(h=3.6 + 2, r=1.6, center=false);
		// retainer
		translate([-slot_l/2, -1, -1]) cube([slot_l, 4 + 1, 3.6 + 2]);
		translate([0, 4, -1]) cylinder(h=3.6 + 2, r=slot_l/2, center=false);
		// cut
		translate([-4 - 1, -1, 2]) cube([8 + 2, 8 + 1, 1.6 + 1]);
		translate([-4 - 1, 8, 2]) rotate([-45, 0, 0]) translate([0, -5, 0]) cube([8 + 2, 5, 5]);
	}
}
