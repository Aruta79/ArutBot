thickness=4;
hole_pitch=31;//26;
rad = 6;
notch = false;

module NEMA17_spacer(){
	//body
	difference(){
        union()
        {
            translate([0,-15/2,thickness/2]) cube([hole_pitch+11,hole_pitch+11+15,thickness],center=true);
            translate([20/2,-(hole_pitch+11)/2-15/2-20/2+0.5,thickness/2]) cube([hole_pitch+11+20,20+1,thickness],center=true);
        }
		for(i=[0,1]){
			rotate([0,0,i*90+45]) union() {
				//translate([(hole_pitch-8)*sqrt(2)+2.5-2.5/sqrt(2),0,thickness/2]) {
				translate([(hole_pitch+11)*sqrt(2)/2-4.5*sqrt(2)+5,0,thickness/2]) {
					cube([5,10,thickness+.2],center=true);
				}
				translate([sqrt(2)*hole_pitch/2,0,0]) cylinder(r=3.2/2,h=thickness*4,center=true,$fn=12);
			}
			
		}
        
        translate([-(hole_pitch+11)/2+20/2, -(hole_pitch+11)/2-15/2-20/2, 0]) cylinder(d=5,h=thickness*2.2,center=true, $fn=15);
        translate([+(hole_pitch+11)/2+20/2, -(hole_pitch+11)/2-15/2-20/2, 0]) cylinder(d=5,h=thickness*2.2,center=true, $fn=15);
		cylinder(r=23/2,h=thickness*2.2,center=true); // Changed from 22.4 - AB

	// Corner notch added by AB
		if(notch)
		{
			translate([-hole_pitch/2+3,hole_pitch/2-1,0]) 
			{
					cylinder(r=rad, h=thickness*4,center=true,$fn=20);
					translate([-rad,3,0])
						cube([2*rad,2*rad+6,thickness*4],center=true);
					rotate([0,0,-45])
					translate([-3,rad+3,0])
						cube([2*rad+6,2*rad+6,thickness*4],center=true);
			}
		}
	}
}

NEMA17_spacer();
