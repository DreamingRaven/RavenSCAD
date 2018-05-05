module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module 3dHypot(l=50, w=20, h=10, thick=1){
    difference(){
        prism(l=l, w=w/2, h=h);
        prism(l=l, w=w/2-thick, h=h-thick);
    }
}

module anchor(dim=[10,10,3], holeDiam=4.5){
    translate([dim[0]/2, dim[1]/2, dim[2]/2])
    difference(){
        cube(anchorDim, center=true);
        cylinder(h=dim[2]+1, d=holeDiam, center=true);
    };
}

length = 200;
width = 60;
height = 30;
thickness = 3;

anchorDim = [15, 20, 3];
screwHoleDiam = 2.5;

3dHypot(l=length, w=width, h=height, thick=thickness
);
translate([width/2-4,0,0]) anchor(dim=anchorDim, holeDiam=screwHoleDiam);
translate([width/2-4, length-anchorDim[1], 0]) anchor(dim=anchorDim, holeDiam=screwHoleDiam);

mirror(){
    3dHypot(l=length, w=width, h=height, thick=thickness);
    translate([width/2-4,0,0]) anchor(dim=anchorDim, holeDiam=screwHoleDiam);
    translate([width/2-4, length-anchorDim[1], 0]) anchor(dim=anchorDim, holeDiam=screwHoleDiam);
}