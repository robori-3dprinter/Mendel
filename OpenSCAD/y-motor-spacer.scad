// ========================================================================================
// Robori Mendel
// Y motor spacer
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 28 Jan 2015 - First version
// ========================================================================================

$fn = 25;

y_motor_spacer();

module y_motor_spacer()
{
	spacer_h = 16;
	id = 3 + 0.5;
	od = id + 2*4;

	difference()
	{
		cylinder(h=spacer_h, r=od/2, center=false);
		translate([0, 0, -1]) cylinder(h=spacer_h + 2, r=id/2, center=false);
	}
}
