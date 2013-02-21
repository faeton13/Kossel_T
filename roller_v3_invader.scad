include <configuration.scad>;


//extr=15; //extrusion squear size
extr_cl_dist=1.1; // extrusion clearence distance
cone_radius = 5;
cone_radius_dwn = 4;
shrink_wrap = 0.1; // mm thickness
h_base=7;
H_roller=diagonal/2+extr_cl_dist+h_base;
W_roller=diagonal/2+extr_cl_dist+m3_radius;
rod_offset=W_roller; //(25)
layer_h=0.4;

Roller_output=1; 
//output option:
//1 - for right and lefr rollers plate
//2 - for assembled
//3/4 - for right or left only
//5 - for solid version

///////////////////////////////////////////////////////////////////////////////
module estop_scr(){
        translate([5,-(m3_radius+m3_clr)*2,0])
        intersection() {
          difference() {
            translate([h_base/2, W_roller, 0]) 
              union(){
                cylinder(r=5, h=extr/2+cone_radius, center=false);
                rotate([0,90,180]) translate([0,0,m3_radius])
                  cylinder(r1=extr*0.8,r2=extr*0.4, h=5+h_base/2-m3_radius ,center=false);
                translate([-m3_radius,0,0]) rotate([0,0,-90])
                    cube([W_roller,10,extr/2+cone_radius]);
              }
            translate([h_base, 1/2, extr/2+5])
              rotate([0,90,180])
               cylinder(r=W_roller-cone_radius, h=h_base*2,center=false);
            translate([h_base+(W_roller-cone_radius)/2+4, (m3_radius+m3_clr)*2, -1])
              rotate([0,0,90])
               cylinder(r=W_roller-cone_radius+4, h=h_base*2,center=false);
          // Adjustable endstop screw.
          translate([h_base/2, W_roller, -extr/2-m3_radius]) 
            cylinder(r1=m3_radius, r2=m3_radius, h=extr*2, center=false, $fn=16);
          translate([h_base/2, W_roller, extr/2]) 
            cylinder(r=m3_nut_radius, h=4, center=false, $fn=6);
          translate([-5,W_roller+m3_radius*3,0]) rotate([90,0,90])
           cylinder(r=m3_radius*5/2, h=extr*2, center=false, $fn=16);

          }     
        translate ([-5,(cone_radius_dwn) ,0])
          cube([h_base+5, (W_roller), (W_roller-cone_radius)], center=false);
        }
      }

///////////////////////////////////////////////////////////////////////////////
module 623_bearings (r1_623,r2_623,t_623,d_623) {
  for (i=[0,1,2]){
    translate ([0,0,h_base-5.8])
      rotate ([0,45*(cos(180*i)),0]) translate([0, extr*(i-1), 1*d_623])
        cylinder(r1=r1_623, r2=r2_623, h=t_623, center=false, $fn=12);
  } 
}
///////////////////////////////////////////////////////////////////////////////
module roller() {
  // OpenBeam.
  // % rotate([0, 0, 45]) cube([extr, extr, 120], center=true);
  difference() {
    union() {
      intersection() {
        union(){
        difference() {
          union() {
            
              for (z = [0,1,2]) {
                for (u=[-1,1]) {
                // Big round ends.
                rotate([90, 0, 0])
                 { 
                   //Base
                   translate([0, (u*extr/3), 0])
                    difference() {             
                       cylinder(h=h_base, r=W_roller, center=false, $fn=35);
                       translate ([extr, ((u)*extr/2)*1.5,h_base/2])
                         cylinder(r=extr*0.9, h=h_base+5,center=true, $fn=12);
                    }
                
                   // Screw guide tubes.
                   translate([W_roller*(-cos(180*z)), ((z-1)*extr/2), 0]) 
                     cylinder(r1=cone_radius+0.5, r2= cone_radius_dwn , h=H_roller, center=false);
              //     translate([W_roller, ((z-1)*extr/2), 0])
                //     cylinder(r1=cone_radius+0.5, r2= cone_radius_dwn , h=H_roller , center=false);
                    
                 }
                 }
                // Diagonal guide ramps.
                translate([W_roller*(-cos(180*z)), -(H_roller), ((z-1)*extr/2)-4]) 
                 scale([cos(180*z),1,1])  
                   cube([W_roller, H_roller, 8], center=false);
              }
              // Connect guide tubes vertically.     
              scale([1,-1,-1])  

              translate([-W_roller-cone_radius_dwn , 0, -extr/2])
                cube([W_roller/2 , H_roller*0.6 , extr], center=false);
            }        
    
           // Space for 623 bearings with shrink wrap.
            rotate([90,0,0]) 
              623_bearings(6+shrink_wrap,6+shrink_wrap,extr*2,5);     
        }

        // Attachment for diagonal rods.
        translate([-rod_offset, 0, extr]) {
          rotate([90, 0, 0])
            difference(){
              #union(){
                cylinder(r1=9/2 , r2=cone_radius, h=12, center=false, $fn=20);
                rotate([180,0,45])
                 translate([-cone_radius_dwn,0,-12])
                    cube([cone_radius_dwn*2, rod_offset*0.7, 12], center=false);
              }
              translate([0, 0, -1])
                cylinder(r=(m3_radius+m3_clr), h=25, center=false, $fn=12);
              translate([0, 0, 9])
                 cylinder(r=m3_nut_radius, h=4, center=false, $fn=6);
          }
        }
      


        // Mounting surfaces for 623 bearings.
       rotate([90,0,0]) 623_bearings (6,3,extr/3,0);
     }
      
      //extra cutt_off
      translate([0,-H_roller/2,0])
        cube ([(W_roller+cone_radius_dwn)*2 ,H_roller, (extr+3)*2], center=true);
      
      
     
    
   }

  } 
     
   if (Roller_output==5) {
     //one end cutt_off
      translate([0,-H_roller-1,-extr/2])
        cube ([(W_roller+cone_radius_dwn)+2 ,(H_roller+1)-h_base , (extr/2)*2], center=false);
    }  
    
  

    // M3 screws for 623 bearings.
    rotate([90,0,0]) 623_bearings (m3_radius+m3_clr ,m3_radius,extr*3,-extr);
    // Inside space for OpenBeam.
    color([1, 0, 0]) translate ([0,-diagonal/2-h_base-extr_cl_dist ,0]) rotate([0, 0, 45])
      cube([extr+extr_cl_dist, extr+extr_cl_dist, 120], center=true);
        
    // Screw holes.
   # for (z = [0,1,2]) {
      for (z2 = [-W_roller,W_roller]){
        translate([-W_roller*cos(180*z), -5/2-layer_h, ((z-1)*extr/2)]) 
          rotate([90, 0, 0])
	          cylinder(r=(m3_radius+m3_clr), h=80, center=false, $fn=12);
        
      }
    }

  }
  // 623zz ball bearings with shrink wrap.
  %rotate([90,0,0]) 623_bearings (5+shrink_wrap,5+shrink_wrap,4,extr/3);
  }
///////////////////////////////////////////////////////////////////////////////
module roller_left() {
  scale([1, 1, -1])
   difference() {
    union() {
     rotate([0,0,90]) roller();

     // Fishline attachment in the front base
    translate([12, -(W_roller+cone_radius_dwn), extr/2+2*m3_radius]) 
     rotate([90, 0, -0])
      scale([1,1,-1]) {
        difference(){
          cylinder(r=cone_radius_dwn , h=12, center=false, $fn=12);
          translate([cone_radius_dwn,-cone_radius_dwn-m3_radius,-1/2]) 
             rotate([0,0,90]) 
               cube ([cone_radius_dwn,cone_radius_dwn*2,10+1]);
        } 
      translate([-12,0,0]) cube([12,5,11]); //check
    }


      // Adjustable endstop screw.
      estop_scr();
      scale([1,1,-1]) estop_scr();
    }
    // Fishline attachment in the front.
    translate([12, -(W_roller+cone_radius_dwn)-1, extr/2+2*m3_radius])
      rotate([90, 0, 180])
       cylinder(r=m3_radius, h=13, center=false, $fn=12);

#      translate([5+h_base/2,W_roller-(m3_radius+m3_clr)*2,-extr])
                  // Adjustable endstop screw.
         // translate([, , ]) 
            cylinder(r1=m3_radius, r2=m3_radius, h=extr*2, center=false, $fn=16);
    
 
    

    for (x = [0,1,2]) {
      rotate([0,0,90])
        translate([-W_roller*cos(180*x), 0, extr/2*(x-1)]) rotate([90, 0, 0])
          cylinder(r=m3_nut_radius+clear, h=5, center=true, $fn=12);
    }
  }
}
////////////////////////////////////////////////////////////////////////////////
module roller_right() {
  difference() {
    roller();
    // Four M3x35 screws.
  //  for (z = [-1, 1]) {
     // for (x = [-(diagonal+cone_radius_dwn)/2,(diagonal+cone_radius_dwn)/2]) {
	//#translate([(diagonal+cone_radius_dwn)/2*z, 0, diagonal/2*z]) rotate([90, 0, 0])
	  //cylinder(r=m3_cap, h=10, center=true, $fn=12);
    //}
    for (x = [0,1,2]) {
        translate([-W_roller*cos(180*x), 0, extr/2*(x-1)]) rotate([90, 0, 0])
          cylinder(r=m3_nut_radius+clear, h=5, center=true, $fn=6);
    }
    
    // Avoid scratching the returning fishline.
   // translate([-35, 5, diagonal/2]) rotate([0, 0, 45])
     // cube([20, 20, 20], center=true);
  }
}

//////////////////////////////////////////////////////////////////////////////////
if (Roller_output == 1) {
  rotate([180,-90,-90]) translate([0,5/2*extr,0])
    roller_left();
  rotate([-90,0,0]) roller_right();
}

if (Roller_output == 2) {
rotate([180,0,90]) translate([-H_roller,0,0])
  roller_left();
translate([0, H_roller, 0])
  roller_right();
% rotate([0, 0, 45]) cube([extr, extr, 120], center=true);
}
if (Roller_output == 3) {
  rotate([-90,0,0]) roller_right();
}
if (Roller_output == 4) {
  rotate([180,-90,-90]) roller_left();
  }

if (Roller_output == 5) {
rotate([0,-90,0]){
rotate([180,0,90]) translate([-H_roller,0,0])
  roller_left();
translate([0, H_roller, 0])
  roller_right();
}}
//translate([-23, 0, 19])
///translate([0,-H_roller*2,0]) rotate([180, 0, 90]) 
//rotate([180,-90,-90]) translate([0,5/2*extr,0])
  //roller_left();
//rotate ([0,0,0])
// rotate([-90,0,0]) roller_right();
//translate([23, 0, 19]) rotate([-90, 0, 180]) roller_right();
