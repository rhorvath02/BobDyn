within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates.TestSteeringRack;

model TestRackAndPinion
  import BobLib.Resources.VehicleDefn.OrionRecord;
  
  parameter OrionRecord pVehicle;
  
  parameter Real linkDiameter = 0.020;
  
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  
  // Rack definition
  Modelica.Mechanics.MultiBody.Parts.Fixed rackFixed(r = {pVehicle.pRack.leftPickup[1], 0, pVehicle.pRack.leftPickup[3]}, animation = false)  annotation(
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  BobLib.Vehicle.Chassis.Suspension.Templates.SteeringRack.RackAndPinion rackAndPinion(pRack = pVehicle.pRack, linkDiameter = linkDiameter)  annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}})));
  
  // Pinion input
  Modelica.Blocks.Sources.Ramp pinionRamp(height = 100*Modelica.Constants.pi/180, duration = 1, startTime = 1)  annotation(
    Placement(transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position pinionPosition(exact = true)  annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}})));
  
  // Torque feedback
  Modelica.Mechanics.MultiBody.Parts.Fixed springSupport(r = {pVehicle.pRack.leftPickup[1], pVehicle.pRack.leftPickup[2] + 0.5, pVehicle.pRack.leftPickup[3]}, animation = false)  annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Forces.Spring spring(c = 1e6, s_unstretched = 0.5, width = linkDiameter*2)  annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(rackFixed.frame_b, rackAndPinion.mountFrame) annotation(
    Line(points = {{0, -20}, {0, -4}}, color = {95, 95, 95}));
  connect(pinionPosition.flange, rackAndPinion.pinionFlange) annotation(
    Line(points = {{-10, 30}, {0, 30}, {0, 4}}));
  connect(pinionRamp.y, pinionPosition.phi_ref) annotation(
    Line(points = {{-48, 30}, {-32, 30}}, color = {0, 0, 127}));
  connect(springSupport.frame_b, spring.frame_a) annotation(
    Line(points = {{-80, 0}, {-60, 0}}, color = {95, 95, 95}));
  connect(spring.frame_b, rackAndPinion.leftFrame) annotation(
    Line(points = {{-40, 0}, {-20, 0}}, color = {95, 95, 95}));
  
  annotation(experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002));
end TestRackAndPinion;
