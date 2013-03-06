include <configuration.scad>;
use<libraries/frame_axis_block.scad>;

//extr=15;
//frame_thickness=6;
//bracket = 5;
//frame_type=0; //type 0 solid or 1 for sepparate parts

module corner(extr,h,frame_thickness,frame_type) {
radius = thickness+cos(30)*diagonal/2+frame_thickness;  
  union(){
  difference() {
      intersection () {
        translate([0, extr/4, (h-extr)/2]) rotate([90,0,0])
          cube([diagonal+extr*1.8,h,diagonal+extr*1.8], center=true);
        translate([0, 0, (h-extr)/2])
          cylinder(h=h, r=radius, center=true, $fn=32);
      }
    
  // Remove 2/3 of cylinder.
    for (i=[-1,1])
    rotate([0,0,30*i])
    translate([0, radius, 0])
      cube([2*radius, 2*radius, 2*h], center=true);
  // Center round.
    
    rotate([0, 0, 45])
      cylinder(r=diagonal/2+0.5, h=2*h, center=true);
  // Horizontal OpenBeam frame pieces.
  for(i=[-1,1]) {
    rotate([0, 0, -30*i]) 
      translate([(radius-frame_thickness/2)*i, 40, (h-extr)/2])
        cube([frame_thickness+0.1, 60, h+1], center=true);
    
  // Frame brackets under the corner.
 
  translate([diagonal/2*i, 0, (h-extr)/2])
   rotate([0, 0, -30*i]) 
    scale([i,1,1]) frame_axis_block(h+1,diagonal*2,thickness,extr,diagonal,frame_type,diagonal,diagonal,0);
  
    }


    if (frame_type==1) {
      if (h<(extr*1.5)){
       for (a = [-45, 45]) {
         rotate([0, 0, a]) rotate([90, 0, 0]) {
           cylinder(r=m3_radius , h=4*extr, center=true, $fn=12);
         translate([0, 0, radius])
           cylinder(r=m3_nut_radius, h=extr/2, center=true, $fn=24);
         }
       }
      } 
      else {
        for (a = [-45, 45]) {
          for (b =[-1,1]) {
            rotate([0, 0, a])
              rotate([90, 0, 0])
                translate([0, (h-extr)/2+(h-extr)/2*b, 0])
                  {
                  cylinder(r=m3_radius, h=4*extr, center=true, $fn=12);
                  translate([0, 0, radius])
                    cylinder(r=m3_nut_radius, h=extr/2, center=true, $fn=24);
                  }
          }
        }
      }
    
    }
  }
//square addon to corner circle    
for  (i=[-1,1]) {
      scale([i,1,1])
      rotate([180, 0, -30]) 
        translate([(radius-frame_thickness), 1, -(h-extr/2)])
         scale([1,-1,1])
          cube([frame_thickness, extr/2, h], center=false);
      }
  }

}

translate([0, 0, extr/2]) {
  corner(extr,extr*1.4,frame_thickness,frame_type);
% rotate([0, 0, 45]) cube([extr, extr, 10*extr], center=true);  
}
