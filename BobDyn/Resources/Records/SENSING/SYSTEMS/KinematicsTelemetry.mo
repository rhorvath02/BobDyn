within BobDyn.Resources.Records.SENSING.SYSTEMS;

record KinematicsTelemetry
  import Modelica.SIunits;

  SIunits.Angle roll "Roll angle";
  SIunits.Angle pitch "Pitch angle";
  SIunits.Angle yaw "Yaw angle";

  SIunits.AngularVelocity p "Roll rate";
  SIunits.AngularVelocity q "Pitch rate";
  SIunits.AngularVelocity r "Yaw rate";

  SIunits.Velocity vx "Longitudinal velocity";
  SIunits.Velocity vy "Lateral velocity";
  SIunits.Velocity vz "Vertical velocity";

  SIunits.Velocity speed "Vehicle planar speed";
  SIunits.Angle beta "Vehicle sideslip angle";
  
  SIunits.Position X "Global X position";
  SIunits.Position Y "Global Y position";
  SIunits.Position Z "Global Z position";

end KinematicsTelemetry;
