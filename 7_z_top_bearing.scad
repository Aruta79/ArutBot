include <nuts_and_bolts.scad>;
include <generals.scad>;

z_top_width = 60;
z_top_plate_width = 2*thin_wall + z_bearing_d;
z_top_plate_depth = z_bottom_motor_offset + z_bearing_d/2 + thin_wall;

module z_top_bearing(front = false)
{
	difference()
	{
		union()
		{
			if (front)
			{
				translate([-z_top_width/2-z_smooth_rod_offset+alu_x/2, -alu_x, 0]) cube([2*z_smooth_rod_offset + z_top_width-alu_x, alu_x, 2*wall]);

				translate([-z_smooth_rod_offset-holder_width/2 - wall/2, 0, 0]) cube([2*z_smooth_rod_offset + holder_width + wall, z_top_plate_depth, wall]);

			}
			else
			{
				translate([-z_smooth_rod_offset-holder_width/2 - alu_x, 0, 0]) cube([2*z_smooth_rod_offset + holder_width + 2*alu_x, wall, alu_x]);

				translate([-z_smooth_rod_offset-holder_width/2 - wall/2, 0, 0]) cube([2*z_smooth_rod_offset + holder_width + wall, z_top_plate_depth, wall]);

			}

			translate([+z_smooth_rod_offset, z_bottom_motor_offset, wall-0.25]) rotate([0, 0, 180]) rod_holder();

			translate([-z_smooth_rod_offset, z_bottom_motor_offset, wall-0.25]) rotate([0, 0, 180]) rod_holder();
            
			translate([-z_top_plate_width/2, (front ? -alu_x : 0), 0]) cube([z_top_plate_width, z_top_plate_depth+(front ? alu_x : 0), z_bearing_h + 2]);
		}

			translate([0, z_top_plate_depth-z_bearing_d/2-thin_wall, thin_wall]) cylinder(h=z_bearing_h+1, d = z_bearing_d);
			translate([0, z_top_plate_depth-z_bearing_d/2-thin_wall, -1]) cylinder(h=z_bearing_h+5, d = z_rod_d+1);

			translate([-z_smooth_rod_offset, z_bottom_motor_offset, -1]) cylinder(d=rod_dia, h=wall+1);
			translate([z_smooth_rod_offset, z_bottom_motor_offset, -1]) cylinder(d=rod_dia, h=wall+1);

		if (front)
		{
			translate([z_top_width/2-M5/2-wall, -alu_x/2, -0.5]) boltHole(bolt, length = 2*wall + 1);
			translate([-z_top_width/2+M5/2+wall, -alu_x/2, -0.5]) boltHole(bolt, length = 2*wall + 1);
			translate([-z_smooth_rod_offset-z_top_width/2+M5+alu_x/2+wall/2, -alu_x/2, -0.5]) boltHole(bolt, length = 2*wall + 1);
			translate([z_smooth_rod_offset+z_top_width/2-M5-alu_x/2-wall/2, -alu_x/2, -0.5]) boltHole(bolt, length = 2*wall + 1);
		}
		else
		{
			translate([z_top_width/2-M5/2-wall, wall+0.5, alu_x/2]) rotate([90, 0, 0]) boltHole(bolt, length = wall + 1);
			translate([-z_top_width/2+M5/2+wall, wall+0.5, alu_x/2]) rotate([90, 0, 0]) boltHole(bolt, length = wall + 1);

			translate([z_smooth_rod_offset+ z_top_width/2-wall, wall+0.5, alu_x/2]) rotate([90, 0, 0]) boltHole(bolt, length = wall + 1);
			translate([-z_smooth_rod_offset-z_top_width/2+wall, wall+0.5, alu_x/2]) rotate([90, 0, 0]) boltHole(bolt, length = wall + 1);

		}
	}

}

//z_top_bearing(false);
//translate([0, -50, 0]) 
//z_top_bearing(true);
echo(z_top_plate_depth-z_bearing_d/2-thin_wall);