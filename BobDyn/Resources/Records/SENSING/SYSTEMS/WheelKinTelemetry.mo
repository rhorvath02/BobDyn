within BobDyn.Resources.Records.SENSING.SYSTEMS;

record WheelKinTelemetry
  import Modelica.SIunits;
  
  SIunits.Length jounce "Wheel z travel";
  SIunits.Angle roll "Axle roll angle";
  
  SIunits.Angle gamma "Inclination angle";
  SIunits.Angle toe "Toe angle";
  SIunits.Angle caster "Caster angle";
  SIunits.Angle kpi "Kingpin inclination";
  
  SIunits.Length mech_trail "Mechanical trail";
  SIunits.Length mech_scrub "Mechanical scrub radius";
  SIunits.Length spring_length "Spring length";
  SIunits.Angle stabar_angle "Stabar angle";
  
  SIunits.Force jacking "Vertical force acting on frame";
  SIunits.Force Fx "Applied longitudinal force";
  SIunits.Force Fy "Applied lateral force";

end WheelKinTelemetry;
