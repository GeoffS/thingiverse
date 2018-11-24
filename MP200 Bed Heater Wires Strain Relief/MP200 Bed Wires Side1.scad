include <quickthread.scad>
include <MP200 Bed Wires Side Common.scad>

//%mountBody1();

difference()
{
  upperPlate();
  excessRemoval();
  threadsInterior();
  alignmentPins();
  holeEdgeRadiusNeg();
}
difference()
{
  holeEdgeRadiusPos();
  excessRemoval();
}

difference()
{
  threadsExterior();
  threadsInterior();
  threadChamfer();
}
