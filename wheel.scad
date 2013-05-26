// Copyright 2013 Peter Withers
// Licensed as GPL 2

module tire(wheelDiameter, tireWidth){
	rotate_extrude(convexity = 10, $fn = 100)
	translate([wheelDiameter/2, 0, 0])
	circle(r = tireWidth/2, $fn = 10);
}

module simpleRim(wheelDiameter, tireWidth){
	rimThickness=3;
	rimOffset = tireWidth/2-rimThickness/2;
	translate([0,0,rimOffset])
	cylinder(h=rimThickness, r=wheelDiameter/2,center=true);
}
module wheel(axilDiameter, wheelDiameter, tireWidth){
    difference(){
        union(){
            tire(wheelDiameter, tireWidth);
            simpleRim(wheelDiameter, tireWidth);
            cylinder(h=tireWidth, r=axilDiameter/2+5,center=true);
        }
        cylinder(h=tireWidth*2, r=axilDiameter/2,center=true, $fn = 20);
    }
}

module axilBush(axilDiameter, bushDepth, capHeight){
    difference(){
        union(){
            cylinder(h=bushDepth, r=axilDiameter/2+5,center=true);
            translate([0,0,bushDepth/2])cylinder(h=capHeight, r=axilDiameter/2+7,center=true);
        }
        cylinder(h=bushDepth*2, r=axilDiameter/2,center=true, $fn = 20);
    }
}

wheel(4,50,10);
translate([-15,45,0]) axilBush(4, 5, 2);
translate([15,45,0]) axilBush(4, 5, 2);