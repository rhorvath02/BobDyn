within BobLib.Utilities.Mechanics.Multibody;

model LinearActuator
  
  parameter String axis = "z" annotation(choices(choice="x", choice="y", choice="z"));
  
  parameter Integer axisIndex = if axis == "x" then 1 elseif axis == "y" then 2 else 3;
  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic_x(n = {1, 0, 0}, useAxisFlange = true, animation = false)  annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic_y(n = {0, 1, 0}, useAxisFlange = true, animation = false)  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic_z(n = {0, 0, 1}, useAxisFlange = true, animation = false)  annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput u_position annotation(
    Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sources.Position position annotation(
    Placement(transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
equation
  if axis == "x" then
    connect(position.flange, prismatic_x.axis);
  elseif axis == "y" then
    connect(position.flange, prismatic_y.axis);
  elseif axis == "z" then
    connect(position.flange, prismatic_z.axis);
  end if;
  connect(frame_a, prismatic_x.frame_a) annotation(
    Line(points = {{-100, 0}, {-60, 0}}));
  connect(prismatic_x.frame_b, prismatic_y.frame_a) annotation(
    Line(points = {{-40, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(prismatic_y.frame_b, prismatic_z.frame_a) annotation(
    Line(points = {{10, 0}, {40, 0}}, color = {95, 95, 95}));
  connect(prismatic_z.frame_b, frame_b) annotation(
    Line(points = {{60, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(u_position, position.s_ref) annotation(
    Line(points = {{0, 120}, {0, 82}}, color = {0, 0, 127}));
end LinearActuator;
