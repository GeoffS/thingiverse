include <MP200 Bed Wires Side Common.scad>

//%mountBody1();

difference()
{
  union()
  {
    mountBody1();
    upperPlate();
  }
  threadsInterior();
  excessRemoval();
  holeEdgeRadiusNeg();
}
difference()
{
  holeEdgeRadiusPos();
  excessRemoval();
}
