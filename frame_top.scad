include <configuration.scad>;
use <corner.scad>;

module frame_top() {
  difference() {
    union() {
      intersection() {
	     corner(extr+thickness);
	     translate([0, 0, -8]) sphere(r=(extr*1.8+0.1), $fn=60);
       }
      translate([-5, 10, extr/2]) {
	cylinder(r=extr/2, h=thickness);
	for (a = [0, 30]) {
	  rotate([0, 0, a]) translate([0, -extr, thickness/2])
	      cube([14, 30, thickness], center=true);
	}
      }
    }
    translate([-5, 12.5, 0]) # cylinder(r=1.5, h=extr+thickness, $fn=12);
  }
}

translate([0, 0, extr/2+thickness]) {
  scale([1, 1, -1]) frame_top();
  % rotate([0, 0, 45]) cube([extr, extr, extr], center=true);
}

use <tensioner_608.scad>;
% translate([-1.5, 22, 10]) rotate([180, 0, 45]) tensioner_608();
