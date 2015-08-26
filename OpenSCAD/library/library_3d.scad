// ========================================================================================
// Robori Mendel
// General 3D library
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 2013 - First version
// ========================================================================================

lib3d_fn = 50;

// TESTING
//lib3d_hex_nut_recess(3);
//lib3d_round_cube(10, 8, 10, 1, true, false, true, false);


// Hexagonal nut recess
module lib3d_hex_nut_recess(size)
{
	length = 0.8*size;
	hex_r = 1.8*size/2;
	cylinder(h=length, r=hex_r, center=false, $fn=6);
}

// Cube with customized rounded corners
module lib3d_round_cube(x, y, z, rad, left_top=true, left_bottom=true, right_top=true, right_bottom=true)
{
	rx = x/2 - rad + 0.02;
	ry = y/2 - rad + 0.02;

	translate([x/2, y/2, 0]) difference()
	{	
		translate([-x/2, -y/2, 0]) cube([x, y, z]);
		if (left_top)
			translate([-rx, ry, -1]) rotate([0, 0, 90]) __lib3d_round_corner(rad, z + 2);
		if (left_bottom)
			translate([-rx, -ry, -1]) rotate([0, 0, 180]) __lib3d_round_corner(rad, z + 2);
		if (right_top)
			translate([rx, ry, -1]) __lib3d_round_corner(rad, z + 2);
		if (right_bottom)
			translate([rx, -ry, -1]) rotate([0, 0, 270]) __lib3d_round_corner(rad, z + 2);
	}
}

// Helper
module __lib3d_round_corner(rad, height)
{
	difference()
	{
		cube([rad, rad, height]);
		cylinder(h=height, r=rad, center=false, $fn=lib3d_fn);
	}
}
