within BobLib.Vehicle.Chassis.Suspension.Linkages;

model ShockLinkage
  import BobLib.Utilities.Math.Vector.cross;
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  import Modelica.SIunits;
  // Geometry params
  parameter SIunits.Position start_point[3] "Initial point of shock linkage" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position end_point[3] "Final point of shock linkage" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Length rod_length_fraction "Length fraction of effective rigid member on shock linkage" annotation(
    Dialog(group = "Geometry"));
  // Spring params
  parameter SIunits.Length free_length "Spring free length" annotation(
    Dialog(group = "Spring Params"));
  parameter SIunits.TranslationalSpringConstant spring_table[:, 2] "Table of spring force vs deflection (change in length)" annotation(
    Dialog(group = "Spring Params"));
  parameter SIunits.Mass spring_mass "Spring mass" annotation(
    Dialog(group = "Spring Params"));
  // Damper params
  parameter SIunits.TranslationalDampingConstant damper_table[:, 2] "Table of damper force vs relative velocity" annotation(
    Dialog(group = "Damper Params"));
  parameter SIunits.Mass damper_mass "Damper mass" annotation(
    Dialog(group = "Damper Params"));
  // Animation
  parameter SIunits.Length link_diameter "Link diameter" annotation(
    Dialog(group = "Animation"));
  parameter SIunits.Length joint_diameter "Joint diameter" annotation(
    Dialog(group = "Animation"));
  parameter SIunits.Length spring_diameter "Spring diameter" annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  // Shock geometry calcs
  final parameter Real[3] shock_start = (end_point - start_point)*rod_length_fraction + start_point;
  final parameter Real[3] shock_end = end_point;
  // State vars
  Real shock_r_rel[3];

// Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  // Rigid rod
  Modelica.Mechanics.MultiBody.Forces.Spring spring(c = 1e6, s_unstretched = norm(end_point - start_point))  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
equation
//  shock_r_rel = shock_linkage.frame_b.r_0 - shock_linkage.frame_a.r_0;
  shock_r_rel = spring.r_rel_0;
  connect(frame_a, spring.frame_a) annotation(
    Line(points = {{-100, 0}, {-10, 0}}));
  connect(spring.frame_b, frame_b) annotation(
    Line(points = {{10, 0}, {100, 0}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end ShockLinkage;
