include <configuration.scad>;
use <libraries/frame_axis_block.scad>;


//extr=15;
h = 3*extr;
w = 4*extr;
diagonal = extr*sqrt(2);
estp_sw=1; //put 1 to enable enstop holes
double_frame=1; //put 1 to enable dual_frame option
estp_out = 15; //distance between lower frame and endstop hole(works only if dual_frame on)

frame_cheek_output=1;
//frame cheek output:
//1 - for sqear tube version
//2 - for separate right cheek
//3 - for separate left cheek
//4 - assembled version.


module frame_cheek(double_frame,estp_sw)
{
  difference ()  {
   //rotate ([0,0,-30])
    union () {
      frame_axis_block(h, w, thickness, extr, diagonal);
      if (double_frame==1) { //small addon to parts width in oder to fit endstop under lower frame if "dual frame" is on
       if (estp_sw==1) {
         intersection() {
              translate([-extr*sin(15), -extr*cos(15), h/2], center=false)
                cube([extr*sin(15)+thickness, extr*cos(15)+estp_out, estp_out]);
            difference() {
              union (){
                translate([-extr*sin(15), -extr*cos(15), h/2])
                   rotate([0,0,-15])
                   cube([extr, extr*cos(15)+20 , estp_out], center=false); //15degr extr cutout
                translate([0, -extr*cos(15), h/2], center=false)
                   cube([thickness, extr*cos(15)+estp_out , estp_out]);
              }
              translate([-thickness/2, estp_out, h/2+estp_out]) rotate([0, 90, 0]) 
                cylinder(r=estp_out, h=thickness*2, center=false, $fn=60);
            }
       }

      }
    }
    }
    if (double_frame==1) { 
      if ( estp_sw == 1) {
        //// HoneyWell ZM micro switch holes
        translate([-5, -extr*cos(15)/2+9.5/2, h/2-extr/4+estp_out]) rotate([0, 90, 0]) 
          cylinder(r=1.3, h=50, center=false, $fn=60);
        translate([-5, -extr*cos(15)/2-9.5/2, h/2-extr/4+estp_out]) rotate([0, 90, 0]) 
          cylinder(r=1.3, h=50, center=false, $fn=60);}
      }
      else {if (estp_sw==1) {
      //// HoneyWell ZM micro switch.
        translate([-5, -extr*cos(15)/2+9.5/2, h/2-extr/4]) rotate([0, 90, 0]) 
          cylinder(r=1.3, h=50, center=false, $fn=60);
        translate([-5, -extr*cos(15)/2-9.5/2, h/2-extr/4]) rotate([0, 90, 0]) 
          cylinder(r=1.3, h=50, center=false, $fn=60);}  
        }
  

       //hole cuttoff
    rotate([0, 90, 0]) 
    if (double_frame==1) {
      if (h > w) {
        translate([0, w-extr*cos(15), -thickness])
          cylinder(r=(h-extr*2)/2, h=extr, center=true, $fn=60);}
      else {
        translate([0, (w/2-extr*cos(15)+extr/2), -thickness])
          cylinder(r=(w-extr*2)/2, h=extr, center=true, $fn=60);}
    }
    else {
      if (h > w)  {
          translate([h/2-w, w-extr*cos(15), -thickness])
            cylinder(r=w-extr, h=extr, center=true, $fn=60);
          translate([h/2-w, w, -extr/2]) rotate (180,0,0)
            cube([h,w,extr]);
          }
        else {
           translate([-h/2, h-extr*cos(15), -thickness])
             cylinder(r=h-extr, h=extr, center=true, $fn=60);
           translate([-h/2, h-extr , -thickness])  rotate (0,0,0)
             cube([h-extr*cos(15),w,extr]);
        }
    }
 }
}
module frame_cheek_tube () {
  union () {
    for (i=[-1,1]) {
     translate ([diagonal/2*i,0,0]) 
       rotate ([0,0,-30*i]) 
         scale ([i,1,1])
           union (){
             translate ([0,0,-h/2])
               rotate ([00,0,165])
                 translate([0,-thickness,0])
                 cube ([extr+thickness,thickness,h]);
             frame_cheek(double_frame,i);

             translate([0,(-extr*cos(15)),-h/2])
               rotate([0,0,-150]) translate ([thickness,0,0])
               cube([(extr*sin(15)+thickness),20,h]);
           }
    }

  } 
}


//insert module frame_cheek
if (frame_cheek_output==2) {
     scale(1,1,1)
    frame_cheek();
   }  
if (frame_cheek_output==3) {
  //estp_sw=1;
  rotate ([0,0,180])
    scale(-1,1,1) 
      frame_cheek();    
   } 
if (frame_cheek_output==1){
  frame_cheek_tube();
}
//translate([-extr*sin(15),-extr*cos(15), -150])
    // extrusion.
  //% rotate([0, 0, 75]) cube([extr, extr, 300], center=false);
