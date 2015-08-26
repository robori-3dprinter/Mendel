// ========================================================================================
// Robori Mendel
// Shared X axis design data
// GNU GPL v3
//
// Contact : support@robori.com
// Reference : http://www.robori.com/documentation/Mendel
//
// History :
// 30 Jan 2015 - First version
// ========================================================================================

include <library/component.scad>

// Distance between smooth rods : LM8UU + heatsink + bearing holder + spare
rod_dist = LM8UU_OD + 40 + 2*lm8uu_holder_wall_t + 2*2;

belt_rod_dist = LM8UU_OD/2 + lm8uu_holder_wall_t;
belt_rod_h = lm8uu_holder_h/2 + 3;

// Console
echo("rod_dist", rod_dist);
