within BobLib.Vehicle.Chassis.Suspension.Linkages;

model Stabar
  import Modelica.Math.Vectors.norm;
  parameter Modelica.SIunits.Position left_bar_end[3] "Left end of torsion bar";
  parameter Modelica.SIunits.Position left_arm_end[3] "End of leftmost lever arm";
  parameter Modelica.SIunits.Position left_droplink_end[3] "End of leftmost droplink, connecting to bellcrank";
  parameter Modelica.SIunits.RotationalSpringConstant bar_rate "Torsion bar stiffness";
  parameter Real joint_diameter;
  parameter Real link_diameter;
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b left_pickup annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b right_pickup annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a support_pickup annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  // Droplinks
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_arm(r = left_arm_end - left_bar_end, width = link_diameter) annotation(
    Placement(transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_arm(r = {left_arm_end[1], -left_arm_end[2], left_arm_end[3]} - {left_bar_end[1], -left_bar_end[2], left_bar_end[3]}, width = link_diameter) annotation(
    Placement(transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute stabar_axis(useAxisFlange = false, n = {0, 1, 0}, animation = false, phi(displayUnit = "rad")) annotation(
    Placement(transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute stabar_deflection(n = {0, 1, 0}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {20, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Mechanics.Rotational.Components.Spring spring(c = bar_rate) annotation(
    Placement(transformation(origin = {24, -80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_bar_half(r = {0, left_arm_end[2], 0}, width = link_diameter) annotation(
    Placement(transformation(origin = {-30, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_bar_half(r = {0, -left_arm_end[2], 0}, width = link_diameter) annotation(
    Placement(transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical left_droplink(rodLength = norm(left_droplink_end - left_arm_end), sphereDiameter = joint_diameter, rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical right_droplink(rodLength = norm(left_droplink_end - left_arm_end), sphereDiameter = joint_diameter, rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(support_pickup, stabar_axis.frame_a) annotation(
    Line(points = {{0, 100}, {0, 50}}));
  connect(stabar_axis.frame_b, stabar_deflection.frame_a) annotation(
    Line(points = {{0, 30}, {0, -50}, {10, -50}}, color = {95, 95, 95}));
  connect(spring.flange_a, stabar_deflection.support) annotation(
    Line(points = {{14, -80}, {14, -60}}));
  connect(spring.flange_b, stabar_deflection.axis) annotation(
    Line(points = {{34, -80}, {34, -60}, {20, -60}}));
  connect(stabar_deflection.frame_a, left_bar_half.frame_a) annotation(
    Line(points = {{10, -50}, {-20, -50}}, color = {95, 95, 95}));
  connect(left_bar_half.frame_b, left_arm.frame_a) annotation(
    Line(points = {{-40, -50}, {-70, -50}, {-70, -40}}, color = {95, 95, 95}));
  connect(stabar_deflection.frame_b, right_bar_half.frame_a) annotation(
    Line(points = {{30, -50}, {40, -50}}, color = {95, 95, 95}));
  connect(right_bar_half.frame_b, right_arm.frame_a) annotation(
    Line(points = {{60, -50}, {70, -50}, {70, -40}}, color = {95, 95, 95}));
  connect(left_arm.frame_b, left_droplink.frame_a) annotation(
    Line(points = {{-70, -20}, {-70, -10}}, color = {95, 95, 95}));
  connect(left_droplink.frame_b, left_pickup) annotation(
    Line(points = {{-70, 10}, {-70, 20}, {-100, 20}, {-100, 0}}, color = {95, 95, 95}));
  connect(right_arm.frame_b, right_droplink.frame_a) annotation(
    Line(points = {{70, -20}, {70, -10}}, color = {95, 95, 95}));
  connect(right_droplink.frame_b, right_pickup) annotation(
    Line(points = {{70, 10}, {70, 20}, {100, 20}, {100, 0}}, color = {95, 95, 95}));
end Stabar;
