within BobLib.TestVehicle.TestChassis.TestSuspension.TestLinkages;

model TestTabularSpring
  import Modelica.Math.Vectors.normalize;
  
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = {-0.01102743, 0.34553503, 0.41125991}, animation = false)  annotation(
    Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}})));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 70, sphereDiameter = 0.625*0.0254, enforceStates = true) annotation(
    Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));
  Vehicle.Chassis.Suspension.Linkages.TabularSpring tabularSpring(force_table = [0, 0; 0.02, 800; 0.035, 1400], free_length = 0.17943000, start_point = {-0.01102743, 0.34553503, 0.41125991}, end_point = {-0.02067347, 0.24784709, 0.56145693}, spring_diameter = 0.040)  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
equation
  connect(tabularSpring.frame_b, body.frame_a) annotation(
    Line(points = {{10, 0}, {30, 0}}, color = {95, 95, 95}));
  connect(fixed.frame_b, tabularSpring.frame_a) annotation(
    Line(points = {{-30, 0}, {-10, 0}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-08, Interval = 0.0001));
end TestTabularSpring;
