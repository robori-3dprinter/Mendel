// ========================================================================================
// Robori Mendel
// Y motor mount
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 28 Jan 2015 - First version
// ========================================================================================

include <y-motor-mount-data.scad>

$fn = 30;

y_motor_mount();

module y_motor_mount()
{
	union()
	{
		y_motor_mount_base();
		// Bearing bushing
		translate([30.83, 10.02, 5 - 0.01]) bearing_bushing();
		// Belt guide bushing
		translate([0, 0, 5 - 0.01]) belt_guide_bushing();
	}
}
