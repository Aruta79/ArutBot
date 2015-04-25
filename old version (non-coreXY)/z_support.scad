// preview[view:north west, tilt:top diagonal]

include <inc/nuts_and_bolts.scad>;

panel_depth = 80;
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

//units are in millimeters
M3 = 3.0/2.0;
nema17_side = 42.2;
nema17_bolts = 31.04;
nema17_depth = 33.8;
nema17_crown = 11;
nema17_bolt_radious = M3;

module bracket_whole()
{

difference()
{
	union()
	{
		cube([nema17_side+bracket_wall_width*2, bracket_wall_width, nema17_side+bracket_wall_width*2]);

		translate([-bracket_flaps-rod,0,0])
			cube([nema17_side+(bracket_wall_width+bracket_flaps)*2+rod,panel_depth,bracket_wall_width]);		
		
		translate([-bracket_wall_width-rod/2,0,0])
		difference()
		{
			cube([bracket_wall_width+rod/2, bracket_depth, nema17_side+bracket_wall_width*2]);
			translate([0,bracket_depth+2,nema17_side/2+bracket_wall_width]) rotate([90,0,0]) cylinder(h=bracket_depth+4,d=rod,$fn=100);
		}
	}

		translate([20,panel_depth,0])
			rotate([0,0,-atan((panel_depth-22)/(nema17_side-(bracket_wall_width)+20))])
			cube([nema17_side+(bracket_wall_width+bracket_flaps)*2+rod,panel_depth,bracket_wall_width]);		

		translate([-(bracket_flaps+bracket_wall_width+rod/2),20,0])
			rotate([0,0,atan((panel_depth-22)/(bracket_flaps+bracket_wall_width+rod/2))])
			cube([nema17_side+(bracket_wall_width+bracket_flaps)*2+rod,panel_depth,bracket_wall_width]);		

	translate([bracket_wall_width + nema17_side + bracket_wall_width + bracket_flaps-bracket_flap_margin,bracket_depth/2,0])
		cylinder(r = bracket_bolts_diameter/2, h = 30, $fn = 40,center=true);

	translate([10,panel_depth-bracket_depth/2,0])
		cylinder(r = bracket_bolts_diameter/2, h = 30, $fn = 40,center=true);

	translate([-bracket_flaps+bracket_flap_margin-rod,bracket_depth/2,0])
		cylinder(r = bracket_bolts_diameter/2, h = 30, $fn = 40,center=true);


	translate([bracket_wall_width,bracket_wall_width,bracket_wall_width])
	NemaForCSG(nema17_side, nema17_depth, nema17_bolts, nema17_crown, nema17_bolt_radious);

	
	translate([0,bracket_wall_width,-nut_and_margin/2+bracket_wall_width+(nema17_side-bracket_wall_width)/4])
	cube([bracket_wall_width*2,bracket_depth-bracket_wall_width, nut_and_margin]);

	translate([0,bracket_wall_width,-nut_and_margin/2+bracket_wall_width+(nema17_side-bracket_wall_width)/4+nema17_side/2+bracket_wall_width/2])
	cube([bracket_wall_width*2,bracket_depth-bracket_wall_width, nut_and_margin]);

	translate([-METRIC_NUT_THICKNESS[3],bracket_wall_width+(bracket_depth-bracket_wall_width)/2,bracket_wall_width+(nema17_side-bracket_wall_width)/4])
	rotate([0,90,0])
	union()
	{
		nutHole(3);
		translate([0,0,-rod-bracket_wall_width*2+1]) cylinder(h=rod+bracket_wall_width*2,r=M3,$fn=100);
	}

	translate([-METRIC_NUT_THICKNESS[3],bracket_wall_width+(bracket_depth-bracket_wall_width)/2,bracket_wall_width+(nema17_side-bracket_wall_width)/4+nema17_side/2+bracket_wall_width/2])
	rotate([0,90,0])
	union()
	{
		nutHole(3);
		translate([0,0,-rod-bracket_wall_width*2+1]) cylinder(h=rod+bracket_wall_width*2,r=M3,$fn=100);
	}

}
		translate([-bracket_depth-bracket_flaps,-margin,0])
		rotate([0,0,90])
		difference()
		{
			translate([margin,0,0]) cube([bracket_wall_width+rod/2-margin, bracket_depth, nema17_side+bracket_wall_width*2]);
			translate([0,bracket_depth+2,nema17_side/2+bracket_wall_width]) rotate([90,0,0]) cylinder(h=bracket_depth+4,d=rod,$fn=100);
	translate([bracket_wall_width+rod/2,bracket_wall_width+(bracket_depth-bracket_wall_width)/2,bracket_wall_width+(nema17_side-bracket_wall_width)/4])

	rotate([0,90,0])
	union()
	{
		boltHole(3);
		translate([0,0,-rod-bracket_wall_width*2+1]) cylinder(h=rod+bracket_wall_width*2,r=M3,$fn=100);
	}

	translate([bracket_wall_width+rod/2,bracket_wall_width+(bracket_depth-bracket_wall_width)/2,bracket_wall_width+(nema17_side-bracket_wall_width)/4+nema17_side/2+bracket_wall_width/2])
	rotate([0,90,0])
	union()
	{
		boltHole(3);
		translate([0,0,-rod-bracket_wall_width*2+1]) cylinder(h=rod+bracket_wall_width*2,r=M3,$fn=100);
	}


	}


}

rotate([90,0,0])
{
translate([0,0,-nema17_side-bracket_wall_width*2-20]) 
bracket_whole();

mirror([0,0,1]) 
translate([0,0,-nema17_side-bracket_wall_width*2-20]) 
bracket_whole();
}

color([1,1,1]) 
translate([-bracket_wall_width,-40,-5])
cube([22 ,10,10]);

/*
	color([0,0,1]) 

	color([1,0,0]) translate([-50,0,0])
			cube([nema17_side+(bracket_wall_width+bracket_flaps)*2+rod+100,20,bracket_wall_width]);		
	color([1,0,0]) 
			cube([20,100,bracket_wall_width]);		

*/