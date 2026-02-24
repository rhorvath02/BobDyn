within BobDyn.TestVehicle.TestPowertrain;
model TestPowertrain
  import Modelica.SIunits;
  // Battery
  BobDyn.Vehicle.Powertrain.Battery.BatteryPack batt(Ns = 140, Np = 4, SOC_start = 1.0) annotation(
    Placement(transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}})));
  // Inverter
  BobDyn.Vehicle.Powertrain.Electronics.InverterDC inv annotation(
    Placement(transformation(origin = {-80, 30}, extent = {{-10, -10}, {10, 10}})));
  // Power command
  Modelica.Blocks.Sources.Step P_step(height = 80e3,  // 80 kW
  startTime = 1.0) annotation(
    Placement(transformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}})));
  // Electrical reference
  Modelica.Electrical.Analog.Basic.Ground g annotation(
    Placement(transformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}})));
  Vehicle.Powertrain.Drivetrain.Motor motor annotation(
    Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation(
    Placement(transformation(origin = {60, 20}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Mechanics.Rotational.Sources.Speed speed annotation(
    Placement(transformation(origin = {90, 20}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Step speed_step(height = w_avg + dw/2, startTime = 1.0) annotation(
    Placement(transformation(origin = {120, 20}, extent = {{10, -10}, {-10, 10}})));
  Vehicle.Powertrain.Drivetrain.Differential differential(c_lock = 8, T_preload = 25, w_scale = 2)  annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 3.31, useSupport = false)  annotation(
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
  
  parameter Real w_avg = 60 "Average wheel speed [rad/s]";
  parameter Real dw = 0 "Wheel speed difference wL-wR [rad/s]";
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor1 annotation(
    Placement(transformation(origin = {60, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed1 annotation(
    Placement(transformation(origin = {90, -20}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Step speed_step1(height = w_avg - dw/2, startTime = 1.0) annotation(
    Placement(transformation(origin = {120, -20}, extent = {{10, -10}, {-10, 10}})));
equation
  connect(P_step.y, inv.P_req) annotation(
    Line(points = {{-99, 50}, {-80, 50}, {-80, 42}}, color = {0, 0, 255}));
  connect(g.p, batt.p) annotation(
    Line(points = {{-110, -40}, {-110, -20}, {-90, -20}}, color = {0, 0, 255}));
  connect(inv.p, batt.p) annotation(
    Line(points = {{-90, 30}, {-100, 30}, {-100, -20}, {-90, -20}}, color = {0, 0, 255}));
  connect(inv.n, batt.n) annotation(
    Line(points = {{-70, 30}, {-60, 30}, {-60, -20}, {-70, -20}}, color = {0, 0, 255}));
  connect(inv.P_out, motor.P_elec) annotation(
    Line(points = {{-80, 19}, {-80, -1}, {-52, -1}}, color = {0, 0, 127}));
  connect(speed.flange, torqueSensor.flange_b) annotation(
    Line(points = {{80, 20}, {70, 20}}));
  connect(speed_step.y, speed.w_ref) annotation(
    Line(points = {{109, 20}, {101, 20}}, color = {0, 0, 127}));
  connect(motor.shaft, idealGear.flange_a) annotation(
    Line(points = {{-30, 0}, {-20, 0}}));
  connect(idealGear.flange_b, differential.shaft_in) annotation(
    Line(points = {{0, 0}, {10, 0}}));
  connect(speed_step1.y, speed1.w_ref) annotation(
    Line(points = {{109, -20}, {101, -20}}, color = {0, 0, 127}));
  connect(speed1.flange, torqueSensor1.flange_b) annotation(
    Line(points = {{80, -20}, {70, -20}}));
  connect(torqueSensor1.flange_a, differential.shaft_right) annotation(
    Line(points = {{50, -20}, {40, -20}, {40, -4}, {30, -4}}));
  connect(torqueSensor.flange_a, differential.shaft_left) annotation(
    Line(points = {{50, 20}, {40, 20}, {40, 4}, {30, 4}}));
annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"),
  Diagram(coordinateSystem(extent = {{-120, 60}, {140, -60}})));
end TestPowertrain;
