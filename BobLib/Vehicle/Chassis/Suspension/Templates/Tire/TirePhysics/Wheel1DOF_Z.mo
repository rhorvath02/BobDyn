within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics;

model Wheel1DOF_Z
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Wheel1DOF_ZRecord;
  
  // Record parameters
  parameter Wheel1DOF_ZRecord wheel1DOF_ZParams;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates.PartialWheel(inertia(J = 0.01));
  
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper(c = wheel1DOF_ZParams.wheelC, d = wheel1DOF_ZParams.wheelD, s_rel0 = partialWheelParams.R0)  annotation(
    Placement(transformation(origin = {-30, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

equation
  connect(springDamper.flange_a, prismatic_z.support) annotation(
    Line(points = {{-30, -36}, {-6, -36}}, color = {0, 127, 0}));
  connect(springDamper.flange_b, prismatic_z.axis) annotation(
    Line(points = {{-30, -56}, {-20, -56}, {-20, -48}, {-6, -48}}, color = {0, 127, 0}));
  connect(inertia.flange_a, hubAxis.support) annotation(
    Line(points = {{30, 30}, {14, 30}, {14, 10}}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  Icon(graphics = {Ellipse(fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, color = {255, 255, 255}, thickness = 5), Line(origin = {-8.97, -80}, points = {{-1.02758, -20}, {-1.02758, -6}, {-5.02758, -4}, {2.97242, 0}, {-5.02758, 4}, {2.97242, 8}, {-1.02758, 12}, {-1.02758, 20}}, color = {0, 170, 0}, thickness = 2), Line(origin = {10, -91}, points = {{0, -9}, {0, 9}}, color = {0, 170, 0}, thickness = 2), Line(origin = {10, -82}, points = {{-5, 0}, {5, 0}}, color = {0, 170, 0}, thickness = 2), Line(origin = {10, -81}, points = {{-8, -5}, {-8, 5}, {8, 5}, {8, -5}}, color = {0, 170, 0}, thickness = 2), Line(origin = {10, -68}, points = {{0, -8}, {0, 8}}, color = {0, 170, 0}, thickness = 2), Text(origin = {-2, 4}, textColor = {255, 0, 0}, extent = {{-83, 100}, {83, -100}}, textString = "1DOF")}),
  Diagram(graphics));
end Wheel1DOF_Z;
