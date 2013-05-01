// Copyright 2013 Peter Withers
// Licensed as GPL 2

module empennage(height, span, chord){
cube([chord,span,1]);
%cube([chord,1,height]);
translate([0,-span,0])cube([chord,span,1]);
}

empennage(20, 30, 25);