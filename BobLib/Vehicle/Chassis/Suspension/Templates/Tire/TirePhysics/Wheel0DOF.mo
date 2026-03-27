within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics;

model Wheel0DOF
  // Modelica units
  import Modelica.SIunits;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates.PartialWheel(inertia(J = 0.01));
  Modelica.Blocks.Sources.RealExpression Fx_reaction(y = -cp_frame.f[1]) annotation(
    Placement(transformation(origin = {-50, 54}, extent = {{-10, -10}, {10, 10}})));
equation
  
  connect(hub_axis.support, inertia.flange_a) annotation(
    Line(points = {{14, 10}, {14, 30}, {30, 30}}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  Icon(graphics = {Ellipse(fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, thickness = 5), Text(origin = {1, 4}, textColor = {255, 0, 0}, extent = {{-81, 100}, {81, -100}}, textString = "0DOF")}),
  Diagram(graphics));
end Wheel0DOF;
