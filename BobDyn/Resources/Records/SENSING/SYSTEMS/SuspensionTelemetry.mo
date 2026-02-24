within BobDyn.Resources.Records.SENSING.SYSTEMS;

record SuspensionTelemetry
  import Modelica.SIunits;

  SIunits.Position jounce "Jounce of the suspension (relative to static position)";
  SIunits.Position frame_height "Height of the vehicle frame above the ground";

  SIunits.Length shock_deflection "Deflection of the suspension spring + damper (co-axial)";
  SIunits.Velocity shock_velocity "Velocity of the suspension spring + damper (co-axial)";

  SIunits.Torque stabar_torque "Torque through the stabar";

end SuspensionTelemetry;
