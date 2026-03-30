within BobLib.Vehicle.Chassis.Suspension.Linkages;

model Rod
  import Modelica.SIunits;
  
  // Geometry parameters
  parameter SIunits.Position r_a[3] "Vector from origin to frame_a, expressed in world frame" annotation(
    Evaluate = false, Dialog(group = "Geometry"));
  parameter SIunits.Position r_b[3] "Vector from origin to frame_b, expressed in world frame" annotation(
    Evaluate = false, Dialog(group = "Geometry"));
  parameter Modelica.Mechanics.MultiBody.Types.Axis n1_a = {1, 0, 0} "Axis 1 of universal joint resolved in frame_a (axis 2 is orthogonal to axis 1 and to rod)" annotation(
    Evaluate = false, Dialog(group = "Geometry"));
  parameter Boolean kinematicConstraint = true annotation(
    Evaluate = false, Dialog(group = "Geometry"));
  
  // Visual parameters
  parameter SIunits.Length linkDiameter annotation(
    Evaluate = true, Dialog(tab="Animation"));
  parameter SIunits.Length jointDiameter annotation(
    Evaluate = true, Dialog(tab="Animation"));
  parameter Boolean show_universal_axes = true annotation(
    Evaluate = true, Dialog(tab="Animation"));
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));

protected
  // Kinematics
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical rod(n1_a = n1_a,
                                                             rRod_ia = r_b - r_a,
                                                             sphereDiameter = jointDiameter,
                                                             rodWidth = linkDiameter,
                                                             rodHeight = linkDiameter,
                                                             cylinderLength = jointDiameter,
                                                             cylinderDiameter = jointDiameter,
                                                             kinematicConstraint = kinematicConstraint,
                                                             showUniversalAxes = show_universal_axes)  annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}})));

equation
  connect(rod.frame_a, frame_a) annotation(
    Line(points = {{-20, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(rod.frame_b, frame_b) annotation(
    Line(points = {{20, 0}, {100, 0}}, color = {95, 95, 95}));
annotation(
    Diagram(graphics),
    Icon(graphics = {Line(origin = {-25.8, 3.2}, points = {{-54.2, -3.2}, {25.8, -3.2}, {105.8, -3.2}}, thickness = 5), Ellipse(origin = {-80, 0}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {80, 0}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-92, 0}, points = {{-8, 0}, {8, 0}, {8, 0}}), Line(origin = {92, 0}, points = {{8, 0}, {-8, 0}, {-8, 0}})}),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Rod;
