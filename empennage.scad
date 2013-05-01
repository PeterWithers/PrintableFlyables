// Copyright 2013 Peter Withers
// Licensed as GPL 2

module empennageCard(height, span, chord, elevatorChord){
	cube([chord,span,1]);
	cube([chord,1,height]);
	translate([0,-span,0])cube([chord,span,1]);
	elevator(height, span, chord,elevatorChord);
}

module empennageStruts(height, span, chord){
	horizontalStabiliser(height, span, chord);
	verticalStabiliser(height, span, chord);
	translate([0,-span,0])horizontalStabiliser(height, span, chord);
}

module verticalStabiliser(height, span, chord){
	cube([chord,1,height]);
}

module horizontalStabiliser(height, span, chord){
	cube([chord,span,1]);
}

module elevator(height, span, chord, elevatorChord){
	translate([chord+1,-span,0]) cube([elevatorChord,span*2,1]);
}

empennageCard(20, 30, 25, 10);
//empennageStruts(20, 30, 25, 10);