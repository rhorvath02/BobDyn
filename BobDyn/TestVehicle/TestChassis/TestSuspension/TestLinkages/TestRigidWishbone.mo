within BobDyn.TestVehicle.TestChassis.TestSuspension.TestLinkages;

model TestRigidWishbone
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
  parameter SIunits.Length joint_diameter = 0.030 annotation(Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));

  // Wishbones
  BobDyn.Vehicle.Chassis.Suspension.Linkages.RigidWishbone rigid_wishbone(fore_i = upper_fore_i,
                                                                                   aft_i = upper_aft_i,
                                                                                   outboard = upper_o,
                                                                                   link_diameter = link_diameter,
                                                                                   joint_diameter = joint_diameter) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed_inboard(r = (upper_fore_i + upper_aft_i)/2)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 1, enforceStates = false)  annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(fixed_inboard.frame_b, rigid_wishbone.inboard_frame) annotation(
    Line(points = {{20, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(rigid_wishbone.outboard_frame, body.frame_a) annotation(
    Line(points = {{-10, 0}, {-20, 0}}, color = {95, 95, 95}));
end TestRigidWishbone;
