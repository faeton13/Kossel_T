include <configuration.scad>;
use <libraries/frame_axis_block.scad>;
use <corner.scad>;
use <tensioner_608.scad>;


//extr=25;
h_up_frame  = motor_d;
w_up_frame = w_fm+10;
diagonal = extr*sqrt(2);
estp_sw=1; //put 1 to enable enstop holes
double_frame=1; //put 1 to enable dual_frame option

estp_out = 15; //distance between lower frame and endstop hole(works only if dual_frame on)
h_tensioner=22;

frame_cheek_output=12;

//frame cheek output:
//1 - for sqear tube version assembled
// - for  sqear tube:
//11 - printing plate
//12 - corner only
//13 - tensioner only
//2 - for separate right cheek
//3 - for separate left cheek
//4 - assembled version.


module frame_cheek(double_frame,estp_sw)
 for (i=[-1,1])
  difference ()  {
    union () {
      frame_axis_block(h_up_frame, w_up_frame, thickness, extr, diagonal, frame_type, extr*0.9, extr/2,m_frame_open*2,layer_h);
        if (frame_type==1){
          if (double_frame==1) { //small addon to parts width in oder to fit endstop under lower frame if "dual frame" is on
            if (estp_sw==1) {
              intersection() {
                translate([-extr*sin(15), -extr*cos(15), h_up_frame /2], center=false)
                  cube([extr*sin(15)+thickness, extr*cos(15)+estp_out, estp_out]);
                difference() {
                  union (){
                    translate([-extr*sin(15), -extr*cos(15), h_up_frame /2])
                      rotate([0,0,-15])
                        cube([extr, extr*cos(15)+20 , estp_out], center=false); //15degr extr cutout
                    translate([0, -extr*cos(15), h_up_frame /2], center=false)
                      cube([thickness, extr*cos(15)+estp_out , estp_out]);
                  }
                  translate([-thickness/2, estp_out, h_up_frame /2+estp_out]) rotate([0, 90, 0]) 
                    cylinder(r=estp_out, h=thickness*2, center=false, $fn=60);
                }
              }
            }
          }
      }
    }
     if(frame_type==1){
       if (double_frame==1) { 
         if ( estp_sw == 1) {
           //// HoneyWell ZM micro switch holes
           translate([-5, -extr*cos(15)/2+9.5/2, h_up_frame /2-extr/4+estp_out]) rotate([0, 90, 0]) 
             cylinder(r=1.3, h=50, center=false, $fn=60);
           translate([-5, -extr*cos(15)/2-9.5/2, h_up_frame /2-extr/4+estp_out]) rotate([0, 90, 0]) 
             cylinder(r=1.3, h=50, center=false, $fn=60);}
       }
        else {
           if (estp_sw==1) {
           //// HoneyWell ZM micro switch.
           translate([-5, -extr*cos(15)/2+9.5/2, h_up_frame/2-extr/4]) rotate([0, 90, 0]) 
             cylinder(r=1.3, h=50, center=false, $fn=60);
           translate([-5, -extr*cos(15)/2-9.5/2, h_up_frame /2-extr/4]) rotate([0, 90, 0]) 
             cylinder(r=1.3, h=50, center=false, $fn=60);
           }  
         }         
     }
     else {
      if (estp_sw==1) {
        //// HoneyWell ZM micro switch.
        translate([-5, -extr*cos(15)/2+9.5/2, h_up_frame /2-(m3_open_radius+2)]) rotate([0, 90, 0]) 
          cylinder(r=1.3, h=50, center=false, $fn=60);
        translate([-5, -extr*cos(15)/2-9.5/2, h_up_frame /2-(m3_open_radius+2)]) rotate([0, 90, 0]) 
          cylinder(r=1.3, h=50, center=false, $fn=60);
          }  
         }

       //hole cuttoff
    rotate([0, 90, 0]) 
    if (double_frame==1) {
      if (h_up_frame  > (w_up_frame-extr*cos(15))  ) {
        translate([0, (w_up_frame  -extr*cos(15))/2, -thickness])
          cylinder(r=(h_up_frame -extr*2)/2, h=extr, center=true, $fn=60);}
      else {
        translate([0, (w_up_frame-extr*cos(15))/2+extr/8, -thickness])
          cylinder(r=(h_up_frame -extr)/2, h=extr, center=true, $fn=60);}
    }
    else {
      if (h_up_frame  > (w_up_frame-extr*cos(15))  )  {
          translate([h_up_frame /2-w_up_frame  , w_up_frame  -extr*cos(15), -thickness])
            cylinder(r=w_up_frame  -extr, h=extr, center=true, $fn=60);
          translate([h_up_frame /2-w_up_frame  , w_up_frame  , -extr/2]) rotate (180,0,0)
            cube([h_up_frame ,w_up_frame  ,extr]);
          }
        else {
           translate([-h_up_frame /2, h_up_frame -extr*cos(15), -thickness])
             cylinder(r=h_up_frame -extr, h=extr, center=true, $fn=60);
           translate([-h_up_frame /2, h_up_frame -extr , -thickness])  rotate (0,0,0)
             cube([h_up_frame -extr*cos(15),w_up_frame  ,extr]);
        }
       
    }
 }




//translate([-extr*sin(15),-extr*cos(15), -150])
    // extrusion.
  //% rotate([0, 0, 75]) cube([extr, extr, 300], center=false);

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

module frame_cheek_tube ()
for (i=[-1,1])
difference() {
  union() {
           
            translate([diagonal/2*i,0,0])
              rotate ([0,0,-30*i])
                scale ([i,1,1])
                  frame_cheek(1,i);  
    
    intersection()
     {
        rotate([0,0,127])
          translate([W_roller+thickness+9,0,-(h_up_frame-thickness*2)/2])
            {rotate([0,0,27+90*i])
             cube([14,W_roller*4,thickness*2],center=true);
             }
    /// remove ou
     rotate([0,0,30])
       translate([0,w_up_frame/2,0])
         cube([(radius-frame_thickness)*2,w_up_frame,h_up_frame+2],center=true);
      }
        
        
          translate ([0,0,(extr-h_up_frame)/2])
            corner(extr,h_up_frame ,frame_thickness,frame_type);
             
    //tube fix block
    rotate([0,0,45]) 
          //extrusion fix block
      intersection(){
        cylinder(r=W_roller+cone_radius_dwn,h=h_up_frame,center=true);
        rotate([0,0,-45])
          translate([0,cone_radius_dwn,0])
            cylinder(r=diagonal/2+cone_radius_dwn,h=h_up_frame+2,center=true, $fn=12);
      }

   //support frame 
     
              translate ([diagonal/2*i,extr*0.4,-h_up_frame /2])
                rotate([0,0,270])
                  cylinder(r=extr*0.4, h=h_up_frame , $fn=3);
  
}
        rotate([0,0,127])
          translate([W_roller+thickness+9,0,-(h_up_frame-thickness*2)/2])
            //m3_screw hole
             cylinder(r=m3_open_radius,h=h_up_frame*2,center=true,$fn=16);


/// V-slots for tensioners
              for(i=[1,-1])
              { rotate ([0,0,145*i])
                  translate ([0,-(W_roller+cone_radius/2),0])
                    rotate([0,0,30])
                     cylinder(r=thickness+3*clear,h=h_up_frame*2, center=true, $fn=3);
              }
/// space for extrusion cutt off              
              rotate([0,0,45])
                cube ([extr+extr_clr,extr+extr_clr,h_up_frame*2 ], center=true);
  for(i=[-1,1]) {
  translate([-2/2,0,-h_up_frame])
   rotate(270,0,0)
    cube([diagonal*2,2,h_up_frame*2]);
  
    translate ([-diagonal/2*i,0,-h_up_frame])
      
        cylinder (r=2,h=h_up_frame*2, $fn=16);
    translate ([-diagonal/4*i,0,0])
      
        cube ([diagonal/2,4,h_up_frame+4], center=true);
   }
 
      //cutt_off holles for tube joint
      for(a=[-1,1]) {
      if (h_up_frame<(extr*1.5)){
        
                      
              translate([0,-(diagonal/2+m_frame_radius+m_frame_clr) , (h_up_frame-extr)/3-2])
                rotate([90, 0, 0])
                 {
                 cylinder(r=m_frame_radius, h=4*extr, center=true, $fn=12);
                 translate([0, 0, radius-frame_thickness])
                // union()
                // {
                  cylinder(r=m_frame_cap, h=extr*2/3, center=true, $fn=24);
                //  scale(-1,1,1)
                  //  translate ([-m_frame_cap,0,-extr/3])
                    //  cube ([m_frame_cap*2,m_frame_cap*8,extr*2/3]);
               //  }
                  
                translate([0, 0, -(radius-frame_thickness)])
               //  union(){
                  cylinder(r=m_frame_nut, h=extr*2/3, center=true, $fn=6);
                 // scale(-1,1,1)
                 //   translate ([-m_frame_cap,0,-extr/3])
                   //   cube ([m_frame_cap*2,m_frame_cap*8,extr*2/3]);
                 //}
                 }
               
          
      
      }
      else {
                 translate([0,-(diagonal/2+m_frame_radius) , (h_up_frame-extr)/3*(a)-2])
              rotate([0, 90, 0])
                {
                 cylinder(r=m_frame_radius, h=2*extr, center=true, $fn=12);
                 translate([0, 0, (5+extr/2)]) 
               //  union()
               //  {
                  cylinder(r=m_frame_cap, h=extr*2/3, center=true, $fn=24);
              //    scale(-1,1,1)
              //      translate ([-m_frame_cap,0,-extr/3])
                //      cube ([m_frame_cap*2,m_frame_cap*8,extr*2/3]);
                // }
                   
                 translate([0, 0, -(5+extr/2)]) 
            //     union(){
                  cylinder(r=m_frame_nut, h=extr*2/3, center=true, $fn=6);
              //    scale(-1,1,1)
                //    translate ([-m_frame_cap,0,-extr/3])
                  //    cube ([m_frame_cap*2,m_frame_cap*8,extr*2/3]);
               //  }

               }               
          }
     
      }
  for(a=[-1,1])
    translate ([(diagonal/2+thickness/2)*a,extr*0.4,-h_up_frame ])
      rotate([0,0,-90]) //rotate triangels around z-axis
        cylinder(r=extr*0.2, h=h_up_frame*2 , $fn=3);
  if (frame_type==0) {     
   rotate ([0,0,60]) 
          translate ([0,-(radius-frame_thickness/2+6/2),h_up_frame/2-15/2+clear])
          cube([22*2,6+frame_thickness,15],center=true);   
        //// HoneyWell ZM micro switch.
    rotate ([0,0,-30]) { 
        translate([-5, -2+9.5/2, h_up_frame/2-(m3_open_radius+2)])
      rotate([0,90,0])
            cylinder(r=1.3, h=50, center=false, $fn=60);
      translate([-5, -2-9.5/2, h_up_frame/2-(m3_open_radius+2)]) 
      rotate([0,90,0])
            cylinder(r=1.3, h=50, center=false, $fn=60);
          }
  }
  }
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//tensioner block
module tensioner() {
 for (i=[-1,1]) {
  union(){
    difference(){
      cylinder(r=W_roller+cone_radius_dwn+extr_clr/2+thickness,h=h_tensioner,center=true);
      cylinder(r=W_roller+cone_radius_dwn+extr_clr/2+0*clear,h=h_tensioner+4,center=true);
      rotate([0,0,-45])
          translate ([0,-(W_roller+cone_radius_dwn+extr_clr+thickness),0])
            cube([(W_roller+cone_radius_dwn+extr_clr+thickness)*2,2*(W_roller+cone_radius_dwn+extr_clr+thickness),h_tensioner+4],center=true);
      rotate([0,0,45])
          translate ([0,-(W_roller+cone_radius_dwn+extr_clr+thickness),0])
            cube([(W_roller+cone_radius_dwn+extr_clr+thickness)*2,2*(W_roller+cone_radius_dwn+extr_clr+thickness),h_tensioner+4],center=true);
       translate([0,W_roller+cone_radius+extr_clr+thickness+3/2,0])
         cube([diagonal,thickness*2,40],center=true);
      translate([0,W_roller+cone_radius+thickness+extr_clr,-4]) 
        rotate([0,90,90]) 
          cylinder (r=4+clear,h=18+4,center=true,$fn=32);
    }
    rotate([0,0,145*i])
      translate ([0,-(W_roller+cone_radius/2),0])
        rotate([0,0,30])
          cylinder(r=thickness,h=h_tensioner, center=true, $fn=3);      

    translate([0,W_roller+thickness+8,-4]) 
      rotate([0,180,90]) 
        tensioner_608();
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
  translate([0,0,(22-4)/2])
  tensioner();
}
if (frame_cheek_output==11){
  frame_cheek_tube();
  translate([0,diagonal/2,-(h_up_frame-22)/2])
 rotate ([0,180,-10])
  tensioner();
}

if (frame_cheek_output==12){
  frame_cheek_tube();
}
if (frame_cheek_output==13){

  translate([0,diagonal/2,-(h_up_frame-22)/2])
 rotate ([0,180,-10])
  tensioner();
}
