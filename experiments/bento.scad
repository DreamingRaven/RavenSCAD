// George Onoufriou <GeorgeRaven> bento.scad
bentoBox();

module bentoBox(){
    // customise
    height = 100;
    length =400;
    width = 200;
    thickness = 5;
    tolerance = 1;
    center = true;

    openHollowCube(width, length, height, thickness, center);

};

module openHollowCube(width, length, height, thickness, center){
    if(center == true){
        difference(){
            hollowCube(width, length, height, thickness, center);
            translate([0,0,(height/2)-(thickness/2)]){
                cube([width-(thickness*2), length-(thickness*2), thickness+0.1], center);
            };
        }
    }
    else{
        difference(){
            hollowCube(width, length, height, thickness, center);
            translate([thickness, thickness, (height-thickness)]){
                cube([width-(thickness*2), length-(thickness*2), thickness+0.1], center);
            };
        }
    }
}

// module which generates a hollow cube/ rectangle based on dimensions given
module hollowCube(width, length, height, thickness, center){
    if(center == true){
        difference(){
            cube([width, length, height], center);
            cube([width-(thickness*2), length-(thickness*2), height-(thickness*2)], center);
        };
    }
    else{
        difference(){
            cube([width, length, height], center);
            translate([thickness, thickness, thickness]){
                cube([width-(thickness*2), length-(thickness*2), height-(thickness*2)], center);
            }
        };
    };
};
