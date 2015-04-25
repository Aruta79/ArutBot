width = 50;
height = 90;
depth = 5;

margin = 0.3;

rod = 10;
holder_length = 15;
holder_thickness = 5;
holder_width = 30;
rounded = 3;

bolt = 5 + margin;
holder_bolt = 3 + margin;

m3_diameter = 3.6;
m3_nut_diameter = 5.3;
m3_nut_diameter_horizontal = 6.1;
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;

nut_trap_depth = 2;

space = 1;
alu_x = 20;

module plate()
{
	hull()
	{
		translate([width/2-rounded/2,height/2-rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
		translate([width/2-rounded/2,-height/2+rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
		translate([-width/2+rounded/2,height/2-rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
		translate([-width/2+rounded/2,-height/2+rounded/2,0]) cylinder(depth,r=rounded/2,$fn=100,true);
	}
}

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

//main



translate([width/2+holder_length/2+5,0,0])
rotate([0,0,90])
//translate([0,-space,depth+holder_length/2])
//rotate([90,0,0])
{
	difference()
	{
		union()
		{
			cube([holder_width,holder_length,6],center=true);
			translate([0,0,-space])
			rotate([90,0,0]) cylinder(holder_length,d=rod+6,$fn=100,center=true);
		}

		translate([0,0,-1])
		rotate([90,0,0]) cylinder(holder_length+5,d=rod,$fn=100,center=true);
		
		translate([0,0,(-holder_thickness-rod)/2])
		cube([holder_width+2,holder_length+2,holder_thickness+rod],center=true);

		translate([holder_width/2-rod/2,0,0])
		cylinder(holder_thickness+1,d=holder_bolt,$fn=100,center=true);		

		translate([-holder_width/2+rod/2,0,0])
		cylinder(holder_thickness+1,d=holder_bolt,$fn=100,center=true);		
	}
}