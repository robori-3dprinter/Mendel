// ========================================================================================
// Robori Mendel
// X belt guide
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 6 Feb 2015 - First version
// ========================================================================================

$fn = 25;

x_belt_guide();

module x_belt_guide()
{
	od = 15;
	id = 3 + 0.5;
	height = 2.1;

	difference()
	{
		cylinder(r=od/2, h=height, center=false);
		translate([0, 0, -1]) cylinder(r=id/2, h=height + 2, center=false);
	}
}
