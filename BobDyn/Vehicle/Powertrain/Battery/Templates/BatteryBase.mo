within BobDyn.Vehicle.Powertrain.Battery.Templates;
partial model BatteryBase
  import Modelica.SIunits;

  // Electrical terminals
  Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive DC terminal" annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative DC terminal" annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
  
  // Cell topology (structural parameters)
  parameter Integer Ns(min=1) "Number of cells in series";
  parameter Integer Np(min=1) "Number of cells in parallel";

  // Initial condition
  parameter Real SOC_start(unit="1", min=0, max=1) = 1 "Initial battery state of charge";

  // Physical state (NOT output)
  Real SOC(unit="1", min=0, max=1) "Pack state of charge";

  // Internal electrical quantities (NOT outputs)
  SIunits.Voltage v "Terminal voltage (p.v - n.v)";
  SIunits.Current i "Battery current (positive -> discharge)";
  SIunits.Power   P "Electrical power (i * v)";

equation
  // Kirchhoff-consistent relations
  v = p.v - n.v;
  i = n.i;
  P = i * v;

initial equation
  SOC = SOC_start;

end BatteryBase;
