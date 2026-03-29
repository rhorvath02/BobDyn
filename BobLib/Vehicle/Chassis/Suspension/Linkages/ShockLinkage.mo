within BobLib.Vehicle.Chassis.Suspension.Linkages;

model ShockLinkage
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  // Custom linalg
  import BobLib.Utilities.Math.Vector.cross;
  // Geometry params
  parameter SIunits.Position r_a[3] "Initial vector from origin to frame_a, resolved in world frame" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position r_b[3] "Initial vector from origin to frame_b, resolved in world frame" annotation(
    Dialog(group = "Geometry"));
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a "Axis of revolute joint 1, resolved in world frame" annotation(
    Dialog(group = "Geometry"));
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b "Axis of revolute joint 2, resolved in world frame" annotation(
    Dialog(group = "Geometry"));
  // Spring params
  parameter SIunits.Length s_0 "Spring free length" annotation(
    Dialog(group = "Spring Params"));
  parameter SIunits.TranslationalSpringConstant spring_table[:, 2] "Table of spring force vs deflection (change in length)" annotation(
    Dialog(group = "Spring Params"));
  // Damper params
  parameter SIunits.TranslationalDampingConstant damper_table[:, 2] "Table of damper force vs relative velocity" annotation(
    Dialog(group = "Damper Params"));
  // Animation
  parameter SIunits.Length link_diameter "Link diameter" annotation(
    Dialog(tab = "Animation"));
  parameter SIunits.Length joint_diameter "Joint diameter" annotation(
    Dialog(tab = "Animation"));
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  // Joints
  Modelica.Mechanics.MultiBody.Joints.Universal to_shock_joint(cylinderLength = joint_diameter, cylinderDiameter = joint_diameter, n_a = n_a, n_b = n_b) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical from_shock_joint(sphereDiameter = joint_diameter) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));

  // Shock axis
  Modelica.Mechanics.MultiBody.Joints.Prismatic shock_axis(boxWidth = joint_diameter*0.5, n = normalize(r_b - r_a), useAxisFlange = true, s(start = norm(r_b - r_a))) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  // Force elements
  BobLib.Vehicle.Chassis.Suspension.Linkages.TabularSpring TabularSpring(spring_table = spring_table, s_0 = s_0) annotation(
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Linkages.TabularDamper TabularDamper(damper_table = damper_table)  annotation(
    Placement(transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(frame_a, to_shock_joint.frame_a) annotation(
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(to_shock_joint.frame_b, shock_axis.frame_a) annotation(
    Line(points = {{-60, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(shock_axis.frame_b, from_shock_joint.frame_a) annotation(
    Line(points = {{10, 0}, {60, 0}}, color = {95, 95, 95}));
  connect(from_shock_joint.frame_b, frame_b) annotation(
    Line(points = {{80, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(TabularSpring.flange_a, shock_axis.support) annotation(
    Line(points = {{-10, 30}, {-20, 30}, {-20, 6}, {-4, 6}}, color = {0, 127, 0}));
  connect(TabularSpring.flange_b, shock_axis.axis) annotation(
    Line(points = {{10, 30}, {20, 30}, {20, 6}, {8, 6}}, color = {0, 127, 0}));
  connect(TabularDamper.flange_a, shock_axis.support) annotation(
    Line(points = {{-10, 50}, {-20, 50}, {-20, 6}, {-4, 6}}, color = {0, 127, 0}));
  connect(TabularDamper.flange_b, shock_axis.axis) annotation(
    Line(points = {{10, 50}, {20, 50}, {20, 6}, {8, 6}}, color = {0, 127, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(graphics),
    Icon(graphics = {Line(origin = {-80, 0}, points = {{0, -8}, {0, 8}}, color = {255, 0, 0}, thickness = 5), Line(origin = {-72, 8}, points = {{0, -8}, {-16, -8}}, color = {255, 0, 0}, thickness = 5), Ellipse(origin = {-80, 0}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}}), Line(origin = {1, -40}, points = {{-61, 0}, {-41, 0}, {-31, 20}, {-11, -20}, {11, 20}, {29, -20}, {39, 0}, {59, 0}}, thickness = 3), Line(origin = {-60, -15}, points = {{0, -25}, {0, 55}}, thickness = 3), Line(origin = {-40, 40}, points = {{-20, 0}, {30, 0}}, thickness = 3), Line(origin = {-10, 40}, points = {{0, -28}, {0, 26}}, thickness = 3), Line(origin = {0, 39}, points = {{-20, 31}, {20, 31}, {20, -31}, {-20, -31}}, thickness = 3), Line(origin = {60, -15}, points = {{0, -25}, {0, 55}}, thickness = 3), Line(origin = {40, 40}, points = {{-20, 0}, {20, 0}}, thickness = 3), Line(origin = {-29.91, -67.91}, points = {{-2.0908, 7.9092}, {39.9092, 17.9092}, {59.9092, 47.9092}}, color = {255, 0, 0}, thickness = 3), Line(origin = {9.96, 38.96}, points = {{-39.9639, -30.9639}, {-9.96392, 21.0361}, {20.0361, 31.0361}}, color = {255, 0, 0}, thickness = 3), Line(origin = {-66, 0}, points = {{-6, 0}, {6, 0}}, thickness = 3), Line(origin = {67, 0}, points = {{-7, 0}, {9, 0}}, thickness = 3), Ellipse(origin = {80, 0}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}})}));
end ShockLinkage;
