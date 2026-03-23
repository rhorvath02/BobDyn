within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates.TestSteeringRack;

model TestRackAndPinion
  // Test parameters
  parameter BobLib.Resources.Records.SUS.FrAxleDW Axle annotation(
    Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));
  
  parameter Real link_diameter = 0.020;
  
  Vehicle.Chassis.Suspension.Templates.SteeringRack.RackAndPinion RackAndPinion(tie_i = Axle.tie_inboard, c_factor = 0.088646, link_diameter = link_diameter)  annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed rack_fixed(r = {Axle.tie_inboard[1], 0, Axle.tie_inboard[3]}, animation = false)  annotation(
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position position(exact = true)  annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp steer_ramp(height = 100*Modelica.Constants.pi/180, duration = 1, startTime = 1)  annotation(
    Placement(transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed spring_support(r = {Axle.tie_inboard[1], Axle.tie_inboard[2] + 0.5, Axle.tie_inboard[3]}, animation = false)  annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Forces.Spring spring(c = 1e6, s_unstretched = 0.5, width = link_diameter*2, numberOfWindings = 10)  annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(rack_fixed.frame_b, RackAndPinion.mount_frame) annotation(
    Line(points = {{0, -20}, {0, -4}}, color = {95, 95, 95}));
  connect(position.flange, RackAndPinion.pinion_flange) annotation(
    Line(points = {{-10, 30}, {0, 30}, {0, 4}}));
  connect(steer_ramp.y, position.phi_ref) annotation(
    Line(points = {{-48, 30}, {-32, 30}}, color = {0, 0, 127}));
  connect(spring_support.frame_b, spring.frame_a) annotation(
    Line(points = {{-80, 0}, {-60, 0}}, color = {95, 95, 95}));
  connect(spring.frame_b, RackAndPinion.left_frame) annotation(
    Line(points = {{-40, 0}, {-20, 0}}, color = {95, 95, 95}));
  annotation(
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --daeMode",
  experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002));
end TestRackAndPinion;
