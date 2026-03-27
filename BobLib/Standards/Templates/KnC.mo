within BobLib.Standards.Templates;

partial model KnC
  import Modelica.SIunits;
  import Modelica.Mechanics.MultiBody.Frames;
  parameter Modelica.SIunits.Length rack_position = 1*0.0254 "Rack position";
  parameter Modelica.SIunits.Length jounce_amplitude = 1.5*0.0254 "Jounce amplitude";
  parameter Modelica.SIunits.Force force_amplitude = 10000 "Force amplitude";
  final parameter Real left_jounce_table[:, 2] = [1, 0; 2, -1; 3, -1; 4, -1; 5, -0.5; 6, -0.5; 7, 0; 8, 0; 9, 0; 10, 0; 11, 0.5; 12, 0.5; 13, 0.5; 14, 1; 15, 1; 16, 1; 17, 0; 18, 1; 19, 1; 20, 1; 21, 0.5; 22, 0.5; 23, 0.5; 24, 0; 25, 0; 26, 0; 27, -0.5; 28, -0.5; 29, -0.5; 30, -1; 31, -1; 32, -1];
  final parameter Real right_jounce_table[:, 2] = [1, 0; 2, -1; 3, -1; 4, -1; 5, -0.5; 6, -0.5; 7, 0; 8, 0; 9, 0; 10, 0; 11, 0.5; 12, 0.5; 13, 0.5; 14, 1; 15, 1; 16, 1; 17, 0; 18, -1; 19, -1; 20, -1; 21, -0.5; 22, -0.5; 23, -0.5; 24, 0; 25, 0; 26, 0; 27, 0.5; 28, 0.5; 29, 0.5; 30, 1; 31, 1; 32, 1];
  final parameter Real left_Fx_table[:, 2] = [1, 0; 2, 0; 3, 1; 4, 0; 5, 0; 6, 1; 7, 0; 8, 0; 9, 1; 10, 0; 11, 0; 12, 1; 13, 0; 14, 0; 15, 1; 16, 0; 17, 0; 18, 0; 19, 0; 20, 0; 21, 0; 22, 0; 23, 0; 24, 0; 25, 0; 26, 0; 27, 0; 28, 0; 29, 0; 30, 0; 31, 0; 32, 0];
  final parameter Real right_Fx_table[:, 2] = [1, 0; 2, 0; 3, 1; 4, 0; 5, 0; 6, 1; 7, 0; 8, 0; 9, 1; 10, 0; 11, 0; 12, 1; 13, 0; 14, 0; 15, 1; 16, 0; 17, 0; 18, 0; 19, 0; 20, 0; 21, 0; 22, 0; 23, 0; 24, 0; 25, 0; 26, 0; 27, 0; 28, 0; 29, 0; 30, 0; 31, 0; 32, 0];
  final parameter Real left_Fy_table[:, 2] = [1, 0; 2, 0; 3, 0; 4, 0; 5, 0; 6, 0; 7, 0; 8, 0; 9, 0; 10, 0; 11, 0; 12, 0; 13, 0; 14, 0; 15, 0; 16, 0; 17, 0; 18, 0; 19, 1; 20, 0; 21, 0; 22, 1; 23, 0; 24, 0; 25, 1; 26, 0; 27, 0; 28, 1; 29, 0; 30, 0; 31, 1; 32, 0];
  final parameter Real right_Fy_table[:, 2] = [1, 0; 2, 0; 3, 0; 4, 0; 5, 0; 6, 0; 7, 0; 8, 0; 9, 0; 10, 0; 11, 0; 12, 0; 13, 0; 14, 0; 15, 0; 16, 0; 17, 0; 18, 0; 19, 1; 20, 0; 21, 0; 22, 1; 23, 0; 24, 0; 25, 1; 26, 0; 27, 0; 28, 1; 29, 0; 30, 0; 31, 1; 32, 0];
  final parameter SIunits.Position left_cp_init[3] = Axle.Axle.wheel_center + Frames.resolve1(Frames.axesRotations({1, 2, 3}, {Axle.Axle.static_gamma*Modelica.Constants.pi/180, 0, Axle.Axle.static_alpha*Modelica.Constants.pi/180}, {0, 0, 0}), {0, 0, -Axle.left_tire.R0});
  final parameter SIunits.Position right_cp_init[3] = {left_cp_init[1], -left_cp_init[2], left_cp_init[3]};
  
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}, g = 0) annotation(
    Placement(transformation(origin = {-150, -110}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = {0, 0, left_cp_init[3]}) annotation(
    Placement(transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  // Replaceable axle definition
  replaceable BobLib.Vehicle.Chassis.Suspension.FrAxleDW Axle annotation(
    Placement(transformation(origin = {0, 40}, extent = {{-30, -30}, {30, 30}})));
  // Origin roll frame
  Modelica.Mechanics.MultiBody.Joints.Revolute roll_frame(n = {1, 0, 0}, useAxisFlange = true, phi(start = 0, fixed = true)) annotation(
    Placement(transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r = Axle.effective_center - {0, 0, left_cp_init[3]}) annotation(
    Placement(transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  // Roll frame compensation
  Modelica.Blocks.Sources.RealExpression roll_expression(y = -atan((left_linear_actuator.u_position - right_linear_actuator.u_position)/(Axle.left_cp.r_0[2] - Axle.right_cp.r_0[2]))) annotation(
    Placement(transformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position roll_position(useSupport = true) annotation(
    Placement(transformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}})));
  // Contact patch actuators
  Utilities.Mechanics.Multibody.LinearActuator left_linear_actuator(axis = "z") annotation(
    Placement(transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Utilities.Mechanics.Multibody.LinearActuator right_linear_actuator(axis = "z") annotation(
    Placement(transformation(origin = {30, -10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Spherical left_spherical(animation = false) annotation(
    Placement(transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Spherical right_spherical(animation = false) annotation(
    Placement(transformation(origin = {30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  // Jounce inputs
  Modelica.Blocks.Sources.CombiTimeTable left_jounce_signal(table = [left_jounce_table[:, 1], jounce_amplitude*left_jounce_table[:, 2]], columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(
    Placement(transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable right_jounce_signal(table = [right_jounce_table[:, 1], jounce_amplitude*right_jounce_table[:, 2]], columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(
    Placement(transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}})));
  // Steer input
  Modelica.Blocks.Sources.Ramp steer_input(height = rack_position, duration = 1, offset = 0, startTime = 0) annotation(
    Placement(transformation(origin = {-90, 80}, extent = {{-10, -10}, {10, 10}})));
  // Instrumentation
  BobLib.Resources.Records.SENSING.SYSTEMS.WheelKinTelemetry left_wheel_kin_telemetry;
  BobLib.Resources.Records.SENSING.SYSTEMS.WheelKinTelemetry right_wheel_kin_telemetry;
  Real left_delta_vec[3];
  Real left_kingpin_vec[3];
  Real left_ground_param;
  Real left_ground_pt[3];
  Real right_delta_vec[3];
  Real right_kingpin_vec[3];
  Real right_ground_param;
  Real right_ground_pt[3];
  Modelica.Mechanics.MultiBody.Forces.WorldForce left_cp_force(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world) annotation(
    Placement(transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Forces.WorldForce right_cp_force(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world) annotation(
    Placement(transformation(origin = {70, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.CombiTimeTable left_Fx(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [left_Fx_table[:, 1], force_amplitude*left_Fx_table[:, 2]]) annotation(
    Placement(transformation(origin = {-130, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable left_Fy(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [left_Fy_table[:, 1], force_amplitude*left_Fy_table[:, 2]]) annotation(
    Placement(transformation(origin = {-130, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant left_Fz(k = 0) annotation(
    Placement(transformation(origin = {-130, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable right_Fx(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [right_Fx_table[:, 1], force_amplitude*right_Fx_table[:, 2]]) annotation(
    Placement(transformation(origin = {130, 40}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable right_Fy(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [right_Fy_table[:, 1], force_amplitude*right_Fy_table[:, 2]]) annotation(
    Placement(transformation(origin = {130, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.Constant right_Fz(k = 0) annotation(
    Placement(transformation(origin = {130, -20}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Sensors.CutForce sprung_loads(animation = false) annotation(
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Sources.Position handwheel_angle(exact = true) annotation(
    Placement(transformation(origin = {-50, 80}, extent = {{-10, -10}, {10, 10}})));
equation
  left_wheel_kin_telemetry.jounce = left_linear_actuator.u_position;
  left_wheel_kin_telemetry.gamma = Axle.left_tire.gamma;
  left_wheel_kin_telemetry.spring_length = 0/*Axle.left_tabular_spring.length*/;
  left_delta_vec = Modelica.Mechanics.MultiBody.Frames.resolve1(Axle.left_cp.R, {1, 0, 0});
  left_wheel_kin_telemetry.toe = atan(left_delta_vec[2]/left_delta_vec[1]);
  left_wheel_kin_telemetry.jacking = sprung_loads.force[3];
  left_kingpin_vec = Axle.left_double_wishbone.jointUSR.frame_im.r_0 - Axle.left_double_wishbone.lower_rigid_link.frame_b.r_0;
  left_wheel_kin_telemetry.caster = atan(-1*left_kingpin_vec[1]/left_kingpin_vec[3]);
  left_wheel_kin_telemetry.kpi = atan(-1*left_kingpin_vec[2]/left_kingpin_vec[3]);
  left_ground_param = (Axle.left_cp.r_0[3] - Axle.left_double_wishbone.jointUSR.frame_im.r_0[3])/left_kingpin_vec[3];
  left_ground_pt = Axle.left_double_wishbone.jointUSR.frame_im.r_0 + left_ground_param*left_kingpin_vec;
  left_wheel_kin_telemetry.mech_trail = left_ground_pt[1] - Axle.left_cp.r_0[1];
  left_wheel_kin_telemetry.mech_scrub = Axle.left_cp.r_0[2] - left_ground_pt[2];
  left_wheel_kin_telemetry.Fx = left_cp_force.force[1];
  left_wheel_kin_telemetry.Fy = left_cp_force.force[2];
  left_wheel_kin_telemetry.roll = roll_expression.y;
  left_wheel_kin_telemetry.stabar_angle = 0/*Axle.stabar.stabar_deflection.angle*/;
  right_wheel_kin_telemetry.jounce = right_linear_actuator.u_position;
  right_wheel_kin_telemetry.gamma = Axle.right_tire.gamma;
  right_wheel_kin_telemetry.spring_length = 0/*Axle.left_tabular_spring.length*/;
  right_delta_vec = Modelica.Mechanics.MultiBody.Frames.resolve1(Axle.right_cp.R, {1, 0, 0});
  right_wheel_kin_telemetry.toe = atan(right_delta_vec[2]/right_delta_vec[1]);
  right_wheel_kin_telemetry.jacking = sprung_loads.force[3];
  right_kingpin_vec = Axle.right_double_wishbone.jointUSR.frame_im.r_0 - Axle.right_double_wishbone.lower_rigid_link.frame_b.r_0;
  right_wheel_kin_telemetry.caster = atan(-1*right_kingpin_vec[1]/right_kingpin_vec[3]);
  right_wheel_kin_telemetry.kpi = atan(right_kingpin_vec[2]/right_kingpin_vec[3]);
  right_ground_param = (Axle.right_cp.r_0[3] - Axle.right_double_wishbone.jointUSR.frame_im.r_0[3])/right_kingpin_vec[3];
  right_ground_pt = Axle.right_double_wishbone.jointUSR.frame_im.r_0 + right_ground_param*right_kingpin_vec;
  right_wheel_kin_telemetry.mech_trail = right_ground_pt[1] - Axle.right_cp.r_0[1];
  right_wheel_kin_telemetry.mech_scrub = right_ground_pt[2] - Axle.right_cp.r_0[2];
  right_wheel_kin_telemetry.Fx = right_cp_force.force[1];
  right_wheel_kin_telemetry.Fy = right_cp_force.force[2];
  right_wheel_kin_telemetry.roll = roll_expression.y;
  right_wheel_kin_telemetry.stabar_angle = 0/*Axle.stabar.stabar_deflection.angle*/;
  connect(fixed.frame_b, roll_frame.frame_a) annotation(
    Line(points = {{0, -80}, {0, -70}}, color = {95, 95, 95}));
  connect(roll_expression.y, roll_position.phi_ref) annotation(
    Line(points = {{-59, -60}, {-42, -60}}, color = {0, 0, 127}));
  connect(roll_position.support, roll_frame.support) annotation(
    Line(points = {{-30, -70}, {-10, -70}, {-10, -66}}));
  connect(roll_position.flange, roll_frame.axis) annotation(
    Line(points = {{-20, -60}, {-10, -60}}));
  connect(left_jounce_signal.y[1], left_linear_actuator.u_position) annotation(
    Line(points = {{-59, -30}, {-51, -30}, {-51, -10}, {-43, -10}}, color = {0, 0, 127}));
  connect(right_jounce_signal.y[1], right_linear_actuator.u_position) annotation(
    Line(points = {{59, -30}, {50, -30}, {50, -10}, {41, -10}}, color = {0, 0, 127}));
  connect(left_Fx.y[1], left_cp_force.force[1]) annotation(
    Line(points = {{-118, 40}, {-100, 40}, {-100, 10}, {-82, 10}}, color = {0, 0, 127}, thickness = 0.5));
  connect(left_Fy.y[1], left_cp_force.force[2]) annotation(
    Line(points = {{-118, 10}, {-82, 10}}, color = {0, 0, 127}, thickness = 0.5));
  connect(left_Fz.y, left_cp_force.force[3]) annotation(
    Line(points = {{-118, -20}, {-100, -20}, {-100, 10}, {-82, 10}}, color = {0, 0, 127}));
  connect(right_Fx.y[1], right_cp_force.force[1]) annotation(
    Line(points = {{120, 40}, {100, 40}, {100, 10}, {82, 10}}, color = {0, 0, 127}, thickness = 0.5));
  connect(right_Fy.y[1], right_cp_force.force[2]) annotation(
    Line(points = {{120, 10}, {82, 10}}, color = {0, 0, 127}, thickness = 0.5));
  connect(right_Fz.y, right_cp_force.force[3]) annotation(
    Line(points = {{119, -20}, {100, -20}, {100, 10}, {82, 10}}, color = {0, 0, 127}));
  connect(roll_frame.frame_b, sprung_loads.frame_a) annotation(
    Line(points = {{0, -50}, {0, -40}}, color = {95, 95, 95}));
  connect(sprung_loads.frame_b, fixedTranslation.frame_a) annotation(
    Line(points = {{0, -20}, {0, 0}}, color = {95, 95, 95}));
  connect(right_spherical.frame_a, right_linear_actuator.frame_b) annotation(
    Line(points = {{30, 10}, {30, 0}}, color = {95, 95, 95}));
  connect(left_spherical.frame_a, left_linear_actuator.frame_b) annotation(
    Line(points = {{-30, 10}, {-30, 0}}, color = {95, 95, 95}));
  connect(left_linear_actuator.frame_a, sprung_loads.frame_a) annotation(
    Line(points = {{-30, -20}, {-30, -40}, {0, -40}}, color = {95, 95, 95}));
  connect(right_linear_actuator.frame_a, sprung_loads.frame_a) annotation(
    Line(points = {{30, -20}, {30, -40}, {0, -40}}, color = {95, 95, 95}));
  connect(left_spherical.frame_b, Axle.left_cp) annotation(
    Line(points = {{-30, 30}, {-30, 40}}, color = {95, 95, 95}));
  connect(right_spherical.frame_b, Axle.right_cp) annotation(
    Line(points = {{30, 30}, {30, 40}}, color = {95, 95, 95}));
  connect(left_cp_force.frame_b, Axle.left_cp) annotation(
    Line(points = {{-60, 10}, {-50, 10}, {-50, 40}, {-30, 40}}, color = {95, 95, 95}));
  connect(right_cp_force.frame_b, Axle.right_cp) annotation(
    Line(points = {{60, 10}, {50, 10}, {50, 40}, {30, 40}}, color = {95, 95, 95}));
  connect(steer_input.y, handwheel_angle.phi_ref) annotation(
    Line(points = {{-78, 80}, {-62, 80}}, color = {0, 0, 127}));
  connect(handwheel_angle.flange, Axle.pinion_flange) annotation(
    Line(points = {{-40, 80}, {0, 80}, {0, 62}}));
  annotation(
    experiment(StartTime = 0, StopTime = 32, Tolerance = 1e-05, Interval = 0.05),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*", ls = "totalpivot", noEquidistantTimeGrid = "()"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --maxSizeLinearTearing=2000",
    Diagram(coordinateSystem(extent = {{-160, 100}, {160, -120}})));
end KnC;
