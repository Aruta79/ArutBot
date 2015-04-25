include <nuts_and_bolts.scad>;
include <generals.scad>;

x_carriage_width = 2*hot_end_width + thin_wall;
x_carriage_depth = lm10uu_dia/2 + thin_wall/2;
x_carriage_height = x_end_v_rod_dist + lm10uu_dia + 2*wall;
x_carriage_belt_clip_width = 15;
x_carriage_belt_clip_height = 2*wall + thin_wall;
x_carriage_belt_clip_depth = x_carriage_depth;
x_carriage_belt_hole = 2*belt;
x_carriage_belt_clip_offset = 25;

module x_carriage_vertical(front = true)
{
	mirror([0, front ? 0 : 1, 0])
	difference()
	{
		union()
		{
			translate([0, -lm10uu_dia/2-thin_wall/2, -lm10uu_dia/2-wall]) cube([x_carriage_width, x_carriage_depth, x_carriage_height]);

			*translate([x_carriage_width-x_carriage_belt_clip_offset, -lm10uu_dia/2 - thin_wall/2, x_carriage_height-lm10uu_dia/2-wall]) x_carriage_belt_holder();

			*translate([x_carriage_belt_clip_offset, -lm10uu_dia/2 - thin_wall/2, x_carriage_height-lm10uu_dia/2-wall]) x_carriage_belt_holder();

			if(front) translate([x_carriage_belt_clip_offset, 0, x_carriage_height-lm10uu_dia/2-wall]) x_carriage_belt_clip(); //x_carriage_belt_holder();

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

			translate([x_carriage_width/2-lm10uu_length/2+M3_NUT/2-1, 0.05, +lm10uu_dia/2+thin_wall]) rotate([90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);
		}

		translate([-.5, -x_carriage_depth-.5, -41]) cube([x_carriage_width+1, x_carriage_depth+1, 40]);
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

module x_carriage_belt_holder()
{
			difference()
			{
				cube([wall, x_carriage_depth, x_carriage_belt_clip_height]);
				translate([-1, x_carriage_depth/2, x_carriage_belt_clip_height/2]) rotate([0, 90, 0]) boltHole(small_bolt,length=2*wall);
			}
}

module x_carriage_belt_clip()
{
		difference()
		{
			translate([0, -x_carriage_depth, 0]) cube([x_carriage_belt_clip_width, x_carriage_depth*2, x_carriage_belt_clip_height]);
			
			translate([x_carriage_belt_clip_width - thin_wall - wall, -x_carriage_depth+thin_wall, -1]) cube([wall, x_carriage_depth*2-2*thin_wall, x_carriage_belt_clip_height+2]);


			translate([x_carriage_belt_clip_width+1, -x_carriage_depth/2, x_carriage_belt_clip_height/2]) rotate([0, -90, 0]) boltHole(small_bolt, length=wall+1);

			translate([x_carriage_belt_clip_width+1, x_carriage_depth/2, x_carriage_belt_clip_height/2]) rotate([0, -90, 0]) boltHole(small_bolt, length=wall+1);

			translate([-1, x_carriage_belt_dist/2 + x_carriage_belt_offset-x_carriage_belt_hole, thin_wall]) cube([2*wall, x_carriage_belt_hole, belt_h]);
			translate([-1, -x_carriage_belt_dist/2 + x_carriage_belt_offset, thin_wall]) cube([2*wall, x_carriage_belt_hole, belt_h]);

			//belt_clip(true,belt_h);

		}
}


x_carriage_vertical();
translate([0, 20, 0]) x_carriage_vertical(false);

x_carriage_belt_clip();