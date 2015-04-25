///
/// TODO:
///	OK adjustable height hotend holders
///   OK finish hotend holders
///   OK hotend mount plate
///	OK z smooth rods
///	OK  improve lmuu holders
///	-  add frame braces where required
///	-  add electronics bracktes
///	OK  add extruder mounts - directly on frame
///	OK check belt crossing and belt mount heights
///	? add break and tightening screw to back y rod holder 
///   - fix hotends y distance

// AMENDMENTS
//		OK increase M5 hole size to 6
//		OK increase nema17 crown size
//	OK check nema17 bolt distances
//		- make bottom wall on front pulley holder thicker
//		- add tolerance to rod holes
//		OK move z_bed_carriage_depth by 0.5mm, so heatbed support is 380mm

include <nuts_and_bolts.scad>;
include <generals.scad>;
include <alu.scad>;

bar_x = 450;
bar_y = 490;
bar_z = 450;
bar_bed = 400;
bar_support = 410;

coarse_hotend = true;

include <1_corner_brace.scad>;
include <2_y_axis_support_front.scad>;
include <3a_xy_motor_support.scad>;
//include <3b_back_rod_support.scad>;
include <4a_x_axis_end_vertical_narrow_back.scad>;
include <5a_x_carriage_vertical.scad>;
include <6_hotend_mount.scad>;
include <7_z_top_bearing.scad>;
include <8_z_bed_carriage.scad>;
include <9_z_support_bottom.scad>;
use <99_bits_and_pieces.scad>;

chamber_y = bar_y - motor_sup_arm_y - alu_x;
front_space = alu_x + pulley_plate_y - x_carriage_depth + hotend_offset - 8;
front_space_quad = alu_x + pulley_plate_y + x_carriage_depth + hotend_offset + thin_wall;

bottom_space = z_bottom_motor_top + leadscrew_coupling_h + flange_small_h + heatbed_h + heatbed_support_h + 0.5*wall+wall_clearance*2;

x_axis_pos_max = 145;
x_axis_pos_min = -x_axis_pos_max;
x_axis_pos = x_axis_pos_max*0;

y_axis_pos_min = 90+x_end_v_rod_y_offset;
y_axis_pos_max = 402+x_end_v_rod_y_offset;
y_axis_pos = y_axis_pos_min;

z_axis_pos_min = bottom_space;
z_axis_pos_max = bar_z-alu_x/2-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist+hotend_groove_offset+hotend_drop-hotend_total_height - heatbed_h - heatbed_support_h-3.25;
z_axis_pos = z_axis_pos_max/2;

echo("Predicted single-tool x envelope: ", x_axis_pos_max - x_axis_pos_min);
echo("Predicted single-tool y envelope: ", y_axis_pos_max - y_axis_pos_min);
echo("Predicted single-tool z envelope: ", z_axis_pos_max - z_axis_pos_min);
echo("Predicted quad-tool x envelope: ", x_axis_pos_max - x_axis_pos_min - hotend_width);
echo("Predicted quad-tool y envelope: ", y_axis_pos_max - y_axis_pos_min  - 2*(hotend_offset + thin_wall + x_carriage_depth));
echo("Predicted quad-tool z envelope: ", z_axis_pos_max - z_axis_pos_min);

//--------------------------------------------------------------
//--------------------------------------------------------------
//--------------------------------------------------------------

//frame();
hardware();
parts();
belts();
//build_envelope();
//build_envelope_quad();

module parts()
{
	// ====================== PARTS =======================
	for(i = [0,1])	mirror([i,0,0])
	{
        color([0,0.2,1]) place_corner_braces((i==1));

		place_xy_supports((i==1));

		color([0,0.2,1]) place_x_ends((i==1));

	}
	
	color([0.8,0.8,0.2])
	place_x_carriage();

	color([0.8,0.8,0.6])
	translate([x_axis_pos, y_axis_pos - x_carriage_depth, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist]) hotend_mount();

	color([0.2,0.2,0.2])
	translate([x_axis_pos, y_axis_pos - x_carriage_depth, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist]) 
	{
		translate([0, 0, hotend_groove_h]) hotend_plate();
		translate([-2*(x_carriage_width/2-hotend_width)-hotend_width, 0, hotend_groove_h]) hotend_plate();
	}

	color([0.8,0.8,0.6])
	translate([x_axis_pos, y_axis_pos + x_carriage_depth, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist]) rotate([0, 0, 180]) hotend_mount();

	echo("Hotend mount screw length: ", 2 * x_carriage_depth + 3*thin_wall + METRIC_NUT_THICKNESS[3]);
	color([0,0.2, 1])
	place_z_bed_carriages();
echo(".");
	color([0, 0.4, 0.8])
	{
		translate([0, alu_x, 0]) z_support_bottom(false);
		translate([0, bar_y + alu_x, 0]) rotate([0, 0, 180]) z_support_bottom(false);
	}

	echo("Back of chamber calculated to be: ", alu_x+z_bed_carriage_depth+heatbed_support_offset_y+heatbed_y+z_bed_carriage_depth+1.5*wall+z_bottom_motor_offset);

	translate([0, alu_x, bar_z-alu_x-2*wall]) z_top_bearing(true);
	translate([0, bar_y + alu_x, bar_z - alu_x]) rotate([0, 0, 180]) z_top_bearing();
}

//==============================================================

module build_envelope()
{
	//build envelope
	color([1,1,1])
	translate([x_axis_pos_min - hotend_width/2, front_space, 2*alu_x]) 
	cube([x_axis_pos_max - x_axis_pos_min, 
			y_axis_pos_max - y_axis_pos_min, 
			z_axis_pos_max - z_axis_pos_min]);
}

module build_envelope_quad()
{
	//build envelope
	color([0.8,0.8,0.8])
	%translate([x_axis_pos_min + hotend_width/2, front_space, 2*alu_x]) 
	cube([x_axis_pos_max - x_axis_pos_min - hotend_width,
			y_axis_pos_max - y_axis_pos_min  - 2*(hotend_offset + thin_wall + x_carriage_depth), 
			z_axis_pos_max - z_axis_pos_min]);
}

module frame()
{
	//FRAME
	color([0.5,0.5,0.5])
	{
		for(i = [0,1])	mirror([i,0,0])
		{
			//verticals
			translate([bar_x/2, 0, bar_z/2]) bar_vert(bar_z);
			translate([bar_x/2, bar_y+alu_x, bar_z/2]) bar_vert(bar_z);
		
			//horizontals on y axis
			translate([bar_x/2, bar_y/2 + alu_x, bar_z-alu_x]) bar_horiz(bar_y);
			translate([bar_x/2, bar_y/2 + alu_x, 0]) bar_horiz(bar_y);
		}
		
		//horizontals on x axis
		translate([0, 0, alu_x]) bar_horiz(bar_x, false, true);
		translate([0, bar_y+alu_x, alu_x]) bar_horiz(bar_x, false, true);
		translate([0, 0, bar_z]) bar_horiz(bar_x, false, true);
		translate([0, bar_y+alu_x, bar_z]) bar_horiz(bar_x, false, true);
		
		//back of chamber
		for(i = [0,1])	mirror([i,0,0])
		{
			translate([bar_x/2, chamber_y + alu_x, bar_support/2 + alu_x]) bar_vert(bar_support);
		}

		//z axis supports - top
		//translate([0, chamber_y+alu_x, bar_z-alu_x]) bar_horiz(bar_x, false, true);
		//translate([0, 0, bar_z-y_sup_height_back-alu_x]) bar_horiz(bar_x, false, true);

		//z axis supports - bottom
		translate([0, bar_y+alu_x, z_bottom_height]) bar_horiz(bar_x, false, true);
		//translate([0, chamber_y+alu_x, alu_x]) bar_horiz(bar_x, false, true);
		translate([0, 0, z_bottom_height]) bar_horiz(bar_x, false, true);

		//heatbed supports
		*translate([0, front_space - heatbed_support_offset_y, z_axis_pos - heatbed_h - heatbed_support_h]) bar_horiz(bar_bed, false, true);
		*translate([0, front_space + heatbed_y-alu_x+heatbed_support_offset_y, z_axis_pos - heatbed_h - heatbed_support_h]) bar_horiz(bar_bed, false, true);

	}	
}

module hardware()
{
	// Y-RODS
	for(i = [0,1])
	{
		mirror([i,0,0])
		translate([bar_x/2 - y_from_side, chamber_y+2*alu_x+1.5, bar_z-alu_x-y_from_top-rod_dia/2]) rotate([90,0,0]) smooth_rod(chamber_y+2*alu_x+3);
	}

	// X-RODS
	translate([-bar_x/2 + y_from_side - x_end_v_width /2, y_axis_pos, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist]) rotate([0,90,0]) smooth_rod(bar_x - 2*(y_from_side-x_end_v_width/2));
	translate([-bar_x/2 + y_from_side - x_end_v_width /2, y_axis_pos, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall]) rotate([0,90,0]) smooth_rod(bar_x - 2*(y_from_side-x_end_v_width/2));
	echo("X-rod length: ", bar_x - 2*(y_from_side-x_end_v_width/2));
	
	// MOTORS
	for(i = [0,1])
	{
		mirror([i,0,0])
		translate([bar_x/2 - wall - nema17_side/2 - motor_from_side_x, bar_y + alu_x - (wall + nema17_side/2 + motor_from_side_y), bar_z-alu_x-wall]) rotate([-90, 0, 0]) nema17(top=wall+0.5);
	}

	//Z MOTORS
	translate([0, alu_x+z_bottom_motor_offset, z_bottom_motor_top]) rotate([-90, 0, 0]) nema17(top=wall+0.5);;
	translate([0, bar_y + alu_x - z_bottom_motor_offset, z_bottom_motor_top]) rotate([-90, 0, 0]) nema17(top=wall+0.5);;

	//Z ROD COUPLINGS
	color([1, 1, 1])
	{
		translate([0, alu_x+z_bottom_motor_offset, z_bottom_motor_top+wall+wall_clearance]) cylinder(d = leadscrew_coupling_d, h = leadscrew_coupling_h);
		translate([0, bar_y + alu_x - z_bottom_motor_offset, z_bottom_motor_top+wall+wall_clearance]) cylinder(d = leadscrew_coupling_d, h = leadscrew_coupling_h);
	}

	//Z ROD FLANGES
	color([1, 1, 1])
	{
		translate([0, alu_x+z_bottom_motor_offset, z_axis_pos - heatbed_h - heatbed_support_h -wall]) leadscrew_flange_hole();
		translate([0, bar_y + alu_x - z_bottom_motor_offset, z_axis_pos - heatbed_h - heatbed_support_h-wall]) leadscrew_flange_hole();
	}
	
	//Z AXIS LEADSCREWS
	color([1, 0.5, 1])
	{
		translate([0, alu_x+z_bottom_motor_offset, nema17_depth+alu_x-wall]) cylinder(d=leadscrew_d, h = leadscrew_h);
		translate([0, bar_y + alu_x - z_bottom_motor_offset, nema17_depth+alu_x-wall]) cylinder(d=leadscrew_d, h = leadscrew_h);
	}
	
	echo("Z axist leadscrew offset: ",(bar_y + alu_x - z_bottom_motor_offset)-(alu_x+z_bottom_motor_offset));
	echo("Calculated heatbed support: ",(bar_y + alu_x - z_bottom_motor_offset)-(alu_x+z_bottom_motor_offset)- 2*z_bed_carriage_depth);

	//Z AXIS SMOOTH RODS
	color([1, 1, 1])
	{
		translate([z_smooth_rod_offset, bar_y + alu_x - z_bottom_motor_offset, nema17_depth+alu_x-wall]) cylinder(d=leadscrew_d, h = leadscrew_h);
		translate([-z_smooth_rod_offset, bar_y + alu_x - z_bottom_motor_offset, nema17_depth+alu_x-wall]) cylinder(d=leadscrew_d, h = leadscrew_h);

		translate([z_smooth_rod_offset, alu_x + z_bottom_motor_offset, nema17_depth+alu_x-wall]) cylinder(d=leadscrew_d, h = leadscrew_h);
		translate([-z_smooth_rod_offset, alu_x + z_bottom_motor_offset, nema17_depth+alu_x-wall]) cylinder(d=leadscrew_d, h = leadscrew_h);
	}
	
	// HEATBED SUPPORT
	translate([0, alu_x+z_bottom_motor_offset+z_bed_carriage_depth, z_axis_pos-heatbed_h-heatbed_support_h]) heatbed_support();

	// HEATBED
	translate([0, alu_x+z_bottom_motor_offset+z_bed_carriage_depth+heatbed_support_offset_y+heatbed_offset_y, z_axis_pos-heatbed_h]) heatbed();

	// PULLEYS
	for(i = [0,1])	mirror([i,0,0])
	{
		color([1, 0, 0])
		translate([bar_x/2 - wall - nema17_side/2 - motor_from_side_x, bar_y + alu_x - (wall + nema17_side/2 + motor_from_side_y), bar_z-alu_x+belt_z_offset]) pulley_big();
		
		color([0, 0.8, 0])
		translate([bar_x/2-alu_x/2+2*wall - hole_dist_1, alu_x+hole_dist_1, bar_z-alu_x+i*belt_left_pulley_z_offset+belt_z_offset+(1-i)*(bearing_pulley_h)]) mirror([0, 0, 1-i])pulley_small_new();
		
		color([0, 0.8, 0])
		translate([bar_x/2-alu_x/2+2*wall - hole_dist_2 - hole_x_offset, alu_x+hole_dist_2, bar_z-alu_x+belt_z_offset+i*(bearing_pulley_h) + (1-i)*(pulley_s_base_h)]) mirror([0, 0, i]) pulley_small_new();

		color([1, 0, 1])
		translate([bar_x/2-alu_x/2+2*wall - hole_dist_2 - hole_x_offset, y_axis_pos - pulley_s_d_small/2-x_carriage_belt_dist/2+x_carriage_belt_offset, bar_z-alu_x+belt_z_offset+i*(bearing_pulley_h) + (1-i)*pulley_s_base_h]) mirror([0, 0, i]) pulley_small_new();
        echo("p1:",bar_z-alu_x+belt_z_offset+i*(bearing_pulley_h) + (1-i)*pulley_s_base_h);
	}

	// BEARINGS
		color([1, 0, 1])
	for(i = [0,1])	mirror([i,0,0])
	{
		translate([bar_x/2 - wall - nema17_side/2 - motor_from_side_x-pulley_b_d_small_with_belt/2 - belt_bearing_d/2, y_axis_pos + belt_bearing_d/2 + belt_depth + x_carriage_belt_dist/2 + x_carriage_belt_offset, bar_z-alu_x+belt_z_offset+ pulley_s_base_h]) bearing();
	}
    //echo("p2:",bar_z-y_from_top+rod_dia/2+pulley_b_base_h+belt_z_offset);

	// HOTENDS
	color([1, 0, 0])
	{
		translate([x_axis_pos-x_carriage_width/2+hotend_width/2, y_axis_pos-x_carriage_depth - hotend_offset - thin_wall, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist+hotend_groove_offset+hotend_drop])	rotate([0, 0, -90]) e3d(coarse_hotend);
		translate([x_axis_pos+x_carriage_width/2-hotend_width/2, y_axis_pos-x_carriage_depth - hotend_offset - thin_wall, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist+hotend_groove_offset+hotend_drop])	rotate([0, 0, 90]) e3d(coarse_hotend);

		translate([x_axis_pos-x_carriage_width/2+hotend_width/2, y_axis_pos+x_carriage_depth + hotend_offset + thin_wall, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist+hotend_groove_offset+hotend_drop]) rotate([0, 0, -90]) e3d(coarse_hotend);
		translate([x_axis_pos+x_carriage_width/2-hotend_width/2, y_axis_pos+x_carriage_depth + hotend_offset + thin_wall, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist+hotend_groove_offset+hotend_drop]) rotate([0, 0, 90]) e3d(coarse_hotend);
	}
}

module place_corner_braces(left)
{
		//CORNER BRACES
		translate([bar_x/2+alu_x, 0, -wall]) 									//bottom front
			rotate([0, 0, 90]) open_corner_brace();

		translate([bar_x/2+alu_x+wall, 0, bar_z])								//top front
			rotate([0, 90, 180]) pulley_corner_brace(left);

		translate([bar_x/2+alu_x+wall, bar_y+2*alu_x, 0]) 					//bottom back
			rotate([90, 0, -90]) full_corner_brace();

		translate([bar_x/2+alu_x, bar_y+2*alu_x, bar_z+wall]) 			//top back
			rotate([180, 0, -90]) full_corner_brace();
}

module place_xy_supports(left)
{
        color([0,0.8,0.5])
		translate([bar_x / 2, alu_x, bar_z-alu_x-wall])
		rotate([0,0,180]) y_axis_support_front(left);

        color([0,0.7,1])
		translate([bar_x / 2, bar_y+alu_x, bar_z-alu_x]) 
		rotate([0, 0, 180]) xy_motor_support();

		//translate([bar_x / 2, chamber_y+alu_x, bar_z-alu_x]) 
		//rotate([0, 0, 180]) back_rod_support();
}

module place_x_ends(left)
{
		translate([bar_x / 2 - y_from_side - x_end_v_width /2, y_axis_pos, bar_z-alu_x-y_from_top-rod_dia/2]) x_axis_end(left);
}

module place_x_carriage()
{
		translate([x_axis_pos, y_axis_pos, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist])  x_carriage_vertical();

		translate([x_axis_pos, y_axis_pos, bar_z-alu_x-y_from_top-rod_dia/2-x_end_v_full_height+wall+x_end_v_rod_dist])  x_carriage_vertical(false);
}

module place_z_bed_carriages()
{
	translate([0, bar_y+alu_x-z_bottom_motor_offset, z_axis_pos-heatbed_h-heatbed_support_h]) rotate([0, 0, 0]) z_bed_carriage(false);

	translate([0, alu_x+z_bottom_motor_offset, z_axis_pos-heatbed_h-heatbed_support_h]) rotate([0, 0, 180]) z_bed_carriage();
}



//MEASURING BAR
color([0,0,0])
translate([bar_x / 2, bar_z-alu_x, bar_z]) 
cube([5,100,5]);

module belts()
{
    color([0,0,0])
    hull()
    {
    translate([bar_x/2-alu_x/2+2*wall - hole_dist_1, alu_x+hole_dist_1-pulley_s_d_small/2-belt_depth, bar_z-alu_x+belt_z_offset+1]) cube([1,1,belt_width]);
    translate([-bar_x/2+alu_x/2-2*wall + hole_dist_2 + hole_x_offset, alu_x+hole_dist_2-pulley_s_d_small/2-belt_depth, bar_z-alu_x+belt_z_offset+1]) cube([1,1,belt_width]);
    }		
    
    color([0,0,0])
    hull()
    {		
    translate([bar_x/2-alu_x/2+2*wall - hole_dist_2 - hole_x_offset, alu_x+hole_dist_2-pulley_s_d_small/2-belt_depth, bar_z-alu_x+belt_z_offset+pulley_s_base_h+1]) cube([1,1,belt_width]);
    translate([-bar_x/2+alu_x/2-2*wall + hole_dist_1, alu_x+hole_dist_1-pulley_s_d_small/2-belt_depth, bar_z-alu_x+belt_left_pulley_z_offset+belt_z_offset+1]) cube([1,1,belt_width]);
    }
}