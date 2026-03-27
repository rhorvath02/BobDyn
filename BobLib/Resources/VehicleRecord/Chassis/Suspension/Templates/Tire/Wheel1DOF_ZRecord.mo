within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire;

record Wheel1DOF_ZRecord
  // Modelica units
  import Modelica.SIunits;
  
  // Rate properties
  parameter SIunits.TranslationalSpringConstant tire_c "Wheel vertical stiffness" annotation(
    Dialog(group = "Rate Properties"));
  parameter SIunits.TranslationalDampingConstant tire_d "Wheel vertical damping" annotation(
    Dialog(group = "Rate Properties"));
  
end Wheel1DOF_ZRecord;
