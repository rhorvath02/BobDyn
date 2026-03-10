within BobLib.Utilities.Mechanics.Multibody;

model PlanarMotion
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  
  Modelica.Mechanics.MultiBody.Joints.Prismatic free_x(n = {1, 0, 0})  annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic free_y(n = {0, 1, 0})  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical spherical annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(frame_a, free_x.frame_a) annotation(
    Line(points = {{-100, 0}, {-60, 0}}));
  connect(free_x.frame_b, free_y.frame_a) annotation(
    Line(points = {{-40, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(free_y.frame_b, spherical.frame_a) annotation(
    Line(points = {{10, 0}, {40, 0}}, color = {95, 95, 95}));
  connect(spherical.frame_b, frame_b) annotation(
    Line(points = {{60, 0}, {100, 0}}, color = {95, 95, 95}));
end PlanarMotion;
