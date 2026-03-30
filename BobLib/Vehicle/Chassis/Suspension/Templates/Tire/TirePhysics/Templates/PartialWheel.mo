within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates;

partial model PartialWheel
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Templates.PartialWheelRecord;
  
  // Record parameters
  parameter PartialWheelRecord partialWheelParams;
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a cpFrame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b chassisFrame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  
  Modelica.Mechanics.Rotational.Interfaces.Flange_b hubFlange annotation(
    Placement(transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(extent = {{-10, -10}, {10, 10}})));
  
  // Tire attitude
  Modelica.Mechanics.MultiBody.Parts.FixedRotation toHub(rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
                                                         sequence = {1, 2, 3}, angles = {partialWheelParams.staticGamma, 0, partialWheelParams.staticAlpha})  annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));

  // Rotational physics (wheel rotation about the hub axis)
  Modelica.Mechanics.MultiBody.Joints.Revolute hubAxis(n = {0, 1, 0}, useAxisFlange = true, animation = false, phi(start = 0, fixed = true)) annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));

  // Translational physics (wheel vertical deflection)
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic_z(useAxisFlange = true, n = {0, 0, -1}, animation = true) annotation(
    Placement(transformation(origin = {0, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));

  // Rotational dynamics
  Modelica.Mechanics.Rotational.Components.Inertia inertia annotation(
    Placement(transformation(origin = {40, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Torque tireTorqueSource annotation(
    Placement(transformation(origin = {30, 60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));

  // Torque generation
  Modelica.Blocks.Sources.RealExpression reactionFx(y = -cpFrame.f[1]) annotation(
    Placement(transformation(origin = {-50, 54}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Product tireTorque annotation(
    Placement(transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}})));

  // Sensors
  Modelica.Mechanics.Translational.Sensors.RelPositionSensor radiusSensor annotation(
    Placement(transformation(origin = {-60, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheelRotSpeedSensor annotation(
    Placement(transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteVelocity wheelVelSensor(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) annotation(
    Placement(transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}})));

  // Visualizers
  Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel voluminousWheel(rRim = partialWheelParams.rimR0, rTire = partialWheelParams.R0, width = partialWheelParams.rimWidth) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  
equation
  connect(hubAxis.axis, inertia.flange_a) annotation(
    Line(points = {{20, 10}, {20, 30}, {30, 30}}));
  connect(prismatic_z.frame_a, hubAxis.frame_a) annotation(
    Line(points = {{0, -30}, {0, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(prismatic_z.frame_b, cpFrame) annotation(
    Line(points = {{0, -50}, {0, -100}}, color = {95, 95, 95}));
  connect(radiusSensor.flange_a, prismatic_z.support) annotation(
    Line(points = {{-60, -40}, {-60, -30}, {-6, -30}, {-6, -36}}, color = {0, 127, 0}));
  connect(radiusSensor.flange_b, prismatic_z.axis) annotation(
    Line(points = {{-60, -60}, {-60, -70}, {-6, -70}, {-6, -48}}, color = {0, 127, 0}));
  connect(radiusSensor.s_rel, tireTorque.u1) annotation(
    Line(points = {{-70, -50}, {-80, -50}, {-80, 66}, {-32, 66}}, color = {0, 0, 127}));
  connect(reactionFx.y, tireTorque.u2) annotation(
    Line(points = {{-38, 54}, {-32, 54}}, color = {0, 0, 127}));
  connect(tireTorque.y, tireTorqueSource.tau) annotation(
    Line(points = {{-8, 60}, {18, 60}}, color = {0, 0, 127}));
  connect(voluminousWheel.frame_a, hubAxis.frame_b) annotation(
    Line(points = {{60, 0}, {30, 0}}, color = {95, 95, 95}));
  connect(wheelVelSensor.frame_a, hubAxis.frame_a) annotation(
    Line(points = {{80, -50}, {40, -50}, {40, -20}, {0, -20}, {0, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(tireTorqueSource.flange, inertia.flange_b) annotation(
    Line(points = {{40, 60}, {60, 60}, {60, 30}, {50, 30}}));
  connect(wheelRotSpeedSensor.flange, inertia.flange_b) annotation(
    Line(points = {{80, 50}, {60, 50}, {60, 30}, {50, 30}}));
  connect(hubFlange, inertia.flange_a) annotation(
    Line(points = {{-100, 40}, {20, 40}, {20, 30}, {30, 30}}));
  connect(chassisFrame, toHub.frame_a) annotation(
    Line(points = {{-100, 0}, {-60, 0}}));
  connect(toHub.frame_b, hubAxis.frame_a) annotation(
    Line(points = {{-40, 0}, {10, 0}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(graphics),
    Icon(graphics = {Ellipse(fillColor = {40, 40, 40}, fillPattern = FillPattern.Solid, lineThickness = 3, extent = {{-60, -60}, {60, 60}}), Ellipse(fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-39, -39}, {39, 39}}), Ellipse(fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(points = {{0, 14}, {0, 39}}, thickness = 2), Line(points = {{0, -14}, {0, -39}}, thickness = 2), Line(points = {{14, 0}, {39, 0}}, thickness = 2), Line(points = {{-14, 0}, {-39, 0}}, thickness = 2), Line(points = {{10, 10}, {28, 28}}, thickness = 2), Line(points = {{-10, -10}, {-28, -28}}, thickness = 2), Line(origin = {-2, 2}, points = {{12, -12}, {28, -30}}, thickness = 2), Line(points = {{-10, 10}, {-28, 28}}, thickness = 2), Line(origin = {-63, 0}, points = {{-37, 0}, {63, 0}}, thickness = 5), Ellipse(fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {0, -86}, points = {{0, -14}, {0, 24}}, color = {0, 170, 0}, thickness = 5)}));
end PartialWheel;
