include <configuration.scad>;

offset_x = 18;
//offset_y = 12;
//rotate_z = -22.5;

module tensioner_608() {

  difference() {
    union() {
      difference() {
        union() {
	            translate([0, offset_x-4, -4]) cylinder(r=7, h=22, center=true, $fn=32);
   	          translate([0, offset_x, -4]) cylinder(r=7, h=22, center=true, $fn=32);
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
   #   cylinder(r=(8+clear)/2, h=18, center=true, $fn=24);
    }
    
//fillament holes
    for (y = [10, -12]) {
      translate([0, y, -7])
        cube([3/2, 6, 20], center=true);
      translate([0.75, y, -16])
        rotate([0, 45, 0]) cube([5, 6, 3], center=true);
    }
   
    #  translate([-0, offset_x+2, -2])        
        cylinder(r=m3_open_radius , h=50, center=true, $fn=32);
      translate([-0, offset_x+2, -16])
        cylinder(r=m3_nut_radius+clear, h=5, center=false, $fn=6); 
        
     
    //}      
  }
}


  tensioner_608();
