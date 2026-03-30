within BobLib.Resources.VehicleRecord.Chassis.Suspension;

record AxleDWRecord
  import Modelica.SIunits;
  
  // Geometry
  parameter SIunits.Position bellcrankPivot[3] "Vector from origin to bellcrank pivot, resolved in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position bellcrankPivotAxis[3] "Unit vector along bellcrank pivot axis, resolved in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position bellcrankPickup1[3] "Vector from origin to first bellcrank pickup, resolved in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position bellcrankPickup2[3] "Vector from origin to second bellcrank pickup, resolved in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position bellcrankPickup3[3] "Vector from origin to third bellcrank pickup, resolved in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position rodMount[3] "Vector from origin to push/pullrod wishbone mount, resolved in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position shockMount[3] "Vector from origin to shock chassis mount, resolved in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  
end AxleDWRecord;
