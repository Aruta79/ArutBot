include <nuts_and_bolts.scad>;
include <generals.scad>;
use <Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>;

module bearing_wide_spacer()
{
    difference()
    {
        cylinder(d=15, h=1);
        boltHole(3, length=11);
    }
}

module pulley_spacer(tall = false, narrow = false)
{
    difference()
    {
        cylinder(d=narrow ? (pulley_s_d - 3.4) : pulley_s_d, h=tall ? (alu_x+(wall-thin_wall)-bearing_pulley_h-2*belt_z_offset) : (pulley_s_base_h));
        boltHole(3, length=11);
    }
}


module bed_holder()
{
    bed_holder_overlap = 15;
    bed_holder_length = bed_holder_overlap + 8;
    bed_holder_space = 6.6;
    bed_holder_width = 8;
    
    difference()
    {
        union()
        {
            cube([bed_holder_width, bed_holder_length, thin_wall]);
            intersection()
            {
               translate([bed_holder_width/2, -12, 0]) cylinder(d=40, h=bed_holder_space+thin_wall);
               cube([bed_holder_width, bed_holder_length-bed_holder_overlap, bed_holder_space+thin_wall]);
            }
        }
        
        translate([bed_holder_width/2,(bed_holder_length-bed_holder_overlap)/2,-1]) boltHole(3, length=15);
    }
}

module bed_cap()
{
    difference()
    {
        union()
        {
            cube([55*2, 11+8, thin_wall]);
            cube([55*2, 8, 4+thin_wall]);
            
        }

        translate([55,8,-1]) cube([15,11,thin_wall+2]);
        translate([4,4,-1]) boltHole(3, length=15);
        translate([55*2-4,4,-1]) boltHole(3, length=15);
    }
}

module ilder_pulley()
{
    GT2_2mm_pulley_dia = tooth_spacing (2,0.254);
    
    difference()
    {
        union()
        {
            translate([0,0,0]) cylinder(h=1, d=belt_bearing_d+4);
            translate([0,0,1]) pulley ( "GT2 2mm" , GT2_2mm_pulley_dia , 0.764 , 1.494 );
            translate([0,0,belt_bearing_h+1]) cylinder(h=1, d=belt_bearing_d+4);
        }
        translate([0,0,1]) cylinder(h=belt_bearing_h+5, d=belt_bearing_d);
        translate([0,0,-0.5]) cylinder(h=belt_bearing_h+5, d=M3);
    }
}

scale_f = 1.06;

translate([0,0,0]) bearing_wide_spacer();
translate([20,0,0]) bearing_wide_spacer();
translate([40,0,0]) pulley_spacer(tall = true, narrow = false);
translate([60,0,0]) pulley_spacer(tall = false, narrow = true);
translate([0,20,0]) pulley_spacer(tall = false, narrow = false);
translate([20,20,0]) pulley_spacer(tall = false, narrow = false);
translate([40,20,0]) pulley_spacer(tall = false, narrow = true);
translate([60,20,0]) pulley_spacer(tall = false, narrow = true);

translate([0, -30, 0]) bed_cap();

translate([0,40,0]) scale(scale_f) ilder_pulley();
translate([20,40,0]) scale(scale_f) ilder_pulley();
translate([40,40,0]) scale(scale_f) ilder_pulley();
translate([60,40,0]) scale(scale_f) ilder_pulley();

translate([0,60,0]) scale(scale_f) ilder_pulley();
translate([20,60,0]) scale(scale_f) ilder_pulley();