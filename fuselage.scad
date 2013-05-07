
module fuselageBlock(chordLength, wingspan, fuselageRadius, fuselageLength){
    translate([-chordLength,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius/2, fuselageRadius, chordLength);
    translate([0,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius, fuselageRadius, chordLength);
    translate([chordLength,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius, fuselageRadius/4, fuselageLength - chordLength*2);
}
module makeRibs(startRadius, endRadius, sectionLength){
    cylinder(r1=startRadius, r2=endRadius, h=sectionLength);
}

fuselage(160, 640);