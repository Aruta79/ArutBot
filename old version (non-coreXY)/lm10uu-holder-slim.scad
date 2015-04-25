// lm10uu holder slim v1.1
// *********************************************
// Jonas Kühling
// http://www.jonaskuehling.de
// http://www.thingiverse.com/jonaskuehling
// *********************************************
// derived from:
// http://www.thingiverse.com/thing:14942

// lm10uu/rod dimensions
lm10uu_dia = 19.4;
lm10uu_length = 29;
rod_dia = 10;

LM8LUU_length = 65;

//screw/nut dimensions (M3) - hexagon socket head cap screw ISO 4762, hexagon nut ISO 4032
screw_thread_dia_iso = 3;
screw_head_dia_iso = 5.5;
nut_wrench_size_iso = 5.5;


// screw/nut dimensions for use (plus clearance for fitting purpose)
clearance_dia = 0.5;
screw_thread_dia = screw_thread_dia_iso + clearance_dia;
screw_head_dia = screw_head_dia_iso + clearance_dia;
nut_wrench_size = nut_wrench_size_iso + clearance_dia;
nut_dia_perimeter = (nut_wrench_size/cos(30));
nut_dia = nut_dia_perimeter;
nut_surround_thickness = 1.5;

// main body dimensions
body_wall_thickness = 2.5;
body_width = lm10uu_dia + (2*body_wall_thickness);
body_height = body_width;
default_body_length = lm10uu_length;
gap_width = rod_dia + 2;
screw_bushing_space = 1;
screw_elevation = lm10uu_dia + body_wall_thickness + (screw_thread_dia/2) +screw_bushing_space;

lm10uu_holder_width = body_width;
lm10uu_holder_length = default_body_length;
lm8luu_holder_length = LM8LUU_length;
lm10uu_holder_height = body_height;
lm10uu_support_thickness = body_wall_thickness;
lm10uu_holder_gap=5;
lm10uu_diameter = lm10uu_dia;

// TEST - uncomment to render in openscad:
 lm10uu_holder(1);		// WITH mountplate
// lm10uu_holder();		// WITHOUT mountplate
//lm8luu_bearing_holder();
//color([1,0,0]) cube([24,5,5], center=true);

module lm10uu_bearing_holder(with_mountplate=false) {
	translate([body_width/2,default_body_length/2,0])
	rotate([0,0,0])
	lm10uu_holder(with_mountplate);
}

module lm8luu_bearing_holder(with_mountplate=false) {
	translate([body_width/2,LM8LUU_length/2,0])
	rotate([0,0,0])
	lm10uu_holder(with_mountplate, LM8LUU_length);
}

module lm10uu_mounting_cutout()
{
  translate([0,0,0])
  cube([body_width,
	default_body_length,
	body_height]);
}

module lm8luu_mounting_cutout()
{
  translate([0,0,0])
  cube([body_width,
	LM8LUU_length,
	body_height]);
}

// nophead's polyhole module for better lm10uu-fit
module polyhole(d,h) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}


module mount_plate(body_length)
{
	difference()
	{
		translate([0,0,1.5])
		cube([body_width+2*screw_head_dia,body_length,3], center=true);

		for(i=[-1,1])
			for(j=[-1,0,1])
				translate([i*28/2,j*11,-0.5])
					cylinder(r=screw_thread_dia/2, h=4, $fn=20);
	}
}

module screw_mount(y_offset) {
	difference() {
		union() {
			// nut trap surround
			translate([gap_width/2,y_offset,screw_elevation])
				rotate([0,90,0])
					cylinder(r=(((nut_wrench_size+nut_surround_thickness*2)/cos(30))/2), h=(body_width-gap_width)/2, $fn=6);
			translate([gap_width/2+(body_width-gap_width)/4,y_offset,screw_elevation/2])
				cube([(body_width-gap_width)/2,nut_wrench_size+(nut_surround_thickness*2),screw_elevation],center=true);
		
			// Screw hole surround
			translate([-gap_width/2,y_offset,screw_elevation])
				rotate([0,-90,0])
					cylinder(r=(screw_head_dia/2)+nut_surround_thickness, h=(body_width-gap_width)/2, $fn=20);
			translate([-(gap_width/2+(body_width-gap_width)/4),y_offset,screw_elevation/2])
				cube([(body_width-gap_width)/2,screw_head_dia+(nut_surround_thickness*2),screw_elevation],center=true);
		}
	
		// nut trap
		translate([gap_width/2+body_wall_thickness,y_offset,screw_elevation])
			rotate([0,90,0])
				cylinder(r=nut_dia/2, h=body_width/2-gap_width/2-body_wall_thickness+1,$fn=6);
	
		// screw head hole
		translate([-(gap_width)/2-body_wall_thickness,y_offset,screw_elevation])
			rotate([0,-90,0])
				cylinder(r=screw_head_dia/2, h=body_width/2-gap_width/2-body_wall_thickness+1,$fn=20);
	}
}

module screw_hole(y_offset) {
	// screw hole (one all the way through)
	translate([0,y_offset,screw_elevation])
		rotate([0,90,0])
			cylinder(r=screw_thread_dia/2, h=body_width+3, center=true, $fn=20);
}

// main body
module lm10uu_holder(with_mountplate=false, body_length=default_body_length)
{
	difference()
	{
		union()
		{
			if (with_mountplate) 
			mount_plate(body_length);
	
			// body
			translate([0,0,body_height/4])
				cube([body_width,body_length,body_height/2], center=true);
			translate([0,0,(lm10uu_dia/2)+body_wall_thickness])		
				rotate([90,0,0])
					cylinder(r=(lm10uu_dia/2)+body_wall_thickness, h=body_length, center=true);
	
			// gap support
			translate([-(gap_width/2)-body_wall_thickness,-(body_length/2),body_height/2])
				cube([body_wall_thickness,body_length,(lm10uu_dia/2)+screw_bushing_space+(screw_thread_dia/2)]);
			translate([gap_width/2,-(body_length/2),body_height/2])
				cube([body_wall_thickness,body_length,(lm10uu_dia/2)+screw_bushing_space+(screw_thread_dia/2)]);
	
	
			if (body_length > 40) {
				for (i=[-1,1])
					screw_mount(i*body_length/3);
			} else {
				screw_mount(0);
			}
		}
	
		if (body_length > 40) {
			for (i=[-1,1])
				screw_hole(i*body_length/3);
		} else {
			screw_hole(0);
		}

		// bushing hole
		translate([0,0,lm10uu_dia/2+body_wall_thickness])
			rotate([90,0,0])
//				cylinder(r=lm10uu_dia/2, h=lm10uu_length+1, center=true);
				translate([0,0,-(body_length+1)/2]) polyhole(lm10uu_dia,body_length+1);	// TESTING POLYHOLE MODULE FOR BETTER lm10uu FIT
	
		// top gap
		translate([-(gap_width/2),-(body_length/2)-1,body_height/2])
			cube([gap_width,body_length+2,(lm10uu_dia/2)+screw_bushing_space+(screw_thread_dia/2)+(nut_dia/2)+nut_surround_thickness+1]);
	
	}
}
