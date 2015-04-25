include <nuts_and_bolts.scad>;
include <generals.scad>;

x_end_v_depth = 2*lm10uu_length + 3*wall;
x_end_v_height = wall + y_from_top;
x_end_v_width = lm10uu_dia+2*thin_wall;
x_end_v_rod_offset = -lm10uu_dia-wall;
x_end_v_full_height  = x_end_v_rod_offset + rod_dia + x_end_v_rod_dist;
x_end_v_top_plate = -(-(-y_from_side - x_end_v_width /2) - wall - nema17_side/2 - motor_from_side_x-pulley_d/2 - belt_bearing_d) + x_end_v_width;

module x_axis_end()
{
	difference()
	{
		union()
		{
			translate([0, 0, -lm10uu_dia/4]) cube([x_end_v_width, x_end_v_depth, x_end_v_height+lm10uu_dia/4]);

			translate([-x_end_v_top_plate + x_end_v_width, 0, x_end_v_height - wall]) cube([x_end_v_top_plate, x_end_v_depth, wall]);

			hull()
			{
				translate([0, x_end_v_depth/2 - (lm10uu_dia + 2*wall)/2 , 0]) cube([x_end_v_width, lm10uu_dia + 2*wall, x_end_v_height]);
				translate([0, x_end_v_depth/2, -x_end_v_full_height]) rotate([0, 90, 0]) cylinder(h=x_end_v_width, d=lm10uu_dia+wall);
			}
		}

		translate([-1, x_end_v_depth/2, -x_end_v_full_height+wall+x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(h=x_end_v_width+2, d=rod_dia);

		translate([-1, x_end_v_depth/2, -x_end_v_full_height+wall]) rotate([0, 90, 0]) cylinder(h=x_end_v_width+2, d=rod_dia);

		translate([rod_dia+thin_wall, x_end_v_depth+1, 0]) rotate([90, 0, 0]) cylinder(h=x_end_v_depth+2, d=rod_dia + wall_clearance*4);

		translate([rod_dia+thin_wall, lm10uu_length, 0]) rotate([90, 0, 0]) cylinder(h=lm10uu_length+1, d=lm10uu_dia + clearance/2);

		translate([rod_dia+thin_wall, x_end_v_depth+1, 0]) rotate([90, 0, 0]) cylinder(h=lm10uu_length+1, d=lm10uu_dia + clearance/2);

		translate([-alu_x/2+2*wall - hole_dist_2 - hole_x_offset-(-y_from_side - x_end_v_width /2), x_end_v_depth/2 - pulley_d_small/2-x_carriage_belt_dist/2 + x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)]) boltHole(5,length=20);

		translate([-(-y_from_side - x_end_v_width /2)- wall - nema17_side/2 - motor_from_side_x-pulley_d/2 - belt_bearing_d/2, x_end_v_depth/2 + belt_bearing_d/2 + belt_depth + x_carriage_belt_dist/2+ x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)]) boltHole(3,length=20);
	}
}

//x_axis_end();

*translate([-(-y_from_side - x_end_v_width /2), 0, -(-alu_x-y_from_top-rod_dia/2)]) 
{
		color([1, 0, 1])
		translate([-alu_x/2+2*wall - hole_dist_2 - hole_x_offset, x_end_v_depth/2 - pulley_d_small/2-x_carriage_belt_dist/2+x_carriage_belt_offset, -y_from_top+rod_dia/2]) pulley();

		translate([- wall - nema17_side/2 - motor_from_side_x-pulley_d/2 - belt_bearing_d/2, x_end_v_depth/2 + belt_bearing_d/2 + belt_depth + x_carriage_belt_dist/2 + x_carriage_belt_offset, -y_from_top+rod_dia/2+pulley_base_h]) bearing();
	}
