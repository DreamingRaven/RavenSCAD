board_thickness = 1.5;
pin_space = 2.2;
$fn = 30;

underboard_thickness = board_thickness + pin_space;
translate([0,0,underboard_thickness]){
  translate([0,0,-(underboard_thickness)])
  {
    cube([85,56.4,underboard_thickness]); // board + underpins
  }
  translate([-2.81,2.25,0]) cube([21.3,16,13.6]);     // Ethenrnet port
  translate([-2.81,22.6,0]) cube([17.44,13.1,15.6]);  // USB 3.0
  translate([-2.81,40.6,0]) cube([17.44,13.1,15.6]);  // USB 2.0
  translate([27.36,1,0]) cube([50.7,5.0,8.6]);        // GPIO pins

  translate([69.5,50,0]) cube([9,7.4,3.2]);       // USB type c power
  translate([56.0,50,0]) cube([6.55,7.8,3.2]);    // Micro HDMI0
  translate([42.55,50,0]) cube([6.55,7.8,3.2]);   // Micro HDMI1
  translate([33,43.55,0]) cube([6.9,14.85,5.9]);  // Audio jack

  translate([85,22.5,-board_thickness]) cube([2.55,11.02,1.0]); // SD card (poking out)

  translate([22.2,2,0]) translate([1.25,1.25,0]) cylinder(15,d=2.5, center=true);     // hole  top-r
  translate([22.2,2,0]) translate([1.25,1.25,0]) cylinder(10,d=5.9, center=true);     // mount top-r
  translate([22.2,51.1,0]) translate([1.25,1.25,0]) cylinder(15,d=2.5, center=true);  // hole  bot-r
  translate([22.2,51.1,0]) translate([1.25,1.25,0]) cylinder(10,d=5.9, center=true);  // mount bot-r
  translate([80.2,2,0]) translate([1.25,1.25,0]) cylinder(15,d=2.5, center=true);     // hole  top-l
  translate([80.2,2,0]) translate([1.25,1.25,0]) cylinder(10,d=5.9, center=true);     // mount top-l
  translate([80.2,51.1,0]) translate([1.25,1.25,0]) cylinder(15,d=2.5, center=true);  // hole  bot-l
  translate([80.2,51.1,0]) translate([1.25,1.25,0]) cylinder(10,d=5.9, center=true);  // mount bot-l

}
