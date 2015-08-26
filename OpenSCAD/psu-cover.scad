// ========================================================================================
// Robori Mendel
// Power supply unit cover
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 27 Mar 2015 - First version
// ========================================================================================

$fn = 30;

// Cover
cover_wall_t = 2.5;
cover_face_t = 2.5;
cover_face_dist = 15;
cover_overlap_dist = 26;		// terminal gap = 12mm
cover_l = 111 + 2*cover_wall_t + 0.5;
cover_w = 50 + cover_wall_t + 0.75;
cover_h = cover_face_t + cover_face_dist + cover_overlap_dist;

cover_screw_d = 3 + 0.8;
cover_screw2_driving_d = 5;
cover_screw2_block_l = 10;
cover_screw2_block_w = 6;
cover_screw2_block_h = cover_face_t + cover_face_dist + 10;

// Power socket
socket_l = 27 + 2*0.5;
socket_w = 18.25 + 2*0.5;
socket_screw_d = 3 + 0.6;

// Outlet
outlet_d = 8 + 1;
outlet_space = 3;
outlet_slot_l = 2*2.5 + 3;
outlet_slot_w = 2;
outlet_slot_space = 7;

optimized_psu_cover();
//psu_cover();

module optimized_psu_cover()
{
	cut_h = cover_overlap_dist - 20;
	excess_dist = 20;

	difference()
	{
		psu_cover();
		translate([-cover_wall_t - excess_dist, -1, cover_h - cut_h]) cube([cover_l, cover_w + 2, cut_h + 1]);
		//translate([cover_wall_t + 1, cover_w/2 + excess_dist, cover_h - cut_h]) cube([cover_l, cover_w, cut_h + 1]);
		translate([cover_l - cover_wall_t - excess_dist, -1, cover_h - cut_h]) rotate([0, 45, 0]) translate([-20, 0, 0]) cube([20, cover_wall_t + 2, 20]);
		//translate([cover_l - cover_wall_t - 1, cover_w/2 + excess_dist, cover_h - cut_h]) rotate([45, 0, 0]) cube([cover_wall_t + 2, 20, 20]);
	}
}

module psu_cover()
{
	// Cover screw 1 (right side)
	screw1 = [cover_l - cover_wall_t, cover_w/2 - 0.5, cover_h - cover_face_t - cover_face_dist - 20];

	// Cover screw 2 block (front left)
	screw2_block = [cover_wall_t + 1, 9, cover_h - cover_screw2_block_h];

	// Power socket
	socket_x = cover_l - cover_wall_t - socket_l - 10 - 3;  // screw holder + spare
	socket_y = cover_w - cover_wall_t - socket_w - 2 - 2;	// socket frame + spare
	socket_screw_dist = 6;
	
	// Outlet
	outlet_x = cover_wall_t + outlet_d/2 + 3;
	outlet_y = cover_w - cover_wall_t - outlet_d/2 - 5;
	outlet_slot_dist = outlet_d/2 + 28;

	translate([0, cover_w, cover_h]) rotate([180, 0, 0]) union()
	{
		difference()
		{
			// Cover
			cube([cover_l, cover_w, cover_h]);
			translate([cover_wall_t, cover_wall_t, -cover_face_t]) cube([cover_l - 2*cover_wall_t, cover_w - 2*cover_wall_t, cover_h]);
			// Overlap cut
			translate([cover_wall_t, -1, -1]) cube([cover_l - 2*cover_wall_t, cover_wall_t + 2, cover_overlap_dist + 1]);
			// Screw 1
			translate([screw1[0] - 1, screw1[1], screw1[2]]) rotate([0, 90, 0]) cylinder(r=cover_screw_d/2, h=cover_wall_t + 2, center=false);
			// Screw 2 driving hole
			translate([screw2_block[0] + cover_screw2_block_l/2, cover_w + 1 , cover_h - cover_screw2_block_h + 5]) rotate([90, 0, 0]) cylinder(r=cover_screw2_driving_d/2, h=cover_wall_t + 2, center=false);
			// Power socket
			translate([socket_x, socket_y, 0]) cube([socket_l, socket_w, cover_h + 1]);
			// Power socket screws
			translate([socket_x - socket_screw_dist, socket_y + socket_w/2, 0]) cylinder(r=socket_screw_d/2, h=cover_h + 1, center=false);
			translate([socket_x + socket_l + socket_screw_dist, socket_y + socket_w/2, 0]) cylinder(r=socket_screw_d/2, h=cover_h + 1, center=false);
			// Outlet
			translate([outlet_x, outlet_y, 0]) cylinder(r=outlet_d/2, h=cover_h + 1, center=false);
			translate([outlet_x + outlet_space, outlet_y, 0]) cylinder(r=outlet_d/2, h=cover_h + 1, center=false);
			translate([outlet_x, outlet_y - outlet_d/2, 0]) cube([outlet_space, outlet_d, cover_h + 1]);
			// Outlet slots
			translate([outlet_x + outlet_slot_dist, outlet_y + outlet_slot_space/2, 0]) cube([outlet_slot_l, outlet_slot_w, cover_h + 1]);
			translate([outlet_x + outlet_slot_dist, outlet_y - outlet_slot_space/2 - outlet_slot_w, 0]) cube([outlet_slot_l, outlet_slot_w, cover_h + 1]);
		}
		// Screw 2 block
		translate(screw2_block) cover_screw2_block();
	}
}

module cover_screw2_block()
{
	difference()
	{
		cube([cover_screw2_block_l, cover_screw2_block_w, cover_screw2_block_h]);
		translate([cover_screw2_block_l/2, -1, 5]) rotate([-90, 0, 0]) cylinder(r=cover_screw_d/2, h=cover_screw2_block_w + 2, center=false);
	}
}
