use <jonaskuehling-default.scad>
include <lm10uu-holder-slim_double-vertical.scad>

//see thing http://www.thingiverse.com/thing:18384

$fa =0.01;
$fs = 1;

// PARAMETERS
rod_dia = 10;
rod_dist = 65;		// center to center
zrod_leadscrew_dist = 23;
zrod_leadscrew_offset = 24;
z_leadscrew_margin = -5;
clearance = 0.2;		// default clearance
wall = 3;			// default wall thickness
wall_thin = 3;
xend_body_length = 36;

holder_height = 29;
c_holder_height = 29;

m3_screw_dia = 3;
m3_screw_head_dia = 5.5;
m3_screw_head_height = 3;
m3_nut_wrench_size = 5.5;
m3_nut_height = 2.4;

idler_width = 30;
idler_hole = idler_width - 10;
idler_spacing = 12;
idler_dia = 25;		// when using pure 608 bearing without belt guide: 22mm
idler_hole_width = 3;
idler_cover_offset = 9;  //608 thickness + 2* 1mm belt guide

belt_rod_dist = 7.5;		// in y direction
belt_elevation = 6.5;		// in z direction, space between rod top and belt bottom;
						// = distance between upper side of rods and upper platform of x-carriage (with belt clamps)
belt_height = 2.6;		// belt thickness..

xmotor_y_offset = 50;
idler_y_offset = rod_dist/2+rod_dia/2+belt_rod_dist - 3;

// belt range = rod_dist/2+rod_dia/2+belt_rod_dist - nema17 shaft socket = 36.5 - 43 = 6.5mm

leadscrew_dia = 8;
leadscrew_nut_wrench_size = 13+0.2;		// plus some extra clearance
leadscrew_nut_height = 6.8;
anti_backlash_spring_space = 25;

nema17_width = 43;
nema17_hole_dist = 31;
nema17_center_dia = 25;
nema17_depth = 34;
nema17_crown = 11;

layer_height = 0.25;

xend_body_x_offset = 3;
motor_mount_x_offset = 28;

z_type = "flange"; //"nuttrap";

flange_small = 25 + clearance*2;
flange_big = 42 + clearance*2;
flange_small_h = 25;
flange_big_h = 10;

additional_x_for_flange = (z_type=="nuttrap") ?  0 : 25;

// Z-ENDS
holder_length = 15;
holder_thickness = 5;
holder_width = 30;
rod = rod_dia;
width = 70;
top_height = 90;
bottom_height = 90;
bottom_width = 70;
bottom_depth = 70;
bottom_z_offset = 10;
depth = 8;
bolt = 5 + clearance;
holder_bolt = 3 + clearance;
m3_diameter = 3.6;
m3_nut_diameter = 5.3;
m3_nut_diameter_horizontal = 6.1;
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;
nut_trap_depth = 2;
rounded = 3;
z_axis_y_offset = width - 45;
z_axis_x_offset = 27;
m5_bolt = 5 + clearance;
alu_x = 20;
z_bearing = 26;
z_bearing_h = 8;

// CALCULATIONS
xend_body_height = rod_dia+2*clearance+2*wall;
xend_body_width = rod_dist+rod_dia+2*wall;
leadscrew_nuttrap_height = 2*leadscrew_nut_height+wall+anti_backlash_spring_space;
bearing_support_height = leadscrew_nuttrap_height;
idler_elevation = xend_body_height/2+rod_dia/2+belt_elevation+belt_height+idler_dia/2;

//CARRIAGE
c_width=50;
c_depth_x = 25;
c_offset_x = 7;
c_slot_depth = 5;
c_center_x = 33;
c_center_x_offset = 3.5;
c_center_y = 50;
c_screw_offset = 15;
c_belt_screw_offset = 20;
//belt_width= 6 + clearance;
//belt_thickness = 0.6 - clearance;
c_fan_ext_width = 40;
c_fan_ext_len=c_slot_depth+3;
x_flag_height = xend_body_height+6;
x_flag_offset = -5;
x_flag_width = 25;

// y-idler
y_idler_y = 60;
y_idler_x = 10;

// RENDER
// "idler=false" for motor-x-end, "idler=true" for idler-x-end
//translate([-20,0,0]) 

*translate([-80,0,0]) 
	{
		assembly(idler=false);
		//translate([zrod_leadscrew_dist,7,xend_body_height+flange_big_h-2]) rotate([90,0,30]) flange();
		mirror([0,1,0]) z_top_end();
		mirror([0,1,0]) z_bottom_end();
	}

*translate([80,0,0]) 
rotate([0,0,180])
	{
		assembly(idler=true);
		//translate([zrod_leadscrew_dist,-7,xend_body_height+flange_big_h-2]) rotate([90,0,30]) flange();
		z_top_end();
		z_bottom_end();
	}

*translate([45,90,0]) rotate([0,90,90]) mirror([1,0,0]) z_bottom_end();
*translate([-45,90,0]) rotate([0,-90,-90]) z_bottom_end();

mirror([0,0,1]) 
//rotate([0,0,90]) 
//translate([0,0,lm10uu_dia])
x_carriage();

//translate([64,86,0]) 
//rotate([-90,0,0])
//	idler_bits();

*translate([0,-40,0]) y_motor_end();
*translate([0,40,0]) y_idler_end();
*translate([0,90,0]) y_idler_bit();

// -------------------------------------------------

module rod_mount(){
	difference(){
		// block for rods
		translate([additional_x_for_flange/2,(rod_dist/2+rod_dia/2+wall)/2,0])
		cube([xend_body_length+additional_x_for_flange,rod_dist/2+xend_body_height/2,xend_body_height],center=true);
	
		// round corners horizontal
		translate([xend_body_length/2+additional_x_for_flange,rod_dist/2+xend_body_height/2,xend_body_height/2])
			rotate([180,90,0])
				roundcorner(xend_body_height/2,xend_body_length+additional_x_for_flange);
		translate([xend_body_length/2+additional_x_for_flange,rod_dist/2+xend_body_height/2,-xend_body_height/2])
			rotate([0,0,180]) 
				roundcorner_tear(xend_body_height/2,xend_body_length+additional_x_for_flange);
	
		// rod hole
		translate([additional_x_for_flange,rod_dist/2,0]) teardropcentering(rod_dia/2+clearance,xend_body_length+additional_x_for_flange*2+2);
	
		// rod clamp
		translate([0,body_width/2+1,0])
		difference(){
			translate([0,(rod_dist/2+rod_dia/2+wall+1)/2,-(rod_dia/2+wall+1)/2])
				cube([xend_body_length-20,rod_dist/2+rod_dia/2+wall+1,rod_dia/2+wall+1],center=true);
			translate([0,(rod_dist/2+rod_dia/2+wall+1)/2,-(rod_dia/2+wall+1)/2-2])
				cube([xend_body_length-20-2,rod_dist/2+rod_dia/2+wall+1+2,rod_dia/2+wall+1],center=true);
		}
		translate([0,rod_dist/2,-0.1]) teardropcentering_half(rod_dia/2+clearance+1,xend_body_length-20-2-4,bottom=1);
		

		// clamp screw + nut trap + screw-head-trap
		translate([0,rod_dist/2-rod_dia/2-m3_screw_dia/2-2*clearance-1,0])
			polyhole(m3_screw_dia+2*clearance,xend_body_height+2);
		translate([0,rod_dist/2-rod_dia/2-m3_screw_dia/2-2*clearance-1,xend_body_height/2-m3_nut_height/2+0.5])
			nut_trap(m3_nut_wrench_size,m3_nut_height+1);
	}

	// screw hole print support
	translate([0,rod_dist/2-rod_dia/2-m3_screw_dia/2-2*clearance-1,layer_height/2+(xend_body_height/2-layer_height*round((xend_body_height/2)/layer_height))])
		polyhole(m3_screw_dia+2*clearance,layer_height);
}



module bearing_holder(idler){
	// linear bearing holder
	translate([-zrod_leadscrew_dist/2,zrod_leadscrew_offset / 2 * (idler ? 1 : -1),0])
		rotate([0,0,90])
			lm10uu_holder_slim_double_vertical(holder_height);
}

module bearing_holder_spacer(idler){
	render()
	union(){
		translate([-body_width/2-zrod_leadscrew_dist/2,zrod_leadscrew_offset / 2 * (idler ? 1 : -1),holder_height/2])
		cube([body_width,body_width+3,holder_height+2], center = true);
		
		difference()
		{
			translate([-zrod_leadscrew_dist/2,zrod_leadscrew_offset / 2 * (idler ? 1 : -1),-0.5])
			cylinder(r=body_width/2+1.5, h=xend_body_height+1);
	
			translate([-1+3*body_width/4-zrod_leadscrew_dist/2,zrod_leadscrew_offset / 2 * (idler ? 1 : -1),-0.5])
			cube([body_width,body_width+3,xend_body_height+1], center = true);
		}
		translate([-zrod_leadscrew_dist/2,zrod_leadscrew_offset / 2 * (idler ? 1 : -1),-0.5])
			cylinder(r=lm10uu_dia/2, h=holder_height+1);
	}
}

module leadscrew_nuttrap(){
	translate([zrod_leadscrew_dist/2,0,0])
		rotate([0,0,30]){
			translate([0,0,leadscrew_nuttrap_height/2])
				difference(){
					nut_trap(leadscrew_nut_wrench_size+2*wall,leadscrew_nuttrap_height);
					nut_trap(leadscrew_nut_wrench_size,leadscrew_nuttrap_height+2);
				}
			translate([0,0,wall/2+leadscrew_nut_height])
				difference(){
					nut_trap(leadscrew_nut_wrench_size+2*wall,wall);
					rotate([0,0,-30]) cube([leadscrew_dia+1,leadscrew_nut_wrench_size*2,wall+2],center=true);
				}
		}

}

module leadscrew_nuttrap_spacer(){
	translate([zrod_leadscrew_dist/2,0,leadscrew_nuttrap_height/2])
	rotate([0,0,30])
		nut_trap(leadscrew_nut_wrench_size+2*wall,leadscrew_nuttrap_height+2);
}


module leadscrew_flange_hole(){
	color([0,1,1]) 
	rotate([90,0,0])
	{
		translate([zrod_leadscrew_dist,xend_body_height/2,0]) rotate([90,0,0])
		cylinder(r = flange_small/2, h = xend_body_height+2, $fn = 100,center=true);	

		translate([zrod_leadscrew_dist,xend_body_height,0]) rotate([90,0,0])
		cylinder(r = flange_big/2+0.25, h = 2, $fn = 100,center=true);	

		translate([zrod_leadscrew_dist,xend_body_height/2,0])
		{
		for ( i = [0 : 5] )
		{
		    rotate([90, 30 + i * 360 / 6, 0])
		    translate([0, 34/2, -0.5])
		    cylinder(r = 2.5, h=xend_body_height+2,$fn=80,center=true);
		}
		}		
	}
}

nema17_hole1 = [nema17_hole_dist/2,nema17_hole_dist/2];
nema17_hole2 = [nema17_hole_dist/2,-nema17_hole_dist/2];
nema17_hole3 = [-nema17_hole_dist/2,nema17_hole_dist/2];
nema17_hole4 = [-nema17_hole_dist/2,-nema17_hole_dist/2];

module motor_mount(){
	translate([-15.5+motor_mount_x_offset, xmotor_y_offset, 31.75]) rotate([90, 0, 0]) 
	difference() {
		cylinder(r=29, h=10);
		cylinder(r=16, h=50, center=true);
		rotate([0, 0, 0]) translate([-17, 0, -50]) cube([36, 60, 80]);
		rotate([0, 0, 00]) translate([-18, -50, -50]) cube([36, 100, 80]);
	}
	
	translate([-motor_mount_x_offset/2+wall+1.5,idler_y_offset-wall+2,xend_body_height-wall])
	difference()
	{
		rotate([-45,0,0])
		cube([wall*2,idler_width+wall*4,idler_width+wall*4],center=true);
		translate([-wall+3,0,-24]) cube([wall*2+2,50,50],center=true);
		translate([-wall+3,25,10]) cube([wall*2+2,50,100],center=true);
	}

	difference(){
		union(){
			translate([-nema17_hole_dist/2+motor_mount_x_offset,xmotor_y_offset,
						nema17_hole_dist/2+xend_body_height+m3_screw_dia/2+clearance])
				difference(){
					union(){
						rotate([90,0,0])
							linear_extrude(height=10)
							{
								barbell(nema17_hole2,nema17_hole1,
										(nema17_width-nema17_hole_dist)/2,(nema17_width-nema17_hole_dist)/2,
										20,60);
								barbell(nema17_hole1,nema17_hole3,
										(nema17_width-nema17_hole_dist)/2,(nema17_width-nema17_hole_dist)/2,
										20,60);
								barbell(nema17_hole3,nema17_hole4,
										(nema17_width-nema17_hole_dist)/2,(nema17_width-nema17_hole_dist)/2,
										20,60);
								barbell(nema17_hole4,nema17_hole2,
										(nema17_width-nema17_hole_dist)/2,(nema17_width-nema17_hole_dist)/2,
										20,60);
							}
		
						// nema17 mount bottom support
						translate([0,-10-(xmotor_y_offset-10-rod_dist/2)/2,
									-xend_body_height/2-nema17_hole_dist/2-m3_screw_dia/2-clearance])
							cube([nema17_width,xmotor_y_offset-10-rod_dist/2,xend_body_height],center=true);
						translate([0,-5,-(xend_body_height+m3_screw_dia/2+clearance)/2-nema17_hole_dist/2])
							difference(){
								cube([nema17_width,10,(xend_body_height+m3_screw_dia/2+clearance)],center=true);

								// round corner bottom x direction
								translate([nema17_width/2,5,-(xend_body_height+m3_screw_dia/2+clearance)/2])
									rotate([0,0,180]) 
										roundcorner_tear(xend_body_height/2,nema17_width);
							}
					}
		
					// nema17 screw holes
					for(k=[1,-1]) for(l=[1,-1])
						translate([k*nema17_hole_dist/2,-5,l*nema17_hole_dist/2])
							rotate([0,0,90]) teardrop(m3_screw_dia/2+clearance,12);
		
					// xend body cut off 1
					translate([0,-(xmotor_y_offset-rod_dist/2)-0.1,-(xend_body_height/2+m3_screw_dia/2+clearance)-nema17_hole_dist/2])
						rotate([180,0,0])
							teardropcentering(xend_body_height/2,nema17_width+2);

				}
		
			// nema17 mount top support
/*			translate([0,0,nema17_hole_dist+(m3_screw_head_dia+2*clearance)/2+xend_body_height+m3_screw_dia/2+clearance])
				linear_extrude(height=5)
					polygon(points=[[-xend_body_length/2+xend_body_x_offset,body_width/2+1.5],[-xend_body_length/2+xend_body_x_offset+10,body_width/2+1.5],
										[-nema17_hole_dist+motor_mount_x_offset+5,xmotor_y_offset],
										[-nema17_hole_dist+motor_mount_x_offset-5,xmotor_y_offset]]);

*/			translate([-nema17_hole_dist+motor_mount_x_offset,-5+xmotor_y_offset,nema17_hole_dist+xend_body_height+m3_screw_dia/2+clearance+(5+m3_screw_head_dia/2+clearance)/2])
				cube([10,10,5+m3_screw_head_dia/2+clearance-20],center=true);

		}

		// xend body cut off 2
		translate([-xend_body_length+xend_body_x_offset,rod_dist/2-0.1,xend_body_height])
			cube([xend_body_length,xend_body_height,xend_body_height],center=true);

		// rod clamp freedom
		translate([xend_body_x_offset,0,0])
		difference(){
			cube([xend_body_length-20,xend_body_width+2,xend_body_height],center=true);
			cube([xend_body_length-20-2,xend_body_width,xend_body_height-4],center=true);
		}

		// belt freedom
//		translate([(nema17_width-nema17_hole_dist)/2+motor_mount_x_offset,xmotor_y_offset,
//					nema17_hole_dist/2+xend_body_height+m3_screw_dia/2+clearance])
//			cube([nema17_width,50,22],center=true);
	}
}


module idler_mount(){

	translate([xend_body_x_offset*2,0,0])
	mirror([1,0,0])
	difference(){
		union(){
			translate([xend_body_length/2+xend_body_x_offset-wall,-idler_y_offset+wall+2,xend_body_height-wall])
			difference()
			{
				rotate([-42,0,0]) cube([wall*2,idler_width+wall*4,idler_width+wall*4],center=true);
				translate([-wall+3,0,-25]) cube([wall*2+2,50,50],center=true);
				translate([-wall+3,-26,0]) cube([wall*2+2,50,100],center=true);
			}

			translate([0,-idler_y_offset+2.5,0])
				rotate([90,0,0]){
//???					translate([xend_body_x_offset,idler_elevation,0])
//???						cylinder(r=idler_width/2, h=5,center=true);
					translate([0,idler_elevation-xend_body_length/2,0.5])
						linear_extrude(height=6,center=true) polygon(points=[[-xend_body_length/2+xend_body_x_offset,xend_body_length],
															[-xend_body_length/2+xend_body_x_offset,0],
															[xend_body_length/2+xend_body_x_offset,0],
															[xend_body_length/2+xend_body_x_offset,xend_body_length]]);
				}

/*			// idler mount support top
			difference(){
				translate([xend_body_length/2+xend_body_x_offset-(idler_width/2/sin(45))/2+1.25,-idler_y_offset/2,xend_body_height/2+xend_body_length+wall+3.1])
					cube([idler_width/2/sin(45)-2.5,idler_y_offset,wall*2],center=true);
				translate([xend_body_x_offset*2,0,0])
					mirror([1,0,0]){
						translate([-(body_width+1)/2-zrod_leadscrew_dist/2,0,holder_height/2])
							cube([body_width+1,body_width+3,holder_height+2], center = true);
						translate([-zrod_leadscrew_dist/2,0,-1])
							cylinder(r=body_width/2+1.5, h=holder_height+2);
					}
			}
*/

			// idler mount support bottom
			translate([-xend_body_length/2+xend_body_x_offset,-idler_y_offset,0])
				cube([xend_body_length,5,idler_elevation-xend_body_length/2+idler_width/2/sin(45)]);

		}

		// rod clamp freedom
		translate([xend_body_x_offset,0,0])
		difference(){
			cube([xend_body_length-20,xend_body_width+2,xend_body_height],center=true);
			cube([xend_body_length-20-2,xend_body_width,xend_body_height-4],center=true);
		}

		// xend body cut off
		translate([xend_body_x_offset,-rod_dist/2+0.1,xend_body_height/2])
			rotate([180,0,0])
				teardropcentering(xend_body_height/2,xend_body_length+2);

		// round corner bottom x direction
		translate([-xend_body_length/2+xend_body_x_offset,-idler_y_offset,0])
			roundcorner_tear(xend_body_height/2,xend_body_length);


		// idler bolt hole
		translate([xend_body_x_offset-idler_spacing,-idler_y_offset+2.5,idler_elevation-idler_spacing])
		rotate([0,0,90])
			hull(){
			translate([0,-idler_hole_width/2,0]) teardrop(m3_screw_dia/2+clearance,8+zrod_leadscrew_offset);
			translate([0,+idler_hole_width/2,0]) teardrop(m3_screw_dia/2+clearance,8+zrod_leadscrew_offset);
			}

		// idler bolt hole
		translate([xend_body_x_offset+idler_spacing,-idler_y_offset+2.5,idler_elevation+idler_spacing])
		rotate([0,0,90])
			hull(){
			translate([0,-idler_hole_width/2,0]) teardrop(m3_screw_dia/2+clearance,8);
			translate([0,+idler_hole_width/2,0]) teardrop(m3_screw_dia/2+clearance,8);
			}

		// idler big hole
		translate([xend_body_x_offset,-idler_y_offset+2.5,idler_elevation])
		rotate([0,0,90])
			teardrop(idler_hole/2+clearance,8+zrod_leadscrew_offset);


	}

/*	translate([0,zrod_leadscrew_offset/2,0])
	mirror([0,1,0])
	difference(){
		union(){
			translate ([-body_width/2-zrod_leadscrew_dist/2,0,(xend_body_length/2+idler_elevation)/2])
				cube([body_width,body_width+3+2*wall,xend_body_length/2+idler_elevation], center=true);
			translate([-zrod_leadscrew_dist/2,0,0])
				cylinder(r=body_width/2+1.5+wall, h=xend_body_length/2+idler_elevation);
		}
		translate([-(body_width+1)/2-zrod_leadscrew_dist/2,0,holder_height/2])
			cube([body_width+1,body_width+3,holder_height+2], center = true);
		translate([-zrod_leadscrew_dist/2,0,-1])
			cylinder(r=body_width/2+1.5, h=holder_height+2);
		translate([-body_width-xend_body_length/2+xend_body_x_offset,0,holder_height/2])
			cube([2*body_width,body_width+3+2*wall+2,holder_height+2], center = true);
		translate([xend_body_x_offset,-xend_body_width/4-wall/2,holder_height/2])
			cube([xend_body_length+2,xend_body_width/2,holder_height+2], center = true);
	}*/

//	translate([-zrod_leadscrew_dist/2,-xend_body_width/4+wall,idler_y_offset+1])
//		cube([wall*2+3,xend_body_width/4,xend_body_length/4-6+idler_elevation], center = true);
}



module assembly(idler=false){

	difference()
	{
		union(){
			translate([xend_body_x_offset,0,xend_body_height/2])
			for(i=[0,1]) mirror([0,i,0]) rod_mount();
		
			if(idler==false)
			{
				motor_mount();
			}
			else
			{
				idler_mount();
			}
				// bearing holder support
			translate([(body_width/2+3+wall/2)/2-zrod_leadscrew_dist/2,(idler?1:-1) * zrod_leadscrew_offset/2,3*holder_height/4])
				cube([body_width/2+wall,wall*2+zrod_leadscrew_offset/2,holder_height-xend_body_height],center=true);
		}
		bearing_holder_spacer(idler);
		translate([0,(zrod_leadscrew_offset / 2 + z_leadscrew_margin) * (idler ? -1 : 1),0])
		if (z_type == "nuttrap") leadscrew_nuttrap_spacer();
		else leadscrew_flange_hole();

		if(idler==false){

			// nema17 screw head/ screw driver clearance
			translate([additional_x_for_flange-motor_mount_x_offset+nema17_hole_dist/2,xmotor_y_offset-m3_screw_head_height*2.5-wall*2,nema17_hole_dist/2+m3_screw_dia/2+clearance+xend_body_height]){
				translate([nema17_hole_dist/2,0,-nema17_hole_dist/2])
					rotate([0,0,90]) teardrop(m3_screw_head_dia/2+clearance+0.5,m3_screw_head_height*3);	
				translate([nema17_hole_dist/2,0,nema17_hole_dist/2])
					rotate([0,0,90]) teardrop(m3_screw_head_dia/2+clearance+0.5,m3_screw_head_height*3);	
				translate([-nema17_hole_dist/2,0,nema17_hole_dist/2]){
					rotate([0,0,90]) teardrop(m3_screw_head_dia/2+clearance+0.5,m3_screw_head_height*3);
				translate([0,-m3_screw_head_height*2,-nema17_hole_dist])
					rotate([0,0,90]) teardrop(m3_screw_head_dia/2+clearance+0.5,m3_screw_head_height*8);
				}
			}
		}
	}
	bearing_holder(idler);
	if (z_type == "nuttrap") 	leadscrew_nuttrap();
}

module flange()
{
translate([0,0,0])
rotate([90,0,0])
color([0,0,0])
{
	difference()
	{
		union()
		{
			cylinder(h=flange_small_h,r=flange_small/2,$fn=80);
			cylinder(h=flange_big_h,r=flange_big/2,$fn=80);
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

module z_bottom_end()
{
	color([0.7,0.7,0.7]) 
	translate([-zrod_leadscrew_dist/2,zrod_leadscrew_offset/2,-100])
	union()
	{

		difference()
		{
			union()
			{
				translate([-width/2 + z_axis_y_offset -depth + alu_x/2, -bottom_width/2 + z_axis_x_offset - depth / 4, bottom_z_offset]) 
				rotate([0, 90, 0]) 
				plate(bottom_height,bottom_width); //,4,false,true);

				translate([-width/2 + z_axis_y_offset -depth + alu_x/2, -bottom_width+alu_x/2 + z_axis_x_offset - depth / 4, bottom_z_offset+bottom_height/2]) 
				rotate([0, 90, 0]) 
				plate(alu_x*2,alu_x); //,4,false,true);
	
				translate([z_axis_x_offset, -bottom_width/2 + z_axis_x_offset - depth / 4, 0]) 
				plate(bottom_depth,bottom_width,0);

	
				//translate([zrod_leadscrew_dist+body_width/2 - nema17_width/2 - depth/2,-zrod_leadscrew_offset - z_leadscrew_margin - nema17_width/2 - depth/2, -depth]) cube([nema17_width + depth, nema17_width + depth, depth+1]);
			}
		
			translate([0,0,-bottom_height/2-1+bottom_z_offset])
			rotate([0,0,90])
			cylinder(bottom_height+2,r=rod/2+clearance,$fn=100,true);
	
			translate([zrod_leadscrew_dist+body_width/2 - nema17_width/2,-zrod_leadscrew_offset - z_leadscrew_margin - nema17_width/2, 0])
			rotate([-90, 0,0])
			NemaForCSG(nema17_width, nema17_depth, nema17_hole_dist, nema17_crown, m3_screw_dia/2, true);
	
			rod_bolt_holes(-10);
			rod_bolt_holes(25);
	
		}

		z_bottom_support(0);
		z_bottom_support(-bottom_width +4);

		translate([0,0,depth]) mirror([0,0,1]) z_bottom_support(0);
		translate([0,0,depth]) mirror([0,0,1]) z_bottom_support(-bottom_width +4);
	}

		//translate([-zrod_leadscrew_dist/2,zrod_leadscrew_offset/2,-100]) 	translate([zrod_leadscrew_dist+body_width/2 - nema17_width/2,-zrod_leadscrew_offset - z_leadscrew_margin - nema17_width/2, 0]) rotate([-90, 0,0])	NemaForCSG(nema17_width, nema17_depth, nema17_hole_dist, nema17_crown, m3_screw_dia/2, true);
	//color([0,0,0]) translate([-zrod_leadscrew_dist/2,zrod_leadscrew_offset/2,-100]) rotate([0,0,90]) translate([-width/2,5,-bottom_height/2-1]) cube([width,3,height+2]);
}

module z_bottom_support(y_offset)
{
		translate([0,y_offset,0])
		difference()
		{
			translate([-8, z_axis_x_offset-depth+2, depth+1])
			rotate([0,asin((bottom_height/2-depth*1.5) / bottom_height),0]) cube([65,4,20]);

			translate([-bottom_height/2+z_axis_x_offset, -bottom_width + z_axis_x_offset - depth / 4, -depth*4]) 
			cube([bottom_height+2,bottom_width+2,depth*4]);
		}
}

module rod_bolt_holes(z_offset)
{
		translate([-depth-1,holder_width/2-rod/2, z_offset])
		rotate([0,90,0])
		{
			//cylinder(r=m3_nut_diameter_bigger/2, h=nut_trap_depth+1, $fn=6);
			//translate([0, 0, nut_trap_depth])  
			cylinder(r=m3_screw_dia/2, h=depth+2, $fn=100);
		}

		translate([-depth-1,-holder_width/2+rod/2, z_offset])
		rotate([0,90,0])
		{
			//cylinder(r=m3_nut_diameter_bigger/2, h=nut_trap_depth+1, $fn=6);
			//translate([0, 0, nut_trap_depth])  
			cylinder(r=m3_screw_dia/2, h=depth+2, $fn=100);
		}
}

module z_top_end()
{
	color([0.5,0.5,0.5]) 
	translate([-zrod_leadscrew_dist/2,zrod_leadscrew_offset/2,100])
	difference()
	{
		union()
		{
			rotate([0,0,90])
			{
				rotate([0,0,90])
				{
					 rod_holder();
	
					difference()
					{
						cylinder(depth+holder_length,r=rod/2+3,$fn=100,true);
						translate([-width/2,-rod/2-3,0]) cube([width,rod/2+3,50]);
					}
				}

				translate([-width/2 + z_axis_y_offset, -top_height/2 + z_axis_x_offset, 0]) plate(width, top_height,3, true);

				translate([-width/2 + z_axis_y_offset-alu_x, -top_height/2 + z_axis_x_offset + alu_x*1.75, 0]) plate(width + alu_x*2, alu_x, 1);
			}

			translate([zrod_leadscrew_dist+body_width/2,-zrod_leadscrew_offset - z_leadscrew_margin, z_bearing_h/2])
				cylinder(z_bearing_h,r=z_bearing/2 + wall/2,$fn=100,true);
		}

		union()
		{
			translate([0,0,-50]) cylinder(depth+holder_length+150,r=rod/2+clearance,$fn=100,true);

			translate([zrod_leadscrew_dist+body_width/2,-zrod_leadscrew_offset - z_leadscrew_margin, +z_bearing_h/2])
				cylinder(z_bearing_h+1,r=z_bearing/2,$fn=100,true);

			translate([zrod_leadscrew_dist+body_width/2,-zrod_leadscrew_offset - z_leadscrew_margin, -50])
				cylinder(depth+holder_length+150,r=rod/2 + 2*clearance,$fn=100,true);		
		}

		translate([-width/2 + z_axis_y_offset + alu_x, -top_height/2 + alu_x/2, -1]) cylinder(depth+2,d=bolt, $fn=100,true);
	}
}

//cube([zrod_leadscrew_dist+body_width/2,zrod_leadscrew_offset + z_leadscrew_margin, 10],center=true);

module rod_holder()
{
	difference()
	{
		translate([-holder_width/2, 0, depth]) cube([holder_width,holder_thickness,holder_length]);
		
		translate([holder_width/2-rod/2,holder_thickness/2,depth+holder_length/2])
		rotate([90,0,0])
		cylinder(holder_thickness+10, r=holder_bolt/2,$fn=100,center=true);

		translate([-holder_width/2+rod/2,holder_thickness/2,depth+holder_length/2])
		rotate([90,0,0])
		cylinder(holder_thickness+10, r=holder_bolt/2,$fn=100,center=true);

		translate([holder_width/2-rod/2,holder_thickness+1,depth+holder_length/2])
		rotate([90,0,0])
		cylinder(r=m3_nut_diameter_bigger/2, h=nut_trap_depth+1, $fn=6);

		translate([-holder_width/2+rod/2,holder_thickness+1,depth+holder_length/2])
		rotate([90,0,0])
		cylinder(r=m3_nut_diameter_bigger/2, h=nut_trap_depth+1, $fn=6);
	}
}

module plate(p_width, p_height, holes = 4, cut = false, with_caps = false)
{
	difference()
	{
		hull()
		{
			translate([p_width/2-rounded/2,p_height/2-rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
			if (cut)
			{
				translate([0-rounded/2,-p_height/2+rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
				translate([p_width/2-rounded/2,0/2+20+rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
			}
			else
			{
				translate([p_width/2-rounded/2,-p_height/2+rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
			}
			translate([-p_width/2+rounded/2,p_height/2-rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
			translate([-p_width/2+rounded/2,-p_height/2+rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
		}

		if (holes > 0) translate([-p_width/2 + alu_x/2, p_height/2 - alu_x/2, -1]) cylinder(depth+2,d=bolt, $fn=100,true);
		if (holes > 1) translate([+p_width/2 - alu_x/2, p_height/2 - alu_x/2, -1]) cylinder(depth+2,d=bolt, $fn=100,true);
		if (holes > 2) translate([-p_width/2 + alu_x/2, -p_height/2 + alu_x/2, -1]) cylinder(depth+2,d=bolt, $fn=100,true);
		if (holes > 3) translate([+p_width/2 - alu_x/2, -p_height/2 + alu_x/2, -1]) cylinder(depth+2,d=bolt, $fn=100,true);
	}

//		translate([-p_width/2 + alu_x/2, p_height/2 - alu_x/2, 0]) cube([20,20,20], center=true);
	if (with_caps)
	{
		color([1,0,0])
		{
		translate([-p_width/2 + alu_x/2, p_height/2 - alu_x/2, 5]) cylinder(depth,d=11, $fn=100,true);
		translate([+p_width/2 - alu_x/2, p_height/2 - alu_x/2, 5]) cylinder(depth,d=11, $fn=100,true);
		translate([-p_width/2 + alu_x/2, -p_height/2 + alu_x/2, 5]) cylinder(depth,d=11, $fn=100,true);
		translate([+p_width/2 - alu_x/2, -p_height/2 + alu_x/2, 5]) cylinder(depth,d=11, $fn=100,true);
		}
	}
}

module NemaForCSG(nema_side, nema_depth, nema_bolts, nema_crown, nema_bolt_radious, bevel_inner_corners = false)
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

		if (bevel_inner_corners == true)
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

module x_carriage()
{
	difference()
	{
		union()
		{
			*translate([rod_dist/2,-c_holder_height/2,-lm10uu_dia/2])
			rotate([-90,0,0]) lm10uu_holder_slim_double_vertical(c_holder_height);
		
			*translate([-rod_dist/2,-c_holder_height/2-c_width/2,-lm10uu_dia/2])
			rotate([-90,0,0]) lm10uu_holder_slim_double_vertical(c_holder_height);

			*translate([-rod_dist/2,-c_holder_height/2+c_width/2,-lm10uu_dia/2])
			rotate([-90,0,0]) lm10uu_holder_slim_double_vertical(c_holder_height);

			*translate([-c_depth_x/4,0,0])
			cube([rod_dist+lm10uu_dia+c_depth_x/2,c_width+c_holder_height,0],true);

			translate([-c_offset_x,0,-depth/2-2])
			plate(rod_dist+lm10uu_dia+c_depth_x,c_width+c_holder_height, 0);

			translate([0,-c_width+7.75,-depth/2-2])
			plate(c_fan_ext_width,c_fan_ext_len, 0);
			
			translate([x_flag_offset,c_width-13-0.5,-depth/2-x_flag_height/2])
			cube([x_flag_width,6,x_flag_height], center=true);
		}

		holder_hole(rod_dist/2-lm10uu_dia/2-0.75,c_holder_height/2-8);
		holder_hole(rod_dist/2-lm10uu_dia/2-0.75,-c_holder_height/2+5);
		holder_hole(rod_dist/2+lm10uu_dia/2-0.75,c_holder_height/2-8);
		holder_hole(rod_dist/2+lm10uu_dia/2-0.75,-c_holder_height/2+5);

		holder_hole(-rod_dist/2-lm10uu_dia/2-0.75,c_width/2+c_holder_height/2-8);
		holder_hole(-rod_dist/2-lm10uu_dia/2-0.75,c_width/2+-c_holder_height/2+5);
		holder_hole(-rod_dist/2+lm10uu_dia/2-0.75,c_width/2+c_holder_height/2-8);
		holder_hole(-rod_dist/2+lm10uu_dia/2-0.75,c_width/2+-c_holder_height/2+5);

		holder_hole(-rod_dist/2-lm10uu_dia/2-0.75,-c_width/2+c_holder_height/2-8);
		holder_hole(-rod_dist/2-lm10uu_dia/2-0.75,-c_width/2+-c_holder_height/2+5);
		holder_hole(-rod_dist/2+lm10uu_dia/2-0.75,-c_width/2+c_holder_height/2-8);
		holder_hole(-rod_dist/2+lm10uu_dia/2-0.75,-c_width/2+-c_holder_height/2+5);

		translate([c_center_x_offset,0,-2])
		cube([c_center_x,c_center_y,depth+1],true);

		translate([-c_center_x/2+c_center_x_offset+m3_screw_dia/4+0.25,0,0])
		{
			c_slot(1, c_slot_depth, m3_screw_dia/2);
			c_slot(0, c_slot_depth+1, 5/2);
			c_slot(-1, c_slot_depth, m3_screw_dia/2);
		}

		translate([-c_offset_x-(rod_dist+lm10uu_dia+c_depth_x)/2-m3_screw_dia/4-0.25,22,0])
		mirror([1,0,0])
		{
			c_slot(1, c_slot_depth, m3_screw_dia/2);
			c_slot(0, c_slot_depth+1, 5/2);
			c_slot(-1, c_slot_depth, m3_screw_dia/2);
		}

		translate([-c_offset_x-(rod_dist+lm10uu_dia+c_depth_x)/2-m3_screw_dia/4-0.25,-22,0])
		mirror([1,0,0])
		{
			c_slot(1, c_slot_depth, m3_screw_dia/2);
			c_slot(0, c_slot_depth+1, 5/2);
			c_slot(-1, c_slot_depth, m3_screw_dia/2);
		}

		translate([0, -c_width-c_fan_ext_len/2+6.9, 0])
		rotate([0,0,-90])
		{
			c_slot(1, c_slot_depth, m3_screw_dia/2);
			c_slot(0, c_slot_depth+1, 5/2);
			c_slot(-1, c_slot_depth, m3_screw_dia/2);
		}

		translate([+rod_dist/2,-c_holder_height/2-c_width/2-1,-lm10uu_dia/2])
		rotate([-90,0,0]) cylinder(r=lm10uu_dia/2, h=c_width+c_holder_height+2);

		translate([-rod_dist/2,-c_holder_height/2-c_width/2-1,-lm10uu_dia/2])
		rotate([-90,0,0]) cylinder(r=lm10uu_dia/2, h=c_width+c_holder_height+2);

		//belt slot
		//translate([-rod_dist/2,0,wall-belt_thickness/2+0.1])
		//cube([belt_width,rod_dist+lm10uu_dia+c_depth_x/2,belt_thickness+0.1],true);

		//belt screws
		belt_screw(1, 0);
		*belt_screw(1, c_belt_screw_offset);
		belt_screw(-1, 0);
		*belt_screw(-1, c_belt_screw_offset);
		
		mirror([0,1,0])
		{
			belt_screw(1, 0);
			*belt_screw(1, c_belt_screw_offset);
			belt_screw(-1, 0);
			*belt_screw(-1, c_belt_screw_offset);
		}
	}

	*color([1,0,0]) translate([0,0,-depth/2-25/2-2]) cube([35,2,2], center=true);
	*color([1,0,0]) translate([4.5,0,-depth/2-25/2-2]) cube([25,4,2], center=true);
	*color([1,0,0]) translate([0,0,-depth/2-25/2-2]) cube([2,40,2], center=true);
	*color([1,0,0]) translate([0,0,-depth/2-25/2-2]) cube([4,25,2], center=true);
}

module c_slot(dir, slot_depth, slot_r)
{
	translate([-slot_depth,dir*c_screw_offset/2,-depth])
	union()
	{
		cylinder(r=slot_r, h=depth*2+1, $fn=100);
		translate([slot_depth/2-0.25,0,depth]) cube([slot_depth-m3_screw_dia/2+0.5,slot_r*2,depth*2+1],true);
	}
}

module belt_screw(dir, offset)
{
	translate([-rod_dist/2+dir*(lm10uu_dia/2+5),c_width/2,-depth-0.5+nut_trap_depth])
	{
		cylinder(r=m3_screw_dia/2, h=depth*2+1, $fn=100);
		cylinder(r=m3_nut_diameter_bigger/2, h=nut_trap_depth+1, $fn=6);	
	}
}

module holder_hole(x_offset, y_offset)
{
	translate([x_offset,y_offset,-depth+1])
	cube([1.5, 3.5, depth+1]);
}

module idler_bits(to_print = true)
{
	//back
	translate([to_print ? 0 : xend_body_x_offset,to_print? -2.5-0.5: -idler_y_offset, 0])
	difference(){
		union(){
			translate([0,+2.5,0])
			rotate([90,0,0])
			union(){
//				translate([xend_body_x_offset,idler_elevation,0])
//				cylinder(r=idler_width/2, h=5,center=true);
	
				translate([-idler_spacing-wall-m3_screw_dia/2,idler_elevation-idler_spacing-wall-m3_screw_dia/2,-0.5])
//				cube([xend_body_length,xend_body_length,4]);	
				linear_extrude(height=4) polygon(points=[
					[0,0],
					[0,wall*2+m3_screw_dia],
					[wall*2+m3_screw_dia-idler_hole_width,wall*2+m3_screw_dia],
					[idler_spacing*2-idler_hole_width,idler_spacing*2+wall*2+m3_screw_dia],
					[idler_spacing*2+wall*2+m3_screw_dia,idler_spacing*2+wall*2+m3_screw_dia],
					[idler_spacing*2+wall*2+m3_screw_dia,idler_spacing*2],
					[idler_spacing*2+idler_hole_width,idler_spacing*2],
					[wall*2+m3_screw_dia+idler_hole_width,0]]);
	

				translate([0,idler_elevation,6+0.5])
				rotate([0,90,90])
				teardrop(idler_hole/2-idler_hole_width/2-m3_screw_dia-1+clearance,6);
			}
		}

	// idler bolt hole
	translate([-idler_spacing,+2.5,idler_elevation-idler_spacing])
	rotate([0,0,90])
	teardrop(m3_screw_dia/2+clearance,8);

	// idler bolt hole
	translate([+idler_spacing,+2.5,idler_elevation+idler_spacing])
	rotate([0,0,90])
	teardrop(m3_screw_dia/2+clearance,8);

	translate([0,-2,idler_elevation])
	rotate([0,0,90])
	teardrop(m3_screw_dia/2+clearance,12+0.5);

	}
	

	//front
	translate([to_print ? xend_body_length + 10 : xend_body_x_offset,to_print? -6 : -idler_y_offset+idler_cover_offset/2-6-wall-idler_cover_offset,0])
	rotate([0,0,to_print ? 180 : 0])
	difference(){
		union(){
//			translate([-xend_body_length/2+xend_body_x_offset,wall-idler_y_offset+2,idler_elevation-xend_body_length/2])
			translate([-idler_spacing-wall-m3_screw_dia/2,-2,idler_elevation-idler_spacing-wall-m3_screw_dia/2])
			rotate([90,0,0])
				//cube([xend_body_length,xend_body_length,wall*2]);	
				linear_extrude(height=4) polygon(points=[
					[0,0],
					[0,wall*2+m3_screw_dia],
					[wall*2+m3_screw_dia-idler_hole_width,wall*2+m3_screw_dia],
//					[idler_spacing*2-idler_hole_width,idler_spacing*2+wall*2+m3_screw_dia],
//					[idler_spacing*2+wall*2+m3_screw_dia,idler_spacing*2+wall*2+m3_screw_dia],
//					[idler_spacing*2+wall*2+m3_screw_dia,idler_spacing*2],
					[idler_spacing+idler_hole_width/2,idler_spacing*2-idler_hole_width],	//****
//					[idler_spacing*2+idler_hole_width,idler_spacing*2],
					[idler_spacing+wall*2+m3_screw_dia+idler_hole_width,idler_spacing*2-idler_hole_width],	//****
					[wall*2+m3_screw_dia+idler_hole_width,0]]);

			translate([-idler_spacing,2,idler_elevation-idler_spacing])
			cube([wall*2+m3_screw_dia,wall*2+m3_screw_dia,idler_cover_offset],true);

			//translate([+idler_spacing,2,idler_elevation+idler_spacing])
			//cube([wall*2+m3_screw_dia,wall*2+m3_screw_dia,idler_cover_offset],true);
		}


	// idler bolt hole
	translate([-idler_spacing,0,idler_elevation-idler_spacing])
	rotate([0,0,90])
	teardrop(m3_screw_dia/2+clearance,9+idler_cover_offset);

	// idler bolt hole
	//translate([+idler_spacing,0,idler_elevation+idler_spacing])
	//rotate([0,0,90])
	//teardrop(m3_screw_dia/2+clearance,9+idler_cover_offset);

	translate([0,-idler_cover_offset/2,idler_elevation])
	rotate([0,0,90])
	teardrop(m3_screw_dia/2+clearance,6);

	}
}

module y_motor_end()
{
	color([0.7,0.7,0.7]) 
	union()
	{

		difference()
		{
			union()
			{
				rotate([0, 90, 0]) 
				plate(bottom_height,bottom_width); //,4,false,true);
	
				translate([depth+(nema17_width+2*wall)/2-rounded, 2*depth , 0]) 
				rotate([90, 0, 0]) 
				plate(nema17_width+2*wall,nema17_width+2*wall,0);

				//translate([zrod_leadscrew_dist+body_width/2 - nema17_width/2 - depth/2,-zrod_leadscrew_offset - z_leadscrew_margin - nema17_width/2 - depth/2, -depth]) cube([nema17_width + depth, nema17_width + depth, depth+1]);
			}
			
			translate([nema17_width/4 - wall + clearance*2, depth*2 , -nema17_width/2]) 
			rotate([0, 0,0])
			NemaForCSG(nema17_width, nema17_depth, nema17_hole_dist, nema17_crown, m3_screw_dia/2, true);
	
		}

		rotate([90, 0, 0]) 
		{
			y_motor_support(nema17_width/2+wall - 4);
			y_motor_support(-nema17_width/2-wall);
		}
	}
}

module y_motor_support(y_offset)
{
	translate([0,y_offset,-depth*2])
	difference()
	{
		translate([0, 0, depth])
		rotate([0,asin((nema17_width+2*wall-depth*1.7) / bottom_height),0]) cube([48,4,20]);

		translate([-bottom_height/2+z_axis_x_offset, -1, -depth*4]) 
		cube([70,6,depth*4]);
	}
}

module y_idler_end()
{
	union()
	{

		difference()
		{
			rotate([0, 90, 0]) 
			plate(bottom_height,bottom_width);

			rotate([0, 90, 0])
			translate([0,0,-1])
			scale([1,1,1.5]) plate(y_idler_y, y_idler_x,0);

			translate([wall*2,0,y_idler_y/2+2*wall])
			rotate([0,90,0])
			cylinder(r=m3_screw_dia/2, h=wall*4+2,$fn=50, center=true);
		}

		translate([depth+wall*3,-y_idler_x/2-wall*2,-y_idler_y/2+wall*2])
		y_idler_support(true);

		translate([depth+wall*3,+y_idler_x/2+wall*4,-y_idler_y/2+wall*2])
		y_idler_support();
	}
}

module y_idler_bit()
{
	translate([0,0,wall*2])
	difference()
	{
		union()
		{
			rotate([0, 90, 0]) 
			plate(y_idler_y+wall*4,y_idler_x+wall*4,0);
	
			translate([depth,0,0])
			rotate([0, 90, 0]) 
			plate(wall*4,y_idler_x+wall*4,0);
	
			translate([depth+wall,y_idler_x/2+wall*2,-y_idler_y/2])
			rotate([90, 0, 0]) 
			cylinder(r=wall*2,h=y_idler_x+wall*4);

			translate([wall*2,0,-y_idler_y/2])
			cube([wall*4,y_idler_x+wall*4,wall*4],center=true);
		}

		translate([-1,0,0])
		scale([3,1,1])
		rotate([0, 90, 0]) 
		plate(y_idler_y-wall*4,0,0);

		translate([wall*3,0,0])
		rotate([90, 0, 0])
		union()
		{
			cylinder(r=m3_screw_dia/2, h=y_idler_x+wall*4+2,$fn=50, center=true);

			%translate([0,0,-y_idler_x/2-wall*2+m3_nut_height/2-0.1])
			cylinder(r=m3_nut_diameter_bigger/2, h=m3_nut_height,$fn=6, center=true);
		}
		translate([wall*4,0,-y_idler_y/2])
		rotate([90, 0, 0]) 		
		union()
		{
			cylinder(r=m3_screw_dia/2, h=y_idler_x+wall*4+2,$fn=50, center=true);

			%translate([0,0,-y_idler_x/2-wall*2+m3_nut_height/2-0.1])
			cylinder(r=m3_nut_diameter_bigger/2, h=m3_nut_height,$fn=6, center=true);
		}


		translate([0,0,y_idler_y/2])
		rotate([0,90,0])
		union()
		{
			translate([0,0,wall*2])
			cylinder(r=m3_screw_dia/2, h=wall*4+2,$fn=50, center=true);

			translate([0,0,m3_nut_height/2-0.1])
			cylinder(r=m3_nut_diameter_bigger/2, h=m3_nut_height,$fn=6, center=true);
		}
	}
}

module y_idler_support(nut = false)
{
	difference()
	{
		union()
		{
			rotate([90,0,0]) cylinder(r=wall*2, h=wall*2, $fn=50);
			translate([-wall*2,-wall,0])cube([wall*4,wall*2,wall*4],true);
		}
		
		rotate([90,0,0]) translate([0,0,-1]) cylinder(r=m3_screw_dia/2, h=wall*2+2, $fn=50);

		if (nut)
			rotate([90,30,0]) translate([0,0,wall/2+m3_nut_height]) cylinder(r=m3_nut_diameter_bigger/2, h=m3_nut_height, $fn=6);
	}
}