within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire;

record Wheel1DOF_YRecord
  // Modelica units
  import Modelica.SIunits;
  
  // Mass properties
  parameter SIunits.Inertia wheel_J "Effective inertia of rotating mass" annotation(Dialog(group = "Mass Properties"));
  
end Wheel1DOF_YRecord;