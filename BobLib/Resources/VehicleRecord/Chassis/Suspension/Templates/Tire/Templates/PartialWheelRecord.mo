within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Templates;

record PartialWheelRecord
  // Modelica units
  import Modelica.SIunits;
  
  // Dimensions
  parameter SIunits.Length R0 = 8 * 0.0254 "Tire unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rim_R0 = R0*0.625 "Rim unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rim_width = rim_R0*1.4 "Rim unloaded width" annotation(
    Dialog(group = "Dimensions"));
  
end PartialWheelRecord;
