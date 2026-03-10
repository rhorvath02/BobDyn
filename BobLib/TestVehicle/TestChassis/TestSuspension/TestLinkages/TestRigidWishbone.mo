within BobLib.TestVehicle.TestChassis.TestSuspension.TestLinkages;

model TestRigidWishbone
  // Modelica units
  import Modelica.SIunits;
  // Parameters - FL sus defn
  final parameter BobLib.Resources.Records.SUS.FrAxleBase FLDW;
  // Parameters
  parameter SIunits.Position upper_fore_i[3] = FLDW.upper_fore_i annotation(Dialog(group="Geometry"));
  parameter SIunits.Position upper_aft_i[3] = FLDW.upper_aft_i annotation(Dialog(group="Geometry"));
  parameter SIunits.Position upper_o[3] = FLDW.upper_outboard annotation(Dialog(group="Geometry"));
   
  parameter SIunits.TranslationalSpringConstant[3] FUCA_fore_i_c = FLDW.upper_fore_i_c "{x, y, z}-stiffness of upper, fore, inboard mount" annotation(Dialog(group="Mounting"));
  parameter SIunits.TranslationalSpringConstant[3] FUCA_aft_i_c = FLDW.upper_aft_i_c "{x, y, z}-stiffness of upper, aft, inboard mount" annotation(Dialog(group="Mounting"));
  
  parameter SIunits.TranslationalDampingConstant[3] FUCA_fore_i_d = FLDW.upper_fore_i_d "{x, y, z}-damping of upper, fore, inboard mount" annotation(Dialog(group="Mounting"));
  parameter SIunits.TranslationalDampingConstant[3] FUCA_aft_i_d = FLDW.upper_aft_i_d "{x, y, z}-damping of upper, aft, inboard mount" annotation(Dialog(group="Mounting"));
  // Visual parameters
  parameter SIunits.Length link_diameter = 0.025 annotation(Dialog(tab="Animation", group="Sizing"));
  parameter SIunits.Length joint_diameter = 0.030 annotation(Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));
  // Wishbones
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed_inboard(r = (upper_fore_i + upper_aft_i)/2)  annotation(
    Placement(transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}})));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  Vehicle.Chassis.Suspension.Templates.DoubleWishbone.LeftDoubleWishbone leftDoubleWishbone annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
equation
end TestRigidWishbone;
