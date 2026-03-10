within BobLib.TestVehicle.TestPowertrain;

model TestBatteryPack

  import Modelica.Electrical.Analog.Basic.*;
  import Modelica.Electrical.Analog.Sensors.*;
  import Modelica.SIunits;

  // Device under test
  BobLib.Vehicle.Powertrain.Battery.BatteryPack batt(Ns = 140,
                                                          Np = 4,
                                                          SOC_start = 1.0, R_cell = 0.020, E_cell = 3.888e4) annotation(
    Placement(transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}})));
  
  // Load
  Modelica.Electrical.Analog.Basic.Resistor load(R = 4.3) "Electrical load" annotation(
    Placement(transformation(origin = {30, -30}, extent = {{10, -10}, {-10, 10}})));
  
  // Sensors
  Modelica.Electrical.Analog.Sensors.VoltageSensor V_batt annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor I_batt annotation(
    Placement(transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

  // Electrical reference
  Modelica.Electrical.Analog.Basic.Ground g annotation(
    Placement(transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(load.p, g.p) annotation(
    Line(points = {{40, -30}, {60, -30}, {60, -60}, {-70, -60}}, color = {0, 0, 255}));
  connect(g.p, batt.p) annotation(
    Line(points = {{-70, -60}, {-70, -30}, {-60, -30}}, color = {0, 0, 255}));
  connect(V_batt.n, batt.n) annotation(
    Line(points = {{-40, 0}, {-40, -30}}, color = {0, 0, 255}));
  connect(V_batt.p, batt.p) annotation(
    Line(points = {{-60, 0}, {-60, -30}}, color = {0, 0, 255}));
  connect(batt.n, I_batt.n) annotation(
    Line(points = {{-40, -30}, {-20, -30}}, color = {0, 0, 255}));
  connect(I_batt.p, load.n) annotation(
    Line(points = {{0, -30}, {20, -30}}, color = {0, 0, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"));
end TestBatteryPack;
