// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = (m3_nut_od+0.2)/2;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2;
m3_open_radius = 3.2/2;
m3_cap=4;
m3_clr=0.2;

// NEMA17 stepper motors.
motor_d=48;
motor_shaft_diameter = 5;
motor_shaft_radius = (motor_shaft_diameter+0.3)/2;

//frame motor dimm
motor_screws = 31; // mm center-to-center
motor_width = 42.5; // mm total motor face width
motor_height = 15; // mm bracket height
motor_length = 12; // mm bracket length
motor_screws_height = (motor_width - motor_screws) / 2;
motor_shaft = 30; // mm from motor face to OpenBeam center
motor_thickness = 5; // mm bracket thickness
//height = 2*extr + motor_width;
//diagonal = extr*sqrt(2);
motor_offset = motor_shaft+2;

// Frame brackets.
thickness = 3.6;

// extrusion dimmensions
extr = 20; //15 - 20 for 20x20 extrusion
extr_tslot = 6.8; //3.2 6.8 for 20x20 extrusion
extr_nut = 11; //5.8 11 for 20x20 extrusion
extr_corn = (extr - extr_tslot)/2;
diagonal=extr*sqrt(2);

clear = 0.4;

// motor offset change 24mm - pulley size +2mm offset
//if (motor_shaft < 24) {
  //motor_offset = 24 ;
  //}
  //else  {motor_offset = 24;
  //}

//dimmensions calculations for frame_motor (some trigonometry)

f1= (extr*sin(15)+thickness)/cos(30);
f2=(extr*sin(15)+thickness)*cos(60)/sin(60);
L=f1+diagonal+motor_offset;
f4=L*sin(30)/cos(30)-motor_d/2;
f3=f4/2;
w_fm = L/cos(30)-f3-f2;

//motor cut_off frame
h_mot_cut_off = L*sin(30) - (motor_screws - motor_d/2)*cos(30);
