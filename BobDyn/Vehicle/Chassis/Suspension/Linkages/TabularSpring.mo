within BobDyn.Vehicle.Chassis.Suspension.Linkages;

model TabularSpring "Tabular translational spring with optional mass"
  extends BobDyn.Vehicle.Chassis.Suspension.Linkages.Templates.TabularCompliant;
  
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  import Modelica.SIunits;
  
  // Parameters
  parameter SIunits.TranslationalSpringConstant spring_table[:,2] "Table of Force vs Compression (change in length)" annotation(
    Dialog(group = "Spring Parameters"));
  parameter SIunits.Length free_length "Free length of spring" annotation(Dialog(group = "Spring Parameters"));
  
  parameter SIunits.Length spring_diameter "Diameter of smallest possible cylinder enclosing spring" annotation(Dialog(group = "Animation"));
  
//protected
  // State vars
  Real defl;
  Real defl_abs;
  Real sgn;
  
  // Visual vars
  Real[3] e_spring;
  Real[3] ref;
  Real[3] w_spring;

  // Visualization
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(
    shapeType = "spring",
    R = Modelica.Mechanics.MultiBody.Frames.nullRotation(),
    r = lineForceWithMass.frame_a.r_0,
    lengthDirection = e_spring,
    widthDirection  = w_spring,
    length = length,
    width  = spring_diameter / 2,
    height = spring_diameter/10,
    extra  = 6) annotation(Placement(transformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}})));
  
  // Force generation
  Modelica.Blocks.Sources.RealExpression defl_expression(y = defl_abs) annotation(
    Placement(transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(columns = {2}, 
                                                   extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
                                                   smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments,
                                                   table = spring_table) annotation(
    Placement(transformation(origin = {-20, 84}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression sgn_expression(y = sgn) annotation(
    Placement(transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Product product annotation(
    Placement(transformation(origin = {-60, 84}, extent = {{-10, -10}, {10, 10}})));
  
equation
  // Deflection calc
  defl = free_length - length;
  
  // Smooth abs and smooth sign
  defl_abs = sqrt(defl*defl + eps*eps);
  sgn = defl/defl_abs;
  
  // Visualization calcs
  e_spring = if length > 1e-9 then r_rel/length else {1, 0, 0};
  ref = if abs(e_spring[3]) < 0.9 then {0, 0, 1} else {1, 0, 0};
  w_spring = normalize(cross(ref, e_spring));
  connect(defl_expression.y, product.u1) annotation(
    Line(points = {{-78, 90}, {-72, 90}}, color = {0, 0, 127}));
  connect(sgn_expression.y, product.u2) annotation(
    Line(points = {{-78, 78}, {-72, 78}}, color = {0, 0, 127}));
  connect(product.y, combiTable1D.u[1]) annotation(
    Line(points = {{-48, 84}, {-32, 84}}, color = {0, 0, 127}));
  connect(combiTable1D.y[1], force.f) annotation(
    Line(points = {{-8, 84}, {0, 84}, {0, 34}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end TabularSpring;
