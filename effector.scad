include <configuration.scad>;

separation = H_roller*2;
R_od = 33; //effector offset
R_id=20;
height = 8;
cone_r1 = height/2;
cone_r2 = 5.5;
eff_offset=R_od;

difference() {
  union() {
    cylinder(r=R_od, h=height, center=true, $fn=6);
  
    for (a = [60:120:359]) 
      rotate([0, 0, a]) {
        translate([0, eff_offset, 0]) 
          intersection() {
              cube([separation, eff_offset*2, height], center=true);
            union() {
              for (s = [-1, 1]) 
                scale([s, 1, 1]) {
                  difference(){
                    union(){
                      translate([separation/2-4, 0, 0])
                        rotate([0, 90, 0])
                          cylinder(r1=cone_r2, r2=cone_r1, h=8, center=true, $fn=24);
                      translate([separation/2-4, -eff_offset/2, 0])
                          cube([separation, eff_offset, height], center=true);
                    }
                    cylinder (r=(separation)/2-8, h=height+1, center=true);
                }}
            }
         }
      }
  
  }
  
  for (a = [60:120:359]) rotate([0, 0, a]) {
    translate([0, eff_offset, 0]) 
      rotate([0, 90, 0])
        cylinder(r=1.5, h=separation+1, center=true, $fn=12);
    translate([0, eff_offset, 0])
      rotate([90, 0, 90])
        cylinder(r=m3_nut_radius, h=separation-12, center=true, $fn=6);
  }
  
  cylinder(r=R_id, h=height+1, center=true, $fn=36);
  
  for (a = [0:30:359])
   rotate([0, 0, a]) {
    translate([0, 25, 0])
      cylinder(r=2.2, h=2*height, center=true, $fn=12);
  }
}
