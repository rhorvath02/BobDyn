within BobLib.Resources.Records.SENSING.SYSTEMS;

record PowertrainTelemetry
  import Modelica.SIunits;

  SIunits.Torque wheel_torque[4] "Torque at each wheel (FL, FR, RL, RR)";
  SIunits.Power wheel_power[4] "Power at each wheel (FL, FR, RL, RR)";

end PowertrainTelemetry;
