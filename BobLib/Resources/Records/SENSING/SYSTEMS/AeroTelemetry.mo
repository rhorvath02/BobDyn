within BobLib.Resources.Records.SENSING.SYSTEMS;

record AeroTelemetry
  import Modelica.SIunits;

  SIunits.Force drag "Drag force";
  SIunits.Force side_force "Side force";
  SIunits.Force lift "Lift force";

  SIunits.Torque roll_moment "Roll moment";
  SIunits.Torque pitch_moment "Pitch moment";
  SIunits.Torque yaw_moment "Yaw moment";

end AeroTelemetry;
