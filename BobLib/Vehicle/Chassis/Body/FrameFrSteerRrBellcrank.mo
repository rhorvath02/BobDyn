within BobLib.Vehicle.Chassis.Body;
model FrameFrSteerRrBellcrank
  import Modelica.SIunits;
  
  extends FrameFrSteer;
  
  parameter SIunits.Position left_mount[3];
  parameter SIunits.Position right_mount[3];
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b left_bellcrank_mount_frame annotation(
    Placement(transformation(origin = {100, -20}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-200, -500}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b right_bellcrank_mount_frame annotation(
    Placement(transformation(origin = {100, -20}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {200, -500}, extent = {{-16, -16}, {16, 16}})));
  
  // Translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_mount(r = left_mount - Rr_avg) annotation(
    Placement(transformation(origin = {-70, -90}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_mount(r = right_mount - Rr_avg) annotation(
    Placement(transformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(to_left_mount.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{-60, -90}, {0, -90}, {0, -40}}, color = {95, 95, 95}));
  connect(to_right_mount.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{60, -90}, {0, -90}, {0, -40}}, color = {95, 95, 95}));
end FrameFrSteerRrBellcrank;