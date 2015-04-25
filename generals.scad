include <nuts_and_bolts.scad>;

$fn=50;

M3 = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[3];
M3_NUT = METRIC_NUT_AC_WIDTHS[3];
M3_DEPTH = METRIC_NUT_THICKNESS[3];

M5 = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[5];
M5_NUT = METRIC_NUT_AC_WIDTHS[5];
M5_DEPTH = METRIC_NUT_THICKNESS[5];

bolt = 6;
small_bolt = 3;

lm10uu_dia = 19.4;
lm10uu_length = 29;

thin_wall = 3;
wall = 5;

clearance = 0.2;
wall_clearance = 1;

alu_x = 20;

rod_dia = 10;

zip_width = 3.5;
zip_height = 1.5;
zip_offset = 2;

leadscrew_d = 10;
leadscrew_h = 500;
leadscrew_coupling_d = 25;
leadscrew_coupling_h = 30;

holder_length = 11;
holder_thickness = 5;
holder_width = 30;

rounded = 3;

hotend_width = 35;
hotend_fan = 30;
hotend_top_h = 3.7;
hotend_groove_h = 6;
hotend_groove_offset = hotend_groove_h + hotend_top_h;
hotend_groove_d = 12;
hotend_d = 16;
hotend_big_d = 22.3;
hotend_drop = -3-hotend_groove_h/2;
hotend_total_height = 62.3;
//hot_end_fan_depth = 10.5;
//hot_end_fan_opening = 25;

//PULLEY PARAMETERS AND LOCATIONS
pulley_s_d_small = 12.22; //9.8;
pulley_s_d = 16; //13;
pulley_s_h = 14.1;
pulley_s_base_h = 6;

pulley_b_d = 16;
pulley_b_d_small = 12.22;
pulley_b_d_small_with_belt = 13.65;
pulley_b_h = 16;
pulley_b_base_h = 6.6;

hole_dist_1 = pulley_s_d/2 + 3*wall_clearance;
hole_x_offset = 16;
hole_dist_2 = hole_dist_1 + sqrt(2)/2 * pulley_s_d-1;

belt_bearing_d = 10;
belt_bearing_h = 8;   //two small bearings stacked

bearing_pulley_h = belt_bearing_h + 2; //also two small bearings stacked, plus two 1mm walls

belt_z_offset = 1; //2mm per rubber washer
belt_left_pulley_z_offset = alu_x-bearing_pulley_h;

z_bearing_d = 26;
z_bearing_h = 8;
z_rod_d = 10;

belt_depth = 0.8; //thickness of belt above pulley
belt_width = 6;
belt_pitch = 2.0;                  
tooth_width = 1.3;
tooth_h = .75;
beltClip_length = 2*wall + thin_wall;

endstop_hole_spread = 10;
endstop_hole_offset = 7.5;

//XY ROD LOCATIONS
y_from_top = 25;
y_from_side = alu_x/2 + thin_wall + wall_clearance;

x_end_v_rod_dist = lm10uu_dia + 4*wall;

//MOTOR PARAMETERS AND LOCATIONS
motor_from_side_x = 0;
motor_from_side_y = 0;

nema17_side = 42.3;
nema17_bolts = 31.04;
nema17_depth = 34;
nema17_crown = 22.5;

//X CARRIAGE
x_carriage_width = 2*hotend_width + thin_wall;
x_carriage_depth = lm10uu_dia/2 + thin_wall/2;
x_carriage_height = x_end_v_rod_dist + lm10uu_dia + 2*wall;
x_carriage_top_height = 32;
x_carriage_belt_clip_height = 10;
x_carriage_belt_clip_offset = 20;
x_carriage_belt_holder_height = 10;

x_carriage_belt_dist = 15;
x_carriage_belt_offset = 0;

//Z BOTTOM
z_bottom_width =  80;
z_bottom_clearing_width =  40;
z_bottom_height = 2*alu_x + nema17_depth;
z_bottom_motor_offset = 22 + wall+ 1.5;
z_bottom_motor_top = nema17_depth+alu_x-3*wall;

z_smooth_rod_offset = 50;

//OTHERS
heatbed_x = 300;
heatbed_y = 300;
heatbed_h = 5;
heatbed_offset_y = 5;
heatbed_support_h = 5;
heatbed_support_offset_x = 20;
heatbed_support_offset_y = 40;


//---------------------------------------------------------------------
//-------------------------- HARDWARE ---------------------------------
//---------------------------------------------------------------------

module smooth_rod(length = 800)
{
	color([1,1,1]) cylinder(d=rod_dia, h=length);
}

module nemaMotor(nema_side, nema_depth, nema_bolts, nema_crown, nema_bolt_radius, bevel_inner_corners = true, top_length = 30)
{
	//bevel corners
	r1 = nema_side/2- nema_bolts/2;
	r2 = sqrt(2)* r1 ;
	r=(r2-r1)*2;
	
	translate([-nema17_side/2, 0, -nema17_side/2])
	difference()
	{
	
		union()
		{
			cube([nema_side,nema_depth,nema_side]);
	
			translate( [nema_side/2,-top_length/2,nema_side/2]) 
				rotate(90,[1,0,0]) 
				{
					cylinder(d = nema_crown, h = top_length, $fn = 40,center=true);
				}

			translate( [nema_side/2,0,nema_side/2])
			{
				//bolt holes
				for(j=[1:4])
				{		
					rotate(90*j,[0,1,0]) 
						translate( [nema_bolts/2.0,-top_length/2,nema_bolts/2.0]) 
							rotate(-90,[1,0,0]) 
							{
								cylinder(r = nema_bolt_radius, h = top_length, $fn = 20,center=true);
							}
				}
			}
		}	

		if (bevel_inner_corners)
		{
			//bevel
			translate( [nema_side/2,0,nema_side/2])
			{
			
				for(j=[1:4])
				{
					rotate(90*j,[0,1,0]) 
						translate( [nema_side/2,nema_depth/2,nema_side/2]) 
					rotate(45,[0,1,0]) 
					cube([30,50,r], center = true);
				}
			}
		}
	}

}

module nema17(depth = nema17_depth, top)
{
	color([1,0,0])
	nemaMotor(nema17_side, depth, nema17_bolts, nema17_crown, M3/2, top_length=top);
}

module heatbed()
{
	color([0, 0, 0]) 
	translate([-heatbed_x/2, 0, 0])
	cube([heatbed_x, heatbed_y, heatbed_h]);
}

module heatbed_support()
{
	color([0.2, 0.2, 0.2]) 
	translate([-(heatbed_x)/2 - heatbed_support_offset_x, 0, 0])
	cube([heatbed_x + heatbed_support_offset_x*2, heatbed_y + heatbed_support_offset_y*2, heatbed_support_h]);

	echo("Heatbed support x: ",heatbed_x + heatbed_support_offset_x*2);
	echo("Heatbed support y: ",heatbed_y + heatbed_support_offset_y*2);
}
	
module bar_vert(length)
{
	translate([alu_x/2, alu_x/2, 0]) 2020Profile(length);
}

module bar_horiz(length, x = true, y = false)
{
	rotate([x ? 90 : 0, y ? 90 : 0, 0]) bar_vert(length);
}

module pulley_small()
{
	difference()
	{
		union()
		{
			cylinder(h = pulley_s_base_h, d=pulley_s_d);
			translate([0, 0, pulley_s_base_h]) cylinder(h = pulley_s_h-pulley_s_base_h, d=pulley_s_d_small);
			translate([0, 0, pulley_s_h-1]) cylinder(h = 1, d=pulley_s_d);
		}

		translate([0, 0, -1]) cylinder(h=pulley_s_h+2, d=5);
	}
}

module pulley_small_new()
{
	difference()
	{
		union()
		{
			cylinder(h = 1, d=pulley_s_d);
			translate([0, 0, 1]) cylinder(h = belt_bearing_h, d=pulley_s_d_small);
			translate([0, 0, belt_bearing_h+1]) cylinder(h = 1, d=pulley_s_d);
		}

		translate([0, 0, -1]) cylinder(h=pulley_s_h+2, d=3);
	}
}

module pulley_big()
{
	difference()
	{
		union()
		{
			cylinder(h = pulley_b_base_h, d=pulley_b_d);
			translate([0, 0, pulley_b_base_h]) cylinder(h = pulley_b_h-pulley_b_base_h, d=pulley_b_d_small);
			translate([0, 0, pulley_b_h-1]) cylinder(h = 1, d=pulley_b_d);
		}

		translate([0, 0, -1]) cylinder(h=pulley_b_h+2, d=5);
	}
}

module bearing()
{
	difference()
	{
		union()
		{
			cylinder(h = 1, d=pulley_s_d);
			translate([0, 0, 1]) cylinder(h = belt_bearing_h, d=belt_bearing_d);
			translate([0, 0, belt_bearing_h+1]) cylinder(h = 1, d=pulley_s_d);
		}

		translate([0, 0, -1]) cylinder(h=pulley_s_h+2, d=3);
	}
}

module notch()
{
	difference()
	{
		union()
		{
			translate([0, 1.5, 0])cylinder(d1 = 5, d2 = 0, h = 10, $fn=30);
		
			translate([0, 1.5, -3])cylinder(d1 = 0, d2 = 5, h = 3, $fn=30);
		}
		
		translate([-5, 0, -5]) cube([10,10,15]);
	}
}

module zip_channel()
{
	rotate([90, -90, 0])
	{
		/*translate([(bearing_dia/2+border-zip_height/2+0.1), 0, zip_width/2])
			cube([zip_height, 12, zip_width], center=true);*/
		for (j=[-1,1])
		{
			translate([0,j*(lm10uu_dia/2+thin_wall-zip_height/2), zip_width/2])
				cube([11,zip_height+0.5, zip_width], center=true);
		}
		translate([zip_offset,0,0])// bearing_len/2 + border])
		difference ()
		{
			cylinder(r=lm10uu_dia/2 + thin_wall-0.1, h=zip_width);
			cylinder(r=lm10uu_dia/2 + thin_wall-0.3 - zip_height, h=zip_width);
		}
	}
}

module rod_holder()
{
	m3_nut_diameter = 5.3;
	m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;
	nut_trap_depth = 2;

	difference()
	{
		union()
		{
			difference()
			{
				translate([-holder_width/2, 0, 0]) cube([holder_width,holder_thickness,holder_length]);
				
				translate([holder_width/2-rod_dia/2,holder_thickness/2,holder_length/2])
				rotate([90,0,0])
				cylinder(holder_thickness+10, r=M3/2,$fn=100,center=true);
		
				translate([-holder_width/2+rod_dia/2,holder_thickness/2,holder_length/2])
				rotate([90,0,0])
				cylinder(holder_thickness+10, r=M3/2,$fn=100,center=true);
		
				translate([holder_width/2-rod_dia/2,holder_thickness+1,holder_length/2])
				rotate([90,0,0])
				cylinder(r=m3_nut_diameter_bigger/2, h=nut_trap_depth+1, $fn=6);
		
				translate([-holder_width/2+rod_dia/2,holder_thickness+1,holder_length/2])
				rotate([90,0,0])
				cylinder(r=m3_nut_diameter_bigger/2, h=nut_trap_depth+1, $fn=6);
			}

			difference()
			{
				cylinder(holder_length,r=rod_dia/2+3,$fn=100,true);
				translate([-holder_width/2,-rod_dia/2-3,-10]) cube([holder_width,rod_dia/2+4,50]);
			}
		}
	
		translate([0, 0, -1]) cylinder(holder_length+2,r=rod_dia/2,$fn=100,true);
	}
}

module rod_clamp()
{
	{
		difference()
		{
			union()
			{
				cube([holder_width,holder_length,6],center=true);
				translate([0,0,wall_clearance])
				rotate([90,0,0]) cylinder(holder_length,d=rod_dia+6,$fn=100,center=true);
			}
	
			translate([0,0,-1])
			rotate([90,0,0]) cylinder(holder_length+5,d=rod_dia,$fn=100,center=true);
			
			translate([0,0,(-holder_thickness-rod_dia)/2])
			cube([holder_width+2,holder_length+2,holder_thickness+rod_dia],center=true);
	
			translate([holder_width/2-rod_dia/2,0,0])
			cylinder(holder_thickness+1,d=M3,$fn=100,center=true);		
	
			translate([-holder_width/2+rod_dia/2,0,0])
			cylinder(holder_thickness+1,d=M3,$fn=100,center=true);		
		}
	}
}

//rod_holder();
