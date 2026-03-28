within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52;

record SetupRecord
  // Modelica units
  import Modelica.SIunits;

  parameter SIunits.Force Fnomin
    "Nominal vertical load used for normalization (Fz0 in MF formulations)";

  parameter SIunits.Length R0
    "Unloaded tire radius (used for kinematics and moment calculations)";

end SetupRecord;
