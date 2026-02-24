within BobDyn.TestVehicle.TestChassis.TestSuspension.TestLinkages;

model TestWishbone
  // Modelica units
  import Modelica.SIunits;
  
  // Parameters - FL sus defn
  final parameter BobDyn.Resources.Records.SUS.FrAxleBase FLDW;
  
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
  parameter SIunits.Length joint_diameter = 0.030 annotation(Dialog(tab="Animation", group="Sizing"));

  // Wishbones
  BobDyn.Vehicle.Chassis.Suspension.Linkages.Wishbone upper_wishbone(fore_i = upper_fore_i,
                                                                              aft_i = upper_aft_i,
                                                                              outboard = upper_o,
                                                                              link_diameter = link_diameter,
                                                                              joint_diameter = joint_diameter,
                                                                              fore_i_c = FUCA_fore_i_c,
                                                                              aft_i_c = FUCA_aft_i_c,
                                                                              fore_i_d = FUCA_fore_i_d,
                                                                              aft_i_d = FUCA_aft_i_d) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed_fore(r = upper_fore_i)  annotation(
    Placement(transformation(origin = {30, 20}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed_aft(r = upper_aft_i)  annotation(
    Placement(transformation(origin = {30, -20}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 1, useQuaternions = false)  annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(fixed_aft.frame_b, upper_wishbone.aft_i_frame) annotation(
    Line(points = {{20, -20}, {10, -20}, {10, -7}}, color = {95, 95, 95}));
  connect(fixed_fore.frame_b, upper_wishbone.fore_i_frame) annotation(
    Line(points = {{20, 20}, {10, 20}, {10, 6}}, color = {95, 95, 95}));
  connect(body.frame_a, upper_wishbone.outboard_frame) annotation(
    Line(points = {{-20, 0}, {-10, 0}}, color = {95, 95, 95}));
end TestWishbone;
