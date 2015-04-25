clamp_height = 3;
clamp_width = 20;
clamp_length = 30;
rounded = 3;
belt_pitch = 2;
belt_width = 8;
tooth_width = 1.3;
tooth_heigth = .75;
//offset = belt_pitch/4;
offset = 0;
screw_offset = 2;
m3_diameter = 3;

module beltclamp(){
	difference(){
		// basic shape
		hull(){
			translate([clamp_length/2, clamp_width/2, 0]) cylinder(r=rounded,h=clamp_height, $fn=50);
			translate([clamp_length/2, -clamp_width/2, 0]) cylinder(r=rounded,h=clamp_height, $fn=50);
			translate([-clamp_length/2, clamp_width/2, 0]) cylinder(r=rounded,h=clamp_height, $fn=50);
			translate([-clamp_length/2, -clamp_width/2, 0]) cylinder(r=rounded,h=clamp_height, $fn=50);
			}
		// screw holes
		translate(v = [-clamp_length/2, -clamp_width/2, -1]) cylinder(d=m3_diameter, h=clamp_height+2, $fn=50);
		translate(v = [clamp_length/2, -clamp_width/2, -1]) cylinder(d=m3_diameter, h=clamp_height+2, $fn=50);
		translate(v = [-clamp_length/2, +clamp_width/2, -1]) cylinder(d=m3_diameter, h=clamp_height+2, $fn=50);
		translate(v = [clamp_length/2, +clamp_width/2, -1]) cylinder(d=m3_diameter, h=clamp_height+2, $fn=50);
		// belt grip
		translate(v = [0,offset,clamp_height-tooth_heigth])
		for ( i = [round(-clamp_width/belt_pitch/2) : round(clamp_width/belt_pitch/2)]){
			translate(v = [0,belt_pitch*i,tooth_heigth])cube(size = [belt_width, tooth_width, tooth_heigth*2], center = true);
		}
	}

}

beltclamp();