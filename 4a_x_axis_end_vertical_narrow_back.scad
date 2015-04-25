include <nuts_and_bolts.scad>;
include <generals.scad>;

x_end_v_depth = 2*lm10uu_length + 3*wall;
x_end_v_height = y_from_top;
x_end_v_width = lm10uu_dia+2*thin_wall;
x_end_v_rod_offset = -lm10uu_dia-wall;
x_end_v_full_height  = x_end_v_rod_offset + rod_dia + x_end_v_rod_dist;
x_end_v_top_plate = -(-(-y_from_side - x_end_v_width /2) - wall - nema17_side/2 - motor_from_side_x-pulley_s_d/2 - belt_bearing_d) + x_end_v_width;
x_end_v_rod_y_offset = 8;
x_end_v_bottom_plate_gap = 35;
x_end_v_bottom_plate_offset = 25;

module x_axis_end(left = false)
{
	translate([0, -x_end_v_depth/2 - x_end_v_rod_y_offset, 0])
	difference()
	{
		union()
		{
			translate([0, 0, wall-lm10uu_dia/4]) cube([x_end_v_width, x_end_v_depth, x_end_v_height+lm10uu_dia/4]);

			translate([-x_end_v_top_plate + x_end_v_width, 0, x_end_v_height -x_end_v_rod_dist/2]) cube([x_end_v_top_plate-x_end_v_width+1, x_end_v_depth, wall]);

			echo(x_end_v_top_plate-x_end_v_width);

			translate([-x_end_v_top_plate + x_end_v_width, x_end_v_bottom_plate_offset, x_end_v_height]) cube([x_end_v_top_plate, x_end_v_depth-x_end_v_bottom_plate_gap, wall]);

			translate([0, x_end_v_rod_y_offset, 0])
			hull()
			{
				translate([0, x_end_v_depth/2 - (lm10uu_dia + 2*wall)/2 , 0]) cube([x_end_v_width, lm10uu_dia + 2*wall, x_end_v_height]);
				translate([0, x_end_v_depth/2, -x_end_v_full_height+wall]) rotate([0, 90, 0]) cylinder(h=x_end_v_width, d=rod_dia+2*wall);
			}

            hull()
            {
                translate([-alu_x/2+2*wall - hole_dist_2 - hole_x_offset-(-y_from_side - x_end_v_width /2), x_end_v_depth/2 + x_end_v_rod_y_offset - pulley_s_d_small/2-x_carriage_belt_dist/2 + x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)]) cylinder(h=wall+1, d=2*wall);
                translate([0, x_end_v_depth/2 + x_end_v_rod_y_offset - pulley_s_d_small/2-x_carriage_belt_dist/2 + x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)]) cylinder(h=wall+1, d=2*wall);
            }

            hull()
            {
                translate([-(-y_from_side - x_end_v_width /2)- wall - nema17_side/2 - motor_from_side_x-pulley_b_d_small_with_belt/2 - belt_bearing_d/2, x_end_v_depth/2 + x_end_v_rod_y_offset + belt_bearing_d/2 + belt_depth + x_carriage_belt_dist/2+ x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)]) cylinder(h=wall+1, d=2*wall-1);
                translate([0, x_end_v_depth/2 + x_end_v_rod_y_offset + belt_bearing_d/2 + belt_depth + x_carriage_belt_dist/2+ x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)]) cylinder(h=wall+1, d=2*wall-1);
            }
            
            /*if (!left)
            {
                translate([-alu_x/2+2*wall - hole_dist_2 - hole_x_offset-(-y_from_side - x_end_v_width /2), x_end_v_depth/2 + x_end_v_rod_y_offset - pulley_s_d_small/2-x_carriage_belt_dist/2 + x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)+pulley_s_base_h+wall-2]) cylinder(h=pulley_s_base_h+1, d=pulley_s_d);
            }*/
            
		}

		translate([-1, x_end_v_depth/2 + x_end_v_rod_y_offset, -x_end_v_full_height+wall+x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(h=x_end_v_width+2, d=rod_dia);

		translate([-1, x_end_v_depth/2 + x_end_v_rod_y_offset, -x_end_v_full_height+wall]) rotate([0, 90, 0]) cylinder(h=x_end_v_width+2, d=rod_dia);

		translate([rod_dia+thin_wall, x_end_v_depth+1, 0]) rotate([90, 0, 0]) cylinder(h=x_end_v_depth+2, d=rod_dia + wall_clearance*4);

		translate([rod_dia+thin_wall, lm10uu_length, 0]) rotate([90, 0, 0]) cylinder(h=lm10uu_length+1, d=lm10uu_dia + clearance);

		translate([rod_dia+thin_wall, x_end_v_depth+1, 0]) rotate([90, 0, 0]) cylinder(h=lm10uu_length+1, d=lm10uu_dia + clearance);

		translate([-x_end_v_top_plate+x_end_v_width+endstop_hole_offset, x_end_v_depth/2 + x_end_v_rod_y_offset-endstop_hole_spread/2, x_end_v_height -x_end_v_rod_dist/2-1]) cylinder(d=2.8, h=10);

		translate([-x_end_v_top_plate+x_end_v_width+endstop_hole_offset, x_end_v_depth/2 + x_end_v_rod_y_offset+endstop_hole_spread/2, x_end_v_height -x_end_v_rod_dist/2-1]) cylinder(d=2.8, h=10);

		translate([-alu_x/2+2*wall - hole_dist_2 - hole_x_offset-(-y_from_side - x_end_v_width /2), x_end_v_depth/2 + x_end_v_rod_y_offset - pulley_s_d_small/2-x_carriage_belt_dist/2 + x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)-wall]) boltHole(3,length=40);

		translate([-(-y_from_side - x_end_v_width /2)- wall - nema17_side/2 - motor_from_side_x-pulley_b_d_small_with_belt/2 - belt_bearing_d/2, x_end_v_depth/2 + x_end_v_rod_y_offset + belt_bearing_d/2 + belt_depth + x_carriage_belt_dist/2+ x_carriage_belt_offset, -y_from_top-rod_dia/2-(-alu_x-y_from_top-rod_dia/2)-wall]) boltHole(3,length=40);

		translate([rod_dia+thin_wall-0.3, x_end_v_depth-wall, 0]) zip_channel();
		translate([rod_dia+thin_wall-0.3, lm10uu_length/3, 0]) zip_channel();
		translate([rod_dia+thin_wall-0.3, 2*lm10uu_length/3+zip_width, 0]) zip_channel();
		
        echo("XE1:",-alu_x/2+2*wall - hole_dist_2 - hole_x_offset-(-y_from_side - x_end_v_width /2), x_end_v_depth/2 + x_end_v_rod_y_offset - pulley_s_d_small/2-x_carriage_belt_dist/2 + x_carriage_belt_offset);
        echo("XE2:",-(-y_from_side - x_end_v_width /2)- wall - nema17_side/2 - motor_from_side_x-pulley_b_d_small_with_belt/2 - belt_bearing_d/2, x_end_v_depth/2 + x_end_v_rod_y_offset + belt_bearing_d/2 + belt_depth + x_carriage_belt_dist/2+ x_carriage_belt_offset);
	}
}

translate([0, 0, x_end_v_width]) rotate([0, 90, 0]) x_axis_end();

translate([x_end_v_depth, 0, x_end_v_width]) rotate([0, -90, 0]) mirror([1,0,0]) x_axis_end();
*color([1,1,1])x_axis_end(true);

*translate([0, -x_end_v_depth/2, 0])
*translate([-(-y_from_side - x_end_v_width /2), 0, -(-alu_x-y_from_top-rod_dia/2)]) 
{
		color([1, 0, 1])
		translate([-alu_x/2+2*wall - hole_dist_2 - hole_x_offset, x_end_v_depth/2 - pulley_s_d_small/2-x_carriage_belt_dist/2+x_carriage_belt_offset, -y_from_top+rod_dia/2]) pulley_small();

		translate([- wall - nema17_side/2 - motor_from_side_x-pulley_b_d/2 - belt_bearing_d/2, x_end_v_depth/2 + belt_bearing_d/2 + belt_depth + x_carriage_belt_dist/2 + x_carriage_belt_offset, -y_from_top+rod_dia/2+pulley_b_base_h]) bearing();
	}

echo(- wall - nema17_side/2 - motor_from_side_x-pulley_b_d/2 - belt_bearing_d/2);
echo(- wall - nema17_side/2 - motor_from_side_x-pulley_b_d_small_with_belt/2 - belt_bearing_d/2);
