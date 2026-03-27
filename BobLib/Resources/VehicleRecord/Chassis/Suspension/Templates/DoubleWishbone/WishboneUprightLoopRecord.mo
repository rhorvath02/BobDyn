within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.DoubleWishbone;

record WishboneUprightLoopRecord
  // Modelica units
  import Modelica.SIunits;
  
  // Geometry
  parameter SIunits.Position upper_fore_i[3] "Upper control arm fore inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position upper_aft_i[3] "Upper control arm aft inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position lower_fore_i[3] "Lower control arm fore inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position lower_aft_i[3] "Lower control arm aft inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position upper_o[3] "Upper control arm outboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position lower_o[3] "Lower control arm outboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Evaluate = true,
    Dialog(tab = "Animation"));
  parameter SIunits.Length joint_diameter annotation(
    Evaluate = true,
    Dialog(tab = "Animation"));
  
end WishboneUprightLoopRecord;
