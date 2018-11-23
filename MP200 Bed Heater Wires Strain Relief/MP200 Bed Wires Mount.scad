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

layerHeight = 0.21875;

mtgScrewCtrs_x = 13.73;
mtgHoleToEdge = 14.3;
mtgScrewDia = 3.5;
mtgScrewHeadRecessDia = 6; // Extra-big M3 socket-head.

plate_x = 2*(mtgHoleToEdge + mtgScrewCtrs_x/2) - 2;
plate_y = 14*layerHeight;
plate_z = 22;
echo(str("plate_x = ", plate_x));
echo(str("plate_y (thickness) = ", plate_y));

plateEdgeRadius = plate_y;

plateLRDia = 10;

cableSupportPlate_xAtPlate = plate_x;
cableSupportPlate_xAtEnd = 20;
cableSupportPlate_y = 20;
cableSupportPlate_z = plate_y;
cableSupportPlateDia_xy = 10;
cableSupportPlateDia_xz = 8;

cableSupportLowerDia_xy = 30;
cableSupportLowerDia_yz = 15;

zipTimeHoleDia = 3;
zipTieCtrs_x = cableSupportPlate_xAtEnd - cableSupportPlateDia_xy;
zipTimeCtr_yAtPlate = mtgScrewDia/2;
zipTimeCtr_yAtEnd = cableSupportPlate_y - cableSupportPlateDia_xy/2;

mtgScrewCtr_x = plate_x/2;
mtgScrewCtr_z = plate_z - 8.75;

screwClearanceHoleCtr_x = mtgScrewCtr_x;
screwClearanceHoleCtr_z = plate_z - 14.8;
screwClearanceHoleDia = 10;

plateRLRadius = plateLRDia/2;

difference()
{
  union()
  {
    mountBody();
  }
  screwClearanceHole();
  mtgScreHole(1);
  mtgScreHole(-1);
  zipTimeHole(zipTimeCtr_yAtPlate);
  zipTimeHole(zipTimeCtr_yAtEnd);

  translate([-50, plate_y-0.01, -10]) cube([100, 100, 100]);
}

module mountBody()
{
  d1x = cableSupportPlate_xAtEnd/2-cableSupportPlateDia_xy/2;
  d2x = cableSupportPlate_xAtPlate/2-cableSupportPlateDia_xz/2;
  d1y = cableSupportPlate_y-cableSupportPlateDia_xy/2;
  dz = plate_z-cableSupportPlateDia_xz/2;

  {
    hull()
    {
      translate([mtgScrewCtr_x, 0, dz])
      {
        translate([d1x, -d1y, 0]) torus3(cableSupportPlateDia_xy, cableSupportPlateDia_xz);
        translate([-d1x,-d1y, 0]) torus3(cableSupportPlateDia_xy, cableSupportPlateDia_xz);
        translate([d2x, plate_y-0.1, 0]) rotate(-90, [1,0,0]) cylinder(d=cableSupportPlateDia_xz, h=0.1);
        translate([-d2x, plate_y-0.1, 0]) rotate(-90, [1,0,0]) cylinder(d=cableSupportPlateDia_xz, h=0.1);
      }
      translate([mtgScrewCtr_x, plate_y, cableSupportLowerDia_yz/2]) torus3(cableSupportLowerDia_xy, cableSupportLowerDia_yz);
    }
  }
}

module zipTimeHole(yOffset)
{
  translate([mtgScrewCtr_x, 0, 0])
  {
    translate([0, -yOffset, plate_z]) rotate(90, [1,0,0]) torus3a(zipTieCtrs_x+zipTimeHoleDia, zipTimeHoleDia);
  }
}

module mtgScreHole(sgn)
{
  translate([mtgScrewCtr_x+sgn*(mtgScrewCtrs_x/2), 0, mtgScrewCtr_z]) rotate(-90, [1,0,0])
  {
    translate([0, 0, -100+10]) cylinder(d=mtgScrewDia, h=100);
    translate([0, 0, -100-1]) cylinder(d=mtgScrewHeadRecessDia, h=100);
  }
}


module mtgScrewHeadRecesss(sgn)
{
  translate([mtgScrewCtr_x+sgn*(mtgScrewCtrs_x/2), -100+10, mtgScrewCtr_z]) rotate(-90, [1,0,0]) cylinder(d=mtgScrewHeadRecessDia, h=100);
}

module screwClearanceHole()
{
  h = 10;
  translate([screwClearanceHoleCtr_x, plate_y+1-h, screwClearanceHoleCtr_z]) rotate(-90, [1,0,0]) cylinder(d=screwClearanceHoleDia, h=h);
}

module torus2(radius, translation)
{
  echo("2 radius, translation", radius, translation);
  rotate_extrude(convexity = 4)
  translate([translation, 0, 0])
    difference()
    {
      circle(r = radius);
      translate([-2*radius,-radius-1]) square(2*[radius, radius+2]);
    }
}

module torus3(outsideDiameter, circleDiameter)
{
  circleRadius = circleDiameter/2;
  torus2(circleRadius, outsideDiameter/2-circleRadius);
}

module torus2a(radius, translation)
{
  echo("2a radius, translation", radius, translation);
  rotate_extrude(convexity = 4)
  translate([translation, 0, 0]) circle(r = radius);
}

module torus3a(outsideDiameter, circleDiameter)
{
  circleRadius = circleDiameter/2;
  torus2a(circleRadius, outsideDiameter/2-circleRadius);
}
