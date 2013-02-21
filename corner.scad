include <configuration.scad>;
use<libraries/frame_axis_block.scad>;
//extr=15;
radius = thickness+cos(30)*diagonal/2+extr;
bracket = 10;

module corner(h) {
  difference() {
    intersection () {
      translate([0, extr/4, (h-extr)/2]) rotate([90,0,0])
       cube([diagonal+extr*1.8,h,diagonal+extr*1.8], center=true);
      translate([0, 0, (h-extr)/2])
       cylinder(h=h, r=radius, center=true, $fn=40);
     }
  // Remove back half of cylinder.
    translate([0, radius, 0])
      cube([2*radius, 2*radius, 2*h], center=true);
  // Center round.
    
    rotate([0, 0, 45])
      cylinder(r=diagonal/2+0.5, h=2*h, center=true);
  // Horizontal OpenBeam frame pieces.
  for(i=[-1,1]) {
    rotate([0, 0, -30*i]) translate([(radius-extr/2)*i, 30, (h-extr)/2])
      cube([extr+0.1, 60, h+1], center=true);
    
  // Frame brackets under the corner.
   
  translate([diagonal/2*i, 0, (h-extr)/2])
   rotate([0, 0, -30*i]) 
    scale([i,1,1]) frame_axis_block(h+1,40,thickness,extr,diagonal);
    }

    // Screw holes.
    if (h<extr) {
      for (a = [-45, 45]) {
        rotate([0, 0, a]) rotate([90, 0, 0]) {
	        cylinder(r=1.6, h=4*extr, center=true, $fn=12);
	      translate([0, 0, radius])
	        cylinder(r=3.3, h=extr/2, center=true, $fn=24);
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
                cylinder(r=1.6, h=4*extr, center=true, $fn=12);
                translate([0, 0, radius])
                  cylinder(r=3.3, h=extr/2, center=true, $fn=24);
         }
       }
      }
    }
  }
}

translate([0, 0, extr/2]) {
  corner(extr);
% rotate([0, 0, 45]) cube([extr, extr, 10*extr], center=true);  
}
