within BobDyn.TestVehicle.TestChassis.TestSuspension;

model TestRrRigidAxleBellcrank
  
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  
  BobDyn.Vehicle.Chassis.Suspension.RrAxleDWPullBCARB Rr_axle(link_diameter = 0.025, joint_diameter = 0.030)  annotation(
    Placement(transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Blocks.Sources.Constant RL_torque_in(k = 0)  annotation(
    Placement(transformation(origin = {-50, 17}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant RR_torque_in(k = 0)  annotation(
    Placement(transformation(origin = {50, 17}, extent = {{10, -10}, {-10, 10}})));
  
  BobDyn.Utilities.Mechanics.Multibody.GroundPhysics RL_ground annotation(
    Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}})));
  BobDyn.Utilities.Mechanics.Multibody.GroundPhysics RR_ground annotation(
    Placement(transformation(origin = {30, -30}, extent = {{10, -10}, {-10, 10}})));
  
  output Real test;
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = Rr_axle.effective_center, animation = false)  annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  test = Rr_axle.left_cp.r_0[2];
  connect(RL_ground.frame_a, world.frame_b) annotation(
    Line(points = {{-40, -30}, {-70, -30}, {-70, -90}, {-80, -90}}, color = {95, 95, 95}));
  connect(RR_ground.frame_a, world.frame_b) annotation(
    Line(points = {{40, -30}, {70, -30}, {70, -90}, {-80, -90}}, color = {95, 95, 95}));
  connect(fixed.frame_b, Rr_axle.axle_frame) annotation(
    Line(points = {{0, -30}, {0, 0}}, color = {95, 95, 95}));
  connect(Rr_axle.left_cp, RL_ground.frame_b) annotation(
    Line(points = {{-10, 2}, {-30, 2}, {-30, -20}}, color = {95, 95, 95}));
  connect(Rr_axle.right_cp, RR_ground.frame_b) annotation(
    Line(points = {{10, 2}, {30, 2}, {30, -20}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 6, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"));
end TestRrRigidAxleBellcrank;
