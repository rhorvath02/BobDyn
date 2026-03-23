within BobLib.Vehicle.Chassis.Suspension.Linkages;

model TabularSpring "Tabular translational spring with optional mass"
  extends BobLib.Vehicle.Chassis.Suspension.Linkages.Templates.TabularCompliant;
  
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  import Modelica.SIunits;
  
  // Parameters
  parameter SIunits.TranslationalSpringConstant spring_table[:, 2] "Table of Force vs Compression (change in length)" annotation(
    Evaluate = false,
    Dialog(group = "Spring Parameters"));
  parameter SIunits.Length free_length "Free length of spring" annotation(
    Evaluate = false,
    Dialog(group = "Spring Parameters"));
  parameter SIunits.Length spring_diameter "Diameter of smallest possible cylinder enclosing spring" annotation(
    Dialog(group = "Animation"));
  
  // State vars
  Real defl;
  Real defl_abs;
  Real sgn;
  
  // Force generation
  Modelica.Blocks.Sources.RealExpression defl_expression(y = defl_abs) annotation(
    Placement(transformation(origin = {-90, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression sgn_expression(y = sgn) annotation(
    Placement(transformation(origin = {-90, 24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Product product annotation(
    Placement(transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(columns = {2}, extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, table = spring_table) annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}})));

equation
  defl = free_length - s_rel;
  defl_abs = sqrt(defl*defl + eps*eps);
  sgn = defl/defl_abs;
  
  connect(defl_expression.y, product.u1) annotation(
    Line(points = {{-79, 36}, {-73, 36}}, color = {0, 0, 127}));
  connect(sgn_expression.y, product.u2) annotation(
    Line(points = {{-79, 24}, {-73, 24}}, color = {0, 0, 127}));
  connect(product.y, combiTable1D.u[1]) annotation(
    Line(points = {{-49, 30}, {-33, 30}}, color = {0, 0, 127}));
  connect(combiTable1D.y[1], force.f) annotation(
    Line(points = {{-8, 30}, {0, 30}, {0, 4}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Icon(graphics = {Line(origin = {27.89, 0}, points = {{-127.885, 0}, {-107.885, 60}, {-67.8851, -60}, {-27.8851, 60}, {12.1149, -60}, {52.1149, 60}, {72.1149, 0}}, thickness = 5), Line(origin = {-0.02, -1.02}, points = {{-59.9838, -58.9838}, {-19.9838, -48.9838}, {20.0162, -18.9838}, {50.0162, 21.0162}, {60.0162, 61.0162}}, color = {255, 0, 0}, thickness = 3)}));
end TabularSpring;
