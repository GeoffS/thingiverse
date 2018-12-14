// Copyright 2018 Geoff Sobering - All Rights Reserved
//
// This design is licensed under the Creative Commons
//   Attribution-NonCommercial-ShareAlike 3.0 Unported License
//  (CC BY-NC-SA 3.0)
//  https://creativecommons.org/licenses/by-nc-sa/3.0/
//  https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// For commerical use, please contact us (geoff@geoffs.net).

$fa = 3;
$fs = 0.2;

//         <------ A ---->
//
//         +-------------+         ^
//         |             |         |
//      +--+             +--+  ^   D
//      |                   |  C   |
//      +-------------------+  v  v
//
//      <------- B  -------->

length = 35;
A = 16.3;
Ab = A + 0.5;
B = 20.3;
C = 3.3;
D = 6.3;

// #8 Flat-Head screw:
screHoleDia = 4.5;
headAngle = 82.5;
headDepth = 3.4;

AbDia = 4;
AbPos = length * 0.25;
chamfer_xz = 0.4;
chamfer_xy = 3;

baseCountersinkInset = (screHoleDia/2)/tan(headAngle/2);

difference()
{
  union()
  {
    translate([-A/2, 0, 0]) cube([A, length, D]);
    translate([-B/2, 0, 0]) cube([B, length, C]);
    Abump(1, 0, 1);
    Abump(-1, 0, 1);
    Abump(1, length, -1);
    Abump(-1, length, -1);
  }

  chamfer_xz(-B/2, C, 45, chamfer_xz);
  chamfer_xz(-B/2, 0, -45, chamfer_xz);
  chamfer_xz(B/2, C, 135, chamfer_xz);
  chamfer_xz(B/2, 0, -135, chamfer_xz);

  chamfer_xy(-B/2, 0, 45, chamfer_xy);
  chamfer_xy( B/2, 0, 135, chamfer_xy);
  chamfer_xy(-B/2, length, -45, chamfer_xy);
  chamfer_xy( B/2, length, -135, chamfer_xy);

  translate([0, length/2, 0])
  {
    coneDepth = 10;
    coneDia = 2*tan(headAngle/2)*coneDepth;
    translate([0, 0, -1]) cylinder(d=screHoleDia, h=20);
    translate([0,0,-coneDepth+baseCountersinkInset+headDepth]) cylinder(d2=0, d1=coneDia, h=coneDepth);
  }
}

module Abump(xs, y, ys)
{

  translate([xs*(Ab-AbDia)/2, y+ys*AbPos, 0]) cylinder(d=AbDia, h=D);
}

module chamfer_xz(dx, dz, a, chamfer)
{
    translate([dx, 0, dz]) rotate(a, [0,1,0]) translate([-2+chamfer, -1, -1-chamfer/2]) cube([2, length+2, 2]);
}

module chamfer_xy(dx, dy, a, chamfer)
{
    translate([dx, dy, 0]) rotate(a, [0,0,1]) translate([-8+chamfer, -4, -1]) cube([8, 8, D+2]);
}
