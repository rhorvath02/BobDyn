within BobLib.Vehicle.Chassis.Suspension.Linkages;
model Link
  import Modelica.SIunits;
  
  parameter SIunits.Position inboard[3] "Inboard node coordinates";
  parameter SIunits.Position outboard[3] "Outboard node coordinates";
    
  parameter SIunits.Length link_diameter "Link diameter";
  parameter SIunits.Length joint_diameter "Joint diameter" annotation(
    Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));
  
  parameter SIunits.TranslationalSpringConstant[3] inboard_c = {1e9, 1e9, 1e9} "{x, y, z}-stiffness of inboard mount" annotation(Dialog(group="Mounting"));
  parameter SIunits.TranslationalDampingConstant[3] inboard_d = {1e9, 1e9, 1e9} "{x, y, z}-damping of inboard mount" annotation(Dialog(group="Mounting"));
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
    
  // Joints
  Joints.xyzSphericalCompliant to_link(r_rel(each fixed = true), diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}})));
  Joints.xyzSphericalCompliant from_link(r_rel(each fixed = true), diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}})));
  // Link
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r = outboard - inboard, width = link_diameter, height = link_diameter) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
equation
  connect(frame_a, to_link.frame_a) annotation(
    Line(points = {{-100, 0}, {-70, 0}}));
  connect(to_link.frame_b, fixedTranslation.frame_a) annotation(
    Line(points = {{-50, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(fixedTranslation.frame_b, from_link.frame_a) annotation(
    Line(points = {{10, 0}, {50, 0}}, color = {95, 95, 95}));
  connect(from_link.frame_b, frame_b) annotation(
    Line(points = {{70, 0}, {100, 0}}, color = {95, 95, 95}));
  annotation(
  Icon(
    graphics = {
    Line(
          points = {{-80, 0}, {80, 0}},
          color = {0, 0, 0},
          thickness = 5
        ),
    Ellipse(
          extent = {{-90, -10}, {-70, 10}},
          lineColor = {0, 0, 0},
          fillColor = {255, 0, 0},
          fillPattern = FillPattern.Solid
        ),
    Ellipse(
          extent = {{70, -10}, {90, 10}},
          lineColor = {0, 0, 0},
          fillColor = {255, 0, 0},
          fillPattern = FillPattern.Solid
        )
        }));
end Link;
