include <nuts_and_bolts.scad>;
include <generals.scad>;

z_support_bottom_plate_width = nema17_side + 2* wall + 2* wall_clearance;

module z_support_bottom(narrow = true)
{
	difference()
	{
		union()
		{
			translate([-z_bottom_width/2 - (narrow ? 0 : (holder_width + wall)), 0, 0]) cube([z_bottom_width + (narrow ? 0 : 2*(holder_width + wall)), wall, z_bottom_height]);
			echo(z_bottom_width + (narrow ? 0 : 2*(holder_width + wall)));
			
			translate([(narrow ? (-z_support_bottom_plate_width/2) : (-z_smooth_rod_offset-holder_width/2 - wall)), 0, z_bottom_motor_top]) cube([(narrow ? z_support_bottom_plate_width : 2*(z_smooth_rod_offset+holder_width/2 + wall)), nema17_side + wall, wall]);

			translate([- z_support_bottom_plate_width/2, 0, z_bottom_motor_top-2*wall]) cube([wall, nema17_side + wall, 3*wall]);

			translate([z_support_bottom_plate_width/2 -wall, 0, z_bottom_motor_top-2*wall]) cube([wall, nema17_side + wall, 3*wall]);

			if (!narrow)
			{			
				translate([z_smooth_rod_offset+holder_width/2, 0, z_bottom_motor_top-2*wall]) cube([wall, nema17_side + wall, 3*wall]);
	
				translate([-((z_smooth_rod_offset+holder_width/2 + wall)), 0, z_bottom_motor_top-2*wall]) cube([wall, nema17_side + wall, 3*wall]);

				translate([-z_smooth_rod_offset, z_bottom_motor_offset, z_bottom_motor_top+wall]) rotate([0, 0, 180]) rod_holder();
				translate([+z_smooth_rod_offset, z_bottom_motor_offset, z_bottom_motor_top+wall]) rotate([0, 0, 180]) rod_holder();
			}
				
		}

		translate([-z_bottom_clearing_width/2, -1, z_bottom_motor_top+wall]) cube([z_bottom_clearing_width, wall+2, z_bottom_height]);

		translate([z_bottom_width/2 - alu_x/2, wall+1, alu_x/2]) rotate([90, 0, 0]) boltHole(5, length = wall+2);

		translate([-z_bottom_width/2 + alu_x/2, wall+1, alu_x/2]) rotate([90, 0, 0]) boltHole(5, length = wall+2);

		translate([z_bottom_width/2 - alu_x/2, wall+1, z_bottom_height - alu_x/2]) rotate([90, 0, 0]) boltHole(5, length = wall+2);

		translate([-z_bottom_width/2 + alu_x/2, wall+1, z_bottom_height - alu_x/2]) rotate([90, 0, 0]) boltHole(5, length = wall+2);

		if (!narrow)
		{
			translate([z_bottom_width/2 + holder_width + wall-alu_x/2, wall+1, alu_x/2]) rotate([90, 0, 0]) boltHole(5, length = wall+2);
	
			translate([-(z_bottom_width/2 + holder_width + wall-alu_x/2), wall+1, alu_x/2]) rotate([90, 0, 0]) boltHole(5, length = wall+2);
	
			translate([z_bottom_width/2 + holder_width + wall-alu_x/2, wall+1, z_bottom_height - alu_x/2]) rotate([90, 0, 0]) boltHole(5, length = wall+2);
	
			translate([-(z_bottom_width/2 + holder_width + wall-alu_x/2), wall+1, z_bottom_height - alu_x/2]) rotate([90, 0, 0]) boltHole(5, length = wall+2);
	
		}

		translate([0, z_bottom_motor_offset , z_bottom_motor_top-1]) rotate([-90, 0, 0]) nema17(top=wall+2);

		translate([-z_smooth_rod_offset, z_bottom_motor_offset, 0]) rotate([0, 0, 180]) cylinder(d=rod_dia, h=100);

		translate([z_smooth_rod_offset, z_bottom_motor_offset, 0]) rotate([0, 0, 180]) cylinder(d=rod_dia, h=100);
	}
}

//translate([0, z_bottom_height/2+wall, 0]) rotate([90, 0, 0]) z_support_bottom(false);
//translate([0, -z_bottom_height/2, 0]) rotate([90, 0, 0]) z_support_bottom(true);

//translate([0, nema17_side/2 + wall+wall_clearance, z_bottom_motor_top]) rotate([-90, 0, 0]) nema17(top=wall+0.5);;