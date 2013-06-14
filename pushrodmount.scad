module pushrodmount(baseDiameter,baseHeight,leverLength,leverWidth,leverThickness,leverAngle,holeDiameter){
	// make the base
	cylinder(r=baseDiameter/2,h=baseHeight,center=true);
	rotate([90,0,0]){
		difference(){
			hull(){
				cube([leverWidth,baseHeight,leverThickness],center=true);
				rotate([0,0,leverAngle])translate([0,-leverLength-leverWidth/2,0]) cylinder(r=leverWidth/2,h=leverThickness,center=true);
			}
			// make the hole for the pushrod
			rotate([0,0,leverAngle])translate([0,-leverLength-leverWidth/2,0]) cylinder(r=holeDiameter/2,h=leverThickness*2,center=true);
		}
	}	
}

baseDiameter=10;
baseHeight=2;
leverLength=10;
leverWidth=5;
leverThickness=2;
leverAngle=30;
holeDiameter=1;

pushrodmount(baseDiameter,baseHeight,leverLength,leverWidth,leverThickness,leverAngle,holeDiameter);