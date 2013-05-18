// Copyright 2013 Peter Withers
// Licensed as GPL 2
use <aerofoil-skewered.scad>;

module aileronCard(chordLength, strutSpacing,strutThickness, strutsPerWing, aileronLength, aileronChord, aileronAngle, overlap){
    aileronThickness = 20;
    spanLength = strutSpacing*strutsPerWing;
    //translate([chordLength-overlap,-spanLength,0]){
    translate([-overlap,-spanLength,0]){
        union(){
            cube([aileronChord+overlap,spanLength-aileronLength,1]);
            cube([overlap, spanLength, 1]);
        }
        translate([0,spanLength-aileronLength,0]) %translate([overlap,0,0]) rotate([0,aileronAngle,0]) aileronSection(chordLength, aileronChord, aileronLength, aileronThickness,strutsPerWing);
    }
}
module aileronSection(chordLength, aileronChord, aileronLength, aileronThickness,strutsPerWing){
    edgeThickness = 1;
    intersection(){
        translate([0,0,-aileronThickness/2])union(){
            for (strutCounter = [0:strutsPerWing-1]){
                translate([0,strutCounter*(aileronLength/strutsPerWing),0]){
                    cube([aileronChord, edgeThickness, aileronThickness]);
                    cube([edgeThickness, aileronLength/strutsPerWing, aileronThickness]);
                    translate([aileronChord-edgeThickness,0,0])cube([edgeThickness, aileronLength/strutsPerWing, aileronThickness]);
                }
            }
            translate([0,aileronLength-edgeThickness,0]) cube([aileronChord,edgeThickness, aileronThickness]);
        }
        translate([aileronChord-chordLength,aileronLength+aileronThickness/2,0])rotate([90,0,0])hull() linear_extrude(height = aileronLength+aileronThickness) makeFoilPoints(chordLength, 0.6);
    }
}
aileronCard(120, 40, 8, 120, 20, 10, 10);