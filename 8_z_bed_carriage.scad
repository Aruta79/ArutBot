use <lm10uu-holder-slim.scad>;
include <nuts_and_bolts.scad>;
include <generals.scad>;

z_bed_carriage_depth = 27;
z_bed_carriage_width = 160;

flange_small = 25;
flange_big = 42;
flange_small_h = 25;
flange_big_h = 10;

module leadscrew_flange_hole(){
	color([0,1,1]) 
	{
		translate([0,0,-flange_small_h])
		cylinder(r = flange_small/2, h = flange_small_h+2, $fn = 100);	

		translate([0,0,0])
		cylinder(r = flange_big/2+0.25, h = flange_big_h, $fn = 100);	

		translate([0,0,0])
		{
		for ( i = [0 : 5] )
		{
		    rotate([0, 0, i * 360 / 6])
		    translate([0, 34/2, -3*wall])
		    cylinder(d=6, h=3*wall+1);
		}
		}		
	}
}

module z_bed_carriage(holders = true)
{
	difference()
	{
		union()
		{
			translate([0, 0, -2*wall])
			cylinder(r = flange_big/2+wall, h = 2*wall);

			translate([0, 0, -2*wall])
			linear_extrude(2*wall)
			{
				polygon(points=[
					[-flange_big/2-wall,0],
					[+flange_big/2+wall,0],
					[z_bed_carriage_width/2-alu_x/2,-z_bed_carriage_depth],
					[-z_bed_carriage_width/2+alu_x/2,-z_bed_carriage_depth]]);
			}

			translate([-z_bed_carriage_width/2, -z_bed_carriage_depth, -2*wall]) cube([z_bed_carriage_width, wall, heatbed_support_h+2*wall]);

			translate([-z_bed_carriage_width/2, -z_bed_carriage_depth-alu_x, -2*wall]) cube([z_bed_carriage_width, alu_x+1, 2*wall]);

			if (!holders)
			{
				difference()
				{
					union()
					{
						translate([-z_smooth_rod_offset - lm10uu_dia/2, -z_bed_carriage_depth, -2*wall]) cube([2*z_smooth_rod_offset + lm10uu_dia, z_bed_carriage_depth, 2*wall]);
					translate([z_smooth_rod_offset, 0, lm10uu_length-2*wall]) rotate([-90, 0, 0]) lm10uu_bearing_holder(false, hole_margin=0.25);
					translate([-z_smooth_rod_offset, 0, lm10uu_length-2*wall]) rotate([-90, 0, 0]) lm10uu_bearing_holder(false, hole_margin=0.25);
					}

					translate([z_smooth_rod_offset, 0, -2*wall-1]) cylinder(d=lm10uu_dia, h=lm10uu_length+2, $fn=100);
					translate([-z_smooth_rod_offset, 0, -2*wall-1]) cylinder(d=lm10uu_dia, h=lm10uu_length+2, $fn=100);
				}

			}
		}

		translate([0, 0, -wall])
		leadscrew_flange_hole();

		translate([z_bed_carriage_width/2 - M5_NUT/2-wall, -z_bed_carriage_depth - alu_x/2, -2*wall-0.5]) boltHole(bolt, length = 2*wall+1);

		translate([-z_bed_carriage_width/2 + M5_NUT/2+wall, -z_bed_carriage_depth - alu_x/2, -2*wall-0.5]) boltHole(bolt, length = 2*wall+1);

		translate([0, -z_bed_carriage_depth - alu_x/2, -2*wall-0.5]) boltHole(bolt, length = 2*wall+1);

		translate([z_bed_carriage_width/2 - M5_NUT/2-wall, -z_bed_carriage_depth - alu_x/2, -M5_DEPTH+0.1]) nutHole(bolt, length = 2*wall+1);

		translate([-z_bed_carriage_width/2 + M5_NUT/2+wall, -z_bed_carriage_depth - alu_x/2, -M5_DEPTH+0.1]) nutHole(bolt, length = 2*wall+1);

		translate([0, -z_bed_carriage_depth - alu_x/2, -M5_DEPTH+0.1]) nutHole(bolt, length = 2*wall+1);

		//translate([z_bed_carriage_width/2 - M5_NUT/2-wall, -z_bed_carriage_depth+5, 0]) rotate([90, 0, 0]) boltHole(bolt, length = wall+1);
		//translate([z_bed_carriage_width/2 - M5_NUT/2-wall, -z_bed_carriage_depth+23+wall, 0]) rotate([90, 0, 0]) cylinder(d = M5_NUT, h = 23);

		//translate([-z_bed_carriage_width/2 + M5_NUT/2+wall, -z_bed_carriage_depth+5, 0]) rotate([90, 0, 0]) boltHole(bolt, length = wall+1);
		//translate([-z_bed_carriage_width/2 + M5_NUT/2+wall, -z_bed_carriage_depth+23+wall, 0]) rotate([90, 0, 0]) cylinder(d = M5_NUT, h = 23);
	}

}

//translate([0, 50, 2*wall]) z_bed_carriage(true);

//translate([0, -50, 2*wall]) mirror([0,1,0]) z_bed_carriage(false);
