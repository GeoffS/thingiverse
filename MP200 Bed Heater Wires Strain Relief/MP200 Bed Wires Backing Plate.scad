// Copyright 2018 Geoff Sobering - All Rights Reserved
//
// This design is licensed under the Creative Commons
//   Attribution-NonCommercial-ShareAlike 3.0 Unported License
//  (CC BY-NC-SA 3.0)
//  https://creativecommons.org/licenses/by-nc-sa/3.0/
//  https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// For commerical use, please contact us (geoff@geoffs.net).

$fa=1;
$fs=0.5;

mtgScrewCtrs_x = 13.73;
mtgHoleToEdge = 14.3;
mtgScrewDia = 3.5;
mtgScrewHeadRecessDia = 6; // Extra-big M3 socket-head.

plateZcorrection = 0;

plate_x = mtgScrewCtrs_x + 10;
plate_y = 3;
plate_z = 10;
echo(str("plate_x = ", plate_x));
echo(str("plate_y (thickness) = ", plate_y));

mtgScrewCtr_x = plate_x/2;
mtgScrewCtr_z = plate_z/2;

screwClearanceHoleCtr_x = mtgScrewCtr_x;
screwClearanceHoleCtr_z = mtgScrewCtr_z - 6.1;
screwClearanceHoleDia = 9;

difference()
{
  plate();
  guideRodClearanceSlot();
  mtgScreHole(1);
  mtgScreHole(-1);
  mtgScrewHeadRecesss(1);
  mtgScrewHeadRecesss(-1);
}

module plate()
{
  cube([plate_x, plate_y, plate_z]);
}

module mtgScreHole(sgn)
{
  translate([mtgScrewCtr_x+sgn*(mtgScrewCtrs_x/2), 0, mtgScrewCtr_z]) rotate(-90, [1,0,0])
  {
    translate([0, 0, -100+10]) cylinder(d=mtgScrewDia, h=100);
  }
}

module mtgScrewHeadRecesss(sgn)
{
  translate([mtgScrewCtr_x+sgn*(mtgScrewCtrs_x/2), 1.2, mtgScrewCtr_z]) rotate(-90, [1,0,0]) M3_nutRecess(5);
}

module guideRodClearanceSlot()
{
  h = plate_y+2;
  translate([screwClearanceHoleCtr_x,-1, screwClearanceHoleCtr_z]) rotate(-90, [1,0,0]) cylinder(d=screwClearanceHoleDia, h=h);
  translate([screwClearanceHoleCtr_x-screwClearanceHoleDia/2, -1, -1]) cube([screwClearanceHoleDia, h, screwClearanceHoleCtr_z+1]);
}

module M3_nutRecess(h)
{
  M3_nutRecessDia = 6.4;
  cylinder(r=M3_nutRecessDia/2, h=h, $fn=6);
}
