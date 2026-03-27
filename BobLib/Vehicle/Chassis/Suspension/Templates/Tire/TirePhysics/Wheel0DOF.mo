within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics;

model Wheel0DOF
  // Modelica units
  import Modelica.SIunits;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates.PartialWheel(inertia(J = 0.01));
  
  Modelica.Mechanics.MultiBody.Parts.Mounting1D rotational_lock annotation(
    Placement(transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.Translational.Components.Rod fixed_radius(L = partialWheelParams.R0) annotation(
    Placement(transformation(origin = {-30, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

equation
  connect(rotational_lock.frame_a, hub_axis.frame_a) annotation(
    Line(points = {{-10, 20}, {-10, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(rotational_lock.flange_b, inertia.flange_a) annotation(
    Line(points = {{0, 30}, {30, 30}}));
  connect(fixed_radius.flange_a, prismatic_z.support) annotation(
    Line(points = {{-30, -36}, {-6, -36}}, color = {0, 127, 0}));
  connect(fixed_radius.flange_b, prismatic_z.axis) annotation(
    Line(points = {{-30, -56}, {-20, -56}, {-20, -48}, {-6, -48}}, color = {0, 127, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  Icon(graphics = {Ellipse(fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, thickness = 5)}),
  Diagram(graphics));
end Wheel0DOF;
