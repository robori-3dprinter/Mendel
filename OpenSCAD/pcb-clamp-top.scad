// ========================================================================================
// Robori Mendel
// Top clamp level for RAMPS stack
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 15 Feb 2015 - First version
// ========================================================================================

include <library/component.scad>
include <library/library_3d.scad>
include <pcb-clamp-data.scad>

$fn = 25;

// PCB
pcb_screw_d = 125/1000*25.4 + 0.4;

// Plate
plate_h = 6;

pcb_clamp_top();

module pcb_clamp_top()
{
	in_dia = 8;
	out_dia = 16;
	leg_length = 11;
	leg_space = 8;
	height = 20;
	screw_dia = 3 + 0.4;
	screw_dist_from_end = 5.5;

	translate([0, 15.29, 0]) difference()
	{
		union()
		{
			// plate
			translate([-48.83, -69.5, 0]) linear_extrude(height=plate_h, center=false, convexity=10) import(file="../dxf/controller-assembly.dxf", layer="pcb-clamp-top-profile");
			// fan holder mount
			cube([fan_holder_mount_l, fan_holder_mount_h, fan_holder_mount_w]);
			// clamp
			translate([108.73, 4, in_dia/2 + plate_h]) rotate([-90, 0, 30]) clamp(in_dia, out_dia, leg_length, leg_space, height, screw_dia, screw_dist_from_end);
			translate([112.2, 6, 0]) rotate([0, 0, 30]) cube([out_dia/2 - in_dia/2, 20, plate_h + in_dia]);
		}
		// pcb mount screw hole
		translate([8.24, -8.7, -1]) cylinder(r=pcb_screw_d/2, h=plate_h + 2, center=false);
		// fan holder mount screw holes
		translate([fan_holder_mount_screw1_x, -1, fan_holder_mount_screw_y]) rotate([-90, 0, 0]) cylinder(r=fan_holder_mount_screw_d/2, h=fan_holder_mount_h + 2, center=false);
		translate([fan_holder_mount_screw2_x, -1, fan_holder_mount_screw_y]) rotate([-90, 0, 0]) cylinder(r=fan_holder_mount_screw_d/2, h=fan_holder_mount_h + 2, center=false);
		// fan holder mount void
		translate([fan_holder_mount_l/2 - fan_holder_mount_void_l/2, -1, fan_holder_mount_w + 1]) rotate([-90, 0, 0]) lib3d_round_cube(fan_holder_mount_void_l, fan_holder_mount_w - plate_h - fan_holder_mount_void_from_edge + 1,fan_holder_mount_h + 2 ,5, true, false, true, false);
	}
}
