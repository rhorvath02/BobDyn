within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates.TestStabar;

model TestStabar
  // Parameters
  BobLib.Resources.Records.SUS.FrAxleDWPushBCARB StabarParams annotation(
    Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));
  parameter Real link_diameter = 0.020;
  parameter Real joint_diameter = 0.030;
  Vehicle.Chassis.Suspension.Templates.Stabar.Stabar stabar(left_bar_end = StabarParams.left_bar_end, left_arm_end = StabarParams.left_arm_end, joint_diameter = joint_diameter, link_diameter = link_diameter) annotation(
    Placement(transformation(origin = {0, -4}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed mount_fixture(r = {StabarParams.left_bar_end[1], 0, StabarParams.left_bar_end[3]}, animation = false) annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-130, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 1) annotation(
    Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(mount_fixture.frame_b, stabar.support_frame) annotation(
    Line(points = {{0, -30}, {0, -10}}, color = {95, 95, 95}));
  connect(body.frame_a, stabar.right_arm_frame) annotation(
    Line(points = {{30, 0}, {20, 0}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002),
    Diagram(coordinateSystem(extent = {{-140, -60}, {140, 60}})),
    Icon(coordinateSystem(extent = {{-140, -60}, {140, 60}})));
end TestStabar;
