 extr=20; h = 3*extr; w = h; diagonal = extr*sqrt(2); thickness=3.6; 
 rear_hole_dist=extr/2; screw_hole=3.2; forward_hole_dist=5; frame_type=0; layer_h=0.4;
 

module frame_axis_block(h, w, thickness, extr, diagonal, frame_type, forward_hole_dist, rear_hole_dist,screw_hole,layer_h) 
{
  difference() {
    union(){
      intersection() {
        //rotate([0, 0, -30])
         translate([-extr*sin(15), -extr*cos(15), -h/2], center=false)
	          cube([extr*sin(15)+thickness, w, h]);
        union() {
	        translate([0,-extr*cos(15), -h/2]) 
        //   rotate([0, 0, -30])
	            cube([thickness, w, h]); //main frame plate
  	    //  rotate([0, 0, -45])
          translate([-extr*sin(15), -extr*cos(15), -h/2])
            rotate([0,0,-15])
	            cube([extr, extr, h], center=false); //15degr extr cutout
        }
      }

      //mickey mouse ears
            translate([thickness/2, w-extr*cos(15), -(h)/2+layer_h])
              cylinder (r=10, h=layer_h*2,center=true, $fn=26);
    } 
    
    if (frame_type ==1) {
      // Vertical OpenBeam mounting screw holes.
        for (z=[-1, 1]) 
          translate([0, 0, (h-extr)/2*z]) 
            rotate([90, 0, 75])
              translate([-extr/2, 0, extr/2*sin(15)+5]) 
                 cylinder(r=screw_hole/2, h=50, $fn=12, center=true);

      }


    // Horizontal OpenBeam mounting screw holes.
       for (z= [h/2-extr/2, -h/2+extr/2])
       for (y = [forward_hole_dist, w-extr*cos(15)-rear_hole_dist]) 
           translate([0, y, z])
             rotate([0, 90, 0])
               cylinder(r=screw_hole/2, h=10, $fn=12, center=true);
}
}
//
 scale([1, 1, 1]) rotate([0, 90, 90]) rotate([0, 0, 30]) 
{ frame_axis_block(h, w, thickness, extr, diagonal, frame_type, forward_hole_dist, rear_hole_dist,screw_hole,layer_h);
    translate([-extr*sin(15), -extr*cos(15), -h]) rotate([0, 0, 75]) % cube([extr, extr, 1000], center=false);
   }