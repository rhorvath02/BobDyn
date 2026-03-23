within BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone;

model TieClosure
  import Modelica.SIunits;
  // Parameters
  parameter SIunits.Position inboard[3] "Inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position outboard[3] "Outboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Evaluate = true, Dialog(tab="Animation"));
  parameter SIunits.Length joint_diameter annotation(
    Evaluate = true, Dialog(tab="Animation"));
  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a tie_i_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b tie_o_frame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical tie_rod(n1_a = {1, 0, 0},
                                                                 rRod_ia = outboard - inboard,
                                                                 sphereDiameter = joint_diameter,
                                                                 rodWidth = link_diameter,
                                                                 rodHeight = link_diameter,
                                                                 cylinderLength = joint_diameter,
                                                                 cylinderDiameter = joint_diameter, showUniversalAxes = false)  annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}})));

equation
  connect(tie_rod.frame_a, tie_i_frame) annotation(
    Line(points = {{-20, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(tie_rod.frame_b, tie_o_frame) annotation(
    Line(points = {{20, 0}, {100, 0}}, color = {95, 95, 95}));
annotation(
    Diagram(graphics),
    Icon(graphics = {Line(origin = {-25.8, 3.2}, points = {{-54.2, -3.2}, {25.8, -3.2}, {105.8, -3.2}}, thickness = 5), Ellipse(origin = {-80, 0}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {80, 0}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-92, 0}, points = {{-8, 0}, {8, 0}, {8, 0}}), Line(origin = {92, 0}, points = {{8, 0}, {-8, 0}, {-8, 0}})}),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end TieClosure;
