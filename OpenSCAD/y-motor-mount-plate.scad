// ========================================================================================
// Robori Mendel
// Y motor mount plate
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 28 Jan 2015 - First version
// ========================================================================================

include <y-motor-mount-data.scad>;

$fn = 30;

y_motor_mount_plate();

module y_motor_mount_plate()
{
	translate([0, 0, 5]) rotate([180, 0, 0]) difference()
	{
		union()
		{
			y_motor_mount_base();
			// Bearing bushing
			translate([30.83, 10.02, 0.01]) rotate([180, 0, 0]) bearing_bushing();
			// Belt guide bushing
			translate([0, 0, -1.25 + 0.01]) belt_guide_bushing();
		}
		// Remove bushing
		translate([38, -32, 5]) cube([25, 25, 16 + 1]);
	}
}
