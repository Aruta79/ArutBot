include <nuts_and_bolts.scad>;
include <generals.scad>;

pulley_plate_x = 45;
pulley_plate_y = 28;

pulley_arm_x = pulley_plate_x + alu_x;
pulley_arm_y = pulley_plate_y + alu_x;

module front_pulley(lower = false, left = false)
{
    echo("FP:", lower, left);
	difference()
	{
		union()
		{
			translate([-alu_x, 0, 0]) cube([pulley_arm_x, alu_x, wall]);
			translate([-alu_x, -pulley_arm_y+alu_x, 0]) cube([alu_x, pulley_arm_y, wall]);
			translate([0, -pulley_plate_y, lower ? 0 : wall-thin_wall ]) cube([pulley_plate_x, pulley_plate_y, lower ? wall : thin_wall ]); //lower ? 0 : wall-thin_wall 

        /*    if (lower)
            {
                if(left)
                {
                    translate([hole_dist_1, -hole_dist_1, wall-1]) cylinder(h=alu_x+(wall-thin_wall)-bearing_pulley_h-2*belt_z_offset+1, d=pulley_b_d);
                }
                
                if (!left)
                {
                    translate([hole_dist_2+hole_x_offset, -hole_dist_2, wall-1]) cylinder(h=pulley_s_base_h+1, d=pulley_b_d-3.4);
                }
            }
        */
            if (!lower)
            {
                if(left)
                {
                    translate([hole_dist_2+hole_x_offset, -hole_dist_2, -(alu_x-bearing_pulley_h-2*belt_z_offset)]) cylinder(h=alu_x+wall-thin_wall-bearing_pulley_h-2*belt_z_offset+1, d=pulley_b_d-3.4);
                }
                
                if (!left)
                {
                    translate([hole_dist_1, -hole_dist_1, -(alu_x-bearing_pulley_h-2*belt_z_offset)]) cylinder(h=alu_x+thin_wall-bearing_pulley_h-2*belt_z_offset+1, d=pulley_b_d);

                    translate([hole_dist_2+hole_x_offset, -hole_dist_2, -(alu_x-bearing_pulley_h-2*belt_z_offset-pulley_s_base_h)]) cylinder(h=alu_x+wall-thin_wall-bearing_pulley_h-2*belt_z_offset-pulley_s_base_h+1, d=pulley_b_d-3.4);
                }
            }

		}

		translate([(pulley_arm_x - alu_x)*2/3, alu_x/2, -20]) rotate([0, 0, 0]) boltHole(size=bolt,length=40);
		translate([(pulley_arm_x - alu_x)*1/3, alu_x/2, -20]) rotate([0, 0, 0]) boltHole(size=bolt,length=40);
		translate([-alu_x/2, -(pulley_arm_y - alu_x)*2/3-1, -20]) rotate([0, 0, 0]) boltHole(size=bolt,length=40);
		translate([-alu_x/2, -(pulley_arm_y - alu_x)*1/4, -20]) rotate([0, 0, 0]) boltHole(size=bolt,length=40);
		
		translate([hole_dist_1, -hole_dist_1, -20]) boltHole(size=3, length=40);
		translate([hole_dist_2+hole_x_offset, -hole_dist_2, -20]) boltHole(size=3,length=40);
        
		if (lower)
		{
			translate([-alu_x-2+0.1, -0.1, -1]) cube([alu_x+2, alu_x+2, wall+2]);
		}
	}

}

/*
is_left = false;

front_pulley(false, is_left);

translate([0, 0, -alu_x-wall]) front_pulley(true, is_left);
*/
///color([0, 0.2, 0]) translate([hole_dist_1,-hole_dist_1,-pulley_height+2]) pulley();
//color([0, 0.4, 0]) translate([hole_dist_2+hole_x_offset,-hole_dist_2,-4]) mirror([0,0,1])pulley();

//color([0.5,0,0]) translate([30, -40, -alu_x]) cube([20,20,pulley_height+4]);
//color([0,0,0]) translate([5, 10, -alu_x]) cube([20,20,alu_x]);