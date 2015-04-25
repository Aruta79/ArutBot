// PRUSA Mendel
// 10mm bar Endstop holder
// Used to attach endstops to 10mm rods
// GNU GPL v3
// Peter Ellens
// Based on endstop_holder.scad by
// Josef Pru�a
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

m10_diameter = 11;

/**
 * @id endstop-holder
 * @name Endstop holder
 * @category Printed
 * @using 1 m3x20xhex
 * @using 1 m3nut
 * @using 2 m3washer
 */
module endstop(){
outer_diameter = m10_diameter/2+3.3;
screw_hole_spacing = 20;
opening_size = m10_diameter-1.5; //openingsize

difference(){
union(){


translate([outer_diameter, outer_diameter, 0]) cylinder(h =10, r = outer_diameter, $fn = 20);
translate([outer_diameter, 0, 0]) cube([15.5,outer_diameter*2,10]);
translate([-8, 0, 0]) cube([20, 4, 10]);
translate([17, 19.5, 5]) rotate([90, 0, 0]) cylinder(h =5, r = 5.77, $fn = 6);
}




translate([9, outer_diameter-opening_size/2, 0]) cube([18,opening_size,20]);
translate([outer_diameter, outer_diameter, 0]) cylinder(h =20, r = m10_diameter/2, $fn = 18);

//Securing hole
translate([17, 17, 3]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
translate([17, 21.5, 3]) rotate([90, 0, 0]) cylinder(h =5, r = m3_nut_diameter_horizontal/2, $fn = 6);

translate([17, 17, 3]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
translate([17-screw_hole_spacing, 17, 3]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
*translate([17-2*screw_hole_spacing, 17, 3]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
}
}
endstop();