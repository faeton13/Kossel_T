// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = (m3_nut_od+0.2)/2;
m3_nut_h=3;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2;
m3_open_radius = 3.2/2;
m3_cap=4;
m3_clr=0.2;

m_frame_major = 3.8;
m_frame_radius=m_frame_major/2;
m_frame_clr=0.3;
m_frame_open=m_frame_radius+m_frame_clr*2;
m_frame_cap=(8+m_frame_clr)/2;
m_frame_nut=(8+m_frame_clr)/2;

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
motor_thickness = 6; // mm bracket thickness
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
// corner parametrs
frame_thickness=6; //thickness for frame sheets
bracket = 5;
frame_type=10; //type 0 solid. 10 for solid with mottors on the top or 1 for sepparate parts
radius = thickness+cos(30)*diagonal/2+frame_thickness;
slot_hole=3;

//roller parametrs
extr_clr=0.7; // extrusion clearence distance
cone_radius = 5;
cone_radius_dwn = 4;
shrink_wrap = 0.1; // mm thickness
h_base=7;
H_roller=diagonal/2+extr_clr*2+h_base;
W_roller=diagonal/2+extr_clr+m3_radius;
rod_offset=W_roller+5; //(25)
layer_h=0.35;

//dimmensions calculations for frame_motor (some trigonometry)

f1= (extr*sin(15)+thickness)/cos(30);
f2=(extr*sin(15)+thickness)*cos(60)/sin(60);
L=f1+diagonal+motor_offset;
f4=L*sin(30)/cos(30)-motor_d/2;
f3=f4/2;
w_fm = L/cos(30)-f3-f2;

//motor cut_off frame
h_mot_cut_off = L*sin(30) - (motor_screws - motor_d/2)*cos(30);
