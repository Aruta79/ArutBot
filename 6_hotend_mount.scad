include <nuts_and_bolts.scad>;
include <generals.scad>;
include <E3D.scad>;

hotend_offset = hotend_big_d/2;
bolt_shift = 1;
stub_width = 15;

module hotend_mount(front = true)
{
	difference()
	{
		union()
		{
			translate([-x_carriage_width/2, -thin_wall, x_carriage_height-x_carriage_top_height-lm10uu_dia/2-wall-x_end_v_rod_dist]) cube([x_carriage_width, thin_wall, x_carriage_top_height]); 
			translate([-stub_width/2, -thin_wall, x_carriage_height-x_carriage_top_height-lm10uu_dia/2-wall-x_end_v_rod_dist+hotend_drop/2-thin_wall]) cube([stub_width, thin_wall, -hotend_drop/2+thin_wall+1]); 

			translate([-x_carriage_width/2, -hotend_offset-hotend_d, -hotend_groove_offset]) cube([hotend_width, hotend_offset+hotend_d, hotend_groove_h]);
			translate([x_carriage_width/2-hotend_width, -hotend_offset-hotend_d, -hotend_groove_offset]) cube([hotend_width, hotend_offset+hotend_d, hotend_groove_h]);
		}


		////////////////  NEED TO MAKE HOTENDS HEIGHT ADJUSTABLE


		hull()
		{
			translate([-x_carriage_width/2+hotend_width/2, -hotend_offset-thin_wall, -hotend_groove_offset-0.5]) cylinder(d=hotend_groove_d, h=hotend_groove_h + 1);
			translate([-x_carriage_width/2+hotend_width/2, -hotend_offset-thin_wall-30, -hotend_groove_offset-0.5]) cylinder(d=hotend_groove_d, h=hotend_groove_h + 1);
		}

		hull()
		{
			translate([x_carriage_width/2-hotend_width/2, -hotend_offset-thin_wall, -hotend_groove_offset-0.5]) cylinder(d=hotend_groove_d, h=hotend_groove_h + 1);
			translate([x_carriage_width/2-hotend_width/2, -hotend_offset-thin_wall-30, -hotend_groove_offset-0.5]) cylinder(d=hotend_groove_d, h=hotend_groove_h + 1);
		}

		translate([-x_carriage_width/2+hotend_width/2-hotend_width/4, -thin_wall-0.5, x_carriage_height-x_carriage_top_height-lm10uu_dia/2-wall-x_end_v_rod_dist-1]) cube([hotend_width/2, thin_wall+1, hotend_groove_offset-thin_wall+1]); 

		translate([x_carriage_width/2-hotend_width/2-hotend_width/4, -thin_wall-0.5, x_carriage_height-x_carriage_top_height-lm10uu_dia/2-wall-x_end_v_rod_dist-1]) cube([hotend_width/2, thin_wall+1, hotend_groove_offset-thin_wall+1]); 

		// BOLT HOLES
		translate([-x_carriage_width/2+M3+1, -thin_wall-0.5, lm10uu_dia/2+wall - M3]) rotate([front ? -90 : 90, 0 ,0]) boltHoleEx(small_bolt, length=wall+1,shift_y=bolt_shift);

		translate([0, -thin_wall-0.5, lm10uu_dia/2+wall - M3]) rotate([front ? -90 : 90, 0 ,0]) boltHoleEx(small_bolt, length=wall+1,shift_y=bolt_shift);
			
		translate([x_carriage_width/2-M3-1, -thin_wall-0.5, lm10uu_dia/2+wall - M3]) rotate([front ? -90 : 90, 0 ,0]) boltHoleEx(small_bolt, length=wall+1,shift_y=bolt_shift);
			
		translate([-x_carriage_width/2+M3+1, -thin_wall-0.5, -lm10uu_dia/2-1.5*wall + M3]) rotate([front ? -90 : 90, 0 ,0]) boltHoleEx(3, length=wall+1,shift_y=bolt_shift);

		translate([x_carriage_width/2-M3-1, -thin_wall-0.5, -lm10uu_dia/2-1.5*wall + M3]) rotate([front ? -90 : 90, 0 ,0]) boltHoleEx(3, length=wall+1,shift_y=bolt_shift);
			
		translate([0, -thin_wall-0.5, -lm10uu_dia/2-wall + M3+hotend_drop]) rotate([front ? -90 : 90, 0 ,0]) boltHoleEx(3, length=wall+1,shift_y=bolt_shift);

		//hotend bolt holes
		translate([x_carriage_width/2-hotend_width+thin_wall+M3/2, (-hotend_offset-hotend_d/2)/2-M3/2, -hotend_groove_offset]) boltHole(3, length=wall+1);

		translate([x_carriage_width/2-thin_wall-M3/2, (-hotend_offset-hotend_d/2)/2-M3/2, -hotend_groove_offset]) boltHole(3, length=wall+1);

		translate([-x_carriage_width/2+hotend_width-thin_wall-M3/2, (-hotend_offset-hotend_d/2)/2-M3/2, -hotend_groove_offset]) boltHole(3, length=wall+1);

		translate([-x_carriage_width/2+thin_wall+M3/2, (-hotend_offset-hotend_d/2)/2-M3/2, -hotend_groove_offset]) boltHole(3, length=wall+1);

	}
}

module hotend_plate()
{
	difference()
	{
		union()
		{
			translate([x_carriage_width/2-hotend_width, -hotend_offset-hotend_d, -hotend_groove_offset]) cube([hotend_width, hotend_offset+hotend_d-wall-wall_clearance, hotend_top_h]);
		}

		hull()
		{
			translate([x_carriage_width/2-hotend_width/2, -hotend_offset-thin_wall, -hotend_groove_offset-0.5]) cylinder(d=hotend_d, h=hotend_top_h + 1);
			translate([x_carriage_width/2-hotend_width/2, -hotend_offset-thin_wall+50, -hotend_groove_offset-0.5]) cylinder(d=hotend_d, h=hotend_top_h + 1);
		}

		//hotend bolt holes
		translate([x_carriage_width/2-hotend_width+thin_wall+M3/2, (-hotend_offset-hotend_d/2)/2-M3/2, -hotend_groove_offset-0.5]) boltHole(3, length=wall+1);

		translate([x_carriage_width/2-thin_wall-M3/2, (-hotend_offset-hotend_d/2)/2-M3/2, -hotend_groove_offset-0.5]) boltHole(3, length=wall+1);

	}
}

//hotend_mount();

//rotate([-90, 0, 0])hotend_mount();
//translate([0, 35, 0]) rotate([90, 0, 0]) mirror([0,1,0]) hotend_mount();

//translate([0, -hotend_offset-hotend_d, hotend_groove_offset]) hotend_plate();
//translate([-hotend_width-wall, -hotend_offset-hotend_d, hotend_groove_offset]) hotend_plate();

//translate([0, 0, hotend_groove_h/2]) hotend_plate();
//translate([-2*(x_carriage_width/2-hotend_width)-hotend_width, 0, hotend_groove_h/2]) hotend_plate();

//translate([x_carriage_width/4, -hotend_offset-thin_wall, hotend_groove_h/2]) e3d();
//translate([-x_carriage_width/4, -hotend_offset-thin_wall, hotend_groove_h/2]) e3d();
