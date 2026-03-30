within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates.TestStabar;

model TestStabar
  import BobLib.Resources.VehicleDefn.OrionRecord;
  
  parameter OrionRecord pVehicle;
  
  parameter Real linkDiameter = 0.020;
  parameter Real jointDiameter = 0.030;
  
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-130, -50}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.Fixed mountFixture(r = {pVehicle.pFrStabar.leftBarEnd[1], 0, pVehicle.pFrStabar.leftBarEnd[3]}, animation = false) annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  Vehicle.Chassis.Suspension.Templates.Stabar.Stabar stabar(pStabar = pVehicle.pFrStabar, linkDiameter = linkDiameter, jointDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {0, -4}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 1, sphereDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(mountFixture.frame_b, stabar.supportFrame) annotation(
    Line(points = {{0, -30}, {0, -10}}, color = {95, 95, 95}));
  connect(body.frame_a, stabar.rightArmFrame) annotation(
    Line(points = {{30, 0}, {20, 0}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002),
    Diagram(coordinateSystem(extent = {{-140, -60}, {140, 60}})),
    Icon(coordinateSystem(extent = {{-140, -60}, {140, 60}})));
end TestStabar;
