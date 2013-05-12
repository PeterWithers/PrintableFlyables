
noseConeLength = 10;
noseConeCapHeight = 3;
motorRadius = 15;
boltDiameter = 1.6;
boltCapDiameter = 3;
boltDistance = 9;
wallThickness = 1;
ribSpacing = 40;
ribThickness = 2;
skewerRadius = 2.0; // 2.8/2;

module fuselageBlock(chordLength, wingspan, fuselageRadius, fuselageLength){
    translate([-chordLength,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius/2, fuselageRadius, chordLength);
    translate([0,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius, fuselageRadius, chordLength);
    translate([chordLength,0,-fuselageRadius]) rotate([0,90,0]) makeRibs(fuselageRadius, fuselageRadius/4, fuselageLength - chordLength*2);
}

module makeRibs(startRadius, endRadius, sectionLength){
    echo(str("sectionLength: ",sectionLength));
    numberOfRibs = sectionLength/ribSpacing;
    echo(str("ribSpacing: ", ribSpacing));
    echo(str("numberOfRibs: ",numberOfRibs));
    for (ribPosition = [0:numberOfRibs]){
        //echo("ribPosition",ribPosition);
        //r1=startRadius; r2=endRadius;
        translate([0,0,ribSpacing*ribPosition])
        fuselageRib(
            startRadius+((endRadius-startRadius)/numberOfRibs*ribPosition),
            ribThickness, wallThickness, skewerRadius, true);
    }
}

module fuselageRib(ribRadius, ribThickness, wallThickness, skewerRadius, doubleLoops){
    echo(str("fuselageRib(", ribRadius, ",", ribThickness, ",", wallThickness, ",", skewerRadius,",",doubleLoops, ")"));
    union(){
        difference(){
            cylinder(r=ribRadius, h=ribThickness, center=true);
            cylinder(r=ribRadius-wallThickness, h=ribThickness*3, center=true);
        }
        for (rotation=[1:5]){
            rotate([0,0,(360/5)*rotation]) {
                translate([-wallThickness/2,0,-ribThickness/2]) cube([wallThickness,ribRadius-skewerRadius*2-wallThickness,ribThickness], center=false);
                rotate([0,0,18]) { // i have no idea why this rotate is required, the cube and the cylinder should have the same translation matrix at this point
                    // make the inner supports and skewer loops
                    translate([ribRadius-skewerRadius-wallThickness,0,0]){
                        difference(){
                            cylinder(h=ribThickness, r=skewerRadius+wallThickness, center=true);
                            cylinder(h=ribThickness*3, r=skewerRadius, center=true);
                        }
                    }
                    if (doubleLoops == true){
                        // add the loops used to join the skewers
                        rotate([0,0,(360/5)*rotation+(360/5)/2])
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
    }
}

module noseCone(){
    echo(str("noseCone(", noseConeLength, ",", motorRadius, ",", boltDiameter, ",", boltDistance, ",", wallThickness, ",", skewerRadius, ");"));
    //ribRadius = motorRadius;
    difference(){
        union(){
            translate([0,0,noseConeCapHeight/2])cylinder(h=noseConeCapHeight, r=motorRadius, center=true);
            translate([0,0,noseConeLength/2+noseConeCapHeight/2])fuselageRib(motorRadius,noseConeLength, wallThickness, skewerRadius, false);
        }
        for (rotation = [0,90,180,270]){
            // make a hole for the bolt head through the strut
            rotate([0,0,rotation])translate([boltDistance,0,noseConeCapHeight+(boltCapDiameter/2)-0.8]) cylinder(h=boltCapDiameter, r=boltCapDiameter, center=true);
            // make the bolt hole and the space for the bolt cap to be passed through
            hull(){
                rotate([0,0,rotation])translate([boltDistance,0,0]) cylinder(h=noseConeLength, r=boltDiameter, center=true);
                rotate([0,0,rotation+15])translate([boltDistance,0,0]) cylinder(h=noseConeLength, r=boltDiameter, center=true);
            }
            hull(){
                rotate([0,0,rotation+15])translate([boltDistance,0,0]) cylinder(h=noseConeLength, r=boltDiameter, center=true);
                rotate([0,0,rotation+30])translate([boltDistance,0,0]) cylinder(h=noseConeLength, r=boltDiameter, center=true);
            }
            rotate([0,0,rotation+30])translate([boltDistance,0,0]) cylinder(h=noseConeLength, r=boltCapDiameter, center=true);
        }
    }
}

module printPlate01(){
    translate([00,45,0]) fuselageRib(15,2,1,2.0, true);
    translate([50,-5,0]) fuselageRib(18.75,2,1,2.0, true);
    translate([40,40,0]) fuselageRib(22.5,2,1,2.0, true);
    translate([00,00,0]) fuselageRib(26.25,2,1,2.0, true);
}

module printPlate02(){
    translate([00,45,0]) fuselageRib(7.5,2,1,2.0, true);
    translate([50,-5,0]) fuselageRib(10.7143,2,1,2.0, true);
    translate([40,40,0]) fuselageRib(13.9286,2,1,2.0, true);
    translate([00,00,0]) fuselageRib(17.1429,2,1,2.0, true);
}

module printPlate03(){
    translate([100-21,21,0]) fuselageRib(20.3571,2,1,2.0, true);
    translate([100-24-10,21*2+24,0]) fuselageRib(23.5714,2,1,2.0, true);
    translate([27,27,0]) fuselageRib(26.7857,2,1,2.0, true);
}

module printPlate04(){
    translate([30,30,0]) fuselageRib(30,2,1,2.0, true);
    //translate([100-30,100-30,0]) fuselageRib(30,2,1,2.0, true);
}

//fuselage(160, 640);
noseCone();

//%cube(100);
//printPlate01();
//printPlate02();
//printPlate03();
//printPlate04();
/*
ECHO: "fuselageRib(30,2,1,2, true)"
ECHO: "fuselageRib(30,2,1,2, true)"
ECHO: "fuselageRib(30,2,1,2, true)"
ECHO: "fuselageRib(30,2,1,2, true)"
ECHO: "fuselageRib(30,2,1,2, true)"
*/