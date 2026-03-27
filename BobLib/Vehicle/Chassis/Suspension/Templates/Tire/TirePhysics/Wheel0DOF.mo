within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics;

model Wheel0DOF
  // Modelica units
  import Modelica.SIunits;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates.PartialWheel(inertia(J = 0.01), prismatic_z(stateSelect = StateSelect.never));
  
  Modelica.Mechanics.Translational.Components.Rod fixed_radius(L = partialWheelParams.R0) annotation(
    Placement(transformation(origin = {-30, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

equation
  connect(fixed_radius.flange_a, prismatic_z.support) annotation(
    Line(points = {{-30, -36}, {-6, -36}}, color = {0, 127, 0}));
  connect(fixed_radius.flange_b, prismatic_z.axis) annotation(
    Line(points = {{-30, -56}, {-20, -56}, {-20, -48}, {-6, -48}}, color = {0, 127, 0}));
  connect(inertia.flange_a, hub_axis.support) annotation(
    Line(points = {{30, 30}, {14, 30}, {14, 10}}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  Icon(graphics = {Ellipse(fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, thickness = 5), Text(origin = {1, 4}, textColor = {255, 0, 0}, extent = {{-81, 100}, {81, -100}}, textString = "0DOF")}),
  Diagram(graphics));
end Wheel0DOF;
