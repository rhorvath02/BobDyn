within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52;

record SetupRecord
  import Modelica.SIunits;

  parameter SIunits.Force FNOMIN
    "Nominal vertical load used for normalization (Fz0 in MF formulations)";

  parameter SIunits.Length UNLOADED_RADIUS
    "Unloaded tire radius (used for kinematics and moment calculations)";

end SetupRecord;
