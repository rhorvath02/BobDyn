within BobDyn.Vehicle.Chassis.Suspension.Linkages;

model ShockLinkage
  import BobDyn.Utilities.Math.Vector.cross;
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
  // Some vars
  Real shock_r_rel;
  Real shock_v_rel;
  Real defl;
  Real vel;
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  // Rigid rod
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r = shock_start - start_point) annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  // Connecting model
  Modelica.Mechanics.Translational.Sources.Force2 force annotation(
    Placement(transformation(origin = {30, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression spring_source(y = defl) annotation(
    Placement(transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression damper_source(y = vel) annotation(
    Placement(transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable1D spring_combiTable1D(table = spring_table, columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints) annotation(
    Placement(transformation(origin = {-30, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable1D damper_combiTable1D(table = damper_table, columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints) annotation(
    Placement(transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(
    Placement(transformation(origin = {30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(useAxisFlange = true, n = normalize(shock_end - shock_start), s(start = norm(shock_end - shock_start), fixed = true), animation = false) annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  BobDyn.Vehicle.Chassis.Suspension.Joints.xyzSphericalCompliant xyzSphericalCompliant(r_rel(start = {0, 0, 0}, each fixed = true)) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical to_link(sphereDiameter = 0.825*0.0254) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(R = Modelica.Mechanics.MultiBody.Frames.nullRotation(), extra = 6, length = shock_r_rel, lengthDirection = normalize(prismatic.frame_b.r_0 - prismatic.frame_a.r_0), r = prismatic.frame_a.r_0, shapeType = "spring", width = spring_diameter, height = shock_r_rel/20) annotation(
    Placement(transformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 1, I_11 = 1) annotation(
    Placement(transformation(origin = {30, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  shock_r_rel = norm(prismatic.frame_b.r_0 - prismatic.frame_a.r_0);
  shock_v_rel = prismatic.v;
  defl = free_length - shock_r_rel;
  vel = shock_v_rel;
  connect(spring_source.y, spring_combiTable1D.u[1]) annotation(
    Line(points = {{-59, 90}, {-42, 90}}, color = {0, 0, 127}));
  connect(damper_source.y, damper_combiTable1D.u[1]) annotation(
    Line(points = {{-59, 60}, {-42, 60}}, color = {0, 0, 127}));
  connect(spring_combiTable1D.y[1], add.u1) annotation(
    Line(points = {{-19, 90}, {36, 90}, {36, 52}}, color = {0, 0, 127}));
  connect(damper_combiTable1D.y[1], add.u2) annotation(
    Line(points = {{-19, 60}, {24, 60}, {24, 52}}, color = {0, 0, 127}));
  connect(add.y, force.f) annotation(
    Line(points = {{30, 29}, {30, 24}}, color = {0, 0, 127}));
  connect(fixedTranslation.frame_b, prismatic.frame_a) annotation(
    Line(points = {{-20, 0}, {20, 0}}, color = {95, 95, 95}));
  connect(force.flange_a, prismatic.support) annotation(
    Line(points = {{20, 20}, {10, 20}, {10, 6}, {26, 6}}, color = {0, 127, 0}));
  connect(xyzSphericalCompliant.frame_a, prismatic.frame_b) annotation(
    Line(points = {{60, 0}, {40, 0}}, color = {95, 95, 95}));
  connect(xyzSphericalCompliant.frame_b, frame_b) annotation(
    Line(points = {{80, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(frame_a, to_link.frame_a) annotation(
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(to_link.frame_b, fixedTranslation.frame_a) annotation(
    Line(points = {{-60, 0}, {-40, 0}}, color = {95, 95, 95}));
  connect(force.flange_b, prismatic.axis) annotation(
    Line(points = {{40, 20}, {50, 20}, {50, 6}, {38, 6}}, color = {0, 127, 0}));
  connect(body.frame_a, xyzSphericalCompliant.frame_a) annotation(
    Line(points = {{40, -30}, {50, -30}, {50, 0}, {60, 0}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end ShockLinkage;
