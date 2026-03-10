within BobLib.Vehicle.Chassis.Tires.TirePhysics;

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
  // Rotational dynamics
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = wheel_J)  annotation(
    Placement(transformation(origin = {40, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Torque tire_torque_source annotation(
    Placement(transformation(origin = {30, 60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Blocks.Sources.RealExpression tire_torque(y = -cp_frame.f[1]*radius_sensor.r[3])  annotation(
    Placement(transformation(origin = {-30, 60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  // Sensors
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheel_speed annotation(
    Placement(transformation(origin = {80, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteVelocity wheel_vel(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)  annotation(
    Placement(transformation(origin = {50, -90}, extent = {{-10, -10}, {10, 10}})));
  // Visualizers
  Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel voluminousWheel(rRim = rim_R0, rTire = R0, width = rim_width) annotation(
    Placement(transformation(origin = {30, -40}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b hub_frame annotation(
    Placement(transformation(origin = {-70, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Disc disc annotation(
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation tire_radius(r = R0*{0, 0, -1})  annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Sensors.AbsolutePosition radius_sensor annotation(
    Placement(transformation(origin = {-30, -20}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(wheel_speed.flange, inertia.flange_b) annotation(
    Line(points = {{70, 30}, {50, 30}}));
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
  connect(hub_axis.frame_a, tire_radius.frame_a) annotation(
    Line(points = {{10, 0}, {0, 0}, {0, -30}}, color = {95, 95, 95}));
  connect(tire_radius.frame_b, cp_frame) annotation(
    Line(points = {{0, -50}, {0, -100}}, color = {95, 95, 95}));
  connect(radius_sensor.frame_a, tire_radius.frame_a) annotation(
    Line(points = {{-20, -20}, {0, -20}, {0, -30}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Tire2DOF;
