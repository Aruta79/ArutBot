include <nuts_and_bolts.scad>;
include <generals.scad>;

include <sub_rod_support.scad>;
include <sub_front_pulleys.scad>;

y_sup_height_back = y_sup_body_height + 20;

module back_rod_support()
{
	difference()
	{
		union()
		{
			translate([0, -alu_x, 0]) cube([wall, alu_x, alu_x]);
			translate([0, 0, 0]) rod_support(front = false, support_height = y_sup_height_back, with_bottom = false); //, support_width=wall + motor_from_side_y + nema17_side+alu_x+wall_clearance - alu_x);

		}

		translate([wall+0.5, -alu_x/2, alu_x/2]) rotate([0, -90, 0]) boltHole(bolt, length=wall+1);
	}
}

back_rod_support();