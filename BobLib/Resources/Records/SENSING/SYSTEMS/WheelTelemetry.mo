within BobLib.Resources.Records.SENSING.SYSTEMS;

record WheelTelemetry
  import Modelica.SIunits;

  SIunits.Force Fx "Longitudinal force in tire frame";
  SIunits.Force Fy "Lateral force in tire frame";
  SIunits.Force Fz "Vertical force in tire frame";

  SIunits.Torque Mx "Overturning moment in tire frame";
  SIunits.Torque My "Rolling resistance in tire frame";
  SIunits.Torque Mz "Aligning moment in tire frame";

  SIunits.Angle alpha "Tire slip angle";
  SIunits.DimensionlessRatio kappa "Tire slip ratio";
  SIunits.Angle gamma "Tire inclination angle";

  SIunits.AngularVelocity omega "Wheel angular velocity";
  SIunits.Angle delta "Road-wheel angle";
  
end WheelTelemetry;
