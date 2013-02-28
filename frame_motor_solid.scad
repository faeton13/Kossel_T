include <configuration.scad>;
use <corner.scad>;
use <libraries/frame_axis_block.scad>;

//extr=15;
h_motor_frame = motor_d;
w_motor_frame = w_fm+10;
//diagonal = extr*sqrt(2);

module frame_motor() {
  difference() {
     union() {
      rotate([0,0,-0])
        frame_axis_block(h_motor_frame, w_motor_frame, thickness, extr, diagonal,extr, extr/4,m_frame_open*2);
	      intersection() {
          translate([0, w_fm-extr*(cos(15)+1/5)+f3-L*sin(30)*tan(30), -motor_d/2])
            rotate([0, 0, 60])
	           cylinder(r=L*sin(30), h=motor_d, $fn=3, center=false);
	        
          translate([thickness, w_fm-extr*cos(15), -motor_d/2]) 
             scale([-1,-1,1])
              cube([L*sin(30)-diagonal/4, extr/2+motor_thickness*3/4, motor_d], center=false);
              }

    }
	
    rotate([0,0,30]){
    // Motor center cutout.
      scale([1,-1,1])
        translate([-diagonal/2, 0, 0]) 
          rotate([90, 0, 0])
            cylinder(r=diagonal/2, h=L-f1-diagonal/2, center=false);
    // Motor mounting screw holes.
      for (z = [-1, 1]) {
        translate([-diagonal/2+motor_screws/2, L-f1-diagonal/2, z*motor_screws/2])
	        rotate([90, 0, 0])
	          cylinder(r=1.6, h=100, center=false, $fn=12);
        translate([motor_screws/2-diagonal/2, L-f1-diagonal/2-motor_thickness, z*motor_screws/2])
	        rotate([90, 0, 0])
	          cylinder(r=5, h=20, center=false, $fn=24);
        translate([motor_screws/2-diagonal/2, extr, z*motor_screws/2])
	        rotate([90, 0, 0])
	          cylinder(r=4, h=extr*4, center=false);
       
      }
    }
   //  #translate([extr/4, w, 0])
     //     rotate([90, 0, -10])
       //     cylinder(r=extr/3, h=extr*6, center=false);
  }
}
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
module frame_motor_solid(){
difference() {
  union() {
    translate([0, 0, 0])
      //rotate([0, 90, 0])
        //rotate([0, 0, 30])
          for (i=[-1,1]) {
            translate([diagonal/2*i,0,0])
              rotate ([0,0,-30*i])
                scale ([i,1,1])
                  frame_motor();  
          }
    translate ([0,0,-h_motor_frame/2+extr/2])
      corner(h_motor_frame,5,0);
    rotate([0,0,45]) 
      //extrusion fix block
      intersection(){
        difference(){
          //cube ([extr+thickness*3,extr+thickness*3, h_motor_frame],center=true);  
          cylinder(r=W_roller+cone_radius_dwn,h=h_motor_frame,center=true);
          cube ([extr+extr_clr,extr+extr_clr,h_motor_frame+2 ], center=true);
          
        }
        rotate(-45,0,0)
          translate([0,cone_radius_dwn,0])
            cylinder(r=diagonal/2+cone_radius_dwn,h=h_motor_frame+2,center=true, $fn=12);
      }
  //support frame 
   for (i=[-1,1]) {
              rotate([0,0,-45*0])
              translate ([diagonal/2*i,extr*0.5,-h_motor_frame/2])
                rotate([0,0,270])
                cylinder(r=extr*0.5, h=h_motor_frame, $fn=3);
            }
   //motor joint
   translate([0,diagonal/2+motor_offset-(thickness),0])
     difference(){
       cube([motor_width,thickness*0.75,h_motor_frame],center=true);
       cube([motor_screws+m3_open_radius*2,thickness+2,motor_screws+m3_open_radius*2],center=true);
     }

  }
  //slot hole
  translate([-3/2,0,-(h_motor_frame+2)/2])
   rotate(270,0,0)
    cube([diagonal*2,slot_hole,(h_motor_frame+2)]);
  
//flexible cutt off
  for(i=[-1,1]) {
   # translate ([-(diagonal/4)*i,1,0])
    {
      rotate([0,0,90])
      cube([3*2,diagonal/2,h_motor_frame+2],center=true);
      //cylinder (r=4,h=h_motor_frame+2, $fn=16);
      translate ([-(diagonal/4)*i,0,0])
        cylinder (r=3,h=h_motor_frame+2, center=true, $fn=16);
    }
  }
//pulley hole
            translate([0,diagonal/2,0])
              rotate([90,0,0])
                cylinder(r=diagonal/2, h=diagonal, center=true, $fn=16);
//screw holes
if (h_motor_frame<(extr*1.5)){
        for (a = [1, -1]) {
                      
              translate([0,-(diagonal/2+m_frame_radius+m_frame_clr) , (h_motor_frame-extr)/2])
                rotate([90, 0, 0])
                 {
                 cylinder(r=m_frame_radius, h=4*extr, center=true, $fn=12);
                 translate([0, 0, radius-frame_thickness])
                   cylinder(r=m_frame_cap, h=extr, center=true, $fn=24);
                translate([0, 0, -(radius-frame_thickness)])
                   cylinder(r=m_frame_nut, h=extr, center=true, $fn=6);
                 }
               
          
        }
      }
else {
        for (a = [1, -1]) {
          for (b =[-1,1]) {
            translate([0,-(diagonal/2+m_frame_radius+m_frame_clr*2) , (h_motor_frame-extr)/2*(b)])
              rotate([0, 90, 0])
               {
                 cylinder(r=m_frame_radius, h=4*extr, center=true, $fn=12);
                 translate([0, 0, 5+extr/2])
                   cylinder(r=m_frame_cap, h=extr, center=true, $fn=24);
                 translate([0, 0, -(5+extr/2)])
                    cylinder(r=m_frame_nut, h=extr, center=true, $fn=6);
               }               
          }
        }
      }
}
}


frame_motor_solid ();
// scale([-1, 1, 1]) frame_motor();

// OpenBeam.
// % rotate([0, 0, 45]) cube([extr, extr, 100], center=true);

// NEMA17 stepper motor.
// translate([0, motor_offset+30, 0])
// % cube([motor_width, 60, motor_width], center=true);
