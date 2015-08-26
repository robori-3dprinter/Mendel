// ========================================================================================
// Robori Mendel
// Cooling fan holder for RAMPS stack
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 16 Feb 2015 - First version
// ========================================================================================

include <library/library_3d.scad>
include <pcb-clamp-data.scad>

$fn=40;

// Level : controller stack height = 56mm
level_l = 50;
level_w = 6 + 56;
level_h = 6;

// Fan frame
frame_l = level_l;
frame_w = 25.7;
frame_h = 5;
frame_fan_d = 48;
frame_screw_d = 3 + 0.5;

pcb_fan_holder();

module pcb_fan_holder()
{
	void_w = level_w - fan_holder_mount_h - frame_h - 2*fan_holder_mount_void_from_edge;

	difference()
	{
		union()
		{
			// level
			cube([level_l, level_w, level_h]);
			// frame
			translate([0, level_w - frame_h, frame_w]) rotate([-90, 0, 0]) difference()
			{
				// frame plate
				cube([frame_l, frame_w, frame_h]);
				// fan
				translate([frame_l/2, -12.8, -1]) cylinder(r=frame_fan_d/2, h=frame_h + 2, center=false);
				// fan screw holes
				translate([5, 7.2, -1]) cylinder(r=frame_screw_d/2, h=frame_h + 2, center=false);
				translate([45, 7.2, -1]) cylinder(r=frame_screw_d/2, h=frame_h + 2, center=false);
			}
		}
		// holder mount screw holes
		translate([fan_holder_mount_screw1_x, fan_holder_mount_screw_y, -1]) cylinder(r=fan_holder_mount_screw_d/2, h=level_h + 2, center=false);
		translate([fan_holder_mount_screw2_x, fan_holder_mount_screw_y, -1]) cylinder(r=fan_holder_mount_screw_d/2, h=level_h + 2, center=false);
		// level void
		translate([level_l/2 - fan_holder_mount_void_l/2, level_w/2 - void_w/2, -1]) lib3d_round_cube(fan_holder_mount_void_l, void_w, level_h + 2 ,5, true, true, true, true);
	}
}
