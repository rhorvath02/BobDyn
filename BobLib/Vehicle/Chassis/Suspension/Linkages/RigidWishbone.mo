within BobLib.Vehicle.Chassis.Suspension.Linkages;

model RigidWishbone
  import Modelica.Math.Vectors.normalize;
  import Modelica.SIunits;
  
  parameter SIunits.Length link_diameter "Link diameter" annotation(
    Dialog(group = "Animation"));
  parameter SIunits.Length joint_diameter "Joint diameter" annotation(
    Dialog(group = "Animation"));
  parameter SIunits.Position fore_i[3] "Fore inboard node coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position aft_i[3] "Aft inboard node coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position outboard[3] "Outboard node coordinates" annotation(
    Dialog(group = "Geometry"));
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a inboard_frame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b outboard_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b link_frame annotation(
    Placement(transformation(origin = {-40, 100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {-66, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  // Links
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rigid_link(r = outboard - (fore_i + aft_i)/2, width = link_diameter, height = link_diameter) annotation(
    Placement(transformation(extent = {{10, -10}, {-10, 10}})));
  // Joints
  Modelica.Mechanics.MultiBody.Joints.Revolute inboard_joint(n = normalize(fore_i - aft_i), stateSelect = StateSelect.always, phi(start = 0, fixed = true)) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Joints.xyzSphericalCompliant xyzSphericalCompliant(r_rel(start = {0, 0, 0}, each fixed = false))  annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(inboard_joint.frame_b, rigid_link.frame_a) annotation(
    Line(points = {{60, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(rigid_link.frame_b, link_frame) annotation(
    Line(points = {{-10, 0}, {-40, 0}, {-40, 100}}, color = {95, 95, 95}));
  connect(inboard_frame, inboard_joint.frame_a) annotation(
    Line(points = {{100, 0}, {80, 0}}));
  connect(rigid_link.frame_b, xyzSphericalCompliant.frame_a) annotation(
    Line(points = {{-10, 0}, {-60, 0}}, color = {95, 95, 95}));
  connect(xyzSphericalCompliant.frame_b, outboard_frame) annotation(
    Line(points = {{-80, 0}, {-100, 0}}, color = {95, 95, 95}));
  annotation(
    Icon(graphics = {Line(points = {{-80, 0}, {80, 66}}, color = {0, 0, 0}, thickness = 5), Line(points = {{-80, 0}, {80, -66}}, color = {0, 0, 0}, thickness = 5), Line(points = {{-66, 5}, {-66, 100}}, color = {0, 0, 0}, thickness = 5), Ellipse(extent = {{-90, -10}, {-70, 10}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Ellipse(extent = {{70, 56}, {90, 76}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Ellipse(extent = {{70, -76}, {90, -56}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid)}));
end RigidWishbone;
