within BobLib.Resources.Records.SENSING.SYSTEMS;

record InputsTelemetry
  import Modelica.SIunits;

  SIunits.Angle handwheel_angle "Handwheel angle";
  SIunits.Torque torque_command "Torque command from the driver (1 is max acceleration, -1 is max braking)";

end InputsTelemetry;
