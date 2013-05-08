
module fuselageBlock(chordLength, wingspan, fuselageRadius, fuselageLength){
    translate([-chordLength,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius/2, fuselageRadius, chordLength);
    translate([0,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius, fuselageRadius, chordLength);
    translate([chordLength,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius, fuselageRadius/4, fuselageLength - chordLength*2);
}

module makeRibs(startRadius, endRadius, sectionLength){
    ribSpacing = 40;
    ribThickness = 2;
    skewerRadius = 2.8/2;
    wallThickness = 2;
    numberOfRibs = sectionLength/ribSpacing;
    echo(ribSpacing);
    echo(numberOfRibs);
    for (ribPosition = [0:numberOfRibs]){
        echo("ribPosition",ribPosition);
        //r1=startRadius; r2=endRadius;
        translate([0,0,ribSpacing*ribPosition]) 
        fuselageRib(
            startRadius+((endRadius-startRadius)/numberOfRibs*ribPosition),
            ribThickness, 1, 6, skewerRadius);
    }
}

module fuselageRib(ribRadius, ribThickness, wallThickness, holeCount, skewerRadius){
    difference(){
        cylinder(r=ribRadius, h=ribThickness, center=true);
        cylinder(r=ribRadius-wallThickness, h=ribThickness*3, center=true);
    }
    for (rotation=[1:5]){
        rotate([0,0,(360/5)*rotation]) {
            translate([-wallThickness/2,0,-ribThickness/2]) cube([wallThickness,ribRadius-skewerRadius*2-wallThickness,ribThickness], center=false);
            rotate([0,0,18]) { // i have no idea why this rotate is required, the cube and the cylinder should have the same translation matrix at this point
                translate([ribRadius-skewerRadius-wallThickness,0,0]){
                    difference(){
                        cylinder(h=ribThickness, r=skewerRadius+wallThickness, center=true);
                        cylinder(h=ribThickness*3, r=skewerRadius, center=true);
                    }
                }
            }
        }
    }
}

fuselage(160, 640);