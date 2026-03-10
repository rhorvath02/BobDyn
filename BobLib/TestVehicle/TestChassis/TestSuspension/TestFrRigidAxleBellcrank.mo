within BobLib.TestVehicle.TestChassis.TestSuspension;

model TestFrRigidAxleBellcrank
  
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  
  BobLib.Vehicle.Chassis.Suspension.FrAxleDWPushBCARB Fr_axle(final link_diameter = 0.025,
                                                                   final joint_diameter = 0.030)  annotation(
    Placement(transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Blocks.Sources.Constant FL_torque_in(k = 0)  annotation(
    Placement(transformation(origin = {-50, 17}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant FR_torque_in(k = 0)  annotation(
    Placement(transformation(origin = {50, 17}, extent = {{10, -10}, {-10, 10}})));
  
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics FL_ground(c = 1e8, d = 1e4)  annotation(
    Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics FR_ground(c = 1e8, d = 1e4)  annotation(
    Placement(transformation(origin = {30, -30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed constrain_axle(r = Fr_axle.effective_center) annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  output Real test;
  Modelica.Blocks.Sources.Ramp ramp(height = 1.25*0.0254, duration = 1, startTime = 1)  annotation(
    Placement(transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}})));
equation
  test = Fr_axle.left_cp.r_0[2];
  connect(world.frame_b, FL_ground.frame_a) annotation(
    Line(points = {{-80, -90}, {-70, -90}, {-70, -30}, {-40, -30}}, color = {95, 95, 95}));
  connect(world.frame_b, FR_ground.frame_a) annotation(
    Line(points = {{-80, -90}, {70, -90}, {70, -30}, {40, -30}}, color = {95, 95, 95}));
  connect(FL_torque_in.y, Fr_axle.left_torque) annotation(
    Line(points = {{-38, 18}, {-12, 18}, {-12, 16}}, color = {0, 0, 127}));
  connect(FR_torque_in.y, Fr_axle.right_torque) annotation(
    Line(points = {{40, 18}, {12, 18}, {12, 16}}, color = {0, 0, 127}));
  connect(FL_ground.frame_b, Fr_axle.left_cp) annotation(
    Line(points = {{-30, -20}, {-30, 10}, {-10, 10}}, color = {95, 95, 95}));
  connect(FR_ground.frame_b, Fr_axle.right_cp) annotation(
    Line(points = {{30, -20}, {30, 10}, {10, 10}}, color = {95, 95, 95}));
  connect(ramp.y, Fr_axle.steer_input) annotation(
    Line(points = {{-18, 50}, {0, 50}, {0, 22}}, color = {0, 0, 127}));
  connect(constrain_axle.frame_b, Fr_axle.axle_frame) annotation(
    Line(points = {{0, -30}, {0, 0}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 6, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"));
end TestFrRigidAxleBellcrank;
