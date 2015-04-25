include <nuts_and_bolts.scad>;
include <generals.scad>;

x_carriage_width = 2*hot_end_width + thin_wall;
x_carriage_depth = lm10uu_dia/2 + thin_wall/2;
x_carriage_height = x_end_v_rod_dist + lm10uu_dia + 2*wall;
x_carriage_belt_clip_width = x_carriage_width * 1 / 3;
x_carriage_belt_clip_height = 2*wall + thin_wall;
x_carriage_belt_clip_depth = x_carriage_depth*2;
x_carriage_belt_hole = 2;

module x_carriage_vertical(front = true)
{
	mirror([0, front ? 0 : 1, 0])
	difference()
	{
		union()
		{
			translate([0, -lm10uu_dia/2-thin_wall/2, -lm10uu_dia/2-wall]) cube([x_carriage_width, x_carriage_depth, x_carriage_height]);

			if (front)
			{
				translate([(x_carriage_width-x_carriage_belt_clip_width)/2, (x_carriage_depth-x_carriage_belt_clip_depth)/2, x_carriage_height-lm10uu_dia/2-wall]) x_carriage_belt_clip();
			}
		}

		translate([x_carriage_width/2-lm10uu_length/2, 0, 0]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=rod_dia+wall_clearance, h=x_carriage_width+2);
		
		translate([1, 0, x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([x_carriage_width-lm10uu_length-2, 0, x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([-1, 0, x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(d=rod_dia+wall_clearance, h=x_carriage_width+2);

		translate([wall/2, 0, -lm10uu_dia*1.5-3*wall]) x_carriage_cutout();
		translate([x_carriage_width-wall/2, 0, -lm10uu_dia*1.5-3*wall]) x_carriage_cutout();

		if (front)
		{
			translate([M3+1, -x_carriage_depth-0.5, x_carriage_height -lm10uu_dia/2-wall - M3]) rotate([-90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

			translate([x_carriage_width-M3-1, -x_carriage_depth-0.5, x_carriage_height -lm10uu_dia/2-wall - M3]) rotate([-90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);
			
			translate([x_carriage_width/2+lm10uu_length/2-M3_NUT/2+2, -x_carriage_depth-0.5, +lm10uu_dia/2+thin_wall]) rotate([-90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

			translate([x_carriage_width/2-lm10uu_length/2+M3_NUT/2-1, -x_carriage_depth-0.5, +lm10uu_dia/2+thin_wall]) rotate([-90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);
		}
		else
		{
			translate([M3+1, 0.05, x_carriage_height -lm10uu_dia/2-wall - M3]) rotate([90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

			translate([x_carriage_width-M3-1, 0.05, x_carriage_height -lm10uu_dia/2-wall - M3]) rotate([90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

			translate([x_carriage_width/2+lm10uu_length/2-M3_NUT/2+2, 0.05, +lm10uu_dia/2+thin_wall]) rotate([90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

			translate([x_carriage_width/2-lm10uu_length/2+M3_NUT/2-1, 0.05, +lm10uu_dia/2+thin_wall]) rotate([90, 0 ,0]) boltHole(small_bol, length=x_carriage_depth+1);
		}

		translate([-.5, -x_carriage_depth-.5, -41]) cube([x_carriage_width+1, x_carriage_depth+1, 40]);
	}
}

module x_carriage_belt_clip()
{
	difference()
	{
		translate([0, (x_carriage_depth - x_carriage_belt_clip_depth)/2, 0]) 
		difference()
		{
			union()
			{
				cube([x_carriage_belt_clip_width, x_carriage_belt_clip_depth, x_carriage_belt_clip_height]);
				translate([-1.5*wall, 0, 0]) cube([x_carriage_belt_clip_width+wall*3, x_carriage_belt_clip_depth, thin_wall]);
			}
			render()
			{
			translate([2*wall, x_carriage_belt_clip_depth+0.01, 2*thin_wall]) mirror([0, 0, 1]) notch();
			translate([x_carriage_belt_clip_width-2*wall, x_carriage_belt_clip_depth+0.01, 2*thin_wall]) mirror([0, 0, 1]) notch();
	
			translate([2*wall, -0.01, 2*thin_wall]) mirror([0, 0, 1]) rotate([0, 0, 180])notch();
			translate([x_carriage_belt_clip_width-2*wall, -0.01, 2*thin_wall]) mirror([0, 0, 1]) rotate([0, 0, 180]) notch();
			}
		}

	translate([-1, 4.1-x_carriage_belt_dist/2+x_carriage_belt_offset, thin_wall-0.75]) cube([x_carriage_belt_clip_width+2, x_carriage_belt_hole, x_carriage_belt_clip_height+1]);
	translate([-1, 3.65+x_carriage_belt_dist/2+x_carriage_belt_offset, thin_wall-0.75]) cube([x_carriage_belt_clip_width+2, x_carriage_belt_hole, x_carriage_belt_clip_height+1]);
	}
}

module x_carriage_cutout()
{
	translate([-x_carriage_width/4+0.5, 0, 0])
	hull()
	{
		translate([rounded/2, 0.5, rounded/2]) rotate([90, -0.5, 0]) cylinder(h=x_carriage_depth+1, d = rounded);
		translate([rounded/2, 0.5, -rounded/2+x_carriage_height]) rotate([90, -0.5, 0]) cylinder(h=x_carriage_depth+1, d = rounded);
		translate([x_carriage_width/2-rounded/2, 0.5, -rounded/2+x_carriage_height]) rotate([90, -0.5, 0]) cylinder(h=x_carriage_depth+1, d = rounded);
		translate([x_carriage_width/2-rounded/2, 0.5, rounded/2]) rotate([90, -0.5, 0]) cylinder(h=x_carriage_depth+1, d = rounded);
	}
}

module x_carriage_belt_cap()
{
	union()
	{
		difference()
		{
			cube([x_carriage_belt_clip_width, x_carriage_belt_clip_depth+2*thin_wall, x_carriage_belt_clip_height+thin_wall-2*clearance]);
			translate([-0.5, thin_wall, thin_wall]) cube([x_carriage_belt_clip_width+1, x_carriage_belt_clip_depth, x_carriage_belt_clip_height+1]);
		}
		
		translate([2*wall, x_carriage_belt_clip_depth+thin_wall+0.01, x_carriage_belt_clip_height-thin_wall]) notch();
		translate([x_carriage_belt_clip_width-2*wall, x_carriage_belt_clip_depth+thin_wall+0.01, x_carriage_belt_clip_height-thin_wall]) notch();

		translate([2*wall, thin_wall-0.01, x_carriage_belt_clip_height-thin_wall]) mirror([0, 1, 0]) notch();
		translate([x_carriage_belt_clip_width-2*wall, thin_wall-0.01, x_carriage_belt_clip_height-thin_wall]) mirror([0, 1, 0])notch();
	}
}


x_carriage_vertical();
translate([0, 20, 0]) x_carriage_vertical(false);

//translate([0, 25, 0]) x_carriage_belt_cap();
//x_carriage_belt_clip();
