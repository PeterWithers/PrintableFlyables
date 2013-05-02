// Copyright 2013 Peter Withers
// Licensed as GPL 2

use <aerofoil-skewered.scad>;
use <hardware.scad>;
use <ailerons.scad>;
use <empennage.scad>;
use <fuselage.scad>;

// some propotions are from: http://adamone.rchomepage.com/design.htm
// the maximum printable chord is 120 but this can be extended with the flat section containing the ailerons
chordRibLength = 120;
aileronChord = chordRibLength / 3;
chordLength = chordRibLength + aileronChord;
strutSpacing = 50;
strutsPerWing = 8;
wingspan = strutSpacing*strutsPerWing*2;
aileronLength = wingspan/4;
preferedFuselageLength = wingspan * 0.75;
fuselageLength = chordLength*4.5;
fuselageRadius = fuselageLength*0.15/2;
echo("preferedFuselageLength: ",preferedFuselageLength);
echo("fuselageLength: ",fuselageLength);

module wing(innerIndexes, outerIndexes){
	rotate([90,0,0])translate([0,0,0]) makeSkewers(chordRibLength, 210, 1.2, outerIndexes);
	rotate([90,0,0])translate([0,0,strutSpacing*4]) makeSkewers(chordRibLength, 210, 1.2, innerIndexes);
	for (strutCounter = [0:strutsPerWing-1]){
		rotate([90,0,0])translate([0,0,strutCounter*strutSpacing])
			makeAeroFoil(chordRibLength, 2.0, 1.2, 2.8);
	}
}
rotate([5,0,0])translate([0,wingspan/2,0]) {
	wing([0,5,6,11],[1,4,7,10]);
	translate([chordRibLength,0,0]) rotate([0,7,0]) aileronCard(chordLength, strutSpacing,strutsPerWing, aileronLength, aileronChord, 10, 10);
	}
rotate([-5,0,0])translate([0,-wingspan/2,0]) scale([1,-1,1]) {
	wing([1,4,7,10],[0,5,6,11]);
	translate([chordRibLength,0,0]) rotate([0,7,0]) aileronCard(chordLength, strutSpacing,strutsPerWing, aileronLength, aileronChord, -10, 10);
}

// todo: should there be 2-3 degrees downward and 2-3 rightward angle on the motor?
rotate([0,-90,0])translate([-fuselageRadius,0,chordLength]) propellerMotor();
echo("chord length: ",chordLength,"mm");
echo("wing span: ",wingspan,"mm");
echo("wingspan should be 5-6 times the chord: ", wingspan/chordLength);
echo("wing area: ",((wingspan/100)*((chordLength)/100)),"dm2");

translate([30,0,0]) servoMotor();
//translate([0,80,0]) speedController();
//translate([0,140,0]) lipo1000();

//translate([0,180,0]) lipo610();
translate([fuselageLength-chordLength,0,-fuselageRadius]) empennageStruts(chordLength, chordLength, chordLength, 10);
fuselageBlock(chordLength, wingspan,fuselageRadius);