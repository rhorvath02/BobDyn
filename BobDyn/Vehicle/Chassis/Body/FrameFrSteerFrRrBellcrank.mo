within BobDyn.Vehicle.Chassis.Body;
model FrameFrSteerFrRrBellcrank
  import Modelica.SIunits;
  
  extends FrameFrSteer;
  
  parameter SIunits.Position FL_mount[3];
  parameter SIunits.Position FR_mount[3];
  parameter SIunits.Position RL_mount[3];
  parameter SIunits.Position RR_mount[3];
  
  // Front Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FL_mount_frame annotation(
    Placement(transformation(origin = {-100, 90}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-200, 500}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FR_mount_frame annotation(
    Placement(transformation(origin = {100, 90}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {200, 500}, extent = {{-16, -16}, {16, 16}})));
  
  // Rear Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RL_mount_frame annotation(
    Placement(transformation(origin = {-100, -90}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-200, -500}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RR_mount_frame annotation(
    Placement(transformation(origin = {100, -90}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {200, -500}, extent = {{-16, -16}, {16, 16}})));
    
  // Front translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_FL_mount(r = FL_mount - Fr_avg) annotation(
    Placement(transformation(origin = {-70, 90}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_FR_mount(r = FR_mount - Fr_avg) annotation(
    Placement(transformation(origin = {70, 90}, extent = {{-10, -10}, {10, 10}})));
  
  // Rear translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_RL_mount(r = RL_mount - Rr_avg) annotation(
    Placement(transformation(origin = {-20, -90}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_RR_mount(r = RR_mount - Rr_avg) annotation(
    Placement(transformation(origin = {20, -90}, extent = {{-10, -10}, {10, 10}})));
    // Masses
equation
  connect(CG_to_Rr.frame_b, to_RL_mount.frame_a) annotation(
    Line(points = {{0, -40}, {0, -90}, {-10, -90}}, color = {95, 95, 95}));
  connect(to_RL_mount.frame_b, RL_mount_frame) annotation(
    Line(points = {{-30, -90}, {-100, -90}}, color = {95, 95, 95}));
  connect(CG_to_Rr.frame_b, to_RR_mount.frame_a) annotation(
    Line(points = {{0, -40}, {0, -90}, {10, -90}}, color = {95, 95, 95}));
  connect(to_RR_mount.frame_b, RR_mount_frame) annotation(
    Line(points = {{30, -90}, {100, -90}}, color = {95, 95, 95}));
  connect(to_FL_mount.frame_b, FL_mount_frame) annotation(
    Line(points = {{-80, 90}, {-100, 90}}, color = {95, 95, 95}));
  connect(to_FR_mount.frame_b, FR_mount_frame) annotation(
    Line(points = {{80, 90}, {100, 90}}, color = {95, 95, 95}));
  connect(to_FL_mount.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{-60, 90}, {-30, 90}, {-30, 40}, {0, 40}}, color = {95, 95, 95}));
  connect(to_FR_mount.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{60, 90}, {30, 90}, {30, 40}, {0, 40}}, color = {95, 95, 95}));
end FrameFrSteerFrRrBellcrank;