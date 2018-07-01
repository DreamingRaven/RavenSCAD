include <../lib/hollowCylinders.scad>
//include <../externalLib/files/shortcuts.scad>
include <../externalLib/arc.scad>

// create arc with H height; adapter of arc external lib with centering ability
module arcH(r=1, h=1, thick=1, angle=1, centre=true){
    translate([0,0,-h/2]) linear_extrude(h)
        arc(radius=r, thick=thick, angle=angle);
}

module headphone_strap()
{
	strapDepth = 30;
	strapArkHeight = 170/2;
	backboneThickness = 2.3;
	absoluteThickness = 5.3;
	fn = 200;
  backboneArcAngle = 180-14;
	secLayDipDepth = 3;
	secLayBackDepth = strapDepth - (secLayDipDepth * 2);
	secLayBackThickness = 2;
	secLayRadOut = strapArkHeight - backboneThickness;
	thdLayBackDepth = 26.7;
	thdLayBackThickness = absoluteThickness - (backboneThickness + secLayBackThickness);
	thdLayRadOut = secLayRadOut - secLayBackThickness;
    dipDepth = -4.5;

	// create backbone
    difference(){
        half_hollow_cylinder(h=strapDepth, r=strapArkHeight,
            thickness=backboneThickness, fn=fn);
        translate([0,0,-strapDepth/2]) linear_extrude(strapDepth)
            arc(radius=strapArkHeight-backboneThickness,
                thick=backboneThickness+1, angle=360 - backboneArcAngle, $fn=fn);
	}

	// create trams
	difference(){
		union(){
			half_hollow_cylinder(h=secLayBackDepth, r=secLayRadOut,
				thickness=secLayBackThickness, fn=fn);
			half_hollow_cylinder(h=thdLayBackDepth, r=thdLayRadOut,
				thickness=thdLayBackThickness);
		}
		hollow_cylinder(h=17.7, r=secLayRadOut + 1,
			thickness=thdLayBackThickness + secLayBackThickness + 1);
    mirror([1,0,0]) arcH(r=thdLayRadOut-thdLayBackThickness-1, h=21,
      thick=thdLayBackThickness+secLayBackThickness+1, angle=155, center=true,
      $fn=200);
    arcH(r=thdLayRadOut - thdLayBackThickness-1, thick=thdLayBackThickness+1.1,
        angle=360 - backboneArcAngle, h=strapDepth, center=true, $fn=fn);
    translate([dipDepth,0,secLayBackDepth/2]) rotate([90,0,0])
        cylinder(h=2*170, r=2, center=true);
    translate([dipDepth,0,-secLayBackDepth/2]) rotate([90,0,0])
        cylinder(h=2*170, r=2, center=true);
    difference(){
      arcH(r=thdLayRadOut, h=secLayBackDepth+1,
        thick=secLayBackThickness, angle=210, center=true,
        $fn=200);
      translate([-13,-strapArkHeight,-strapDepth/2])
        cube([2*strapArkHeight,strapArkHeight*2, strapDepth]);
    }
	}

  // add screw holes
  centreCentreDist=13.5;
  rotation=129;

  rotate([0,0,rotation])
    translate([(-(secLayBackThickness+thdLayBackThickness)/2)
      +strapArkHeight-backboneThickness+0.5,0,centreCentreDist/2])
    rotate([0,90,0])
    hollow_cylinder(h=secLayBackThickness+thdLayBackThickness, r=2, thickness=1.1);

  mirror([0,1,0])
  rotate([0,0,rotation])
    translate([(-(secLayBackThickness+thdLayBackThickness)/2)
      +strapArkHeight-backboneThickness+0.5,0,centreCentreDist/2])
    rotate([0,90,0])
    hollow_cylinder(h=secLayBackThickness+thdLayBackThickness, r=2, thickness=1.1);

  rotate([0,0,rotation])
    translate([(-(secLayBackThickness+thdLayBackThickness)/2)
      +strapArkHeight-backboneThickness+0.5,0,-centreCentreDist/2])
    rotate([0,90,0])
    hollow_cylinder(h=secLayBackThickness+thdLayBackThickness, r=2, thickness=1.1);

  mirror([0,1,0])
  rotate([0,0,rotation])
    translate([(-(secLayBackThickness+thdLayBackThickness)/2)
      +strapArkHeight-backboneThickness+0.5,0,-centreCentreDist/2])
    rotate([0,90,0])
    hollow_cylinder(h=secLayBackThickness+thdLayBackThickness, r=2, thickness=1.1);
}
