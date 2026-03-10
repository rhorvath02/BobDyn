within BobLib.Utilities.Mechanics.Multibody;

model TranslationalJoint
  import Modelica.SIunits;
  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  
  parameter SIunits.Length x0=0 "Initial x-position" annotation(Dialog(group="Initialization"));
  parameter SIunits.Length y0=0 "Initial y-position" annotation(Dialog(group="Initialization"));
  parameter SIunits.Length z0=0 "Initial z-position" annotation(Dialog(group="Initialization"));
  
  parameter SIunits.Velocity vx0=0 "Initial x-velocity" annotation(Dialog(group="Initialization"));
  parameter SIunits.Velocity vy0=0 "Initial y-velocity" annotation(Dialog(group="Initialization"));
  parameter SIunits.Velocity vz0=0 "Initial z-velocity" annotation(Dialog(group="Initialization"));
  
  // Prismatic joints in each DOF
  Modelica.Mechanics.MultiBody.Joints.Prismatic FreeX(n = {1, 0, 0}, s(start = x0, fixed = true), v(start = vx0, fixed = true))  annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic FreeY(n = {0, 1, 0}, s(start = y0, fixed = true), v(start = vy0, fixed = true))  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic FreeZ(n = {0, 0, 1}, s(start = z0, fixed = true), v(start = vz0, fixed = true))  annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));equation
  connect(frame_a, FreeX.frame_a) annotation(
    Line(points = {{-100, 0}, {-60, 0}}));
  connect(FreeX.frame_b, FreeY.frame_a) annotation(
    Line(points = {{-40, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(FreeY.frame_b, FreeZ.frame_a) annotation(
    Line(points = {{10, 0}, {40, 0}}, color = {95, 95, 95}));
  connect(FreeZ.frame_b, frame_b) annotation(
    Line(points = {{60, 0}, {100, 0}}, color = {95, 95, 95}));
end TranslationalJoint;