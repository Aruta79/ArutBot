/*
Name: OpenSCAD model of "E3D-v6 All Metal HotEnd"
Author: Jons Collasius from Germany/Hamburg

Creator of "E3D-v6 All Metal HotEnd": E3D Online - JR 
URL: http://e3d-online.com/E3D-v6-Documentation
License: CC BY-NC-SA 3.0
License URL: https://creativecommons.org/licenses/by-nc-sa/3.0/

*/

fnresolution = 0.5;	// resolution, length of tiny lines in a circle 

//e3d(coarse= false);	// coarse = true/false. with coarse= true only the outlines mit nor millings or holes are created

module e3d(coarse=false) {
	rotate([0,180,180])
	if(coarse==true) {
		e3d_coarse();	
	} else {
		difference() {
			e3d_coarse();
			translate([0,0,-1]) fncylinder(r=1.6,h=64.1);
			translate([0,0,62.1]) fncylinder(r=0.25,h=4,fn=10);
			translate([0,0,16]) fnpipe(r=9,r2=4.475,h=1.5); 
			translate([0,0,18.5]) fnpipe(r=9,r2=4.475,h=1.5); 
			for ( i = [0 : 9] ) {
				translate([0,0,21+i*2.5]) fnpipe(r=12.15,r2=4.475+i*0.15,h=1.5); 
			}
			translate([-9,8,55.6]) rotate([0,90,0]) fncylinder(r=3.05, h=18);
			translate([-9,8,54.6]) cube([18,8.5,2]);
			translate([0,13,47.1]) fncylinder(r=1.4, h=13.5);
			translate([4.45,-1,54.8]) rotate([0,90,0]) fncylinder(r=1.4, h=4.45);
			translate([3.45,-2.5,57.6]) rotate([0,90,0]) fncylinder(r=1.15, h=5.45);
		}
	}
}

module e3d_coarse() {
	union() {
		translate([0,0,0]) fncylinder(r=8,h=7);
		translate([0,0,6]) fncylinder(r=6,h=8);
		translate([0,0,13]) fncylinder(r=8,h=8);
		translate([0,0,20]) fncylinder(r=11.15,h=26);
		translate([0,0,0]) fncylinder(r=8,h=7);
		translate([0,0,45]) fncylinder(r=2,h=4.1);
		translate([-8,-4.5,48.1]) cube([16,20,11.5]);
		translate([0,0,58.6]) fncylinder(r=2.5,h=3);
		translate([0,0,60.6]) fncylinder(r=4.03,h=3,fn=6);
		translate([0,0,62.6]) fncylinder(r=3,r2=0.5,h=3);
	}
}

module fnpipe(r,r2,h,fn){
	if (fn==undef) {
		difference() {
			fncylinder(r=r,h=h,$fn=2*r*3.14/fnresolution);
			translate([0,0,-1]) fncylinder(r=r2,h=h+2,$fn=2*r*3.14/fnresolution);
		}
	} else {
		difference() {
			fncylinder(r=r,h=h,fn=fn);
			translate([0,0,-1]) fncylinder(r=r2,h=h+2,fn=fn);
		}
	}
}

module fncylinder(r,r2,h,fn){
	if (fn==undef) {
		if (r2==undef) {
			cylinder(r=r,h=h,$fn=2*r*3.14/fnresolution);
		} else {
			cylinder(r=r,r2=r2,h=h,$fn=2*r*3.14/fnresolution);
		}
	} else {
		if (r2==undef) {
			cylinder(r=r,h=h,$fn=fn);
		} else {
			cylinder(r=r,r2=r2,h=h,$fn=fn);
		}
	}
}