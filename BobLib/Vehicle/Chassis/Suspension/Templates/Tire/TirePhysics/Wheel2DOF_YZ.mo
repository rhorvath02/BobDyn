within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics;

model Wheel2DOF_YZ
  // Modelica units
  import Modelica.SIunits;
  // Load parameters
  replaceable record Wheel1DOF_YRecord = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Wheel1DOF_YRecord;
  parameter Wheel1DOF_YRecord wheel1DOF_YParams;
  
  replaceable record Wheel1DOF_ZRecord = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Wheel1DOF_ZRecord;
  parameter Wheel1DOF_ZRecord wheel1DOF_ZParams;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Templates.PartialWheel(inertia(J = wheel1DOF_YParams.wheel_J));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b hub_frame annotation(
    Placement(transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.Translational.Components.SpringDamper spring_damper(c = wheel1DOF_ZParams.tire_c, d = wheel1DOF_ZParams.tire_d, s_rel0 = partialWheelParams.R0) annotation(
    Placement(transformation(origin = {-30, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

equation
  connect(hub_frame, inertia.flange_a) annotation(
    Line(points = {{-100, 40}, {20, 40}, {20, 30}, {30, 30}}));
  connect(spring_damper.flange_a, prismatic_z.support) annotation(
    Line(points = {{-30, -36}, {-6, -36}}, color = {0, 127, 0}));
  connect(spring_damper.flange_b, prismatic_z.axis) annotation(
    Line(points = {{-30, -56}, {-20, -56}, {-20, -48}, {-6, -48}}, color = {0, 127, 0}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  Icon(graphics = {Ellipse(fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-15, -15}, {15, 15}}), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, thickness = 5), Text(origin = {0, 6}, textColor = {255, 0, 0}, extent = {{-98, 100}, {98, -100}}, textString = "2DOF"), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, color = {255, 255, 255}, thickness = 5), Line(origin = {0, -86}, points = {{0, -14}, {0, 24}}, color = {0, 170, 0}, thickness = 5), Line(origin = {0, -81}, points = {{0, -19}, {0, 19}}, color = {255, 255, 255}, thickness = 5), Line(origin = {-8.97, -80}, points = {{-1.02758, -20}, {-1.02758, -6}, {-5.02758, -4}, {2.97242, 0}, {-5.02758, 4}, {2.97242, 8}, {-1.02758, 12}, {-1.02758, 20}}, thickness = 2), Line(origin = {10, -91}, points = {{0, -9}, {0, 9}}, thickness = 2), Line(origin = {10, -82}, points = {{-5, 0}, {5, 0}}, thickness = 2), Line(origin = {10, -81}, points = {{-8, -5}, {-8, 5}, {8, 5}, {8, -5}}, thickness = 2), Line(origin = {10, -68}, points = {{0, -8}, {0, 8}}, thickness = 2)}),
  Diagram(graphics));
end Wheel2DOF_YZ;
