// preview[view:north west, tilt:top diagonal]

include <inc/nuts_and_bolts.scad>;
include <lm10uu-holder-slim.scad>;

panel_depth = 20;
bracket_wall_width = 6;
bracket_depth = 20;
//lengths of tabs
bracket_flaps =  25;
bracket_flap_margin = 10;
bracket_bolts_diameter = 4.2; 
bevel_inner_corners = "no"; //[yes,no]

rod = 10;
nut_and_margin = 7.5;
margin = 1;

bearing_od = 26;
bearing_depth = 8;
bearing_support = 2;

M3 = 3.0/2.0;
nema17_side = 42.2;
nema17_bolts = 31.04;
nema17_depth = 33.8;
nema17_crown = 11;
nema17_bolt_radious = M3;

flange_small = 25;
flange_big = 42;

x_side = flange_big + bracket_wall_width;
x_length = 50;
x_depth = 6;
x_height = nema17_side;

leadscrew_offset = nema17_side/2+bracket_wall_width;
leadscrew_z_offset = (x_side+bracket_wall_width)/2;

module NemaForCSG(nema_side, nema_depth, nema_bolts, nema_crown, nema_bolt_radious)
{
	//bevel corners
	r1 = nema_side/2- nema_bolts/2;
	r2 = sqrt(2)* r1 ;
	r=(r2-r1)*2;
	
	
	difference()
	{
	
		union()
		{
			cube([nema_side,nema_depth,nema_side]);
	
			translate( [nema_side/2,0,nema_side/2]) 
				rotate(90,[1,0,0]) 
				{
					cylinder(r = nema_crown, h = 30, $fn = 40,center=true);
				}

			translate( [nema_side/2,0,nema_side/2])
			{
				//bolt holes
				for(j=[1:4])
				{		
					rotate(90*j,[0,1,0]) 
						translate( [nema_bolts/2.0,0,nema_bolts/2.0]) 
							rotate(-90,[1,0,0]) 
							{
								cylinder(r = nema_bolt_radious, h = 30, $fn = 20,center=true);
							}
				}
			}
		}	

		if (bevel_inner_corners == "yes")
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

module bracket_whole()
{

difference()
{
	union()
	{
		translate([-1.5,0,0])		
		union()
		{
			cube([x_length+1.5, x_depth, x_side]);
			cube([x_depth, x_height, x_side]);
		}

	
		translate([-lm10uu_dia/2+bracket_wall_width+rod/2,lm10uu_length/2,leadscrew_z_offset])
		rotate([0,-90,0])
		{
			lm10uu_holder();
		}
	}

	color([0,0,1]) 
	translate([leadscrew_offset,bearing_depth/2+bearing_support,leadscrew_z_offset]) rotate([90,0,0])
		cylinder(r = bearing_od/2, h = bearing_depth+1, $fn = 100,center=true);	

	color([0,1,1]) 
	translate([leadscrew_offset,0,leadscrew_z_offset]) rotate([90,0,0])
		cylinder(r = flange_small/2, h = bearing_depth, $fn = 100,center=true);	

		translate([leadscrew_offset,x_depth,leadscrew_z_offset])
		{
		for ( i = [0 : 5] )
		{
		    rotate([90, i * 360 / 6, 0])
		    translate([0, 34/2, -0.5])
		    cylinder(r = 2.5, h=x_depth+1,$fn=80);
		}
		}		

}

}

module flange()
{
translate([leadscrew_offset,x_depth+10,leadscrew_z_offset])
rotate([90,0,0])
color([0,0,0])
{
	difference()
	{
		union()
		{
			cylinder(h=25,r=flange_small/2,$fn=80);
			cylinder(h=10,r=flange_big/2,$fn=80);
		}

		for ( i = [0 : 5] )
		{
		    rotate( i * 360 / 6, [0, 0, 1])
		    translate([0, 34/2, -0.5])
		    cylinder(r = 2.5, h=11,$fn=80);
		}		
	}
}
}


bracket_whole();
flange();
