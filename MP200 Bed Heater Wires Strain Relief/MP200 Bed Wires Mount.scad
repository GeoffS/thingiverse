// Copyright 2018 Geoff Sobering - All Rights Reserved
//
// This design is licensed under the Creative Commons
//   Attribution-NonCommercial-ShareAlike 3.0 Unported License
//  (CC BY-NC-SA 3.0)
//  https://creativecommons.org/licenses/by-nc-sa/3.0/
//  https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// For commerical use, please contact us (geoff@geoffs.net).

include <MP200 Bed Wires Mount Common.scad>

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

  excessRemoval();
}
