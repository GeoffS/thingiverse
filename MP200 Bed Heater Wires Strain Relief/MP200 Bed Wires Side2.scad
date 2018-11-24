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

difference()
{
  mountBody1();
  alignmentPins();
  translate([-1, 0, -1]) cube([60, 20, 60]);
}
