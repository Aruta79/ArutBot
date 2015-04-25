$fn=100;

module ramps_holes(h, d)
{
    space=15.2+27.9+5.1;

    translate([14, 0, 0]) {
	cylinder(r=d/2, h=h);
	translate([1.3, space, 0]) cylinder(r=d/2, h=h);
	translate([82.55, 0]) cylinder(r=d/2, h=h);
	translate([1.3+50.8+24.1, space]) cylinder(r=d/2, h=h);
    }
}

module baseplate()
{
    r=3;
    w=82.55+r;
    space=15.2+27.9+5.1;
    h=space+r+6;

	union()
	{
	    difference()
		{
			hull()
			{
			    translate([r, r, 0]) cylinder(r=r, h=4);
			    translate([w, r, 0]) cylinder(r=r, h=4);
			    translate([w-r, h, 0]) cube(size=[r*2, r*2, 4]);
			    translate([r-r, h, 0]) cube(size=[r*2, r*2, 4]);
			}
	
			hull()
			{
			    translate([14, 10, -0.5]) cylinder(r=r, h=5);
			    translate([w-10, 10, -0.5]) cylinder(r=r, h=5);
			    translate([w-10, h-14, -0.5]) cylinder(r=r, h=5);
			    translate([14, h-14, 0-0.5]) cylinder(r=r, h=5);
			}
	    }

			hull()
			{
			    translate([12, 8, 0]) cylinder(r=2, h=4);
			    translate([w-8, h-12, 0]) cylinder(r=2, h=4);
			}
			hull()
			{
			    translate([w-8, 8, 0]) cylinder(r=2, h=4);
			    translate([12, h-12, 0]) cylinder(r=2, h=4);
			}
	}
}

t=4;
e=20;
w = 88.55;

union() {
    translate([0, -56.2, 0])
	difference() {
		union() 
		{
			translate([11, -3, 0]) baseplate();
			ramps_holes(8, 6);
		}
	
		translate([0,0,-0.5]) ramps_holes(9, 3.5);
    }
    
    translate([11, 0, 0]) {
	difference () {
		cube(size=[w, t, e]);

		translate([10, t/2, e/2]) rotate([90, 0, 0]) cylinder(r=5/2, h=t+1, center=true);
		translate([80, t/2, e/2]) rotate([90, 0, 0]) cylinder(r=5/2, h=t+1, center=true);
	}
    }
}



