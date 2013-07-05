include <configuration.scad>;
use <libraries/polyholes.scad>;
//Magneto=1;
//separation=58;
eff_offset=R_od-5;
Magneto_9=1;
Magneto_9_output=3;
///
//0- all plate
//1-effector + pche holder
//2-pche holder
//3-holder for dial indicator
//4-effector
//
dial_d=8.5;



module effector(){
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
                          cylinder(r1=cone_r2, r2=cone_r1, h=7, center=true, $fn=24);
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
}

module Magneto() {
  union(){
  intersection(){
  difference(){
    union(){
 
      translate([0,0,0]) cylinder(r=R_od-3, h=height, center=true,$fn=32);
      //cylinder(r=R_od+2, h=height, center=true,$fn=32);  
      
        for (a = [0:120:359])
           rotate([0, 0, a]) translate([0, eff_offset/2+3, +2])
           difference(){
             intersection(){
                translate([0,0,-1])
                  cube ([separation+2,eff_offset+2,height+2],center=true);
                

                  union(){
                    translate([0,(eff_offset-height*sqrt(2))/2,-(height+2)*sqrt(2)/2+4]) rotate([45,0,0])
                      cube([separation+2,height*sqrt(2),height*sqrt(2)],center=true);
                    cube ([separation,eff_offset/2+2,height],center=true);
                  }
                  }
                translate([0,20,0])
                   cylinder(r=separation*1/4,h=20,center=true,$fn=16);
             }
    
}


  for (a = [0:120:359])
           rotate([0, 0, a]) translate([0, eff_offset/2+3, 0])

  
              for(a=[-1,1])
           translate([(separation/2-5)*a,12,1])
             rotate([0,45, 90]) 
              {
                cylinder(r=m_frame_radius, h=80, center=true, $fn=12);
                translate([0,0,-11]) rotate([0,0,90])
                 cylinder(r=m_frame_nut, h=10, center=true, $fn=6);
      }


    
    cylinder(r=R_id,h=height*2,center=true);
    for (a = [0:60:359])
       rotate([0, 0, a]) translate([0, 25, 0])
           cylinder(r=2.2, h=2*height, center=true, $fn=12);
     for (a = [60:120:359])
       rotate([0, 0, a]) translate([0, 38, 0])
           cylinder(r=8, h=2*height, center=true, $fn=12);
     


  }
  cylinder(r=eff_offset*1.35,h=height*2,center=true,$fn=32);
}}
//mickey mouse ears
 for (a = [0:120:359])
           rotate([0, 0, a]) translate([0, eff_offset/2+3, 0])
              for(a=[-1,1])
                 translate([(separation/2-5)*a,12,1])
                   translate ([(a)*5,2,-(height+2)/2+layer_h/2]) cylinder(r=10,h=layer_h,center=true);

}


module Magneto_9() {
echo ((separation/2-5)/cos(30)-(ball_D/2+8)/sqrt(2));
echo ("effector eff_offset", (((separation/2-5)/cos(30)-(ball_D/2+8)/sqrt(2))*sin(60)));
intersection(){
  difference(){
    union(){
      intersection(){
       translate([0,0,0]) cylinder(r=(separation-5)/2, h=height, center=true,$fn=32);
       intersection(){
         translate([0,0,0]) cylinder(r1=(separation-5)/2+height/2, r2=(separation/2-5/2)-height/2, h=height, center=true,$fn=32);
         translate([0,0,0]) cylinder(r2=(separation-5)/2+height/2, r1=(separation/2-5/2)-height/2, h=height, center=true,$fn=32);
       }}

        for (a = [0:120:359])
           rotate([0, 0, a])
             translate([0, (separation/2-5)/cos(30)-(ball_D/2+8)/sqrt(2), -height*0.4])
              rotate ([-45,0,0])
                translate ([0,0,(ball_D/2+8)/2])
                  cylinder (r=ball_D/2,h=(ball_D/2+8),center=true,$fn=20);
           
    }
    #translate([0,0,(4.7)/2]) poly_cylinder(14/2+clear, height*2, true);
    for (a = [0:120:359])
           rotate([0, 0, a]){
             translate([0, (separation/2-5)/cos(30)-(ball_D/2+8)/sqrt(2), -height*0.4])
              rotate ([-45,0,0])
                translate ([0,0,(ball_D/2+8)])
                {
                  sphere (r=ball_D/2,center=true,$fn=32);
                translate([0,0,-ball_D/2+2])  cylinder (r2=ball_D/2,r1=ball_D/4, h=(ball_D-ball_D/2)/2,center=true,$fn=20);
                 cylinder(r=ball_D/2+2,h=ball_D*0.75,center=true,$fh=16);
                 cylinder(r=m_frame_radius ,h=100, center=true, $fn=12);
                 translate ([0,0,-ball_D/2-4/2]) 
                   cylinder(r=m_frame_cap,h=5,center=true,$fn=12);
                 translate ([0,0,-ball_D/2-12]) 
                   cylinder(r=m_frame_nut,h=4+clear,center=true,$fn=6);

                }
                rotate([0,0,60]) translate([0,22/2,0]) {
                  translate([0,0,-(height-m3_nut_radius)/2+layer_h+m3_nut_h/2 ])
                    poly_cylinder(m3_radius,50,true);
                  translate([0,0,-(height-m3_nut_radius)/2])
                    cylinder(r=m3_nut_radius+clear,h=m3_nut_h+clear,center=true, $fn=6);
                 }
                translate([0,-(separation/2-m3_nut_h),0])
                  union(){
                   cube([separation,8,height+clear],center=true);
                    //translate([0,-28,0]) cylinder(r=(separation/2-m3_nut_h)+16,h=height+clear,center=true);
                  }

 }

  }
translate([0,0,height/4]) cylinder(r=separation+2,h=height+height/2,center=true);
}
}
module pche_01_holder (){
  difference() {
    cylinder(r=30/2,h=4.4,center=true,$fn=12);
    poly_cylinder (13/2,5,true);
  
    translate([0,25/4,0]) cube([11,25/2,4.7+clear],center=true);
    translate([0,15,0]) cube([50,25/2,4.7+clear],center=true);
        for (a = [60:120:359])
           rotate([0, 0, a]){
            translate([0,22/2,0]) {
                   poly_cylinder(m3_radius,50, true);
                  
                 }
      translate([0,-(separation/2-m3_nut_h),0])
                  union(){
                    cube([separation,7,height+clear],center=true);
                    translate([0,-27,0]) cylinder(r=(separation/2-m3_nut_h)+16,h=height+clear,center=true);
                  }}
      for (a = [0:120:359])
           rotate([0, 0, a])
             translate([0, (separation-5)/2/cos(30)-(ball_D/2+8)/sqrt(2), -height])
              rotate ([-45,0,0])
                translate ([0,0,(ball_D/2+8)/2])
                  cylinder (r=ball_D/2+2,h=(ball_D/2+8),center=true,$fn=20);
  }
  
}

module dial_indicator_holder (){
  difference() {
    union (){
       cylinder(r=30/2,h=4.4,center=true,$fn=12);  
       translate([0,0,10/2])
         cylinder(r=(dial_d)/2+2,h=10,center=true,$fn=12);
    }
    poly_cylinder (dial_d/2,40,true);
    translate ([0,0,15/2+5/2])
      cylinder(r1=dial_d/2, r2=dial_d/2+2, h=5, center=true);
    for (a = [60:120:359])
        rotate([0, 0, a]){
          translate([0,22/2,0]) 
              poly_cylinder(m3_radius,50, true);
        translate([0,25/4,10/2])
          cube([1,25/2,15+clear],center=true);    
        translate([0,-(separation/2-m3_nut_h)-27,0])                  
          cylinder(r=(separation/2-m3_nut_h)+16,h=height+clear,center=true);

        rotate([0, 0, 60])
          translate([0, (separation-5)/2/cos(30)-(ball_D/2+8)/sqrt(2), -height])
            rotate ([-45,0,0])
              translate ([0,0,(ball_D/2+8)/2])
                cylinder (r=ball_D/2+2,h=(ball_D/2+8),center=true,$fn=20);      
        }     
  }
}

if (Magneto==1){
if (Magneto_9==1) {
  if(Magneto_9_output==0){
  //difference(){
    Magneto_9();
    translate([separation*0.6,15,-(height-4.4)/2]) pche_01_holder();
    translate([-separation*0.6,15,-(height-4.4)/2]) dial_indicator_holder();
    }
  if (Magneto_9_output==1){
    Magneto_9();
    translate([separation*0.6,15,-(height-4.4)/2]) pche_01_holder();
     }
  if (Magneto_9_output==2){pche_01_holder();}
  if (Magneto_9_output==3){dial_indicator_holder();}
  if (Magneto_9_output==4){Magneto_9();}
  }
  
   
   //translate([0,-separation/4,0])      union()       cube ([14,separation/2,height+clear],center=true);}
 //translate([separation*0.75,0,0]) intersection(){ Magneto_9();  translate([0,-separation/4,0])   cube ([14,separation/2,height+clear],center=true);  } 

else Magneto(); }

  else effector();  
