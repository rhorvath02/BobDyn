within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Templates;

record PartialWheelRecord
  import Modelica.SIunits;
  
  // Dimensions
  parameter SIunits.Length R0 "Tire unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rimR0 = R0*0.625 "Rim unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rimWidth = rimR0*1.4 "Rim unloaded width" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Angle staticAlpha "Static toe angle in DEGREES, following Z-up convention" annotation(
    Dialog(group = "Attitude"));
  parameter SIunits.Angle staticGamma "Static inclination angle in DEGREES, following Z-up convention" annotation(
    Dialog(group = "Attitude"));

end PartialWheelRecord;
