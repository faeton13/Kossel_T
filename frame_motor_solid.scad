include <configuration.scad>;
use <corner.scad>;
use <libraries/frame_axis_block.scad>;
use <libraries/teardrops.scad>;

//extr=25;
h_motor_frame = motor_d;
w_motor_frame = w_fm+10;
//diagonal = extr*sqrt(2);


frame_motor_output=13;

//frame cheek output:
//1 - for sqear tube version assembled
// - for  sqear tube:
//11 - printing plate
//12 - corner only
//13 - motor joint only
//2 - for separate right cheek
//3 - for separate left cheek




module frame_motor() {
  difference() {
     union() {
        frame_axis_block(h_motor_frame, w_motor_frame, thickness, extr, diagonal, frame_type, extr*1.1, 5,m_frame_open*2,layer_h);

	      if (frame_type==1)
          intersection() {
            translate([0, w_fm-extr*(cos(15)+1/5)+f3-L*sin(30)*tan(30), -motor_d/2])
              rotate([0, 0, 60])
	             cylinder(r=L*sin(30), h=motor_d, $fn=3, center=false); 
          translate([thickness, w_fm-extr*cos(15), -motor_d/2]) 
            scale([-1,-1,1])
              cube([L*sin(30)-diagonal/4, extr/2+motor_thickness*3/4, motor_d], center=false);
              }
        else
        {
          intersection() {
            translate([0, w_fm-extr*(cos(15)+1/5)+f3-L*sin(30)*tan(30), -motor_d/2])
              rotate([0, 0, 60])
               cylinder(r=L*sin(30), h=motor_d, $fn=3, center=false); 
          translate([thickness, w_fm-extr*cos(15), -motor_d/2]) 
            scale([-1,-1,1])
              cube([L*sin(30)-diagonal*3/4, extr/2+motor_thickness, motor_d], center=false);
              }
 
        }
    }
	if (frame_type==1)
  {
    rotate([0,0,30]){
    // Motor center cutout#      s
    scale([1,-1,1])
       translate([-diagonal/2, -diagonal*1, 0]) 
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
    }
    if (frame_type!=1)
      // cutt off hole for v-type joint
        translate([-(L*sin(30)-diagonal*0.9), L-f1-diagonal*0.68, 0])
          rotate([0,0,60])
            cylinder(r=(extr/2+motor_thickness*3/4)*0.4+clear*2, h=h_motor_frame*2, center=true, $fn=3);
      //fix motor brasket screw in V-type joint
        translate([-(L*sin(30)-diagonal), L-f1-diagonal*0.68, 0])
            cylinder(r=1.6, h=h_motor_frame*2, center=true, $fn=26);    
                         

  }
}
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
module frame_motor_solid(){
difference() {
  union() {
          for (i=[-1,1]) {
            translate([diagonal/2*i,0,0])
              rotate ([0,0,-30*i])
                scale ([i,1,1])
                  frame_motor();  
            
          }
  translate ([0,0,-h_motor_frame/2+extr/2])
    corner(extr,h_motor_frame,frame_thickness,frame_type);
  rotate([0,0,45]) 
  //extrusion fix block
    intersection(){
      difference(){
        cylinder(r=W_roller+cone_radius_dwn,h=h_motor_frame,center=true);
        cube ([extr+extr_clr,extr+extr_clr,h_motor_frame+2 ], center=true);     
        }

      rotate(-45,0,0)
        translate([0,cone_radius_dwn,0])
          cylinder(r=diagonal/2+cone_radius_dwn,h=h_motor_frame+2,center=true, $fn=12);
      }
  //support frame 
    for (i=[-1,1]) {
      translate ([(diagonal/2+thickness)*i,extr*0.5,-h_motor_frame/2])
        rotate([0,0,270])
          cylinder(r=extr/2, h=h_motor_frame, $fn=3);
    }

  }
  //slot hole
  translate([-3/2,0,-(h_motor_frame+2)/2])
   rotate(270,0,0)
    cube([diagonal*2,slot_hole,(h_motor_frame+2)]);
  
//flexible cutt off
  for(i=[-1,1]) {
    translate ([-(diagonal/4)*i,0,0])
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
              rotate([90,0,180])
                teardrop(diagonal, 13, true, truncate = true);
           # translate([0,W_roller+extr/2,h_motor_frame/2])
             cube([diagonal,extr,h_motor_frame+5], center=true);    
//screw holes
if (h_motor_frame<(extr*1.5)){
        for (a = [1, -1]) {
                      
              translate([0,-(diagonal/2+m_frame_radius+m_frame_clr) , (h_motor_frame-extr)/2])
                rotate([90, 0, 0])
                 {
                 cylinder(r=m_frame_radius, h=4*extr, center=true, $fn=12);
                 translate([0, 0, radius-frame_thickness])
                   cylinder(r=m_frame_cap, h=extr*2/3, center=true, $fn=24);
                translate([0, 0, -(radius-frame_thickness)])
                   cylinder(r=m_frame_nut, h=extr*2/3, center=true, $fn=6);
                 }
               
          
        }
      }
else {
        for (a = [1, -1]) {
          for (b =[-1,1]) {
            translate([0,-(diagonal/2+m_frame_radius+m_frame_clr) , (h_motor_frame-extr)/2*(b)])
              rotate([0, 90, 0])
               {
                 cylinder(r=m_frame_radius, h=4*extr, center=true, $fn=12);
                 translate([0, 0, 5+extr/2])
                   cylinder(r=m_frame_cap, h=extr*2/3, center=true, $fn=24);
                 translate([0, 0, -(5+extr/2)])
                    cylinder(r=m_frame_nut, h=extr*2/3, center=true, $fn=6);
               }               
          }
        }
      }
  for(a=[-1,1])
    translate ([(diagonal/2+thickness)*a,extr*0.5,-h_motor_frame ])
      rotate([0,0,-90]) //rotate triangels around z-axis
        cylinder(r=extr*0.2, h=h_motor_frame*2 , $fn=3);

if (frame_type==10)  {    
  #rotate ([0,0,60]) 
    translate ([0,-(radius-frame_thickness/2+6/2),h_motor_frame/2-15/2+clear])
      cube([22*2,6+frame_thickness,15],center=true);   
  // HoneyWell ZM micro switch.
  #rotate ([0,0,-30]) { 
    translate([-5, -2+9.5/2, h_motor_frame/2-(m3_open_radius+2)])
      rotate([0,90,0])
        cylinder(r=1.3, h=50, center=false, $fn=60);
    translate([-5, -2-9.5/2, h_motor_frame/2-(m3_open_radius+2)]) 
      rotate([0,90,0])
        cylinder(r=1.3, h=50, center=false, $fn=60);
  }  
}
  }
}

///////////////////////////////////////////////////////////////////////////
///////////////////////motor joint/////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
module motor_joint ()
  
  difference (){
    union(){
    for (i=[-1,1]) {

      translate([diagonal/2*i,0,0])
        rotate ([0,0,-30*i])
          scale ([i,1,1]){         
            intersection() {
              translate([0, w_fm-extr*(cos(15)+1/5)+f3-L*sin(30)*tan(30), -motor_d/2])
                rotate([0, 0, 60])
                  cylinder(r=L*sin(30), h=motor_d, $fn=3, center=false); 
              color ("red"){
              union(){
              #  translate([-L*sin(30)+diagonal/3-clear, w_fm-extr*cos(15)+2, -motor_d/2]) 
                  scale([1,-1,1]) 
                    cube([L*sin(30)-diagonal*0.7-clear/2, extr/2+motor_thickness*3/4, motor_d], center=false);
                    
                  
                difference(){
                  //v-type joint
                  translate([-(L*sin(30)-diagonal*0.9), L-f1-diagonal*0.68, 0])
                    rotate([0,0,60])
                      cylinder(r=(extr/2+motor_thickness*3/4)*0.4-clear, h=h_motor_frame*2, center=true, $fn=3);
                      //fix motor brasket screw
                  translate([-(L*sin(30)-diagonal), L-f1-diagonal*0.68, 0])
                    cylinder(r=1.6, h=h_motor_frame*2, center=true, $fn=26);
                  }
              }}
            }
            //mickey mouse ears
            translate([-(L*sin(30)-diagonal*0.9), L-f1-diagonal*0.68, -(h_motor_frame+-layer_h*2)/2])
                      cylinder (r=10, h=layer_h*2,center=true, $fn=26);
          }            
    }
  color ("red"){
    translate([0,diagonal/2+motor_offset-(thickness)-clear,0])
      cube([motor_width,thickness*2,h_motor_frame],center=true);  
  }
//  for (i=[-1,1]) 
  // translate()
  }

      // Motor center cutout
  color ("red"){
    translate([0,diagonal/2+motor_offset-(thickness)/2-clear,0])      
      rotate ([90,0,0])  
        teardrop(diagonal/2, motor_screws/2,true);        

  
    // Motor mounting screw holes.
   for(i=[-1,1])
   translate ([motor_screws/2*i,0,0])      
    rotate([0,0,0]) 
      for (z = [-1, 1]) {
        translate([-diagonal/2+motor_screws/2, L-f1-diagonal/2, z*motor_screws/2])
          rotate([90, 0, 0])
           cylinder(r=m3_open_radius, h=diagonal, center=true, $fn=12);
        translate([motor_screws/2-diagonal/2, L-f1-diagonal/2-motor_thickness, z*motor_screws/2])
          rotate([90, 0, 0])
            cylinder(r=m3_cap, h=diagonal/2, center=false, $fn=24);
             }
  } 
}

//insert module frame_cheek
if (frame_motor_output==2) {
     scale(1,1,1)
    frame_motor();
   }  
if (frame_motor_output==3) {
  //estp_sw=1;
  rotate ([0,0,180])
    scale(-1,1,1) 
      frame_motor();    
   } 
if (frame_motor_output==1){
  frame_motor_solid();
  motor_joint();
}
if (frame_motor_output==11){
  frame_motor_solid();
  rotate([0,0,0])
  translate([diagonal*1.0,diagonal/3,0])
  rotate([0,0,40])
  motor_joint();
}

if (frame_motor_output==12){
  frame_motor_solid();
}
if (frame_motor_output==13){
   motor_joint();
}



//frame_motor_solid ();
//motor_joint();
// scale([-1, 1, 1]) frame_motor();

// OpenBeam.
// % rotate([0, 0, 45]) cube([extr, extr, 100], center=true);

// NEMA17 stepper motor.
// translate([0, motor_offset+30, 0])
// % cube([motor_width, 60, motor_width], center=true);
