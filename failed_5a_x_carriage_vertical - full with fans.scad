include <nuts_and_bolts.scad>;
include <generals.scad>;

x_carriage_width = 2*hot_end_width + wall;
x_carriage_depth = lm10uu_dia + thin_wall;
x_carriage_height = x_end_v_rod_dist + rod_dia+4*wall;
x_carriage_belt_clip_width = x_carriage_width * 2 / 3;
x_carriage_belt_clip_height = 2*wall;
x_carriage_belt_hole = 2;

module x_carriage_vertical()
{
	difference()
	{
		union()
		{
			translate([0, -lm10uu_dia/2, -lm10uu_dia/2-wall]) cube([x_carriage_width, x_carriage_depth, x_carriage_height]);

			translate([(x_carriage_width-x_carriage_belt_clip_width)/2, -lm10uu_dia/2, x_carriage_height-lm10uu_dia/2-wall]) x_carriage_belt_clip();
		}

		translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([x_carriage_width-lm10uu_length+1, 0, 0]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=rod_dia+wall_clearance, h=x_carriage_width+2);
		
		translate([-1, 0, -lm10uu_dia*1/4]) cube([x_carriage_width+2, lm10uu_dia*3/4, lm10uu_dia*3/4]);


		translate([-1, 0, x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([x_carriage_width-lm10uu_length+1, 0, x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([-1, 0, x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(d=rod_dia+wall_clearance, h=x_carriage_width+2);
		
		translate([-1, 0, x_end_v_rod_dist-lm10uu_dia/2]) cube([x_carriage_width+2, lm10uu_dia*3/4, lm10uu_dia*3/4]);

		//FAN CAVITY AND OPENING
		translate([x_carriage_width/4-hot_end_fan/2, x_carriage_depth-hot_end_fan_depth-lm10uu_dia/2, x_carriage_height/2- hot_end_fan/2-lm10uu_dia/2-wall]) cube([hot_end_fan, hot_end_fan_depth+1,hot_end_fan]);
		
		translate([x_carriage_width*3/4-hot_end_fan/2, x_carriage_depth-hot_end_fan_depth-lm10uu_dia/2, x_carriage_height/2- hot_end_fan/2-lm10uu_dia/2-wall]) cube([hot_end_fan, hot_end_fan_depth+1,hot_end_fan]);

		translate([x_carriage_width/4, -lm10uu_dia/2, x_carriage_height/2-lm10uu_dia/2-wall]) rotate([90,0,0]) cylinder(h= x_carriage_depth+2,d=hot_end_fan_opening, center=true);
		
		translate([x_carriage_width*3/4, -lm10uu_dia/2, x_carriage_height/2-lm10uu_dia/2-wall]) rotate([90,0,0]) cylinder(h= x_carriage_depth+2,d=hot_end_fan_opening, center=true);
	}
}

module x_carriage_belt_clip()
{
	difference()
	{
		cube([x_carriage_belt_clip_width, x_carriage_depth, x_carriage_belt_clip_height]);

		translate([-1, x_carriage_depth/2-wall/2 - (x_carriage_belt_hole - belt_thickness) + x_carriage_belt_dist/2, 2]) cube([x_carriage_belt_clip_width+2, x_carriage_belt_hole, x_carriage_belt_clip_height+1]);
		translate([-1, x_carriage_depth/2-wall/2 + belt_thickness - x_carriage_belt_dist/2, 0]) cube([x_carriage_belt_clip_width+2, x_carriage_belt_hole, x_carriage_belt_clip_height+1]);
	}
}

x_carriage_vertical();

