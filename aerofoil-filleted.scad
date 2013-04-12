// Copyright 2013 Peter Withers
// Licensed as GPL 2

module MakeFoil2(span, length, ratio){
	scale([1, ratio, 1])cylinder(h = span, r1 = length, r2 = length, center = true);
	hull() {
	   translate([15,10,0]) circle(10);
	   circle(10);
	}
}

module makeFoilSection1(posY, lengthShift, heightMultiplier){
	hull (){
		translate([lengthShift * posY-1,0,0]) circle(r = posY * heightMultiplier);
		translate([lengthShift * posY+1,0,0]) circle(r = (posY+1) * heightMultiplier);
		}
}
module MakeFoil1(span, length, height){
	lengthShift = length / 10;
	heightMultiplier = height / 1;
	for (posY = [1:10]){
		makeFoilSection1(posY, lengthShift, heightMultiplier);
	}
}
//MakeFoil1(50,30,0.5);

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

// This version failed to print the inner struts on skeinforge 50. 
// This version makes a foil that is solid but sliced so that skeinforge adds peremiters around the internal struts. This should solve the thin walled problem but must be printed with FILL turned off. 
module MakeSlicedFoil(span, length, height, wall){
	difference(){
		MakeFoil(span,length,height,0);
		translate([0,0,span/2])cube([length+10,0.1,span], center =true);
		for (strutPos = [length/5,0,-(length/5)]) {
			translate([strutPos,0,span/2])cube([0.1,height,span], center =true);
		}
	}
}
//MakeSlicedFoil(50,80,10,0.3);
MakeHollowFoil(100,80,10,0.3);
//MakeFoil(100,50,10);