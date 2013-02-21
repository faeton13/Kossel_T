include <configuration.scad>;
use <libraries/frame_axis_block.scad>

//extr=25;
h = motor_d+m3_cap;
w = w_fm;
//diagonal = extr*sqrt(2);

module frame_motor() {
  difference() {
   
 //  intersection() {translate([-h, -h/2, -h/2]) rotate([0, 0, -30]) translate([0, 0, 0]) #cube([22, h , w]);}
    union() {
      rotate([0,0,-0])
        frame_axis_block(h, w, thickness, extr, diagonal);
	      intersection() {
          translate([0, w-extr*(cos(15)+1/5)+f3-L*sin(30)*tan(30), -motor_d/2])
          //translate([0, w-extr*(cos(15)+1/2), -motor_d/2])
	          rotate([0, 0, 60])
	           cylinder(r=L*sin(30), h=motor_d, $fn=3, center=false);
	        //rotate([0, 0, -30]) 
          translate([thickness, w-extr*cos(15), -motor_d/2]) 
             scale([-1,-1,1])
              cube([L*sin(30)-diagonal/4, extr/2+motor_thickness*3/4, motor_d], center=false);
             // translate([-h_mot_cut_off/2+thickness, w-extr*(cos(15)+1/2), 0]) 
             //cube([h_mot_cut_off, extr, motor_d], center=true);
  	      }
    }
	//rotate([0, 0, 135]) translate([-0, 0, -h])	%cube([extr, extr, h*2], center=false);
    rotate([0,0,30]){
    // Motor center cutout.
      scale([1,-1,1])
        translate([-diagonal/2, 0, 0]) 
          rotate([90, 0, 0])
            cylinder(r=diagonal/2, h=L-f1-diagonal/2, center=false);
    // Motor mounting screw holes.
      for (z = [-1, 1]) {
       # translate([-diagonal/2+motor_screws/2, L-f1-diagonal/2, z*motor_screws/2])
	        rotate([90, 0, 0])
	          cylinder(r=1.6, h=100, center=false, $fn=12);
        translate([motor_screws/2-diagonal/2, L-f1-diagonal/2-motor_thickness, z*motor_screws/2])
	        rotate([90, 0, 0])
	          cylinder(r=5, h=20, center=false, $fn=24);
        #translate([motor_screws/2-diagonal/2, extr, z*motor_screws/2])
	        rotate([90, 0, 0])
	          cylinder(r=9, h=extr*4, center=false);
       
      }
    }
   //  #translate([extr/4, w, 0])
     //     rotate([90, 0, -10])
       //     cylinder(r=extr/3, h=extr*6, center=false);
  }
}

translate([0, 0, 0])
rotate([0, 90, 0])
//rotate([0, 0, 30])
frame_motor();
// scale([-1, 1, 1]) frame_motor();

// OpenBeam.
// % rotate([0, 0, 45]) cube([extr, extr, 100], center=true);

// NEMA17 stepper motor.
// translate([0, motor_offset+30, 0])
// % cube([motor_width, 60, motor_width], center=true);
