within BobDyn.TestVehicle.TestChassis.TestSuspension.TestTemplates;

model TestLeftDoubleWishbone
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.SIunits;
  
  parameter BobDyn.Resources.Records.SUS.RrAxleDW RrAxle annotation(Evaluate=true);
  final parameter BobDyn.Resources.Records.SUS.RrAxleDWPullBCARB RrAxleBC;
  
  final parameter BobDyn.Resources.Records.MASSPROPS.RrUnsprung unsprung_mass;
  final parameter BobDyn.Resources.Records.MASSPROPS.RrUCA uca_mass;
  final parameter BobDyn.Resources.Records.MASSPROPS.RrLCA lca_mass;
  final parameter BobDyn.Resources.Records.MASSPROPS.RrTie tie_mass;
  
  final parameter BobDyn.Resources.Records.TIRES.Fr_tire Fr_tire;
  
  final parameter SIunits.Position left_cp_init[3] = RrAxle.wheel_center + Frames.resolve1(Frames.axesRotations({1, 2, 3}, {RrAxle.static_gamma * Modelica.Constants.pi / 180, 0, RrAxle.static_alpha * Modelica.Constants.pi / 180}, {0, 0, 0}), {0, 0, -baseTire.R0});
          
  BobDyn.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.LeftDoubleWishbone leftDoubleWishbone(Axle = RrAxle,
                                                                                                   unsprung_mass = unsprung_mass,
                                                                                                   uca_mass = uca_mass,
                                                                                                   lca_mass = lca_mass,
                                                                                                   tie_mass = tie_mass,
                                                                                                   link_diameter = 0.025,
                                                                                                   joint_diameter = 0.050) annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_upper(r = (RrAxle.upper_fore_i + RrAxle.upper_aft_i)/2)  annotation(
    Placement(transformation(origin = {30, 30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_lower(r = (RrAxle.lower_fore_i + RrAxle.lower_aft_i)/2)  annotation(
    Placement(transformation(origin = {30, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_tie(r = RrAxle.tie_inboard)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed annotation(
    Placement(transformation(origin = {110, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Constant const(k = 0)  annotation(
    Placement(transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}})));
  Vehicle.Chassis.Tires.BaseTire baseTire annotation(
    Placement(transformation(origin = {-60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce annotation(
    Placement(transformation(origin = {80, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  BobDyn.Utilities.Mechanics.Multibody.LinearActuator left_linear_actuator(axis = "z") annotation(
    Placement(transformation(origin = {-60, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed1(r = {0, 0, left_cp_init[3]})  annotation(
    Placement(transformation(origin = {-60, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Forces.WorldForce force(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world)  annotation(
    Placement(transformation(origin = {-130, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp Fx(height = 5000, duration = 1, startTime = 1, offset = 0)  annotation(
    Placement(transformation(origin = {-180, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp Fy(height = 0, duration = 1, startTime = 1, offset = 0)  annotation(
    Placement(transformation(origin = {-180, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant Fz(k = 0)  annotation(
    Placement(transformation(origin = {-180, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical spherical annotation(
    Placement(transformation(origin = {-60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(to_upper.frame_b, leftDoubleWishbone.upper_i_frame) annotation(
    Line(points = {{20, 30}, {0, 30}, {0, 7}, {-20, 7}}, color = {95, 95, 95}));
  connect(to_tie.frame_b, leftDoubleWishbone.tie_i_frame) annotation(
    Line(points = {{20, 0}, {-20, 0}}, color = {95, 95, 95}));
  connect(to_lower.frame_b, leftDoubleWishbone.lower_i_frame) annotation(
    Line(points = {{20, -30}, {0, -30}, {0, -7}, {-20, -7}}, color = {95, 95, 95}));
  connect(leftDoubleWishbone.midpoint_frame, baseTire.chassis_frame) annotation(
    Line(points = {{-40, 0}, {-50, 0}}, color = {95, 95, 95}));
  connect(fixed.frame_b, cutForce.frame_a) annotation(
    Line(points = {{100, 0}, {90, 0}}, color = {95, 95, 95}));
  connect(cutForce.frame_b, to_upper.frame_a) annotation(
    Line(points = {{70, 0}, {60, 0}, {60, 30}, {40, 30}}, color = {95, 95, 95}));
  connect(cutForce.frame_b, to_tie.frame_a) annotation(
    Line(points = {{70, 0}, {40, 0}}, color = {95, 95, 95}));
  connect(cutForce.frame_b, to_lower.frame_a) annotation(
    Line(points = {{70, 0}, {60, 0}, {60, -30}, {40, -30}}, color = {95, 95, 95}));
  connect(const.y, left_linear_actuator.u_position) annotation(
    Line(points = {{-99, 0}, {-90, 0}, {-90, -60}, {-72, -60}}, color = {0, 0, 127}));
  connect(const.y, leftDoubleWishbone.steer_input) annotation(
    Line(points = {{-98, 0}, {-90, 0}, {-90, 30}, {-36, 30}, {-36, 12}}, color = {0, 0, 127}));
  connect(fixed1.frame_b, left_linear_actuator.frame_a) annotation(
    Line(points = {{-60, -80}, {-60, -70}}, color = {95, 95, 95}));
  connect(left_linear_actuator.frame_b, spherical.frame_a) annotation(
    Line(points = {{-60, -50}, {-60, -40}}, color = {95, 95, 95}));
  connect(baseTire.cp_frame, spherical.frame_b) annotation(
    Line(points = {{-60, -10}, {-60, -20}}, color = {95, 95, 95}));
  connect(Fx.y, force.force[1]) annotation(
    Line(points = {{-169, -10}, {-161, -10}, {-161, -40}, {-143, -40}}, color = {0, 0, 127}));
  connect(Fy.y, force.force[2]) annotation(
    Line(points = {{-169, -40}, {-143, -40}}, color = {0, 0, 127}));
  connect(Fz.y, force.force[3]) annotation(
    Line(points = {{-169, -70}, {-161, -70}, {-161, -40}, {-143, -40}}, color = {0, 0, 127}));
  connect(force.frame_b, spherical.frame_a) annotation(
    Line(points = {{-120, -40}, {-60, -40}}, color = {95, 95, 95}));

annotation(
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.006),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
end TestLeftDoubleWishbone;
