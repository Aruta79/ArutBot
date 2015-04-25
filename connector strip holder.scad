include <nuts_and_bolts.scad>;
include <generals.scad>;

strip_length = 66+2*thin_wall;
strip_height = max(24, alu_x)+2*thin_wall;
holder_margin = 14;
hole_offset = 9;
hole_spacing = 46/4;

module connector_strip_holder()
{
	difference()
	{
		union()
		{
			translate([-strip_height/2, 0, 0]) cube([strip_height, 2*holder_margin + strip_length, thin_wall]);

			translate([strip_height/2-thin_wall, holder_margin, 0])
			cube([thin_wall, strip_length, 2*thin_wall]);

			translate([-strip_height/2, holder_margin, 0])
			cube([thin_wall, strip_length, 2*thin_wall]);

			translate([-strip_height/2, holder_margin, 0])
			cube([strip_height, thin_wall, 2*thin_wall]);

			translate([-strip_height/2, strip_length + holder_margin - thin_wall, 0])
			cube([strip_height, thin_wall, 2*thin_wall]);
		}

		for(i=[0:4])
			translate([0, holder_margin + hole_offset + thin_wall + i*hole_spacing, 0]) boltHole(3, length=10);

		translate([0, holder_margin/2, 0]) boltHole(6, length=10);
		translate([0, holder_margin*3/2+strip_length, 0]) boltHole(6, length=10);
	}
}

connector_strip_holder();