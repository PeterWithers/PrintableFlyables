
module aileronCard(chordLength, strutSpacing,strutsPerWing, aileronLength, aileronChord, aileronAngle, overlap){
spanLength = strutSpacing*strutsPerWing;
union(){
	translate([aileronLength,0,0]) cube([spanLength-aileronLength, aileronChord+overlap, 1]);
	cube([spanLength, overlap, 1]);
}
translate([0,overlap,0]) rotate([aileronAngle,0,0]) cube([aileronLength, aileronChord, 1]);
}
aileronCard(120, 40, 8, 120, 20, 10, 10);