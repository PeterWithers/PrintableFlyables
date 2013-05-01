// Copyright 2013 Peter Withers
// Licensed as GPL 2

use <aerofoil-skewered.scad>;
use <hardware.scad>;
use <ailerons.scad>;
use <empennage.scad>;

chordLength = 120;
chordExtenderLength = 20;
strutSpacing = 40;
strutsPerWing = 8;

fuselageLength = 300;
module wing(innerIndexes, outerIndexes){
	rotate([90,0,0])translate([0,0,0]) makeSkewers(chordLength, 210, 1.2, outerIndexes);
	rotate([90,0,0])translate([0,0,strutSpacing*4]) makeSkewers(chordLength, 210, 1.2, innerIndexes);
	for (strutCounter = [0:strutsPerWing-1]){
		rotate([90,0,0])translate([0,0,strutCounter*strutSpacing])
			makeAeroFoil(chordLength, 2.0, 1.2, 2.8);
	}
}
rotate([5,0,0])translate([0,325,0]) {
	wing([0,5,6,11],[1,4,7,10]);
	translate([chordLength,0,0]) rotate([0,7,0]) aileronCard(chordLength, strutSpacing,strutsPerWing, 120, chordExtenderLength, 10, 10);
	}
rotate([-5,0,0])translate([0,-325,0]) scale([1,-1,1]) {
	wing([1,4,7,10],[0,5,6,11]);
	translate([chordLength,0,0]) rotate([0,7,0]) aileronCard(chordLength, strutSpacing,strutsPerWing, 120, chordExtenderLength, -10, 10);
}

rotate([0,-90,0])translate([-30,0,20]) propellerMotor();
echo("chord length: ",chordLength+chordExtenderLength,"mm");
wingspan = strutSpacing*strutsPerWing*2;
echo("wing span: ",wingspan,"mm");
echo("wing area: ",((wingspan/100)*((chordLength+chordExtenderLength)/100)),"dm2");

translate([30,0,0]) servoMotor();
//translate([0,80,0]) speedController();
//translate([0,140,0]) lipo1000();

//translate([0,180,0]) lipo610();
translate([fuselageLength,0,0]) empennageStruts(40, 80, 50, 10);