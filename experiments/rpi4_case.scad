// Raspberry pi 4 model case by George Onoufriou (Raven, GeorgeRaven, Archer) C 2019-06-30
// please see licence in project root https://github.com/DreamingRaven/RavenSCAD/blob/master/LICENSE

board_thickness = 1.5; // the space for the board itself only
pin_space = 3;//2.2; // the min space that the throughhole components require underneath
$fn = 100; // how detailed the circular components are (holes + mounts), not super important
extension = 20; // extension to lengths so case can be subtractiveley created
inhibitionzone_height = 12; // creates an inhibition zone for surface components
case_thickness = 2; // sets the case thickness
pil = 85.5; // this is the length of the pi board only
pid = 56; // this is the width / depth of the pi board only
pih = board_thickness;
sd_height = pin_space + case_thickness + board_thickness; // is how tall the sd card part sticking out is so if you increase it will cut more out for case
mount_pin_height = board_thickness + 2*case_thickness + pin_space + inhibitionzone_height;//31; // this is the most awkward one of the set as it sets the mount point pin size

// fan mount options
fan_pin_diam = 3;
fan_position_x = 43;
fan_position_y = 7.9;
fan_length = 40;

 translate([0,0,inhibitionzone_height + case_thickness]) rotate([0,180,0]) intersection(){ // top of case
  rpi4_case();
  topSelector();
}

 translate([30,0,case_thickness]) rotate([0,-90,0]) difference(){ // bottom of case
  rpi4_case();
  topSelector();
}

translate([-pil,pid+case_thickness*2+5,0]) rpi4_case();
translate([extension+17.44,pid+case_thickness*2+5,0]) rpi4();

module topSelector()
{
  difference(){ // this difference selects the top and bottom parts of the case with a small lip for the IO
    translate([-case_thickness,0,0]) cube([pil+2*case_thickness,pid,pin_space+inhibitionzone_height+case_thickness]);  // test hull
    translate([-case_thickness,0,0]) cube([case_thickness,pid,board_thickness]);
  }
}


module rpi4_case()
{
  difference(){ // subtracts the rpi4 model from a cube to generate the case
    translate([-case_thickness,-case_thickness,-(board_thickness + case_thickness + pin_space)])
    cube([pil+(2*case_thickness),
      pid+(2*case_thickness),
      pin_space+inhibitionzone_height+board_thickness+(2*case_thickness)]); // the case itself
    union(){
      rpi4();
      pins(); // generating the pins themselves so the holes can be inhibited
    }
  }
}

module rpi4(){

  difference(){ // this creates the mount holes
    translate([0,0,board_thickness]){ // two translations cancel out but make maths simpler before they do
      translate([0,0,-(board_thickness)]) // the translation which ^ cancels out
      {
        cube([pil,pid,board_thickness]); // the board only (not the underpins)
      }
      // these are the big surface level components
      translate([-(2.81+extension),2.15,0]) cube([21.3+extension,16.3,13.6]);   // Ethenrnet port
      translate([-(2.81+extension),22.6,0]) cube([17.44+extension,13.5,15.6]);  // USB 3.0
      translate([-(2.81+extension),40.6,0]) cube([17.44+extension,13.5,15.6]);  // USB 2.0
      translate([27.36,1,0]) cube([50.7,5.0,8.6+extension]);                    // GPIO pins
      translate([21,7.15,0]) cube([5.0,5.0,8.6+extension]);                     // Power over ethernet pins
      translate([48.0,16.3,0]) cube([15.0,15.0,2.5]);                           // cpu
      translate([67.5,6.8,0]) cube([10.8,13.1,1.8]);                            // onboard wifi
      translate([79,17.3,0]) cube([2.5,22.15,5.4+extension]);                   // display connector
      translate([69.1,50,0]) cube([9.7,7.4+extension,3.6]);                     // USB type c power
      translate([55.0,50,0]) cube([7.95,7.8+extension,3.9]);                    // Micro HDMI0
      translate([41.2,50,0]) cube([7.95,7.8+extension,3.9]);                    // Micro HDMI1
      translate([37.4,34.1,0]) cube([2.5,22.15,5.4+extension]);                 // CSI camera connector
      translate([26.9,43.55,0]) cube([9,14.95+extension,7.9]);                  // Audio jack
      translate([85,22.4,-(board_thickness+sd_height)]) cube([2.55+extension,11.11,sd_height]); // SD card (poking out)
      translate([fan_position_x,fan_position_y,0]) cylinder(extension,d=fan_pin_diam, center=false);                            // fan mount top-r
      translate([fan_position_x,fan_position_y+fan_length,0]) cylinder(extension,d=fan_pin_diam, center=false);                 // fan mount bot-r
      translate([fan_position_x+fan_length,fan_position_y,0]) cylinder(extension,d=fan_pin_diam, center=false);                 // fan mount top-l
      translate([fan_position_x+fan_length,fan_position_y+fan_length,0]) cylinder(extension,d=fan_pin_diam, center=false);      // fan mount bot-l
      translate([fan_position_x+0.5*fan_length,fan_position_y+0.5*fan_length,0]) cylinder(extension,d=fan_length-fan_pin_diam, center=false);      // fan air hole

      difference(){ // this creates the mount points around the mount holes esp the underneath ones
        union(){
          translate([0,0,0]) cube([pil,pid,inhibitionzone_height]);                           // cpu
          translate([0,0,-(pin_space+board_thickness)]) cube([pil,pid,pin_space]); // underpins only
        }
        mounts();
      }
    } // end of translation cancel
      // these are the end holes for mounting
  pins();
  }
}

module mounts(){
  translate([1.25,1.25,(0.5*mount_pin_height)-(board_thickness+case_thickness+pin_space)]){ // this is to move all the pins
          translate([22.2,2,0]) cylinder(mount_pin_height,d=5.9, center=true);     // mount top-r
          translate([22.2,51.1,0]) cylinder(mount_pin_height,d=5.9, center=true);  // mount bot-r
          translate([80.2,2,0]) cylinder(mount_pin_height,d=5.9, center=true);     // mount top-l
          translate([80.2,51.1,0]) cylinder(mount_pin_height,d=5.9, center=true);  // mount bot-l
        }
}

module pins(){
  translate([1.25,1.25,(0.5*mount_pin_height)-(board_thickness+case_thickness+pin_space)]){ // this is to move all the pins
    translate([22.2,2,0]) cylinder(mount_pin_height,d=2.5, center=true);     // hole  top-r
    translate([22.2,51.1,0]) cylinder(mount_pin_height,d=2.5, center=true);  // hole  bot-r
    translate([80.2,2,0]) cylinder(mount_pin_height,d=2.5, center=true);     // hole  top-l
    translate([80.2,51.1,0]) cylinder(mount_pin_height,d=2.5, center=true);  // hole  bot-l
  }
}
