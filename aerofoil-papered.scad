// Copyright 2013 Peter Withers
// Licensed as GPL 2

// the follwing array data is converted from PT40.dat retrieved on 14 April 2013 from http://www.ae.illinois.edu/m-selig/ads/coord_database.html
aerofoilData = [[1.000000,0.001356],
[0.997540,0.001963],
[0.990700,0.003687],
[0.980370,0.006189],
[0.966980,0.009283],
[0.950440,0.012906],
[0.930640,0.016996],
[0.907750,0.021447],
[0.882020,0.026182],
[0.853700,0.031153],
[0.823090,0.036316],
[0.790480,0.041628],
[0.756160,0.047029],
[0.720430,0.052435],
[0.683590,0.057749],
[0.645940,0.062857],
[0.607780,0.067611],
[0.569370,0.071880],
[0.530990,0.075601],
[0.492650,0.078789],
[0.454350,0.081431],
[0.416380,0.083445],
[0.378870,0.084740],
[0.342040,0.085252],
[0.306090,0.084987],
[0.271200,0.084026],
[0.237600,0.082474],
[0.205490,0.080395],
[0.175040,0.077784],
[0.146480,0.074578],
[0.119990,0.070658],
[0.095760,0.065886],
[0.073950,0.060130],
[0.054680,0.053385],
[0.038110,0.046061],
[0.024330,0.038699],
[0.013380,0.030716],
[0.005480,0.020620],
[0.000980,0.008495],
[0.000000,-0.000736],
[0.000980,-0.009818],
[0.005480,-0.021336],
[0.013380,-0.030819],
[0.024330,-0.037450],
[0.038110,-0.040671],
[0.054680,-0.041138],
[0.073950,-0.040299],
[0.095760,-0.039114],
[0.119990,-0.037979],
[0.146480,-0.036898],
[0.175040,-0.035785],
[0.205490,-0.034591],
[0.237600,-0.033303],
[0.271200,-0.031924],
[0.306090,-0.030468],
[0.342040,-0.028957],
[0.378870,-0.027409],
[0.416380,-0.025838],
[0.454350,-0.024252],
[0.492650,-0.022652],
[0.530990,-0.021046],
[0.569370,-0.019428],
[0.607780,-0.017799],
[0.645940,-0.016172],
[0.683590,-0.014562],
[0.720430,-0.012988],
[0.756160,-0.011467],
[0.790480,-0.010016],
[0.823090,-0.008651],
[0.853700,-0.007383],
[0.882020,-0.006223],
[0.907750,-0.005176],
[0.930640,-0.004246],
[0.950440,-0.003437],
[0.966980,-0.002751],
[0.980370,-0.002186],
[0.990700,-0.001745],
[0.997540,-0.001453],
[1.000000,-0.001348]];
strutIndexesA = [[5, 70], [70, 10], [10, 65], [65,15], [15, 60], [60,20], [20, 55], [55,25], [25, 50], [50,30], [30,45], [35, 45], [35, 40]];
strutIndexesB = [[73,8],[8, 68], [68, 13], [13, 63], [63,18], [18, 58], [58,23], [23, 53], [53,28], [28, 48], [48,33], [33,43], [33, 43]];
ribHoles = [[0.05,0.005,0.025],[0.15,0.02,0.035],[0.27,0.025,0.04],[0.39,0.025,0.037],[0.51,0.025,0.03],[0.61,0.025,0.025],[0.71,0.020,0.02],[0.81,0.015,0.015]];
module makeFoilPoints(chordLength, padding){
	for (vertex = aerofoilData){
		translate([vertex[0]*chordLength, vertex[1]*chordLength, 0])
		circle(r=padding, center=true);
	}
}
module makeOuter(chordLength, wallThickness){
	difference(){
		hull() makeFoilPoints(chordLength, wallThickness+0.1);
		hull() makeFoilPoints(chordLength, 0.1);
	}
}
module makeStruts(chordLength, spanLength, filetSize, wallThickness, strutIndexes){
		intersection() {
			hull() makeFoilPoints(chordLength, 0.6);
			for (strut = strutIndexes){
				// make the struts
				hull(){
					translate([aerofoilData[strut[0]][0]*chordLength, aerofoilData[strut[0]][1]*chordLength, 0]) circle(r=0.5/2, center=true);
					translate([aerofoilData[strut[1]][0]*chordLength, aerofoilData[strut[1]][1]*chordLength, 0]) circle(r=0.5/2, center=true);
				}
				// make the fillets
				translate([aerofoilData[strut[0]][0]*chordLength, aerofoilData[strut[0]][1]*chordLength, 0]) scale([1/10, 1/10, 1/10]) circle(r=filetSize*10, center=true);
				// do the other pair so that the first and last filet are made even though this doubles up a few
				translate([aerofoilData[strut[1]][0]*chordLength, aerofoilData[strut[1]][1]*chordLength, 0]) scale([1/10, 1/10, 1/10]) circle(r=filetSize*10, center=true);
			}
		}
}

module makeStrutsWithLayers(chordLength, spanLength, filetSize){
	spacing = 2;
	for (ribPos = [0:spacing:spanLength]) translate([0, 0, ribPos])
		if (ribPos/spacing%2 == 1)
			linear_extrude(height = spacing) makeStruts(chordLength, spanLength, filetSize, strutIndexesA);
		else
			linear_extrude(height = spacing) makeStruts(chordLength, spanLength, filetSize, strutIndexesB);
//	intersection(){
//		linear_extrude(height = spanLength) makeStruts(chordLength, spanLength, filetSize, strutIndexesA);
		//for (ribPos = [0:10:spanLength]) translate([-5, -chordLength/2, ribPos]) cube([chordLength+10,chordLength,2]);
//	}
}

module makeAeroFoil(chordLength, spanLength){
	union(){
		linear_extrude(height = spanLength) {
		makeOuter(chordLength, 0.8);
		makeStruts(chordLength, spanLength, 0, 0.4, strutIndexesA);
		//makeStruts(chordLength, spanLength, 0, 0.4, strutIndexesB);
		}
		//makeStrutsWithHoles(chordLength, spanLength, 0.6);
		//makeStrutsWithLayers(chordLength, spanLength, 0.4);
	}
}
rotate([0,0,90])translate([-40, 0,0]) makeAeroFoil(100, 1);
