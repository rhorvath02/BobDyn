within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire;

record Wheel1DOF_ZRecord
  import Modelica.SIunits;
  
  // Rate properties
  parameter SIunits.TranslationalSpringConstant wheelC "Wheel vertical stiffness" annotation(
    Dialog(group = "Rate Properties"));
  parameter SIunits.TranslationalDampingConstant wheelD "Wheel vertical damping" annotation(
    Dialog(group = "Rate Properties"));
  
end Wheel1DOF_ZRecord;
