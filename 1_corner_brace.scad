include <nuts_and_bolts.scad>;
include <generals.scad>;

include <sub_front_pulleys.scad>;

corner_length = 80;
hole1 = 30;
hole2 = 55;

module corner_brace(margin = 0)
{
	difference()
	{
		union()
		{
			linear_extrude(height=wall)
 			polygon([
				[0, 0],
				[0, corner_length + margin],
				[corner_length + margin, 0]
			]);
		}
	
		translate([hole1, margin + alu_x / 2, wall+1])	mirror([0,0,1]) boltHole(bolt, length=wall+2);
		translate([hole2, margin +alu_x / 2, wall+1])  mirror([0,0,1]) boltHole(bolt, length=wall+2);
	
		translate([margin + alu_x / 2, hole1, wall+1]) mirror([0,0,1]) boltHole(bolt, length=wall+2);
		translate([margin +alu_x / 2, hole2, wall+1])  mirror([0,0,1]) boltHole(bolt, length=wall+2);
	}
}

module full_corner_brace()
{
	union()
	{
		corner_brace();
		translate([0, 0, wall]) rotate([90, 0, 0]) corner_brace();
		translate([0, 0, wall]) rotate([0, -90, 0]) corner_brace();
		translate([0, -wall, 0]) cube([corner_length, wall+0.01, wall+0.01]);
		translate([-wall, -wall, wall]) cube([wall+0.01, wall+0.01,corner_length]);
		translate([-wall, -wall, 0]) cube([wall+0.01, corner_length + wall, wall+0.01]);
	}
}

module open_corner_brace()
{
	union()
	{
		corner_brace();
		translate([0, 0, wall]) rotate([90, 0, 0]) corner_brace();
		//translate([0, 0, wall]) rotate([0, -90, 0]) corner_brace();
		translate([0, -wall, 0]) cube([corner_length, wall+0.01, wall+0.01]);
		//translate([-wall, -wall, wall]) cube([wall+0.01, wall+0.01,corner_length]);
		//translate([-wall, -wall, 0]) cube([wall+0.01, corner_length + wall, wall+0.01]);
	}
}

module single_corner_brace()
{
	union()
	{
		corner_brace();
		translate([-wall, 0, 0]) cube([wall+0.01, corner_length, wall+0.01]);
	}
}

module pulley_corner_brace(left = false)
{
	union()
	{
		mirror([0,1,0]) single_corner_brace();
		translate([0, -alu_x, alu_x+wall]) rotate([0, -90, 0]) front_pulley(false, left);
	}
}

//rotate([0,-90,0]) pulley_corner_brace(false);
//translate([10,0,0]) rotate([0,90,0]) mirror([1,0,0]) pulley_corner_brace(true);

//front_corner_brace();

//translate([corner_length + 5, corner_length + 5, 0]) rotate([0,0,180]) corner_brace();

//front_corner_brace();
//translate([corner_length + 5, corner_length + 5, 0]) rotate([0,0,180]) front_corner_brace();
//single_corner_brace();