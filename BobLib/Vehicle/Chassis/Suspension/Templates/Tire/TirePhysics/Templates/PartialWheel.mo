within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates;

partial model PartialWheel
  // Modelica units
  import Modelica.SIunits;

  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;

  // Dimensional parameters
  parameter SIunits.Length R0 "Tire unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rim_R0 = R0*0.625 "Rim unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rim_width = rim_R0*1.4 "Rim unloaded width" annotation(
    Dialog(group = "Dimensions"));

  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a cp_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b chassis_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));

  // Rotational physics (wheel rotation about the hub axis)
  Modelica.Mechanics.MultiBody.Joints.Revolute hub_axis(n = {0, 1, 0}, useAxisFlange = true, animation = false, phi(start = 0, fixed = true)) annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));

  // Translational physics (wheel vertical deflection)
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic_z(useAxisFlange = true, n = {0, 0, -1}, animation = true) annotation(
    Placement(transformation(origin = {0, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));

  // Rotational dynamics
  Modelica.Mechanics.Rotational.Components.Inertia inertia annotation(
    Placement(transformation(origin = {40, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Torque tire_torque_source annotation(
    Placement(transformation(origin = {30, 60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));

  // Torque generation
  Modelica.Blocks.Sources.RealExpression Fx_reaction(y = -cp_frame.f[1]) annotation(
    Placement(transformation(origin = {-50, 54}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Product tire_torque annotation(
    Placement(transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}})));

  // Sensors
  Modelica.Mechanics.Translational.Sensors.RelPositionSensor radius_sensor annotation(
    Placement(transformation(origin = {-60, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheel_rot_speed_sensor annotation(
    Placement(transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteVelocity wheel_vel_sensor(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) annotation(
    Placement(transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}})));

  // Visualizers
  Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel voluminous_wheel(rRim = rim_R0, rTire = R0, width = rim_width) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));

equation
  connect(hub_axis.axis, inertia.flange_a) annotation(
    Line(points = {{20, 10}, {20, 30}, {30, 30}}));
  connect(chassis_frame, hub_axis.frame_a) annotation(
    Line(points = {{-100, 0}, {10, 0}}));
  connect(prismatic_z.frame_a, hub_axis.frame_a) annotation(
    Line(points = {{0, -30}, {0, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(prismatic_z.frame_b, cp_frame) annotation(
    Line(points = {{0, -50}, {0, -100}}, color = {95, 95, 95}));
  connect(radius_sensor.flange_a, prismatic_z.support) annotation(
    Line(points = {{-60, -40}, {-60, -30}, {-6, -30}, {-6, -36}}, color = {0, 127, 0}));
  connect(radius_sensor.flange_b, prismatic_z.axis) annotation(
    Line(points = {{-60, -60}, {-60, -70}, {-6, -70}, {-6, -48}}, color = {0, 127, 0}));
  connect(radius_sensor.s_rel, tire_torque.u1) annotation(
    Line(points = {{-70, -50}, {-80, -50}, {-80, 66}, {-32, 66}}, color = {0, 0, 127}));
  connect(Fx_reaction.y, tire_torque.u2) annotation(
    Line(points = {{-38, 54}, {-32, 54}}, color = {0, 0, 127}));
  connect(tire_torque.y, tire_torque_source.tau) annotation(
    Line(points = {{-8, 60}, {18, 60}}, color = {0, 0, 127}));
  connect(voluminous_wheel.frame_a, hub_axis.frame_b) annotation(
    Line(points = {{60, 0}, {30, 0}}, color = {95, 95, 95}));
  connect(wheel_vel_sensor.frame_a, hub_axis.frame_a) annotation(
    Line(points = {{80, -50}, {40, -50}, {40, -20}, {0, -20}, {0, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(tire_torque_source.flange, inertia.flange_b) annotation(
    Line(points = {{40, 60}, {60, 60}, {60, 30}, {50, 30}}));
  connect(wheel_rot_speed_sensor.flange, inertia.flange_b) annotation(
    Line(points = {{80, 50}, {60, 50}, {60, 30}, {50, 30}}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(graphics),
    Icon(graphics = {Ellipse(fillColor = {40, 40, 40}, fillPattern = FillPattern.Solid, lineThickness = 3, extent = {{-60, -60}, {60, 60}}), Ellipse(fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-39, -39}, {39, 39}}), Ellipse(fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(points = {{0, 14}, {0, 39}}, thickness = 2), Line(points = {{0, -14}, {0, -39}}, thickness = 2), Line(points = {{14, 0}, {39, 0}}, thickness = 2), Line(points = {{-14, 0}, {-39, 0}}, thickness = 2), Line(points = {{10, 10}, {28, 28}}, thickness = 2), Line(points = {{-10, -10}, {-28, -28}}, thickness = 2), Line(origin = {-2, 2}, points = {{12, -12}, {28, -30}}, thickness = 2), Line(points = {{-10, 10}, {-28, 28}}, thickness = 2), Line(origin = {-63, 0}, points = {{-37, 0}, {63, 0}}, thickness = 5), Ellipse(fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {0, -86}, points = {{0, -14}, {0, 24}}, color = {0, 170, 0}, thickness = 5)}));
end PartialWheel;
