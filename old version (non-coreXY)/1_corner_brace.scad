height = 90;
width = 40;
thickness = 5;

alu_x = 20;

bolt = 5;

hole_offset = alu_x/2;

union()
	{
		difference()
		{
			cube([height,width,thickness]);

			translate([hole_offset,width/4,0]) 
				cylinder(h=thickness,r=bolt/2, $fn=20);

			translate([height-hole_offset,3*width/4,0]) 
				cylinder(h=thickness,r=bolt/2, $fn=20);
		
			if (height == 90)
			{
				translate([hole_offset,3*width/4,0]) 
					cylinder(h=thickness,r=bolt/2, $fn=20);

				translate([height-hole_offset,width/4,0]) 
					cylinder(h=thickness,r=bolt/2, $fn=20);

			}
		}

		rotate(90,[1,0,0]) 
		difference()
		{
			cube([height,width+alu_x+thickness,thickness]);

			translate([hole_offset,width/4+alu_x+thickness,0])
				cylinder(h=thickness,r=bolt/2, $fn=20);

			translate([height-hole_offset,3*width/4+alu_x+thickness,0])
				cylinder(h=thickness,r=bolt/2, $fn=20);

			if (height == 90)
			{
				translate([hole_offset,3*width/4+alu_x+thickness,0])
					cylinder(h=thickness,r=bolt/2, $fn=20);

				translate([height-hole_offset,width/4+alu_x+thickness,0])
					cylinder(h=thickness,r=bolt/2, $fn=20);

			}
		}
	}
