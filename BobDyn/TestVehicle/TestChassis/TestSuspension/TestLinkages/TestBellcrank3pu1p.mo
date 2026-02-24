within BobDyn.TestVehicle.TestChassis.TestSuspension.TestLinkages;
model TestBellcrank3pu1p

  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = {0, 0, 0}) annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  BobDyn.Vehicle.Chassis.Suspension.Linkages.Bellcrank3pu1p bellcrank(pivot = {0, 0, 0}, pivot_ref = {1, 0, 0}, pickup_1 = {0, 0.25, 0}, pickup_2 = {0, 0.5, 0.25}, pickup_3 = {0, 0.25, 0.15})  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 1)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(fixed.frame_b, bellcrank.mount_frame) annotation(
    Line(points = {{-20, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(bellcrank.pickup_2_frame, body.frame_a) annotation(
    Line(points = {{10, 0}, {20, 0}}, color = {95, 95, 95}));
end TestBellcrank3pu1p;