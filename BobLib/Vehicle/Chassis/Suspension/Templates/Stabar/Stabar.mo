within BobLib.Vehicle.Chassis.Suspension.Templates.Stabar;

model Stabar "Stabar with rigid arms and compliant torsion bar"
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  // Parameters
  parameter SIunits.Position left_bar_end[3] "Left end of torsion bar, expressed in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_arm_end[3] "Left end of arm, expressed in world frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  // Visual parameters
  parameter SIunits.Length joint_diameter annotation(
    Evaluate = true,
    Dialog(tab = "Animation"));
  parameter SIunits.Length link_diameter annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b left_arm_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 20}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b right_arm_frame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 20}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a support_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -30}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_arm_end(r = left_arm_end - left_bar_end, width = link_diameter, height = link_diameter)  annotation(
    Placement(transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_arm_end(r = {left_arm_end[1], -left_arm_end[2], left_arm_end[3]} - {left_bar_end[1], -left_bar_end[2], left_bar_end[3]}, width = link_diameter, height = link_diameter)  annotation(
    Placement(transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute stabar_axis(useAxisFlange = true, cylinderLength = joint_diameter, cylinderDiameter = joint_diameter, n = {0, 1, 0})  annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Joints.Revolute mount_axis(n = {0, 1, 0}, animation = false, useAxisFlange = false)  annotation(
    Placement(transformation(origin = {0, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Components.Spring spring(c = 250)  annotation(
    Placement(transformation(origin = {-34, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_bar_end(r = {left_bar_end[1], left_bar_end[2], left_bar_end[3]} - {left_bar_end[1], 0, left_bar_end[3]}, width = link_diameter, height = link_diameter)  annotation(
    Placement(transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_bar_end(r = {left_bar_end[1], -left_bar_end[2], left_bar_end[3]} - {left_bar_end[1], 0, left_bar_end[3]}, width = link_diameter, height = link_diameter)  annotation(
    Placement(transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(support_frame, mount_axis.frame_b) annotation(
    Line(points = {{0, -100}, {0, -80}}));
  connect(stabar_axis.frame_a, mount_axis.frame_a) annotation(
    Line(points = {{-20, 0}, {0, 0}, {0, -60}}, color = {95, 95, 95}));
  connect(stabar_axis.frame_b, to_left_bar_end.frame_a) annotation(
    Line(points = {{-40, 0}, {-50, 0}, {-50, 20}}, color = {95, 95, 95}));
  connect(to_left_bar_end.frame_b, to_left_arm_end.frame_a) annotation(
    Line(points = {{-50, 40}, {-50, 60}, {-70, 60}, {-70, 40}}, color = {95, 95, 95}));
  connect(to_left_arm_end.frame_b, left_arm_frame) annotation(
    Line(points = {{-70, 20}, {-70, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(stabar_axis.support, spring.flange_b) annotation(
    Line(points = {{-24, -10}, {-24, -20}}));
  connect(stabar_axis.frame_a, to_right_bar_end.frame_a) annotation(
    Line(points = {{-20, 0}, {50, 0}, {50, 20}}, color = {95, 95, 95}));
  connect(to_right_bar_end.frame_b, to_right_arm_end.frame_a) annotation(
    Line(points = {{50, 40}, {50, 60}, {70, 60}, {70, 40}}, color = {95, 95, 95}));
  connect(to_right_arm_end.frame_b, right_arm_frame) annotation(
    Line(points = {{70, 20}, {70, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(spring.flange_a, stabar_axis.axis) annotation(
    Line(points = {{-44, -20}, {-44, -10}, {-30, -10}}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(graphics),
    Icon(graphics = {Line(origin = {0, -10}, points = {{-80, 0}, {80, 0}}, thickness = 5), Line(origin = {-80, 20}, points = {{0, -30}, {0, 0}}, thickness = 5), Line(origin = {80, 20}, points = {{0, -30}, {0, 0}}, thickness = 5), Ellipse(origin = {-80, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {80, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {-80, -10}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {80, -10}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-92, 20}, points = {{-8, 0}, {8, 0}}), Line(origin = {92, 20}, points = {{-8, 0}, {8, 0}}), Line(origin = {0, -31}, points = {{0, 1}, {0, 17}}), Line(origin = {5, -10}, points = {{-11, 0}, {1, 0}}, color = {255, 0, 0}, thickness = 10)}));
end Stabar;
