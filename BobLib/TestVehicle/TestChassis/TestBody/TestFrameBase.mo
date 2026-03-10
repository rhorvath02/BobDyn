within BobLib.TestVehicle.TestChassis.TestBody;
model TestFrameBase
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));

  BobLib.Vehicle.Chassis.Body.FrameBase frameBase(
    c_x = 1e9,
    c_y = 1e9,
    c_z = 1e9,
    c_phi_x=1e6,
    c_phi_y=1e3,
    c_phi_z=1e6,
    d_x = 100,
    d_y = 100,
    d_z = 100,
    d_phi_x=10,
    d_phi_y=10,
    d_phi_z=10,
    
    Fr_effective_center = {0, 0, 0},
    Rr_effective_center = {-1, 0, 0}) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = {0, 0, 0}) annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {-1, 0, 0}, m = 100) annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  
equation
  connect(fixed.frame_b, frameBase.frame_a) annotation(
    Line(points = {{-20, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(frameBase.frame_b, body.frame_a) annotation(
    Line(points = {{10, 0}, {20, 0}}, color = {95, 95, 95}));

annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.002));
end TestFrameBase;