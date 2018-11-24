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
include <MP200 Bed Wires Mount Common.scad>

nut_y = 5;
sideThickness = 1;

threadOD = 12;
threadID = threadOD-3 - 1;
echo(str("threadID = ", threadID));
thread_y = sideThickness + nut_y + 2;

sidePlate_y = 3;
sidePlate_z = 20;

holeCtr = [mtgScrewCtr_x, plate_y-0.01, plate_z+threadID/2];

holeEdgeRadiusID = threadID;
holeEdgeRadius = 2;
holeEdgeRadiusCtr = [mtgScrewCtr_x, holeEdgeRadius/2, holeCtr[2]];

alignmentPinOD = 2.1;

module alignmentPins()
{
  translate([mtgScrewCtr_x, -7, 12]) rotate(-90, [1,0,0])
  {
    d = 20;
    translate([d/2,0,0]) cylinder(d=alignmentPinOD, h=30);
    translate([-d/2,0,0]) cylinder(d=alignmentPinOD, h=30);
  }
}

module holeEdgeRadiusPos()
{
  translate(holeEdgeRadiusCtr+[0, 0, 0]) rotate(90, [1,0,0]) torus3b(holeEdgeRadiusID+2*holeEdgeRadius, holeEdgeRadius);
}

module holeEdgeRadiusNeg()
{
  translate(holeEdgeRadiusCtr) rotate(90, [1,0,0]) cylinder(d=holeEdgeRadiusID+holeEdgeRadius, h=holeEdgeRadius/2);
}

module threadChamfer()
{
  od = 15;
  translate(holeCtr+[0, 4.7, 0]) rotate(-90, [1,0,0]) difference()
  {
    cylinder(d=od, h=od/2);
    cylinder(d1=od, d2=0, h=od/2);
  }
}

module threadsExterior()
{
  translate(holeCtr)
  rotate(-90, [1,0,0])
  render(convexity=5)
  isoThread(d=threadOD, h=thread_y, pitch=3,angle=40,internal=false,$fn=60);
}

module threadsInterior()
{
  translate(holeCtr)
  rotate(-90, [1,0,0])
  translate([0,0,-50]) cylinder(d=threadID, h=100, $fn=60);
}

module upperPlate()
{
  hull()
  {
    difference()
    {
      mountBody1();
      translate([-20, -50, -10]) cube([100, 50, 50]);
    }
    translate([mtgScrewCtr_x, plate_y, holeCtr[2]]) rotate(90, [1,0,0]) torus3(20, plate_y*2);
  }
}

module mountBody1()
{
  difference()
  {
    mountBody();
    zipTimeHole(zipTimeCtr_yAtPlate+1.5);
    zipTimeHole(zipTimeCtr_yAtEnd);
    excessRemoval();
  }
}
