// Copyright 2013 Peter Withers
// Licensed as GPL 2

module MakeFoil(span, length, height, wall){
	lengthShift = length / 10;
	linear_extrude(height=span) hull (){
		translate([lengthShift * 0 - length / 2,0,0]) circle(r = height / 2 * 0.1 - wall);
		translate([lengthShift * 6 - length / 2,0,0]) circle(r = height / 2 * 0.9 - wall);
		translate([lengthShift * 7 - length / 2,0,0]) circle(r = height / 2 * 1.0 - wall);
		translate([lengthShift * 8 - length / 2,0,0]) circle(r = height / 2 * 0.9 - wall);
		translate([lengthShift * 9 - length / 2,0,0]) circle(r = height / 2 * 0.5 - wall);
	}
}

// This version makes a foil that is thin walled. In skeinforge 50 at least when this version is printed the tool path is always the same for each layer. As a result most corners have one edge that will probably break or might never have joined when printing
module MakeHollowFoil(span, length, height, wall){
	difference(){
		MakeFoil(span,length,height,0);
		difference(){
			translate([0,0,-5]) MakeFoil(span+10,length,height,wall);
			translate([0,0,span/2])cube([length+10,wall,span], center =true);
			for (strutPos = [length/5,0,-(length/5)]) {
				translate([strutPos,0,span/2])cube([wall,height,span], center =true);
			}
		}
	}
}

MakeHollowFoil(50,80,10,0.3);
