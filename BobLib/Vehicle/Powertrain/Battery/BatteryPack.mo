within BobLib.Vehicle.Powertrain.Battery;

model BatteryPack
  extends BobLib.Vehicle.Powertrain.Battery.Templates.BatteryBase;
  
  import Modelica.SIunits;
  import Modelica.Math.Vectors.interpolate;

  // Cell parameters
  parameter SIunits.Resistance R_cell = 0.003;
  parameter SIunits.Energy E_cell = 15e3;

  // OCV curve (cell-level)
  parameter Real SOC_table[:] = {0, 0.1, 0.2, 0.4, 0.6, 0.8, 1.0};
  parameter SIunits.Voltage V_ocv_cell_table[:] = {3.0, 3.3, 3.5, 3.7, 3.85, 4.0, 4.2};
  
  final parameter SIunits.Resistance R_pack = (Ns/Np)*R_cell;
  final parameter SIunits.Energy E_pack = Ns*Np*E_cell;
  
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = R_pack)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));

protected
  SIunits.Voltage v_oc_cell;
  SIunits.Voltage v_oc_pack;

equation
  assert(Ns > 0 and Np > 0, "BatteryPack: Ns and Np must be >= 1");
  
  // Open-circuit voltage
  v_oc_cell = interpolate(SOC_table, V_ocv_cell_table, SOC);
  v_oc_pack = Ns*v_oc_cell;
  
  // Electrical behavior
  signalVoltage.v = v_oc_pack;
  
  // SOC dynamics (bounded)
  // i > 0 → discharge → SOC decreases
  if SOC <= 0 and P > 0 then
    der(SOC) = 0;
  elseif SOC >= 1 and P < 0 then
    der(SOC) = 0;
  else
    der(SOC) = -P / E_pack;
  end if;
  
  connect(p, signalVoltage.p) annotation(
    Line(points = {{-100, 0}, {-40, 0}}, color = {0, 0, 255}));
  connect(signalVoltage.n, resistor.p) annotation(
    Line(points = {{-20, 0}, {20, 0}}, color = {0, 0, 255}));
  connect(resistor.n, n) annotation(
    Line(points = {{40, 0}, {100, 0}}, color = {0, 0, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end BatteryPack;
