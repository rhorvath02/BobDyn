within BobLib.TestVehicle.TestChassis.TestSuspension.TestLinkages;

model TestShockLinkage
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  // Fixed base
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = {-0.01102743, 0.34553503, 0.41125991}, animation = false) annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));

// Mass
  Modelica.Mechanics.MultiBody.Parts.Body body(m = 70, r_CM = {0, 0, 0}, animation = false) annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  // Damper under test
  BobLib.Vehicle.Chassis.Suspension.Linkages.ShockLinkage shock_linkage(start_point = {-0.01102743, 0.34553503, 0.41125991}, end_point = {-0.02067347, 0.24784709, 0.56145693}, spring_diameter = 0.040, free_length = norm({-0.02067347, 0.24784709, 0.56145693} - {-0.01102743, 0.34553503, 0.41125991})/2, spring_mass = 0, link_diameter = 0.625*0.0254, joint_diameter = 0.825*0.0254, rod_length_fraction = 0.5, spring_table = [0, 0; 1, 80000], damper_table = [0, 0; 0.25, 100], damper_mass = 0) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
equation
  connect(fixed.frame_b, shock_linkage.frame_a) annotation(
    Line(points = {{-20, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(body.frame_a, shock_linkage.frame_b) annotation(
    Line(points = {{20, 0}, {10, 0}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-08, Interval = 5e-05));
end TestShockLinkage;
