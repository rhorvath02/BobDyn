within BobDyn.Vehicle.Chassis.Tires.TirePhysics;

model Tire2DOF
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  // Parameters - Dimensions
  parameter SIunits.Length R0 "Tire unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rim_width "Rim width" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rim_R0 "Rim unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  // Parameters - Rates
  parameter SIunits.TranslationalSpringConstant tire_c "Wheel vertical stiffness" annotation(
    Dialog(group = "Rate Properties"));
  parameter SIunits.TranslationalDampingConstant tire_d "Wheel vertical damping" annotation(
    Dialog(group = "Rate Properties"));
  // Parameters - Mass properties
  parameter SIunits.Inertia wheel_J "Wheel + hub inertia tensor (y-axis as spindle)" annotation(Dialog(group = "Mass Properties"));
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a cp_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b chassis_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation=0)));
  // Joint interfaces
  Modelica.Mechanics.MultiBody.Joints.Revolute hub_axis(n = {0, 1, 0}, useAxisFlange = true, animation = false, phi(start = 0, fixed = true), w(start = 0, fixed = true)) annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
  // Tire vertical deflection
  Modelica.Mechanics.MultiBody.Joints.Prismatic tire_z(n = {0, 0, 1}, s(start = R0, fixed = true), useAxisFlange = true, animation = false, v(start = 0, fixed = true))  annotation(
    Placement(transformation(origin = {-30, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Forces.SpringDamperParallel tire_spring(c = tire_c, d = tire_d, s_unstretched = R0, fixedRotationAtFrame_a = false, fixedRotationAtFrame_b = false, animation = false) annotation(
    Placement(transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  // Rotational dynamics
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = wheel_J)  annotation(
    Placement(transformation(origin = {40, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Torque tire_torque_source annotation(
    Placement(transformation(origin = {30, 60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Blocks.Sources.RealExpression tire_torque(y = -cp_frame.f[1]*tire_Re.s_rel)  annotation(
    Placement(transformation(origin = {-30, 60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  // Sensors
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheel_speed annotation(
    Placement(transformation(origin = {80, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sensors.RelPositionSensor tire_Re annotation(
    Placement(transformation(origin = {-60, -70}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteVelocity wheel_vel(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)  annotation(
    Placement(transformation(origin = {50, -90}, extent = {{-10, -10}, {10, 10}})));
  // Visualizers
  Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel voluminousWheel(rRim = rim_R0, rTire = R0, width = rim_width) annotation(
    Placement(transformation(origin = {30, -40}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b hub_frame annotation(
    Placement(transformation(origin = {-70, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Disc disc annotation(
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(cp_frame, tire_spring.frame_a) annotation(
    Line(points = {{0, -100}, {0, -80}}));
  connect(tire_spring.frame_b, hub_axis.frame_a) annotation(
    Line(points = {{0, -60}, {0, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(tire_z.frame_a, tire_spring.frame_a) annotation(
    Line(points = {{-30, -80}, {-30, -90}, {0, -90}, {0, -80}}, color = {95, 95, 95}));
  connect(tire_z.frame_b, tire_spring.frame_b) annotation(
    Line(points = {{-30, -60}, {-30, -50}, {0, -50}, {0, -60}}, color = {95, 95, 95}));
  connect(wheel_speed.flange, inertia.flange_b) annotation(
    Line(points = {{70, 30}, {50, 30}}));
  connect(tire_Re.flange_b, tire_z.axis) annotation(
    Line(points = {{-60, -60}, {-60, -50}, {-36, -50}, {-36, -62}}, color = {0, 127, 0}));
  connect(tire_Re.flange_a, tire_z.support) annotation(
    Line(points = {{-60, -80}, {-60, -90}, {-36, -90}, {-36, -74}}, color = {0, 127, 0}));
  connect(wheel_vel.frame_a, cp_frame) annotation(
    Line(points = {{40, -90}, {0, -90}, {0, -100}}, color = {95, 95, 95}));
  connect(voluminousWheel.frame_a, hub_axis.frame_b) annotation(
    Line(points = {{40, -40}, {50, -40}, {50, 0}, {30, 0}}, color = {95, 95, 95}));
  connect(tire_torque.y, tire_torque_source.tau) annotation(
    Line(points = {{-19, 60}, {18, 60}}, color = {0, 0, 127}));
  connect(hub_axis.axis, inertia.flange_a) annotation(
    Line(points = {{20, 10}, {20, 30}, {30, 30}}));
  connect(chassis_frame, hub_axis.frame_a) annotation(
    Line(points = {{-100, 0}, {10, 0}}));
  connect(tire_torque_source.flange, inertia.flange_b) annotation(
    Line(points = {{40, 60}, {50, 60}, {50, 30}}));
  connect(inertia.flange_a, disc.flange_b) annotation(
    Line(points = {{30, 30}, {10, 30}}));
  connect(hub_frame, disc.flange_a) annotation(
    Line(points = {{-70, 100}, {-70, 30}, {-10, 30}}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Tire2DOF;
