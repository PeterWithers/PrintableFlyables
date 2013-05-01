// Copyright 2013 Peter Withers
// Licensed as GPL 2

use <aerofoil-skewered.scad>;
use <hardware.scad>;

module wing(innerIndexes, outerIndexes){
	strutSpacing = 40;
	rotate([90,0,0])translate([0,0,0]) makeSkewers(120, 210, 1.2, outerIndexes);
	rotate([90,0,0])translate([0,0,strutSpacing*4]) makeSkewers(120, 210, 1.2, innerIndexes);
	for (strutCounter = [0:7]){
		rotate([90,0,0])translate([0,0,strutCounter*strutSpacing])
			makeAeroFoil(120, 2.0, 1.2, 2.8);
	}
}
rotate([5,0,0])translate([0,320,0]) wing([0,5,6,11],[1,4,7,10]);
rotate([-5,0,0])translate([0,-320,0]) scale([1,-1,1]) wing([1,4,7,10],[0,5,6,11]);