
module aileronCard(chordLength, strutSpacing,strutsPerWing, aileronLength, aileronChord, aileronAngle, overlap){
spanLength = strutSpacing*strutsPerWing;
//translate([chordLength-overlap,-spanLength,0]){
translate([-overlap,-spanLength,0]){
	union(){
		cube([aileronChord+overlap,spanLength-aileronLength,1]);
		cube([overlap, spanLength, 1]);
}
	translate([0,spanLength-aileronLength,0]) %translate([overlap,0,0]) rotate([0,aileronAngle,0]) cube([aileronChord, aileronLength, 1]);
	}
}
aileronCard(120, 40, 8, 120, 20, 10, 10);