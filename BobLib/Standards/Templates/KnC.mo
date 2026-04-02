within BobLib.Standards.Templates;

partial model KnC
  import Modelica.SIunits;
  Real leftGamma;
  Real leftToe;
  Real leftCaster;
  Real leftKpi;
  Real leftMechTrail;
  Real leftMechScrub;
  Real rightGamma;
  Real rightToe;
  Real rightCaster;
  Real rightKpi;
  Real rightMechTrail;
  Real rightMechScrub;
  Real jackingForce;
  Real heaveSignal;
  Real rollSignal;
  Real fxSignal;
  Real fySignal;
  inner parameter SIunits.Length linkDiameter = 0.020;
  inner parameter SIunits.Length jointDiameter = 0.030;
  parameter SIunits.Angle steerMagnitude = 0 "Maximum pinion angle magnitude" annotation(
    Dialog(group = "Test Parameters"));
  parameter SIunits.Length heaveMagnitude = 1.5*0.0254 "Maximum heave magnitude" annotation(
    Dialog(group = "Test Parameters"));
  parameter SIunits.Angle rollMagnitude = 2*Modelica.Constants.pi/180 "Maximum roll magnitude" annotation(
    Dialog(group = "Test Parameters"));
  parameter SIunits.Force forceMagnitude = 100 "Maximum contact patch force" annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  inner Modelica.Mechanics.MultiBody.World world(g = 0, n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-130, -110}, extent = {{-10, -10}, {10, 10}})));
protected
  Real leftDeltaVec[3];
  Real leftKingpinVec[3];
  Real leftGroundParam;
  Real leftGroundPoint[3];
  Real rightDeltaVec[3];
  Real rightKingpinVec[3];
  Real rightGroundParam;
  Real rightGroundPoint[3];
  // Time-value tables [time, normalized value]
  final parameter Real rollTable[:, 2] = [0, 0; 1, 0; 2, 0; 3, 0; 4, 0; 5, 0; 6, 0; 7, 0; 8, 0; 9, 0; 10, 0; 11, 0; 12, 0; 13, 0; 14, 0; 15, 0; 16, 0; 17, 0; 18, 0; 19, 0; 20, 0; 21, 0; 22, 0; 23, 0; 24, 0; 25, 0; 26, 0; 27, 0; 28, 0; 29, 0; 30, 0; 31, 0; 32, 0; 33, 0; 34, 0; 35, 0; 36, 0; 37, 0; 38, 0; 39, 0; 40, 0; 41, 0; 42, 0; 43, 0; 44, 0; 45, 0; 46, 0; 47, -1; 48, -1; 49, -1; 50, -1; 51, -0.8; 52, -0.8; 53, -0.8; 54, -0.8; 55, -0.6; 56, -0.6; 57, -0.6; 58, -0.6; 59, -0.4; 60, -0.4; 61, -0.4; 62, -0.4; 63, -0.2; 64, -0.2; 65, -0.2; 66, -0.2; 67, 0; 68, 0; 69, 0; 70, 0; 71, 0.2; 72, 0.2; 73, 0.2; 74, 0.2; 75, 0.4; 76, 0.4; 77, 0.4; 78, 0.4; 79, 0.6; 80, 0.6; 81, 0.6; 82, 0.6; 83, 0.8; 84, 0.8; 85, 0.8; 86, 0.8; 87, 1; 88, 1; 89, 1; 90, 1; 91, 0];
  final parameter Real heaveTable[:, 2] = [0, 0; 1, 0; 2, -1; 3, -1; 4, -1; 5, -1; 6, -0.8; 7, -0.8; 8, -0.8; 9, -0.8; 10, -0.6; 11, -0.6; 12, -0.6; 13, -0.6; 14, -0.4; 15, -0.4; 16, -0.4; 17, -0.4; 18, -0.2; 19, -0.2; 20, -0.2; 21, -0.2; 22, 0; 23, 0; 24, 0; 25, 0; 26, 0.2; 27, 0.2; 28, 0.2; 29, 0.2; 30, 0.4; 31, 0.4; 32, 0.4; 33, 0.4; 34, 0.6; 35, 0.6; 36, 0.6; 37, 0.6; 38, 0.8; 39, 0.8; 40, 0.8; 41, 0.8; 42, 1; 43, 1; 44, 1; 45, 1; 46, 0; 47, 0; 48, 0; 49, 0; 50, 0; 51, 0; 52, 0; 53, 0; 54, 0; 55, 0; 56, 0; 57, 0; 58, 0; 59, 0; 60, 0; 61, 0; 62, 0; 63, 0; 64, 0; 65, 0; 66, 0; 67, 0; 68, 0; 69, 0; 70, 0; 71, 0; 72, 0; 73, 0; 74, 0; 75, 0; 76, 0; 77, 0; 78, 0; 79, 0; 80, 0; 81, 0; 82, 0; 83, 0; 84, 0; 85, 0; 86, 0; 87, 0; 88, 0; 89, 0; 90, 0; 91, 0];
  final parameter Real fxTable[:, 2] = [0, 0; 1, 0; 2, 0; 3, 1; 4, 1; 5, 0; 6, 0; 7, 1; 8, 1; 9, 0; 10, 0; 11, 1; 12, 1; 13, 0; 14, 0; 15, 1; 16, 1; 17, 0; 18, 0; 19, 1; 20, 1; 21, 0; 22, 0; 23, 1; 24, 1; 25, 0; 26, 0; 27, 1; 28, 1; 29, 0; 30, 0; 31, 1; 32, 1; 33, 0; 34, 0; 35, 1; 36, 1; 37, 0; 38, 0; 39, 1; 40, 1; 41, 0; 42, 0; 43, 1; 44, 1; 45, 0; 46, 0; 47, 0; 48, 0; 49, 0; 50, 0; 51, 0; 52, 0; 53, 0; 54, 0; 55, 0; 56, 0; 57, 0; 58, 0; 59, 0; 60, 0; 61, 0; 62, 0; 63, 0; 64, 0; 65, 0; 66, 0; 67, 0; 68, 0; 69, 0; 70, 0; 71, 0; 72, 0; 73, 0; 74, 0; 75, 0; 76, 0; 77, 0; 78, 0; 79, 0; 80, 0; 81, 0; 82, 0; 83, 0; 84, 0; 85, 0; 86, 0; 87, 0; 88, 0; 89, 0; 90, 0; 91, 0];
  final parameter Real fyTable[:, 2] = [0, 0; 1, 0; 2, 0; 3, 0; 4, 0; 5, 0; 6, 0; 7, 0; 8, 0; 9, 0; 10, 0; 11, 0; 12, 0; 13, 0; 14, 0; 15, 0; 16, 0; 17, 0; 18, 0; 19, 0; 20, 0; 21, 0; 22, 0; 23, 0; 24, 0; 25, 0; 26, 0; 27, 0; 28, 0; 29, 0; 30, 0; 31, 0; 32, 0; 33, 0; 34, 0; 35, 0; 36, 0; 37, 0; 38, 0; 39, 0; 40, 0; 41, 0; 42, 0; 43, 0; 44, 0; 45, 0; 46, 0; 47, 0; 48, 1; 49, 1; 50, 0; 51, 0; 52, 1; 53, 1; 54, 0; 55, 0; 56, 1; 57, 1; 58, 0; 59, 0; 60, 1; 61, 1; 62, 0; 63, 0; 64, 1; 65, 1; 66, 0; 67, 0; 68, 1; 69, 1; 70, 0; 71, 0; 72, 1; 73, 1; 74, 0; 75, 0; 76, 1; 77, 1; 78, 0; 79, 0; 80, 1; 81, 1; 82, 0; 83, 0; 84, 1; 85, 1; 86, 0; 87, 0; 88, 1; 89, 1; 90, 0; 91, 0];
  // Ground fixture
  Modelica.Mechanics.MultiBody.Parts.Fixed groundFixed(r = {0, 0, 0}, animation = false) annotation(
    Placement(transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  // Roll DOF
  Modelica.Mechanics.MultiBody.Joints.Revolute rollDOF(n = {1, 0, 0}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.CombiTimeTable rollSource(table = rollTable) annotation(
    Placement(transformation(origin = {-60, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain rollGain(k = rollMagnitude) annotation(
    Placement(transformation(origin = {-35, -70}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Mechanics.Rotational.Sources.Position rollPosition(useSupport = true, exact = true) annotation(
    Placement(transformation(origin = {-22, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
  // Heave DOF
  Modelica.Mechanics.MultiBody.Joints.Prismatic heaveDOF(useAxisFlange = true, n = {0, 0, 1}, e) annotation(
    Placement(transformation(origin = {0, 20}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.CombiTimeTable heaveSource(table = heaveTable) annotation(
    Placement(transformation(origin = {40, -50}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain heaveGain(k = heaveMagnitude) annotation(
    Placement(transformation(origin = {20, -10}, extent = {{5, -5}, {-5, 5}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sources.Position heavePosition(useSupport = true, exact = true) annotation(
    Placement(transformation(origin = {20, 16}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  // Kinematics to axle
  Modelica.Mechanics.MultiBody.Parts.FixedRotation toAxle(animation = false) annotation(
    Placement(transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  // Contact patch references
  Modelica.Mechanics.MultiBody.Parts.Fixed leftCPFixed(animation = false) annotation(
    Placement(transformation(origin = {-120, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed rightCPFixed(animation = false) annotation(
    Placement(transformation(origin = {120, -80}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  // Left contact patch forces
  Modelica.Blocks.Sources.CombiTimeTable leftFxSource(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = fxTable) annotation(
    Placement(transformation(origin = {-130, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain leftFxGain(k = forceMagnitude/2) annotation(
    Placement(transformation(origin = {-105, 80}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.CombiTimeTable leftFySource(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = fyTable) annotation(
    Placement(transformation(origin = {-130, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain leftFyGain(k = forceMagnitude/2) annotation(
    Placement(transformation(origin = {-105, 50}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant leftFzSource(k = 0) annotation(
    Placement(transformation(origin = {-130, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Forces.WorldForce leftCPForce(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world) annotation(
    Placement(transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}})));
  // Right contact patch forces
  Modelica.Blocks.Sources.CombiTimeTable rightFxSource(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = fxTable) annotation(
    Placement(transformation(origin = {130, 80}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain rightFxGain(k = forceMagnitude/2) annotation(
    Placement(transformation(origin = {105, 80}, extent = {{5, -5}, {-5, 5}})));
  Modelica.Blocks.Sources.CombiTimeTable rightFySource(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = fyTable) annotation(
    Placement(transformation(origin = {130, 50}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain rightFyGain(k = forceMagnitude/2) annotation(
    Placement(transformation(origin = {105, 50}, extent = {{5, -5}, {-5, 5}})));
  Modelica.Blocks.Sources.Constant rightFzSource(k = 0) annotation(
    Placement(transformation(origin = {130, 20}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Forces.WorldForce rightCPForce(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world) annotation(
    Placement(transformation(origin = {70, 20}, extent = {{10, -10}, {-10, 10}})));
  // Instrumentation
  Modelica.Mechanics.MultiBody.Sensors.CutForce sprungLoads(animation = false) annotation(
    Placement(transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  // Left jounce DOFs
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_DOF_x(animation = false, n = {1, 0, 0}) annotation(
    Placement(transformation(origin = {-120, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_DOF_y(animation = false, n = {0, 1, 0}) annotation(
    Placement(transformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical left_DOF_xyz(sphereDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {-40, -10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute leftRevolute(n = {1, 0, 0}, useAxisFlange = true, animation = false) annotation(
    Placement(transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Disc leftAngleOffset(deltaPhi = Modelica.Constants.pi/2) annotation(
    Placement(transformation(origin = {-71, -5}, extent = {{-5, -5}, {5, 5}})));
  // Right jounce DOFs
  Modelica.Mechanics.MultiBody.Joints.Prismatic right_DOF_x(animation = false, n = {1, 0, 0}) annotation(
    Placement(transformation(origin = {120, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic right_DOF_y(animation = false, n = {0, 1, 0}) annotation(
    Placement(transformation(origin = {100, -30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical right_DOF_xyz(sphereDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute rightRevolute(useAxisFlange = true, n = {1, 0, 0}, animation = false) annotation(
    Placement(transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.Rotational.Components.Disc rightAngleOffset(deltaPhi = -Modelica.Constants.pi/2) annotation(
    Placement(transformation(origin = {71, -5}, extent = {{5, -5}, {-5, 5}})));
equation
// Instrumentation
  jackingForce = sprungLoads.force[3];
// Route user-interface signals
  heaveSignal = heaveGain.y;
  rollSignal = rollGain.y;
  fxSignal = leftFxGain.y*2;
  fySignal = leftFyGain.y*2;
  connect(groundFixed.frame_b, sprungLoads.frame_a) annotation(
    Line(points = {{0, -100}, {0, -80}}, color = {95, 95, 95}));
  connect(rollPosition.support, rollDOF.support) annotation(
    Line(points = {{-12, -50}, {-10, -50}, {-10, -46}}));
  connect(rollPosition.flange, rollDOF.axis) annotation(
    Line(points = {{-22, -40}, {-10, -40}}));
  connect(sprungLoads.frame_b, rollDOF.frame_a) annotation(
    Line(points = {{0, -60}, {0, -50}}, color = {95, 95, 95}));
  connect(leftCPFixed.frame_b, left_DOF_x.frame_a) annotation(
    Line(points = {{-120, -70}, {-120, -60}}, color = {95, 95, 95}));
  connect(left_DOF_x.frame_b, left_DOF_y.frame_a) annotation(
    Line(points = {{-120, -40}, {-120, -30}, {-110, -30}}, color = {95, 95, 95}));
  connect(rightCPFixed.frame_b, right_DOF_x.frame_a) annotation(
    Line(points = {{120, -70}, {120, -60}}, color = {95, 95, 95}));
  connect(right_DOF_x.frame_b, right_DOF_y.frame_a) annotation(
    Line(points = {{120, -40}, {120, -30}, {110, -30}}, color = {95, 95, 95}));
  connect(leftRevolute.support, leftAngleOffset.flange_a) annotation(
    Line(points = {{-76, -20}, {-76, -4}}));
  connect(rightAngleOffset.flange_a, rightRevolute.support) annotation(
    Line(points = {{76, -5}, {76, -21}}));
  connect(rightAngleOffset.flange_b, rightRevolute.axis) annotation(
    Line(points = {{66, -5}, {60, -5}, {60, -21}, {70, -21}}));
  connect(leftAngleOffset.flange_b, leftRevolute.axis) annotation(
    Line(points = {{-66, -5}, {-60, -5}, {-60, -21}, {-70, -21}}));
  connect(left_DOF_y.frame_b, leftRevolute.frame_a) annotation(
    Line(points = {{-90, -30}, {-80, -30}}, color = {95, 95, 95}));
  connect(right_DOF_y.frame_b, rightRevolute.frame_a) annotation(
    Line(points = {{90, -30}, {80, -30}}, color = {95, 95, 95}));
  connect(leftRevolute.frame_b, left_DOF_xyz.frame_a) annotation(
    Line(points = {{-60, -30}, {-40, -30}, {-40, -20}}, color = {95, 95, 95}));
  connect(rightRevolute.frame_b, right_DOF_xyz.frame_a) annotation(
    Line(points = {{60, -30}, {40, -30}, {40, -20}}, color = {95, 95, 95}));
  connect(leftFzSource.y, leftCPForce.force[3]) annotation(
    Line(points = {{-118, 20}, {-82, 20}}, color = {0, 0, 127}));
  connect(rightFzSource.y, rightCPForce.force[3]) annotation(
    Line(points = {{120, 20}, {82, 20}}, color = {0, 0, 127}));
  connect(heavePosition.support, heaveDOF.support) annotation(
    Line(points = {{10, 16}, {6, 16}}, color = {0, 127, 0}));
  connect(heavePosition.flange, heaveDOF.axis) annotation(
    Line(points = {{20, 26}, {20, 28}, {6, 28}}, color = {0, 127, 0}));
  connect(rollDOF.frame_b, toAxle.frame_a) annotation(
    Line(points = {{0, -30}, {0, -20}}, color = {95, 95, 95}));
  connect(toAxle.frame_b, heaveDOF.frame_a) annotation(
    Line(points = {{0, 0}, {0, 10}}, color = {95, 95, 95}));
  connect(leftFxSource.y[1], leftFxGain.u) annotation(
    Line(points = {{-118, 80}, {-110, 80}}, color = {0, 0, 127}));
  connect(leftFxGain.y, leftCPForce.force[1]) annotation(
    Line(points = {{-100, 80}, {-90, 80}, {-90, 20}, {-82, 20}}, color = {0, 0, 127}));
  connect(leftFySource.y[1], leftFyGain.u) annotation(
    Line(points = {{-118, 50}, {-110, 50}}, color = {0, 0, 127}));
  connect(leftFyGain.y, leftCPForce.force[2]) annotation(
    Line(points = {{-100, 50}, {-100, 20}, {-82, 20}}, color = {0, 0, 127}));
  connect(rightFxSource.y[1], rightFxGain.u) annotation(
    Line(points = {{120, 80}, {112, 80}}, color = {0, 0, 127}));
  connect(rightFxGain.y, rightCPForce.force[1]) annotation(
    Line(points = {{100, 80}, {90, 80}, {90, 20}, {82, 20}}, color = {0, 0, 127}));
  connect(rightFySource.y[1], rightFyGain.u) annotation(
    Line(points = {{120, 50}, {112, 50}}, color = {0, 0, 127}));
  connect(rightFyGain.y, rightCPForce.force[2]) annotation(
    Line(points = {{100, 50}, {100, 20}, {82, 20}}, color = {0, 0, 127}));
  connect(heaveSource.y[1], heaveGain.u) annotation(
    Line(points = {{30, -50}, {20, -50}, {20, -16}}, color = {0, 0, 127}));
  connect(heaveGain.y, heavePosition.s_ref) annotation(
    Line(points = {{20, -4}, {20, 4}}, color = {0, 0, 127}));
  connect(rollSource.y[1], rollGain.u) annotation(
    Line(points = {{-48, -70}, {-40, -70}}, color = {0, 0, 127}));
  connect(rollGain.y, rollPosition.phi_ref) annotation(
    Line(points = {{-30, -70}, {-22, -70}, {-22, -62}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-140, -120}, {140, 120}})),
    Icon(coordinateSystem(extent = {{-140, -120}, {140, 120}})));
end KnC;
