
module fuselageBlock(chordLength, wingspan, fuselageRadius, fuselageLength){
    translate([-chordLength,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius/2, fuselageRadius, chordLength);
    translate([0,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius, fuselageRadius, chordLength);
    translate([chordLength,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius, fuselageRadius/4, fuselageLength - chordLength*2);
}

module makeRibs(startRadius, endRadius, sectionLength){
    ribSpacing = 40;
    ribThickness = 1;
    numberOfRibs = sectionLength/ribSpacing;
    echo(ribSpacing);
    echo(numberOfRibs);
    for (ribPosition = [0:numberOfRibs]){
        echo("ribPosition",ribPosition);
        //r1=startRadius; r2=endRadius;
        translate([0,0,ribSpacing*ribPosition]) 
        fuselageRib(
            startRadius+((endRadius-startRadius)/numberOfRibs*ribPosition),
            ribThickness, 1, 6);
    }
}

module fuselageRib(ribRadius, ribThickness, wallThickness, holeCount){
    difference(){
        cylinder(r=ribRadius, h=ribThickness);
        translate([0,0,-wallThickness]) cylinder(r=ribRadius-wallThickness, h=ribThickness*3);
    }
    for (rotation=[1:5]){
        rotate([0,0,(360/5)*rotation]) cube([wallThickness,ribRadius,wallThickness], center=false);
    }
}

fuselage(160, 640);