within BobLib.Resources.Records.SENSING.SYSTEMS;

record DynamicsTelemetry
  import Modelica.SIunits;

  SIunits.Acceleration ax "Longitudinal acceleration";
  SIunits.Acceleration ay "Lateral acceleration";
  SIunits.Acceleration az "Vertical acceleration";

  SIunits.Force Fx "Longitudinal force";
  SIunits.Force Fy "Lateral force";
  SIunits.Force Fz "Vertical force";

  SIunits.Torque Mx "Roll moment";
  SIunits.Torque My "Pitch moment";
  SIunits.Torque Mz "Yaw moment";
  
end DynamicsTelemetry;
