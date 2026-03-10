within BobLib.TestVehicle.TestPowertrain;

model TestBatteryInverter
  import Modelica.SIunits;
  // Battery
  BobLib.Vehicle.Powertrain.Battery.BatteryPack batt(Ns = 140, Np = 4, SOC_start = 1.0) annotation(
    Placement(transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}})));
  // Inverter
  BobLib.Vehicle.Powertrain.Electronics.InverterDC inv annotation(
    Placement(transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}})));
  // Power command
  Modelica.Blocks.Sources.Step P_step(height = 80e3,  // 80 kW
  startTime = 1.0) annotation(
    Placement(transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}})));
  // Electrical reference
  Modelica.Electrical.Analog.Basic.Ground g annotation(
    Placement(transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(P_step.y, inv.P_req) annotation(
    Line(points = {{-19, 60}, {0, 60}, {0, 52}}, color = {0, 0, 255}));
  connect(g.p, batt.p) annotation(
    Line(points = {{-30, -30}, {-30, -10}, {-10, -10}}, color = {0, 0, 255}));
  connect(inv.p, batt.p) annotation(
    Line(points = {{-10, 40}, {-20, 40}, {-20, -10}, {-10, -10}}, color = {0, 0, 255}));
  connect(inv.n, batt.n) annotation(
    Line(points = {{10, 40}, {20, 40}, {20, -10}, {10, -10}}, color = {0, 0, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 10, Interval = 0.002, Tolerance = 1e-06),
    __OpenModelica_simulationFlags(s = "cvode", lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", variableFilter = ".*"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
end TestBatteryInverter;
