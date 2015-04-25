width = 50;
height = 90;
depth = 5;

margin = 0.2;

rod = 10;
holder_length = 15;
holder_thickness = 5;
holder_width = 30;
rounded = 3;

bolt = 5 + margin;
holder_bolt = 3 + margin;

m3_diameter = 3 + margin;
m3_nut_diameter = 5.3;
m3_nut_diameter_horizontal = 6.1;
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;

nut_trap_depth = 2;

space = 1;
alu_x = 20;

socket_d = 11+margin;
switch_x = 30;
switch_y = 22;
offset_socket = 1;
offset_switch = 7;
shell_wall = 3;
shell_depth = 35;

slot_depth=2;
slot_width=10;

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

//main
difference()
{
	difference()
	{
		union()
		{
			plate();
	
			translate([0, 0, shell_depth/2 + depth])
			cube([width, height-alu_x*2, shell_depth],center=true);
		}
	
		translate([0, (-height/2+alu_x/2)/2 + offset_socket, -0.5])
		cylinder(depth+1,r=socket_d/2,$fn=100,true);
	
		translate([0, (height/2-alu_x/2)/2 - offset_switch, depth/2-0.2])
		cube([switch_x, switch_y, depth+1],center=true);
	
		translate([0, 0, shell_depth/2 + depth])
		cube([width-shell_wall, height-alu_x*2-shell_wall, shell_depth+1],center=true);
	
		translate([width/2 - 10, height/2 - alu_x/2, -0.5])
			cylinder(depth+1,d=bolt, $fn=100,true);
	
		translate([-width/2 + 10, -height/2 + alu_x/2, -0.5])
			cylinder(depth+1,d=bolt, $fn=100,true);
	
		translate([width/2 - 10, -height/2 + alu_x/2, -0.5])
			cylinder(depth+1,d=bolt, $fn=100,true);
	
		translate([-width/2 + 10, height/2 - alu_x/2, -0.5])
			cylinder(depth+1,d=bolt, $fn=100,true);
	}

	#translate([width/4, -height/2+alu_x+0.5, shell_depth+depth-3])
	cube([slot_width, shell_wall+1, slot_depth],center=true);

	#translate([-width/4, -height/2+alu_x+0.5, shell_depth+depth-3])
	cube([slot_width, shell_wall+1, slot_depth],center=true);

	#translate([0,height/2-alu_x+1,shell_depth+depth-5])
	rotate([90,0,0])
	cylinder(shell_wall+1,d=m3_diameter, $fn=100,true);
}	
