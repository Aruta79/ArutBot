include <nuts_and_bolts.scad>;
include <generals.scad>;

include <sub_front_pulleys.scad>;
include <sub_rod_support.scad>;

y_sup_arm_length_x = y_sup_body_width + alu_x;
y_sup_arm_length_z = y_sup_body_height + alu_x;

module y_axis_support_front(left = false)
{
	difference()
	{
		union()
		{
/*
			translate([0, 0, -y_sup_arm_length_z+wall]) cube([wall, alu_x, y_sup_arm_length_z]);
			translate([0, 0, -y_sup_body_height+wall]) cube([y_sup_body_width, alu_x, y_sup_body_height]);
			translate([y_from_side, alu_x, -y_from_top]) rotate([90, 0, 0]) cylinder(d = rod_dia + wall + clearance, h = alu_x+wall);
*/
			translate([0, 0, wall]) rod_support(true);

			cube([y_sup_arm_length_x, alu_x, wall]);
			front_pulley(true, left);
	}

			translate([y_sup_arm_length_x-(y_sup_arm_length_x-y_sup_body_width)/2, alu_x/2, -1]) boltHole(size=bolt,length=40);

	}

}

//translate([25,0,wall]) rotate([180,0,0]) y_axis_support_front();

//translate([-25,0,wall]) mirror([1,0,0]) rotate([180,0,0]) y_axis_support_front();

//cylinder(d=10, h=60);