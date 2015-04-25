use <inc/nuts_and_bolts.scad>;

//%translate([0,0,-15]) import_stl("beefy_coupling.stl");

couplingOD = 20;		//Coupling thickness
couplingH = 30;			//Coupling height
motorShaft = 5;		//Motor shaft
threadShaft = 10;		//Z thread shaft
screwShaft = 3.75;		//Screw shaft
screwHead = 6;		//Screw head
flat = 0.5;

clampWidth = 14;		//Clamp block width
clampBlckOffset = 8.5;	//Offset for clamp block
clampCutV = 3;			//Vertical clamp cut
clampCutH = 1;			//Horizontal clamp cut


union()
{
difference(){
	union(){
		cylinder(r=couplingOD/2, h=couplingH, $fn=35, center=true);
		translate([0,clampBlckOffset,0]) cube([clampWidth, clampWidth/2, couplingH], center=true);
	}
	
	translate([0,0,-couplingH/4]) cylinder(r=motorShaft/2, h=(couplingH/2)+0.1, center=true, $fn=24);
	translate([0,0,couplingH/4]) cylinder(r=threadShaft/2, h=(couplingH/2)+0.1, center=true, $fn=24);
	translate([0,clampBlckOffset,0]) cube([clampCutV, (clampWidth/2)+8, couplingH+1], center=true);
	translate([0,clampBlckOffset-1.5,0]) cube([couplingOD+1,(clampWidth/2)+0.5,clampCutH], center=true);
	translate([0,clampBlckOffset-1.5,couplingH/4]) rotate([0,90,0]) cylinder(r=screwShaft/2, h=couplingOD, center=true, $fn=25);
	translate([0,clampBlckOffset-1.5,-couplingH/4]) rotate([0,90,0]) cylinder(r=screwShaft/2, h=couplingOD, center=true, $fn=25);
	translate([(-clampWidth/2),clampBlckOffset-1.5,couplingH/4]) rotate([0,90,0]) nutHole(3, height =10);
	translate([(-clampWidth/2)-2,clampBlckOffset-1.5,couplingH/4]) rotate([0,90,0]) nutHole(3, height =10);
	translate([(-clampWidth/2),clampBlckOffset-1.5,-couplingH/4]) rotate([0,90,0]) nutHole(3, height =10);
	translate([(-clampWidth/2)-2,clampBlckOffset-1.5,-couplingH/4]) rotate([0,90,0]) nutHole(3, height =10);
	translate([(clampWidth/2)+1.5,clampBlckOffset-1.5,couplingH/4]) rotate([0,90,0]) cylinder(r=screwHead/2, h=3, center=true, $fn=25);
	translate([(clampWidth/2)+1.5,clampBlckOffset-1.5,-couplingH/4]) rotate([0,90,0]) cylinder(r=screwHead/2, h=3, center=true, $fn=25);
/*
translate([0,0,0]) union(){
	for (i=	[[8,0,0],
			[6,0,0],
			[-8,0,0],
			[-6,0,0],
			[-5.75,-5.75,0],
			[-4.5,-4.5,0],
			[5.75,5.75,0],
			[4.5,4.5,0],
			[-5.75,5.75,0],
			[-4.5,4.5,0],
			[5.75,-5.75,0],
			[4.5,-4.5,0],
			[-3,-7.25,0],
			[-2.3,-5.75,0],
			[3,-7.25,0],
			[2.3,-5.75,0],
			[-7.5,3,0],
			[-5.5,2.25,0],	
			[-7.5,-3,0],
			[-5.5,-2.25,0],
			[7.5,3,0],
			[5.5,2.25,0],
			[7.5,-3,0],
			[5.5,-2.25,0],	
			[0,-7.75,0],
			[0,-6,0]]){
	translate(i) cylinder(r=0.2, h=couplingH+1, center=true);
}}*/
}


translate([-motorShaft/4,-motorShaft/2+flat/2,-couplingH/4]) cube([motorShaft+1,flat,couplingH/2], center=true);
}