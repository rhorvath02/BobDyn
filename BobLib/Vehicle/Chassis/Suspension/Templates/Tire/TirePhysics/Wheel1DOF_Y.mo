within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics;

model Wheel1DOF_Y
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Wheel1DOF_YRecord;

  // Record parameters
  parameter Wheel1DOF_YRecord wheel1DOF_YParams;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates.PartialWheel(inertia(J = wheel1DOF_YParams.wheelJ));
  
  Modelica.Mechanics.Translational.Components.Rod fixedRadius(L = partialWheelParams.R0)  annotation(
    Placement(transformation(origin = {-30, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
equation
  connect(fixedRadius.flange_a, prismatic_z.support) annotation(
    Line(points = {{-30, -36}, {-6, -36}}, color = {0, 127, 0}));
  connect(fixedRadius.flange_b, prismatic_z.axis) annotation(
    Line(points = {{-30, -56}, {-20, -56}, {-20, -48}, {-6, -48}}, color = {0, 127, 0}));
  
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  Icon(graphics = {Ellipse(fillColor = {0, 170, 0},fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, thickness = 5), Text( origin = {-2, 4},textColor = {255, 0, 0}, extent = {{-83, 100}, {83, -100}}, textString = "1DOF")}),
  Diagram(graphics));
end Wheel1DOF_Y;
