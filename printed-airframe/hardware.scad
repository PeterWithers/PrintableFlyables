

module motor(){
/* 2725 Brushless Outrunner Motor 1600kv
Specs:
Dimensions: 27mm x 25mm
Weight: 35g
KV: 1600 rpm/v
Voltage: 7.4v~11.1v (2s~3s)
Max Current: 17A
Max Power: 190w
Shaft: 3mm
*/
cylinder(r=13.5, h=20,center=true);
cylinder(r=1.5, h=45, center=true);
}

module speedController(){
/*
Cont Current: 18A Burst Current: 22A BEC Mode: Linear BEC : 5v / 2A
Lipo Cells: 2-4
NiMH : 5-12
Weight: 19g Size: 24x45x11mm 
*/
cube([24,45,11], center = true);
}

module lipo1000(){
/* Minimum Capacity: 1000mAh Configuration: 3S1P / 11.1v / 3Cell Constant Discharge: 20C Peak Discharge (10sec): 30C Pack Weight: 87g Pack Size: 79.5 x 36.5 x 17mm Charge Plug: JST-XH
*/
cube([79.5,36.5,17], center = true);
}

module lipo610(){
/* Capacity : 610mAh Constant discharge: 20C Burst rate: 30C (15sec) Configuration : 3S 11.1v Pack size: 55x31x16mm Weight : 50.9g
*/
cube([55,31,16], center = true);
}

module propeller(){
/* 178x102mm */
cube([178,18,1], center = true);
}

module propellerAdapter(){
/* Propeller Adapter (Colet Type) 3MM Spec:
Motor Shaft: 3mm
Prop Shaft: 6mm
Prop Shaft length: 24mm
Weight: 13.2 grams */
cylinder(r1=10, r2=5, h=24, center=true);
}
module servoMotor(){
/* Spec.
Dimension: 23x12.2x29mm
Torque: 1.5kg/cm (4.8V)
Operating speed: 0.10sec/60 degree
Operating voltage: 4.8V
Temperature range: 0-55C
Dead band-width: 7us */
translate([-5,0,16]) cube([33,12,3], center=false);
cube([23,12,21], center=false);
translate([5,6,0]) cylinder(r=1, h=30, center=false);
translate([5,6,0]) cylinder(r=5, h=27, center=false);
translate([2.5,-4,25]) cube([5,20,3], center=false);
}

module propellerMotor(){
translate([0,0,30]) propeller();
translate([0,0,35]) propellerAdapter();
translate([0,0,10]) motor();
}

propellerMotor();
translate([0,30,0]) servoMotor();
translate([0,80,0]) speedController();
translate([0,140,0]) lipo1000();

translate([0,180,0]) lipo610();
