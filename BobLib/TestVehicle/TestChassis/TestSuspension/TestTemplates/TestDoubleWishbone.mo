within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates;

model TestDoubleWishbone
  import Modelica.Mechanics.MultiBody.Frames;

  final parameter BobLib.Resources.Records.SUS.FrAxleDW Axle;
  final parameter BobLib.Resources.Records.MASSPROPS.FrUnsprung unsprung_mass;
  final parameter BobLib.Resources.Records.MASSPROPS.FrUCA uca_mass;
  final parameter BobLib.Resources.Records.MASSPROPS.FrLCA lca_mass;
  final parameter BobLib.Resources.Records.MASSPROPS.FrTie tie_mass;
  
  Vehicle.Chassis.Suspension.Templates.DoubleWishboneV2.LeftDoubleWishboneV2 leftDoubleWishbone(upper_fore_i = Axle.upper_fore_i,
                                                                                                  upper_aft_i = Axle.upper_aft_i,
                                                                                                  lower_fore_i = Axle.lower_fore_i,
                                                                                                  lower_aft_i = Axle.lower_aft_i,
                                                                                                  upper_o = Axle.upper_outboard,
                                                                                                  lower_o = Axle.lower_outboard,
                                                                                                  tie_i = Axle.tie_inboard,
                                                                                                  tie_o = Axle.tie_outboard,
                                                                                                  wheel_center = Axle.wheel_center,
                                                                                                  static_gamma = Axle.static_gamma,
                                                                                                  static_alpha = Axle.static_alpha,
                                                                                                  unsprung_mass = unsprung_mass,
                                                                                                  uca_mass = uca_mass,
                                                                                                  lca_mass = lca_mass,
                                                                                                  tie_mass = tie_mass,
                                                                                                  link_diameter = 0.025,
                                                                                                  joint_diameter = 0.030)  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));

  Modelica.Mechanics.MultiBody.Parts.Fixed upper_fixed(r = (Axle.upper_fore_i + Axle.upper_aft_i)/2, animation = false)  annotation(
    Placement(transformation(origin = {70, 40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Fixed lower_fixed(r = (Axle.lower_fore_i + Axle.lower_aft_i)/2, animation = false)  annotation(
    Placement(transformation(origin = {70, -40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Fixed tie_fixed(r = Axle.tie_inboard, animation = false)  annotation(
    Placement(transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Fixed ground_fixed(r = Axle.wheel_center + Frames.resolve1(Frames.axesRotations({1, 2, 3}, {Axle.static_gamma, 0, Axle.static_alpha}, {0, 0, 0}), {0, 0, -baseTire.R0}), animation = false)  annotation(
    Placement(transformation(origin = {-30, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  Utilities.Mechanics.Multibody.LinearActuator linearActuator(axis = "z")  annotation(
    Placement(transformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Ramp jounce_ramp(height = 3*0.0254, duration = 1, offset = 0, startTime = 1)  annotation(
    Placement(transformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Blocks.Sources.Ramp steer_ramp(height = 0.75*0.0254, duration = 1, offset = 0, startTime = 1)  annotation(
    Placement(transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical spherical(animation = false)  annotation(
    Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Vehicle.Chassis.Tires.BaseTire baseTire annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(ground_fixed.frame_b, linearActuator.frame_a) annotation(
    Line(points = {{-30, -80}, {-30, -70}}, color = {95, 95, 95}));
  connect(jounce_ramp.y, linearActuator.u_position) annotation(
    Line(points = {{-59, -60}, {-43, -60}}, color = {0, 0, 127}));
  connect(linearActuator.frame_b, spherical.frame_a) annotation(
    Line(points = {{-30, -50}, {-30, -40}}, color = {95, 95, 95}));
  connect(lower_fixed.frame_b, leftDoubleWishbone.lower_i_frame) annotation(
    Line(points = {{60, -40}, {20, -40}, {20, -6}, {10, -6}}, color = {95, 95, 95}));
  connect(upper_fixed.frame_b, leftDoubleWishbone.upper_i_frame) annotation(
    Line(points = {{60, 40}, {20, 40}, {20, 6}, {10, 6}}, color = {95, 95, 95}));
  connect(tie_fixed.frame_b, leftDoubleWishbone.tie_i_frame) annotation(
    Line(points = {{60, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(steer_ramp.y, leftDoubleWishbone.steer_input) annotation(
    Line(points = {{-18, 30}, {-6, 30}, {-6, 12}}, color = {0, 0, 127}));
  connect(leftDoubleWishbone.midpoint_frame, baseTire.chassis_frame) annotation(
    Line(points = {{-10, 0}, {-20, 0}}, color = {95, 95, 95}));
  connect(baseTire.cp_frame, spherical.frame_b) annotation(
    Line(points = {{-30, -10}, {-30, -20}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.006),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
end TestDoubleWishbone;
