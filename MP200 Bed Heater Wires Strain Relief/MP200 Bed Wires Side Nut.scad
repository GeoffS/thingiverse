// Copyright 2018 Geoff Sobering - All Rights Reserved
//
// This design is licensed under the Creative Commons
//   Attribution-NonCommercial-ShareAlike 3.0 Unported License
//  (CC BY-NC-SA 3.0)
//  https://creativecommons.org/licenses/by-nc-sa/3.0/
//  https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// For commerical use, please contact us (geoff@geoffs.net).

include <quickthread.scad>
include <MP200 Bed Wires Side Common.scad>

OD = 20.7; //threadOD + 8;
ID = threadOD + 1.2;
h = nut_y;

render(convexity=5)
difference()
{
  translate([0,0,0]) cylinder(d=OD, h=h, $fn=6);
  isoThread(d=threadOD, h=h, pitch=3, angle=40, internal=true, $fn=60);
  insideChamfer();
  translate([0, 0, h]) rotate(180, [1,0,0]) insideChamfer();
  //cut();
}

module insideChamfer()
{
  od = 15;
  h1 = tan(32) * od/2;
  translate([0, 0, -0.75]) cylinder(d1=od, d2=0, h=h1);
}

module cut()
{
  translate([0, -25, -1]) cube([50, 50, 50]);
}
