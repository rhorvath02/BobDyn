within BobLib.Resources.Records.SENSING.SYSTEMS;

record SuspensionTelemetry
  import Modelica.SIunits;

  SIunits.Position frame_height "Height of the vehicle frame above the ground";

  SIunits.Length shock_deflection = 0 "Deflection of the suspension spring + damper (co-axial)";
  SIunits.Velocity shock_velocity = 0 "Velocity of the suspension spring + damper (co-axial)";

  SIunits.Torque stabar_torque "Torque through the stabar";
  SIunits.Torque stabar_angle "Angular deflection of torsion bar";

end SuspensionTelemetry;
