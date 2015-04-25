include <nuts_and_bolts.scad>;
include <generals.scad>;

module x_carriage_vertical(front = true, with_holders = false)
{
	translate([-x_carriage_width/2, 0, 0])
	mirror([0, front ? 0 : 1, 0])
	difference()
	{
		union()
		{
			translate([0, -lm10uu_dia/2-thin_wall/2, x_carriage_height-x_carriage_top_height-lm10uu_dia/2-wall-x_end_v_rod_dist]) cube([x_carriage_width, x_carriage_depth, x_carriage_top_height]);
			translate([x_carriage_width/4-wall, -lm10uu_dia/2-thin_wall/2, -lm10uu_dia/2-wall-x_end_v_rod_dist]) cube([x_carriage_width/2+2*wall, x_carriage_depth, x_carriage_height]);
			
			if (front && with_holders)
			{
				translate([x_carriage_width-x_carriage_belt_clip_offset+5, 0, x_carriage_top_height/2+x_carriage_belt_clip_height/2]) x_carriage_belt_holder(true);

				translate([x_carriage_belt_clip_offset-8, 0, x_carriage_top_height/2+x_carriage_belt_clip_height/2]) x_carriage_belt_holder(false);
			}

			if (front)
			{
				translate([x_carriage_belt_clip_offset + (front ? 0 : thin_wall), -x_carriage_depth, x_carriage_height-lm10uu_dia/2-wall-x_end_v_rod_dist]) x_carriage_belt_clip(); //x_carriage_belt_holder();

				translate([x_carriage_width - x_carriage_belt_clip_offset - (front ? 0 : thin_wall), -x_carriage_depth, x_carriage_height-lm10uu_dia/2-wall-x_end_v_rod_dist]) x_carriage_belt_clip(); //x_carriage_belt_holder();
			}
		}

		translate([x_carriage_width/2-lm10uu_length/2, 0, -x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([-1, 0, -x_end_v_rod_dist]) rotate([0, 90, 0]) cylinder(d=rod_dia+wall_clearance, h=x_carriage_width+2);
		
		translate([1, 0, 0]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([x_carriage_width-lm10uu_length-2, 0, 0]) rotate([0, 90, 0]) cylinder(d=lm10uu_dia, h=lm10uu_length+1);

		translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=rod_dia+wall_clearance, h=x_carriage_width+2);

		// CUTOUTS
		translate([wall/2, 0, -x_carriage_height+(x_carriage_height-x_carriage_top_height-lm10uu_dia/2-wall-x_end_v_rod_dist)]) x_carriage_cutout();
		translate([x_carriage_width-wall/2, 0, -x_carriage_height+(x_carriage_height-x_carriage_top_height-lm10uu_dia/2-wall-x_end_v_rod_dist)]) x_carriage_cutout();

		// BOLT HOLES
		translate([M3+1, (front ? -x_carriage_depth-0.5 : 0.5), lm10uu_dia/2+wall - M3]) rotate([front ? -90 : 90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

		translate([x_carriage_width-M3-1, (front ? -x_carriage_depth-0.5 : 0.5), lm10uu_dia/2+wall - M3]) rotate([front ? -90 : 90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);
			
		translate([x_carriage_width/2, (front ? -x_carriage_depth-0.5 : 0.5), lm10uu_dia/2+wall - M3]) rotate([front ? -90 : 90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);
			
		translate([M3+1, (front ? -x_carriage_depth-0.5 : 0.5), -lm10uu_dia/2-1.5*wall + M3]) rotate([front ? -90 : 90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

		translate([x_carriage_width-M3-1, (front ? -x_carriage_depth-0.5 : 0.5), -lm10uu_dia/2-1.5*wall + M3]) rotate([front ? -90 : 90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);
		
		translate([x_carriage_width/2, (front ? -x_carriage_depth-0.5 : 0.5), -lm10uu_dia/2-wall + M3+hotend_drop]) rotate([front ? -90 : 90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1); //center	
			
		*translate([x_carriage_width/2+lm10uu_length/2-M3_NUT/2+2, (front ? -x_carriage_depth-0.5 : 0.5), -x_end_v_rod_dist+lm10uu_dia/2+wall]) rotate([front ? -90 : 90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

		*translate([x_carriage_width/2-lm10uu_length/2+M3_NUT/2-1, (front ? -x_carriage_depth-0.5 : 0.5), -x_end_v_rod_dist+lm10uu_dia/2+wall]) rotate([front ? -90 : 90, 0 ,0]) boltHole(small_bolt, length=x_carriage_depth+1);

		//BOTTOM REMOVER
		translate([-.5, -x_carriage_depth-.5, -x_end_v_rod_dist-41]) cube([x_carriage_width+1, x_carriage_depth+1, 40]);

		translate([x_carriage_width/2-zip_width/2+lm10uu_length/2-wall, 0, -x_end_v_rod_dist]) rotate([0, 0, 90]) zip_channel();
		translate([x_carriage_width/2-lm10uu_length/2+wall, 0, -x_end_v_rod_dist]) rotate([0, 0, 90]) zip_channel();
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

module x_carriage_belt_clip()
{
		difference()
		{
			cube([thin_wall, x_carriage_depth*2, x_carriage_belt_clip_height]);

			translate([thin_wall+0.5, x_carriage_depth, x_carriage_belt_clip_height / 2]) rotate([0, -90, 0]) boltHole(3, length = thin_wall + 1);
		}
}

module x_carriage_belt_holder(right, extra_bottom = 0, extra_top = 0)
{
            echo(extra_bottom, extra_top);
			translate([0, 0, -x_carriage_belt_holder_height/2])
			difference()
			{
				union()
				{
					translate([right ? 0 : -M3_DEPTH, -x_carriage_depth+2*thin_wall, 0]) cube([wall+M3_DEPTH, 2*x_carriage_depth-4*thin_wall, x_carriage_belt_holder_height]);
					translate([right ? 0 : -beltClip_length+wall, x_carriage_belt_dist/2, 0]) beltClip(right, false, extra_top);
					translate([right ? 0 : -beltClip_length+wall, -x_carriage_belt_dist/2, 0]) beltClip(!right, true, (!right ? extra_bottom : extra_top));
				}
				translate([right ? -0.5 : wall+0.5, 0, x_carriage_belt_holder_height/2]) rotate([0, right ? 90 : -90, 0]) boltHole(3,length=2*wall);
				translate([right ? (wall+0.1) : (-M3_DEPTH-0.1), 0, x_carriage_belt_holder_height/2]) rotate([0, 90, 0]) nutHole(3);
			}
}

module beltClip(left = false, front = false, extra_space = 0)
{
	translate([0, -thin_wall, 0])
	difference()
	{
		cube([beltClip_length, 2*thin_wall, 2*wall]);
        
        echo(extra_space);
		
        translate([-1, thin_wall, (left &&  front) ? (-1) : (2*wall - belt_width)]) cube([beltClip_length+2, belt_depth + extra_space, belt_width+0.5]);
		echo(belt_depth);
		for ( i = [0 : round(beltClip_length/belt_pitch)]){
			translate([belt_pitch*i, thin_wall-tooth_h/2, (left &&  front) ? (belt_width/2-1) : (2*wall - belt_width/2+0.5)]) cube(size = [tooth_width, tooth_h+0.01, belt_width+1], center = true);
		}
	}
}

//translate([0, 0, x_carriage_depth]) rotate([90, 0, 0]) x_carriage_vertical(front = true);
//translate([x_carriage_width/3 + alu_x/2, x_carriage_height-alu_x/2, x_carriage_depth]) rotate([-90, 0, 0]) x_carriage_vertical(front = false);

//translate([-x_carriage_width/2+wall , x_carriage_height/2, x_carriage_belt_holder_height/2]) x_carriage_belt_holder(true);
//translate([x_carriage_width/2+alu_x, 0, x_carriage_belt_holder_height/2]) x_carriage_belt_holder(false);

//x_carriage_vertical(true);
//translate([0, 20, 0]) x_carriage_vertical(false);

//translate([0,0,0]) x_carriage_belt_holder(false, extra_bottom=0.3, extra_top=0.0);
//translate([30,0,0]) x_carriage_belt_holder(true, extra_bottom=0.3, extra_top=0.0);

//beltClip();