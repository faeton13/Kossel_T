 extr=20; h = 3*extr; w = h; diagonal = extr*sqrt(2); thickness=3.6; 
 rear_hole_dist=extr/2; screw_hole=3.2; forward_hole_dist=5; frame_type=0; layer_h=0.4;
 // extrusion dimmensions
extr = 20; //15 - 20 for 20x20 extrusion
extr_tslot = 6.8; //3.2 6.8 for 20x20 extrusion
extr_tslot_depth =6.1; // for 20x20
extr_nut = 11; //5.8 11 for 20x20 extrusion
extr_corn = (extr - extr_tslot)/2;
diagonal=extr*sqrt(2);
extr_type=1;
r=1.5;


module extrusion (h, extr,extr_type)
  {
     difference() {
       rotate([0,90,0])
       minkowski() {
         cube([h/2,extr,extr],center=true);
         rotate([0,90,0]) cylinder(r=r,h=h,center=true);
       }
       
      difference (){ 
         for (i=[00:90:359])
           rotate ([0,0,i]) {
             intersection (){
               cube([extr-1.8*2,extr-1.8*2,h*2],center=true);
                 #minkowski()
                  {                 
                   #intersection(){
                    translate([extr_tslot,0,0]) cube([extr_tslot*2,extr_nut,h*2],center=true);
                     difference(){
                       translate([(extr/2-1.8/4),0,0])
                         rotate ([0,0,45])
                           cube ([extr/2,extr/2,h*2],center=true);
                     cube([extr-extr_tslot_depth*2,extr-extr_tslot_depth*2,h*2 ],center=true);
                     }
                     cube([extr_nut,extr_nut,h*3],center=true);
                     } 
                     rotate([0,90,0]) cylinder(r=r,h=h*2);
                    }
               } 
              translate([extr/2,0,0]) cube ([extr_tslot,extr_tslot,h*2],center=true);
           }
          
      }
      cylinder(r=6/2, h=h*2, center=true, $fn=16);
     }
  }
//
 
 extrusion(h, extr, extr_type);

  