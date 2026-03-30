within BobLib.Vehicle.Chassis.Suspension.Linkages.Templates;

partial model TabularCompliant "Base compliant element"
  import Modelica.SIunits;
  
  final parameter Real eps = 1e-12 "regularization (m)" annotation(Dialog(group="Numerical"));
  
  // Frames
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));

  // Force generation
  Modelica.Mechanics.Translational.Sources.Force2 force annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  
  Real s_rel;

equation
  // Deflection calc
  s_rel = flange_b.s - flange_a.s;
  
  connect(force.flange_a, flange_a) annotation(
    Line(points = {{-10, 0}, {-100, 0}}, color = {0, 127, 0}));
  connect(force.flange_b, flange_b) annotation(
    Line(points = {{10, 0}, {100, 0}}, color = {0, 127, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end TabularCompliant;
