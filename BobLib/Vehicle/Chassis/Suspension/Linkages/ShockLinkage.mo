within BobLib.Vehicle.Chassis.Suspension.Linkages;

model ShockLinkage
  import Modelica.SIunits;

  // Geometry parameters
  parameter SIunits.Position r_a[3] "Initial vector from origin to frame_a, resolved in world frame" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position r_b[3] "Initial vector from origin to frame_b, resolved in world frame" annotation(
    Dialog(group = "Geometry"));
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a "Axis of revolute joint 1, resolved in world frame" annotation(
    Dialog(group = "Geometry"));
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b "Axis of revolute joint 2, resolved in world frame" annotation(
    Dialog(group = "Geometry"));
  
  // Spring parameters
  parameter SIunits.Length s_0 "Spring free length" annotation(
    Dialog(group = "Spring Params"));
  parameter SIunits.TranslationalSpringConstant springTable[:, 2] "Table of spring force vs deflection (change in length)" annotation(
    Dialog(group = "Spring Params"));
  
  // Damper parameters
  parameter SIunits.TranslationalDampingConstant damperTable[:, 2] "Table of damper force vs relative velocity" annotation(
    Dialog(group = "Damper Params"));
  
  // Visual parameters (implement visuals later)
  parameter SIunits.Length linkDiameter "Link diameter" annotation(
    Dialog(tab = "Animation"));
  parameter SIunits.Length jointDiameter "Joint diameter" annotation(
    Dialog(tab = "Animation"));
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  
  // Force elements
  BobLib.Vehicle.Chassis.Suspension.Linkages.TabularSpring TabularSpring(springTable = springTable, s_0 = s_0) annotation(
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Linkages.TabularDamper TabularDamper(damperTable = damperTable) annotation(
    Placement(transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}})));

  // Shock axis
  Modelica.Mechanics.MultiBody.Forces.LineForceWithMass lineForceWithMass annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));

equation
  connect(frame_a, lineForceWithMass.frame_a) annotation(
    Line(points = {{-100, 0}, {-10, 0}}));
  connect(lineForceWithMass.frame_b, frame_b) annotation(
    Line(points = {{10, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(TabularSpring.flange_a, lineForceWithMass.flange_a) annotation(
    Line(points = {{-10, 30}, {-20, 30}, {-20, 10}, {-6, 10}}, color = {0, 127, 0}));
  connect(TabularSpring.flange_b, lineForceWithMass.flange_b) annotation(
    Line(points = {{10, 30}, {20, 30}, {20, 10}, {6, 10}}, color = {0, 127, 0}));
  connect(TabularDamper.flange_a, lineForceWithMass.flange_a) annotation(
    Line(points = {{-10, 50}, {-20, 50}, {-20, 10}, {-6, 10}}, color = {0, 127, 0}));
  connect(TabularDamper.flange_b, lineForceWithMass.flange_b) annotation(
    Line(points = {{10, 50}, {20, 50}, {20, 10}, {6, 10}}, color = {0, 127, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(graphics),
    Icon(graphics = {Line(origin = {1, -40}, points = {{-61, 0}, {-41, 0}, {-31, 20}, {-11, -20}, {11, 20}, {29, -20}, {39, 0}, {59, 0}}, thickness = 3), Line(origin = {-60, -15}, points = {{0, -25}, {0, 55}}, thickness = 3), Line(origin = {-40, 40}, points = {{-20, 0}, {30, 0}}, thickness = 3), Line(origin = {-10, 40}, points = {{0, -28}, {0, 26}}, thickness = 3), Line(origin = {0, 39}, points = {{-20, 31}, {20, 31}, {20, -31}, {-20, -31}}, thickness = 3), Line(origin = {60, -15}, points = {{0, -25}, {0, 55}}, thickness = 3), Line(origin = {40, 40}, points = {{-20, 0}, {20, 0}}, thickness = 3), Line(origin = {-29.91, -67.91}, points = {{-2.0908, 7.9092}, {39.9092, 17.9092}, {59.9092, 47.9092}}, color = {255, 0, 0}, thickness = 3), Line(origin = {9.96, 38.96}, points = {{-39.9639, -30.9639}, {-9.96392, 21.0361}, {20.0361, 31.0361}}, color = {255, 0, 0}, thickness = 3), Line(origin = {-66, 0}, points = {{-14, 0}, {6, 0}}, thickness = 3), Line(origin = {67, 0}, points = {{-7, 0}, {9, 0}}, thickness = 3), Ellipse(origin = {80, 0}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}}), Ellipse(origin = {-80, 0}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}})}));
end ShockLinkage;
