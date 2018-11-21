// George Onoufriou <GeorgeRaven> bento.scad
bentoBox();

module bentoBox(){
    // customise
    height =    100;
    length =    400;
    width =     200;
    thickness = 5;
    tolerance = 1;
    center =    true; // probs best not to fiddle with this
    words = "George";
    letterSize = 50;

    boxBase(width, length, height, thickness, center);
    midBox(width, length, height, thickness, center);
    translate([0,0,height]){
      embossedLid(width, length, height, thickness, center, words, letterSize);
    }
};



module embossedLid(width, length, height, thickness, center, words, letterSize){
    difference(){
        baseLid(width, length, height, thickness, center);
        translate([0,0,(height/2)-(thickness/2)]){
            thickLetters(words, thickness, letterSize);
        }
    }

}

module thickLetters(words, height, size, font){
    rotate([0,0,90]){
        linear_extrude(height){
            text(text=words, size=size, halign="center", valign="center");
        }
    }
}

module midBox(width, length, height, thickness, center){
  union(){
    translate([0,0,height]){
      boxBase(width, length, height, thickness, center);
    }
    baseLid(width, length, height, thickness, center);
  }
}

module boxBase(width, length, height, thickness, center){
  difference(){
    slantOpenCube(width, length, height, thickness, center);
    baseLid(width, length, height, thickness, center);
  }
}

module baseLid(width, length, height, thickness, center){
  difference(){
    rotate([0,180,0]){
      squarePyramid(width, length, height, center);
    }
    translate([0,0,-thickness]){
      cube([width, length, height], center);
    }
  }

}

module squarePyramid(w, l, h, center) {
    offset = [0,0,0];
    offset = [-w/2,-l/2,-h/2];
    if(center == true){
        offset = [w/2,l/2,h/2];
    }

    translate(offset){
        mw = w/2;
        ml = l/2;
        polyhedron(points = [
            [0,  0,  0],
            [w,  0,  0],
            [0,  l,  0],
            [w,  l,  0],
            [mw, ml, h]
        ], faces = [
            [4, 1, 0],
            [4, 3, 1],
            [4, 2, 3],
            [4, 0, 2],
            //base
            [0, 1, 2],
            [2, 1, 3]
            ]);
    }
}

// module which generates a one side open using a slanted cut, hollow cube/ rectangle
module slantOpenCube(width, length, height, thickness, center){
    if(center == true){
        difference(){
            hollowCube(width, length, height, thickness, center);
            translate([0,0,(height/2)-(thickness/2)]){
                cube([width-(thickness*2), length-(thickness*2), thickness+0.01], center);
            };
        }
    }
    else{
        difference(){
            hollowCube(width, length, height, thickness, center);
            translate([thickness, thickness, (height-thickness)]){
                cube([width-(thickness*2), length-(thickness*2), thickness+0.01], center);
            };
        }
    }
}

// module which generates a one side open hollow cube/ rectangle
module openCube(width, length, height, thickness, center){
    if(center == true){
        difference(){
            hollowCube(width, length, height, thickness, center);
            translate([0,0,(height/2)-(thickness/2)]){
                cube([width-(thickness*2), length-(thickness*2), thickness+0.01], center);
            };
        }
    }
    else{
        difference(){
            hollowCube(width, length, height, thickness, center);
            translate([thickness, thickness, (height-thickness)]){
                cube([width-(thickness*2), length-(thickness*2), thickness+0.01], center);
            };
        }
    }
}

// module which generates a hollow cube/ rectangle
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
