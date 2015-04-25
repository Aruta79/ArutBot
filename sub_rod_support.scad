include <nuts_and_bolts.scad>;
include <generals.scad>;

include <sub_front_pulleys.scad>;

y_sup_body_height = alu_x / 2 + wall + y_from_top;
y_sup_body_width = alu_x /2 + y_from_side;
y_back_spacing = -wall;

y_sup_arm_length_x = y_sup_body_width + alu_x;
y_sup_arm_length_z = y_sup_body_height + alu_x;

module rod_support(front = true, support_width = alu_x, support_height = y_sup_body_height, with_bottom = true)
{
	mirror([0, front ? 0 : 1, 0])
	difference()
	{
		union()
		{
			translate([0, 0, -support_height]) cube([y_sup_body_width, alu_x, support_height]);
			
			if (with_bottom)
			{
				translate([0, 0, -y_sup_arm_length_z]) cube([wall, support_width, y_sup_arm_length_z]);
			}
			else
			{
				translate([0, 0, -support_height]) cube([y_sup_body_width + alu_x, alu_x, wall]);
			}
		}

		translate([y_from_side, alu_x+1, -y_from_top-wall]) rotate([90, 0, 0]) cylinder(d = rod_dia + clearance, h = alu_x+2);

		if (with_bottom)
		{
			translate([6, alu_x/2, -y_sup_arm_length_z+(y_sup_arm_length_z-support_height)/2]) rotate([0, -90, 0]) boltHole(size=bolt,length=40);
		}
		else
		{
			translate([y_sup_body_width + alu_x/2, alu_x/2, -support_height-0.5]) rotate([0, 0, 0]) boltHole(bolt, length=wall+1);	
		}
	}
}

//rod_support(support_width=alu_x, with_bottom = true);
//translate([0, 60, 0]) rod_support(false);
