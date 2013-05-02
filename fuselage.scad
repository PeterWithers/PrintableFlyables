
module fuselageBlock(chordLength, wingspan, fuselageRadius, fuselageLength){
    translate([-chordLength,0,-fuselageRadius]) rotate([0,90,0]) cylinder(r1=fuselageRadius/2, r2=fuselageRadius, h=chordLength);
    translate([0,0,-fuselageRadius]) rotate([0,90,0]) cylinder(r1=fuselageRadius, r2=fuselageRadius, h=chordLength);
    translate([chordLength,0,-fuselageRadius]) rotate([0,90,0]) cylinder(r1=fuselageRadius, r2=fuselageRadius/4, h=fuselageLength - chordLength*2);
}
fuselage(160, 640);