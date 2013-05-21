// Copyright 2013 Peter Withers
// Licensed as GPL 2

use <aerofoil-skewered.scad>;

module makePrintedSkinAerofoil(chordLength, strutThickness, spanLength, wallThickness, skewerSize){
        translate([0,0, strutThickness/2]) linear_extrude(height = spanLength) {
            difference(){
                makeOuter(chordLength, wallThickness+0.5);
                makeOuter(chordLength, wallThickness);
            }
        }
        union(){
		linear_extrude(height = strutThickness) {
		makeOuter(chordLength, wallThickness);
		makeStruts(chordLength, strutThickness, 1, wallThickness, 0);
		//makeStruts(chordLength, strutThickness, 0, 0.4, 1);
		makeSkewerHoles(chordLength, strutThickness, skewerSize, wallThickness, 1);
		}
		//makeStrutsWithHoles(chordLength, strutThickness, 0.6);
		//makeStrutsWithLayers(chordLength, strutThickness, 0.4);
	}
}

rotate([0,0,90])translate([-40,-20,0]) makePrintedSkinAerofoil(120, 2.0, 50, 1.2, 2.8);