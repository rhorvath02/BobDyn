within BobDyn.TestVehicle.TestChassis.TestSuspension.TestJoints;

model TestxyzSphericalCompliant
  
  // Fixed ends
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed_in(r = {0, 0, 0}) annotation(
    Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed_out(r = {1, 1, 1})  annotation(
    Placement(transformation(origin = {40, 0}, extent = {{10, -10}, {-10, 10}})));

  // Joint
  Vehicle.Chassis.Suspension.Joints.xyzSphericalCompliant test_joint(trans_x_stiffness = 1e3, trans_y_stiffness = 1e2, trans_z_stiffness = 1e1, trans_x_damping = 1, trans_y_damping = 1, trans_z_damping = 1)  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  
equation
  connect(fixed_in.frame_b, test_joint.frame_a) annotation(
    Line(points = {{-30, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(fixed_out.frame_b, test_joint.frame_b) annotation(
    Line(points = {{30, 0}, {10, 0}}, color = {95, 95, 95}));
end TestxyzSphericalCompliant;