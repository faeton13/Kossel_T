include <configuration.scad>;

offset_x = -12;
offset_y = 12;
rotate_z = -22.5;

module tensioner_608() {
  difference() {
    union() {
      difference() {
        union() {
	        rotate([0, 0, rotate_z]) 
            translate([offset_x, offset_y, -4])
              {	              
	            translate([7, 0, 0]) cylinder(r=7, h=22, center=true, $fn=32);
	            translate([10, 6, 0]) cylinder(r=7, h=22, center=true, $fn=32);
	            } 
          translate([0, 3, -4])
            cube([14, 20, 22], center=true);
          translate([0, -7, -12.5])
            cylinder(r=7, h=5, center=true, $fn=24);
        }
        translate([0, -11, 11])
          cube([18, 22, 22], center=true);
        rotate([0, 90, 0])
          cylinder(r=12+clear, h=9, center=true, $fn=60);
      }
      rotate([0, 90, 0]) 
        cylinder(r=7, h=14, center=true, $fn=24);
    }
    rotate([0, 90, 0]) {
      cylinder(r=11, h=7+clear, center=true);
      cylinder(r=4+clear, h=18, center=true, $fn=24);
    }
    
//fillament holes
    for (y = [10, -12]) {
      translate([0, y, -7])
        cube([1, 6, 20], center=true);
      translate([0, y, -16])
        rotate([0, 45, 0]) cube([3, 6, 3], center=true);
    }
   rotate([0, 0, rotate_z]) {
      translate([offset_x+10, offset_y+6, -4])        
        cylinder(r=m3_open_radius , h=50, center=true, $fn=32);
      translate([offset_x+10, offset_y+6, -16])
        cylinder(r=m3_nut_radius, h=5, center=false, $fn=6); 
        
     
    }      
  }
}


  tensioner_608();
