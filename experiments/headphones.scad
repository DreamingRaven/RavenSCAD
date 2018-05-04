module headphone_strap()
{
	strapDepth = 30;
	strapArkHeight = 170;
	backboneThickness = 2.3;
	
	half_hollow_cylinder(h=strapDepth, r=strapArkHeight, thickness=backboneThickness, fn=100);
}

module hollow_cylinder(h=5, r=10, thickness=1, center=true, fn=200)
{
	difference(){
		cylinder(h=h, r=r, center=center, $fn=fn);
		cylinder(h=h+1, r=r-thickness, center=center, $fn=fn);
	}
}

module half_hollow_cylinder(h=5, r=10, thickness=1, center=true, fn=200)
{
	difference(){
		hollow_cylinder(h=h, r=r, thickness=thickness, center=center, fn=fn);	
		translate([r/2,0,0]) cube([r+1,r*2+1,h+1], center=true);
	}
}
headphone_strap();
