include <nuts_and_bolts.scad>;
include <generals.scad>;

include <sub_rod_support.scad>;
include <sub_front_pulleys.scad>;

motor_sup_arm_x = 70;
motor_sup_arm_y = wall + motor_from_side_y + 45;
motor_sup_plate = 50;

y_sup_height_back = y_sup_body_height + 20;

module back_rod_support()
{
	difference()
	{
		union()
		{
			translate([0, -alu_x, -1]) cube([wall, alu_x, alu_x+1]);
			translate([0, 0, 0]) rod_support(front = false, with_bottom = true); //, support_width=wall + motor_from_side_y + nema17_side+alu_x+wall_clearance - alu_x);

		}

		translate([wall+0.5, -alu_x/2, alu_x/2]) rotate([0, -90, 0]) boltHole(bolt, length=wall+1);
	}
}

module xy_motor_support()
{
	difference()
	{
		union()
		{
			translate([0, 0, -wall]) cube([motor_sup_plate, motor_sup_plate + motor_from_side_y, wall]);
			translate([0, 0, -wall]) cube([motor_sup_arm_x, wall, alu_x+wall]);
			cube([wall, motor_sup_arm_y, alu_x]);

			echo(motor_sup_arm_y);

			translate([0, motor_sup_arm_y+alu_x, 0]) back_rod_support();

			//translate([0, motor_sup_arm_y, -wall]) rod_support(false); //, support_width=wall + motor_from_side_y + nema17_side+alu_x+wall_clearance - alu_x);
		}

		translate([wall + nema17_side/2 + motor_from_side_x, wall + nema17_side/2 + motor_from_side_y, -wall]) rotate([-90, 0, 0]) nema17(2, top=wall+0.01);

		//translate([6, motor_sup_arm_y -alu_x/2 + motor_from_side_y/2, alu_x/2]) rotate([0, -90, 0]) boltHole(size=bolt,length=40);

		translate([(motor_sup_arm_x + motor_sup_plate) / 2, 6, alu_x/2]) rotate([90, 0, 0]) boltHole(size=bolt,length=40);

		translate([wall + nema17_side/2 + motor_from_side_x, 6, alu_x/2]) rotate([90, 0, 0]) boltHole(size=bolt,length=40);

		translate([6, wall + nema17_side/2 + motor_from_side_x, alu_x/2]) rotate([0, -90, 0]) boltHole(size=bolt,length=40);

	}
}

//translate([y_sup_height_back-alu_x, alu_x+10, 0]) rotate([0, 90, 0]) mirror([1, 0, 0]) back_rod_support();


//rotate([0, -90, 0]) xy_motor_support();
//translate([0, -10, 0]) rotate([0, 90, 180]) mirror([1, 0, 0]) xy_motor_support();

//%translate([2*wall, wall+nema17_side-6, 0]) rotate([0, 180, 0]) boltHole(3, length=10);