include <configuration.scad>;

spool_radius = 9;
width = 16;
top = 5;
smoothness = 60;

module spool() {
  difference() {
    union() {
      cylinder(r=spool_radius, h=width, center=true, $fn=smoothness);
      translate([0, 0, width/2])
	cylinder(r1=spool_radius, r2=spool_radius+2, h=2, center=true, $fn=smoothness);
      translate([0, 0, -width/2])
	cylinder(r2=spool_radius, r1=spool_radius+2, h=2, center=true, $fn=smoothness);
      translate([0, 0, width/2+top/2+1])
	cylinder(r=spool_radius+2, h=top, center=true, $fn=smoothness);
    }
    // Motor shaft.
    cylinder(r=motor_shaft_spool_radius, h=50, center=true, $fn=24);
    // Filament tunnels.
    translate([0, spool_radius, width/2-1.5]) rotate([-30, 0, 0])
      cube([2, 2*spool_radius, 2], center=true);
    translate([0, spool_radius, -width/2+1.5]) rotate([30, 0, 0])
      cube([2, 2*spool_radius, 2], center=true);
    translate([0, 5, 0])
      cylinder(r=1.5, h=40, center=true, $fn=6);
    // M3 screws and nuts on three sides.
    for (a = [0:120:359]) {
      rotate([0, 0, a]) translate([0, 4.5, width/2+3]) rotate([90, 0, 0]) {
	cylinder(r=m3_open_radius, h=spool_radius+5, center=true, $fn=12);
	translate([0, 0, 1-spool_radius]) cylinder(r=10, h=6, center=true);
	for (z = [0:10]) {
	  translate([0, z, 1.5]) rotate([0, 0, 30])
	    cylinder(r=m3_nut_radius, h=5, center=true, $fn=6);
	}
      }
    }
  }
}

translate([0, 0, width/2+1]) spool();
