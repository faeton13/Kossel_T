include <configuration.scad>;


//extr=15; //extrusion squear size
extr_cl_dist=1.5; // extrusion clearence distance
cone_radius = 5;
cone_radius_dwn = 4;
rod_offset=extr+5; //(25)
shrink_wrap = 0.1; // mm thickness
h_base=6;
H_roller=diagonal/2+extr_cl_dist+h_base;
W_roller=diagonal/2+extr_cl_dist+m3_radius;
layer_h=0.35;

Roller_output=2; 
//output option:
//1 - for right and lefr rollers
//2 - for assembled
//3/4 - for right or left only



///////////////////////////////////////////////////////////////////////////////
module 623_bearings (r1_623,r2_623,t_623,d_623) {
  for (i=[0,1,2]){
    translate ([0,0,h_base-6])
      rotate ([0,45*(cos(180*i)),0]) translate([0, extr*(i-1), 1*d_623+2])
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
            
              for (z = [-extr / 2, extr / 2]) {
                // Big round ends.
                rotate([90, 0, 0])
                 { 
                   
                   translate([0, z, 0])
                    difference() {             
                       cylinder(h=h_base, r=W_roller, center=false, $fn=36);
                       translate ([-extr,z*2,h_base/2])
                         cylinder(r=extr*1, h=h_base+5,center=true, $fn=12);
                    }

                   // Screw guide tubes.
                   translate([-W_roller, z, 0]) 
                     cylinder(r1=cone_radius+0.5, r2= cone_radius_dwn , h=H_roller, center=false);
                   translate([W_roller, z, 0])
                     cylinder(r1=cone_radius+0.5, r2= cone_radius_dwn , h=H_roller , center=false);
                 }
                // Diagonal guide ramps.
                translate([-W_roller, -(H_roller), z-3]) 
                  cube([W_roller*2, H_roller, 6], center=false);
              }
 
              // Waist.
               translate([0, -h_base/2, 0])
                cube([(W_roller+cone_radius_dwn)*2, h_base, extr], center=true); 
            }        
      
           // Space for 623 bearings with shrink wrap.
            rotate([90,0,0]) 
              623_bearings(6+shrink_wrap,6+shrink_wrap,50,5);     
        }
      


        // Mounting surfaces for 623 bearings.
       rotate([90,0,0]) 623_bearings (5,4,extr/3,0);
     }

      //extra cutt_off
      translate([0,-H_roller/2,0])
        cube ([(W_roller+cone_radius_dwn)*2 ,H_roller, (extr+3)*2], center=true);
        
     
    
  }

        // Connect guide tubes vertically.
      
        translate([-0, -(H_roller), -extr/2])
          cube([W_roller+cone_radius_dwn , H_roller, extr], center=false);
        // Attachment for diagonal rods.
        translate([rod_offset, 0, extr/2]) {
          rotate([90, 0, 0])
            cylinder(r1=7/2, r2=cone_radius, h=12, center=false, $fn=20);
          translate([-rod_offset+extr,-12, -7/2])
            cube([rod_offset-extr, 12, 7], center=false);
        }
      }
     
    
  

    // M3 screws for 623 bearings.
    rotate([90,0,0]) 623_bearings (m3_radius,m3_radius,extr*3,-extr);
    // Inside space for OpenBeam.
    color([1, 0, 0]) translate ([0,-diagonal/2-h_base-extr_cl_dist ,0]) rotate([0, 0, 45])
      cube([extr+extr_cl_dist, extr+extr_cl_dist, 120], center=true);
    
    
    
    // Screw holes.
    for (z = [-extr/2, extr/2]) {
      for (z2 = [-W_roller,W_roller]){
        translate([z2, -5/2-layer_h, z]) rotate([90, 0, 0])
	        cylinder(r=(m3_radius+m3_clr), h=80, center=false, $fn=12);
        translate([rod_offset, 1, z]) rotate([90, 0, 0])
	        cylinder(r=(m3_radius+m3_clr), h=25, center=false, $fn=12);
        translate([rod_offset, -10, z]) rotate([90, 0, 0])
	        cylinder(r=m3_nut_radius, h=10, center=false, $fn=6);
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
      // Adjustable endstop screw.
     
     intersection() {
	      translate([h_base/2, -W_roller/2, extr/2]) 
	        cylinder(r1=4, r2=cone_radius, h=extr/2+3, center=false);
	      translate ([0,-(extr*4+rod_offset)/2,-5/2*extr])
         cube([H_roller, extr*4+rod_offset, 5*extr], center=false);
      }
    }
    // Fishline attachment in the front.
    translate([12, diagonal, 0])  rotate([90, 0, 0])
      cylinder(r=m3_radius, h=30, center=false, $fn=12);

    // Adjustable endstop screw.
    translate([h_base/2, -W_roller/2, extr]) {
       cylinder(r=m3_radius, h=extr*4, center=true, $fn=12);
       cylinder(r=m3_nut_radius, h=4, $fn=6);
    }
    // Four nyloc nuts.
    for (x = [1, -1]) {
      rotate([0,0,90])
        translate([W_roller*x, 0, extr/2*x]) rotate([90, 0, 0])
	        cylinder(r=m3_nut_radius+clear, h=5, center=true, $fn=6);
    
    for (z = [-1, 1]) {
      rotate ([0,0,90])
       translate([W_roller*(-z), 0, extr/2*z]) rotate([90, 0, 0])
          cylinder(r=m3_cap, h=5, center=true, $fn=16);
    }
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
    for (x = [1, -1]) {
        translate([W_roller*x, 0, extr/2*(-x)]) rotate([90, 0, 0])
          cylinder(r=m3_nut_radius+clear, h=5, center=true, $fn=6);
    }
    for (z = [1, -1]) {
       translate([W_roller*(z), 0, extr/2*(z)]) rotate([90, 0, 0])
          cylinder(r=m3_cap, h=5, center=true, $fn=16);
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
//translate([-23, 0, 19])
///translate([0,-H_roller*2,0]) rotate([180, 0, 90]) 
//rotate([180,-90,-90]) translate([0,5/2*extr,0])
  //roller_left();
//rotate ([0,0,0])
// rotate([-90,0,0]) roller_right();
//translate([23, 0, 19]) rotate([-90, 0, 180]) roller_right();
