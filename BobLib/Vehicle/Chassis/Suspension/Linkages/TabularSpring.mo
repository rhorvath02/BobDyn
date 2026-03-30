within BobLib.Vehicle.Chassis.Suspension.Linkages;

model TabularSpring "Tabular translational spring with optional mass"
  import Modelica.SIunits;
    
  extends BobLib.Vehicle.Chassis.Suspension.Linkages.Templates.TabularCompliant;
  
  // Spring parameters
  parameter SIunits.TranslationalSpringConstant springTable[:, 2] "Table of Force vs Compression (dx, F)" annotation(
    Evaluate = false, Dialog(group = "Spring Parameters"));
  parameter SIunits.Length s_0 "Free length of spring" annotation(
    Evaluate = false, Dialog(group = "Spring Parameters"));

  Real defl;
  Real defl_abs;
  Real sgn;
  
  // Deflection processing blocks
  Modelica.Blocks.Sources.RealExpression deflExpression(y = defl_abs) annotation(
    Placement(transformation(origin = {-90, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression sgnExpression(y = sgn) annotation(
    Placement(transformation(origin = {-90, 24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Product product annotation(
    Placement(transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}})));
  
  // Force output block
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(columns = {2}, extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, table = springTable) annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}})));

equation
  defl = s_0 - s_rel;
  defl_abs = sqrt(defl*defl + eps*eps);
  sgn = defl/defl_abs;
  
  connect(deflExpression.y, product.u1) annotation(
    Line(points = {{-79, 36}, {-73, 36}}, color = {0, 0, 127}));
  connect(sgnExpression.y, product.u2) annotation(
    Line(points = {{-79, 24}, {-73, 24}}, color = {0, 0, 127}));
  connect(product.y, combiTable1D.u[1]) annotation(
    Line(points = {{-49, 30}, {-33, 30}}, color = {0, 0, 127}));
  connect(combiTable1D.y[1], force.f) annotation(
    Line(points = {{-8, 30}, {0, 30}, {0, 4}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Icon(graphics = {Line(origin = {27.89, 0}, points = {{-127.885, 0}, {-107.885, 60}, {-67.8851, -60}, {-27.8851, 60}, {12.1149, -60}, {52.1149, 60}, {72.1149, 0}}, thickness = 5), Line(origin = {-0.02, -1.02}, points = {{-59.9838, -58.9838}, {-19.9838, -48.9838}, {20.0162, -18.9838}, {50.0162, 21.0162}, {60.0162, 61.0162}}, color = {255, 0, 0}, thickness = 3)}));
end TabularSpring;
