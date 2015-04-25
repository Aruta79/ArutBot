// lm10uu holder slim v1.1
// *********************************************
// Jonas Kühling
// http://www.jonaskuehling.de
// http://www.thingiverse.com/jonaskuehling
// *********************************************
// derived from:
// http://www.thingiverse.com/thing:14942
// 
// modified by Artur Guja
//		- re-translated to origin in xy-plane, and to center of rod in z
//		- names prefixed with lmuu to enable safe use in larger project
//		- added margin to get smaller hole, to widen in final model (avoid manifold issues)


// lm10uu/rod dimensions
lm10uu_dia = 19.4;
lm10uu_length = 29;
lmuu_rod_dia = 10;

LM8LUU_length = 65;

//screw/nut dimensions (M3) - hexagon socket head cap screw ISO 4762, hexagon nut ISO 4032
lmuu_screw_thread_dia_iso = 3;
lmuu_screw_head_dia_iso = 5.5;
lmuu_nut_wrench_size_iso = 5.5;


// screw/nut dimensions for use (plus clearance for fitting purpose)
lmuu_clearance_dia = 0.5;
lmuu_screw_thread_dia = lmuu_screw_thread_dia_iso + lmuu_clearance_dia;
lmuu_screw_head_dia = lmuu_screw_head_dia_iso + lmuu_clearance_dia;
lmuu_nut_wrench_size = lmuu_nut_wrench_size_iso + lmuu_clearance_dia;
lmuu_nut_dia_perimeter = (lmuu_nut_wrench_size/cos(30));
lmuu_nut_dia = lmuu_nut_dia_perimeter;
lmuu_nut_surround_thickness = 1.5;

// main body dimensions
lmuu_body_wall_thickness = 2.5;
lmuu_body_width = lm10uu_dia + (2*lmuu_body_wall_thickness);
lmuu_body_height = lmuu_body_width;
default_lmuu_body_length = lm10uu_length;
lmuu_gap_width = lmuu_rod_dia + 2;
lmuu_screw_bushing_space = 1;
lmuu_screw_elevation = lm10uu_dia + lmuu_body_wall_thickness + (lmuu_screw_thread_dia/2) +lmuu_screw_bushing_space;

lm10uu_holder_width = lmuu_body_width;
lm10uu_holder_length = default_lmuu_body_length;
lm8luu_holder_length = LM8LUU_length;
lm10uu_holder_height = lmuu_body_height;
lm10uu_support_thickness = lmuu_body_wall_thickness;
lm10uu_holder_gap=5;
lm10uu_diameter = lm10uu_dia;

// TEST - uncomment to render in openscad:
//lm10uu_holder(0);		// WITH mountplate
// lm10uu_holder();		// WITHOUT mountplate
//lm8luu_bearing_holder();
//color([1,0,0]) cube([24,5,5], center=true);

//lm10uu_bearing_holder(with_mountplate=false, hole_margin=0.1);

module lm10uu_bearing_holder(with_mountplate=false, hole_margin = 0) {
	translate([-lmuu_body_width/2,0,0])
	rotate([0,0,0])
	lm10uu_holder(with_mountplate, margin = hole_margin);
}

module lm10uu_bearing_holder_double(with_mountplate=false, hole_margin = 0) {
	translate([-lmuu_body_width/2,-default_lmuu_body_length,0])
	rotate([0,0,0])
	lm10uu_holder(with_mountplate, margin = hole_margin, body_length=2*default_lmuu_body_length);
}

module lm8luu_bearing_holder(with_mountplate=false) {
	translate([-lmuu_body_width/2,0,0])
	rotate([0,0,0])
	lm10uu_holder(with_mountplate, LM8LUU_length);
}

module lm10uu_mounting_cutout()
{
  translate([0,0,0])
  cube([lmuu_body_width,
	default_lmuu_body_length,
	lmuu_body_height]);
}

module lm8luu_mounting_cutout()
{
  translate([0,0,0])
  cube([lmuu_body_width,
	LM8LUU_length,
	lmuu_body_height]);
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
		cube([lmuu_body_width+2*lmuu_screw_head_dia,body_length,3], center=true);

		for(i=[-1,1])
			for(j=[-1,0,1])
				translate([i*28/2,j*11,-0.5])
					cylinder(r=lmuu_screw_thread_dia/2, h=4, $fn=20);
	}
}

module screw_mount(y_offset) {
	difference() {
		union() {
			// nut trap surround
			translate([lmuu_gap_width/2,y_offset,lmuu_screw_elevation])
				rotate([0,90,0])
					cylinder(r=(((lmuu_nut_wrench_size+lmuu_nut_surround_thickness*2)/cos(30))/2), h=(lmuu_body_width-lmuu_gap_width)/2, $fn=6);
			translate([lmuu_gap_width/2+(lmuu_body_width-lmuu_gap_width)/4,y_offset,lmuu_screw_elevation/2])
				cube([(lmuu_body_width-lmuu_gap_width)/2,lmuu_nut_wrench_size+(lmuu_nut_surround_thickness*2),lmuu_screw_elevation],center=true);
		
			// Screw hole surround
			translate([-lmuu_gap_width/2,y_offset,lmuu_screw_elevation])
				rotate([0,-90,0])
					cylinder(r=(lmuu_screw_head_dia/2)+lmuu_nut_surround_thickness, h=(lmuu_body_width-lmuu_gap_width)/2, $fn=20);
			translate([-(lmuu_gap_width/2+(lmuu_body_width-lmuu_gap_width)/4),y_offset,lmuu_screw_elevation/2])
				cube([(lmuu_body_width-lmuu_gap_width)/2,lmuu_screw_head_dia+(lmuu_nut_surround_thickness*2),lmuu_screw_elevation],center=true);
		}
	
		// nut trap
		translate([lmuu_gap_width/2+lmuu_body_wall_thickness,y_offset,lmuu_screw_elevation])
			rotate([0,90,0])
				cylinder(r=lmuu_nut_dia/2, h=lmuu_body_width/2-lmuu_gap_width/2-lmuu_body_wall_thickness+1,$fn=6);
	
		// screw head hole
		translate([-(lmuu_gap_width)/2-lmuu_body_wall_thickness,y_offset,lmuu_screw_elevation])
			rotate([0,-90,0])
				cylinder(r=lmuu_screw_head_dia/2, h=lmuu_body_width/2-lmuu_gap_width/2-lmuu_body_wall_thickness+1,$fn=20);
	}
}

module screw_hole(y_offset) {
	// screw hole (one all the way through)
	translate([0,y_offset,lmuu_screw_elevation])
		rotate([0,90,0])
			cylinder(r=lmuu_screw_thread_dia/2, h=lmuu_body_width+3, center=true, $fn=20);
}

// main body
module lm10uu_holder(with_mountplate=false, body_length=default_lmuu_body_length, margin = 0)
{
	translate([(lmuu_body_width+(with_mountplate ? 2*lmuu_screw_head_dia : 0))/2, body_length/2, -(lm10uu_dia/2+lmuu_body_wall_thickness)])
	difference()
	{
		union()
		{
			if (with_mountplate) 
			mount_plate(body_length);
	
			// body
			translate([0,0,lmuu_body_height/4])
				cube([lmuu_body_width,body_length,lmuu_body_height/2], center=true);
			translate([0,0,(lm10uu_dia/2)+lmuu_body_wall_thickness])		
				rotate([90,0,0])
					cylinder(r=(lm10uu_dia/2)+lmuu_body_wall_thickness, h=body_length, center=true);
	
			// gap support
			translate([-(lmuu_gap_width/2)-lmuu_body_wall_thickness,-(body_length/2),lmuu_body_height/2])
				cube([lmuu_body_wall_thickness,body_length,(lm10uu_dia/2)+lmuu_screw_bushing_space+(lmuu_screw_thread_dia/2)]);
			translate([lmuu_gap_width/2,-(body_length/2),lmuu_body_height/2])
				cube([lmuu_body_wall_thickness,body_length,(lm10uu_dia/2)+lmuu_screw_bushing_space+(lmuu_screw_thread_dia/2)]);
	
	
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
		translate([0,0,lm10uu_dia/2+lmuu_body_wall_thickness])
			rotate([90,0,0])
//				cylinder(r=lm10uu_dia/2, h=lm10uu_length+1, center=true);
				translate([0,0,-(body_length+1)/2]) polyhole(lm10uu_dia-margin,body_length+1);	// TESTING POLYHOLE MODULE FOR BETTER lm10uu FIT
	
		// top gap
		translate([-(lmuu_gap_width/2),-(body_length/2)-1,lmuu_body_height/2])
			cube([lmuu_gap_width,body_length+2,(lm10uu_dia/2)+lmuu_screw_bushing_space+(lmuu_screw_thread_dia/2)+(lmuu_nut_dia/2)+lmuu_nut_surround_thickness+1]);
	
	}
}
