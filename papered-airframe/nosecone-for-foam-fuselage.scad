// Copyright 2013 Peter Withers
// Licensed as GPL 2

noseConeLength = 10;
noseConeCapHeight = 6;
motorRadius = 15;
motorShaftHoleRadius = 1.6;
motorShaftHoleDepth = noseConeLength;
boltDiameter = 1.6;
boltCapDiameter = 3;
boltCapHeight = 4;
boldHeadIndentationDepth = 4.0;
boltDistance = 9.5;
wallThickness = 2;
mountWidth = 19.5;

module taperedBox(widthA, widthB, length){
	translate([0,0,-length/2])
	//rotate([0,0,0])%linear_extrude(height = noseConeLength, center = true, convexity = 10, twist = 0)
	hull(){
		cube([widthA,widthA,1], center=true);
		translate([0,0,length])cube([widthB,widthB,1], center=true);
	}
}

module fuselageMount(motorRadius,noseConeLength, wallThickness){
//	mountWidth = motorRadius * 1.7;
	// make the inner support
	difference(){
		taperedBox(mountWidth,mountWidth-1,noseConeLength);
		translate([0,0,0])taperedBox(mountWidth-wallThickness*2,mountWidth-wallThickness*2,noseConeLength+2);
	}
	// make the outer support
	difference(){
		taperedBox(mountWidth+10,mountWidth+15,noseConeLength);
		translate([0,0,0])taperedBox(mountWidth+10-wallThickness*2,mountWidth+15-wallThickness*2,noseConeLength+2);
	}
}

module noseCone(){
    //echo(str("noseCone(", noseConeLength, ",", motorRadius, ",", boltDiameter, ",", boltDistance, ",", wallThickness, ",", skewerRadius, ");"));
    //ribRadius = motorRadius;
    difference(){
        union(){
            translate([0,0,noseConeCapHeight/2])cylinder(h=noseConeCapHeight, r=motorRadius, center=true);
            translate([0,0,noseConeLength/2+noseConeCapHeight/2])
				rotate([0,0,10])fuselageMount(motorRadius,noseConeLength, wallThickness); //fuselageRib(motorRadius,noseConeLength, wallThickness, skewerRadius, false);
        }
        for (rotation = [0,90,180,270]){
            // make the bolt hole and the space for the bolt cap to be passed through
            hull(){
                rotate([0,0,rotation])translate([boltDistance,0,0]) cylinder(h=noseConeCapHeight*2+3, r=boltDiameter, center=true);
                rotate([0,0,rotation+15])translate([boltDistance,0,0]) cylinder(h=noseConeCapHeight*2+3, r=boltDiameter, center=true);
            }
            hull(){
                rotate([0,0,rotation+15])translate([boltDistance,0,0]) cylinder(h=noseConeCapHeight, r=boltDiameter, center=true);
                rotate([0,0,rotation+30])translate([boltDistance,0,0]) cylinder(h=noseConeCapHeight, r=boltDiameter, center=true);
            }
            // make a hole for the bolt head through the strut and an indentation so the bolt head keys into place				
            rotate([0,0,rotation])translate([boltDistance,0,noseConeCapHeight+(boltCapHeight/2)-boldHeadIndentationDepth/2]) cylinder(h=boltCapHeight+boldHeadIndentationDepth, r=boltCapDiameter, center=true);
				// create a gap in the struts for the bold head to be rotated through
            rotate([0,0,rotation+15])translate([boltDistance,0,noseConeCapHeight+(boltCapHeight/2)]) cylinder(h=boltCapHeight, r=boltCapDiameter, center=true);
				// create a hole for the bolt head to pass through the platess
            rotate([0,0,rotation+30])translate([boltDistance,0,0]) cylinder(h=boltCapHeight*2+noseConeCapHeight*2, r=boltCapDiameter, center=true);
        }
		// make a hole for the motor shaft
		cylinder(h=motorShaftHoleDepth*2, r=motorShaftHoleRadius*2, center=true);
    }
}
noseCone();