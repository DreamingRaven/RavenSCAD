include <../lib/hollowCylinders.scad>

module headphone_strap()
{
	strapDepth = 30;
	strapArkHeight = 170;
	backboneThickness = 2.3;
	absoluteThickness = 5.3;
	fn = 100;
	secLayDipDepth = 4;
	secLayBackDepth = strapDepth - (secLayDipDepth * 2);
	secLayBackThickness = 2;
	secLayRadOut = strapArkHeight - backboneThickness;
	thdLayBackDepth = 26.7;
	thdLayBackThickness = absoluteThickness - (backboneThickness + secLayBackThickness);
	thdLayRadOut = secLayRadOut - secLayBackThickness;
	
	// create backbone
	half_hollow_cylinder(h=strapDepth, r=strapArkHeight, 
		thickness=backboneThickness, fn=fn);
	
	// create trams
	difference(){
		union(){
			half_hollow_cylinder(h=secLayBackDepth, r=secLayRadOut, 
				thickness=secLayBackThickness, fn=fn);
			half_hollow_cylinder(h=thdLayBackDepth, r=thdLayRadOut, 
				thickness=thdLayBackThickness);
		}
		hollow_cylinder(h=15, r=secLayRadOut + 1, 
			thickness=thdLayBackThickness + secLayBackThickness + 1);
	}
}

headphone_strap();
