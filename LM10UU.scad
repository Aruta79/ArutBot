// LM8UU holder module, zip tie model
// Yes, another one
// John Ridley
// September 3 2012

LM8UU_dia = 19.4; 
LM8UU_length = 29;
LM8UU_rod_dia = 12;
LM8UU_body_wall_thickness = 4;
// set up all this junk as globals for compatibility with some other objects



///////////////////////////////////////////////////////////////////////////////////////////
// use this to create a bare holder (change false to true)
if (true)
{
 LM8UU_holder(
 	tab_length = 9.6,
 	tab_width = 12,
 	tab_screw_dia = 5);
}
///////////////////////////////////////////////////////////////////////////////////////////

module LM8UU_holder(
	bearing_dia = LM8UU_dia, 
	bearing_len = LM8UU_length, 
	shaft_dia = LM8UU_rod_dia, 
	border = LM8UU_body_wall_thickness, 
	borderP = LM8UU_body_wall_thickness + 2,
	zip_width = 3.5,
	zip_height = 1.5,
	tab_length = 0, 
	tab_width = 0, 
	tab_screw_dia = 0)
{
	;
	
	//screw/nut dimensions (M3) - hexagon socket head cap screw ISO 4762, hexagon nut ISO 4032
	screw_thread_dia_iso = 3.5;
	screw_head_dia_iso = 6.5;
	nut_wrench_size_iso = 7.95;
	
	
	// screw/nut dimensions for use (plus clearance for fitting purpose)
	clearance_dia = 0.5;
	screw_thread_dia = screw_thread_dia_iso + clearance_dia;
	screw_head_dia = screw_head_dia_iso + clearance_dia;
	nut_wrench_size = nut_wrench_size_iso + clearance_dia;
	nut_dia_perimeter = (nut_wrench_size/cos(30));
	nut_dia = nut_dia_perimeter;
	nut_surround_thickness = 2;
	
	// main body dimensions
	body_width = LM8UU_dia + (2*LM8UU_body_wall_thickness);
	body_height = LM8UU_dia/2 + LM8UU_body_wall_thickness;
	body_length = LM8UU_length + (2*LM8UU_body_wall_thickness);
	zip_offset = 2;

	translate([0,0,(bearing_dia/2+border)/2])
	difference()
	{
		union ()
		{
			cube([bearing_len + border*2, bearing_dia + border*2, bearing_dia/2 + borderP], center = true);
			if (tab_length > 0)
			{
				difference()
				{
					translate([0,0,-(bearing_dia/2)/2])
					{
						union ()
						{
							//soporte de los agujeros (base)
							cube([tab_width, tab_length + bearing_dia + border*2, borderP], center=true);

							for (i=[-1,1])
							{
								//Cilindros externos
								translate([0,(bearing_dia/2 + border + tab_length/2)*i, -borderP/2])
									cylinder(r=tab_width/2, h=borderP);
							}
						}
					}

					for (i=[-1,1])
					{
						//cilindros internos ( agujeros)
						translate([0,(bearing_dia/2 + borderP + tab_length/2)*i, -(bearing_dia/2 + borderP)/2])
							cylinder(r=tab_screw_dia / 2, h=borderP+0.1, $fn=10);
					}
				}
			}
		}
		translate([-(bearing_len/2 + border+0.05), 0, (bearing_dia/2+border)/2])
		rotate([0,90,0])
		union()
		{
			cylinder(r=shaft_dia/2, h=bearing_len + border*2+0.1);
			translate([0,0,(bearing_dia - shaft_dia)/2])
			cylinder(r=bearing_dia/2, h=bearing_len);

			// zip tie channels
			for (i=[-1,1])
			{
				translate([0,0,bearing_len/2+border-zip_width/2 + bearing_len/4 * i])
				{
					/*translate([(bearing_dia/2+border-zip_height/2+0.1), 0, zip_width/2])
						cube([zip_height, 12, zip_width], center=true);*/
					for (j=[-1,1])
					{
						translate([0,j*(bearing_dia/2+border-zip_height/2), zip_width/2])
							cube([11,zip_height, zip_width], center=true);
					}
					translate([zip_offset,0,0])// bearing_len/2 + border])
					difference ()
					{
						cylinder(r=bearing_dia/2 + border-0.1, h=zip_width);
						cylinder(r=bearing_dia/2 + border-0.3 - zip_height, h=zip_width);
					}
				}
			}
		}
	}
}