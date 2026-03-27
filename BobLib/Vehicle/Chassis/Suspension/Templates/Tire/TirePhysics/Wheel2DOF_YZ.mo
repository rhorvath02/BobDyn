within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics;

model Wheel2DOF_YZ
  // Modelica units
  import Modelica.SIunits;
  
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  
  // Load parameters
  replaceable record Wheel1DOF_YRecord = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Wheel1DOF_YRecord;
  parameter Wheel1DOF_YRecord wheel1DOF_YParams;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates.PartialWheel(inertia(J = wheel1DOF_YParams.wheel_J));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b hub_frame annotation(
    Placement(transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(extent = {{-10, -10}, {10, 10}})));

equation
  connect(hub_frame, inertia.flange_a) annotation(
    Line(points = {{-100, 40}, {20, 40}, {20, 30}, {30, 30}}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  Icon(graphics = {Ellipse(fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, thickness = 5), Text(origin = {0, 6}, textColor = {255, 0, 0}, extent = {{-98, 100}, {98, -100}}, textString = "2DOF")}),
  Diagram(graphics));
end Wheel2DOF_YZ;
