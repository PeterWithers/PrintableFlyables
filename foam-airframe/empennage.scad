// Copyright 2013 Peter Withers
// Licensed as GPL 2

module empennageCard(height, span, chord, elevatorChord){
    translate([-chord,0,0]){
        cube([chord,span,1]);
	cube([chord,1,height]);
	translate([0,-span,0])cube([chord,span,1]);
	elevator(height, span, chord,elevatorChord);
    }
}

module empennageStruts(height, span, chord, elevatorChord){
// because we are making a triangles while we calculated the area as a square we will increase the height and chord each by sqrt(2)
    heightCorrected=height*1.41;
    spanCorrected=span*1.41;
    chordCorrected=chord*1.41;
    translate([-chordCorrected,0,0]){
	horizontalStabiliser(heightCorrected, spanCorrected, chordCorrected);
	verticalStabiliser(heightCorrected, spanCorrected, chordCorrected);
	scale([1,-1,1])translate([0,0,0])horizontalStabiliser(heightCorrected, spanCorrected, chordCorrected);
	elevator(height, span, chordCorrected,elevatorChord);
    }
}

module verticalStabiliser(height, span, chord){
	rotate([90,0,0]) hull() {
		translate([chord-10,height-10,0]) circle(10);
		translate([1,1,0])circle(1, center=true);
		translate([chord-1,1,0])circle(1, center=true);
 	}
}

module horizontalStabiliser(height, span, chord){
	hull() {
		translate([chord-10,span-10,0]) circle(10);
		translate([1,1,0])circle(1, center=true);
		translate([chord-1,1,10])circle(1, center=true);
 	}
}

module elevator(height, span, chord, elevatorChord){
	translate([chord+1,10-span,0]) cube([elevatorChord,span*2-20,1]);
}

//empennageCard(20, 30, 25, 10);
empennageStruts(20, 30, 25, 10);
//empennageStruts(40, 80, 50, 10);