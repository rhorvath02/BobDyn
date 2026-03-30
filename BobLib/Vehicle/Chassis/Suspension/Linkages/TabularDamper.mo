within BobLib.Vehicle.Chassis.Suspension.Linkages;

model TabularDamper "Tabular translational damper with velocity-force curve"
  import Modelica.SIunits;
  
  extends BobLib.Vehicle.Chassis.Suspension.Linkages.Templates.TabularCompliant;
  
  // Damper parameters
  parameter SIunits.TranslationalDampingConstant damperTable[:, 2] "Table of Force vs Relative Velocity (m/s, N)" annotation(
    Dialog(group = "Damper Parameters"));
  
  Real v_rel;
  Real v_abs;
  Real vel_sgn;
  
  // Velocity processing blocks
  Modelica.Blocks.Sources.RealExpression velExpression(y = v_abs) annotation(
    Placement(transformation(origin = {-90, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression sgnExpression(y = -vel_sgn) annotation(
    Placement(transformation(origin = {-90, 24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Product product annotation(
    Placement(transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}})));  
  
  // Force output block
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(columns = {2}, extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, table = damperTable) annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}})));

equation
  v_rel = der(s_rel);
  v_abs = sqrt(v_rel*v_rel + eps*eps);
  vel_sgn = v_rel/v_abs;
  
  connect(velExpression.y, product.u1) annotation(
    Line(points = {{-79, 36}, {-73, 36}}, color = {0, 0, 127}));
  connect(sgnExpression.y, product.u2) annotation(
    Line(points = {{-79, 24}, {-73, 24}}, color = {0, 0, 127}));
  connect(product.y, combiTable1D.u[1]) annotation(
    Line(points = {{-49, 30}, {-33, 30}}, color = {0, 0, 127}));
  connect(combiTable1D.y[1], force.f) annotation(
    Line(points = {{-8, 30}, {0, 30}, {0, 4}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Icon(graphics = {Line(origin = {-60, 0}, points = {{-40, 0}, {40, 0}}, thickness = 5), Line(origin = {-20, 0}, points = {{0, 36}, {0, -36}}, thickness = 5), Line(origin = {-5, 0}, points = {{-25, 40}, {25, 40}, {25, -40}, {-25, -40}}, thickness = 5), Line(origin = {65, 0}, points = {{-45, 0}, {35, 0}}, thickness = 5), Line(origin = {-0.13, -19.13}, points = {{-59.8675, -12.8675}, {-49.8675, 17.1325}, {-19.8675, 43.1325}, {60.1325, 47.1325}}, color = {255, 0, 0}, thickness = 3)}));
end TabularDamper;
