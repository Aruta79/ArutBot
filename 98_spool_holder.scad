include <nuts_and_bolts.scad>;
include <generals.scad>;

spool_hole_d = 50;
spool_hole_overhang =  20;
spool_width = 70;
spool_rod = 10;

difference()
{
    union()
    {
        cylinder(h=wall, d=spool_hole_d + spool_hole_overhang);
        cylinder(h = spool_width + wall, d= spool_hole_d);
    }
    
    translate([0,0,-1]) cylinder(h= spool_width + wall + 2, d = spool_rod+1);
}