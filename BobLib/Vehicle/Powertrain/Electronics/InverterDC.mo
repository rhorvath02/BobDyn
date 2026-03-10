within BobLib.Vehicle.Powertrain.Electronics;

model InverterDC
  import Modelica.SIunits;

  // Electrical ports
  Modelica.Electrical.Analog.Interfaces.PositivePin p "DC bus positive" annotation(
    Placement(transformation(origin={-100,0}, extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "DC bus negative" annotation(
    Placement(transformation(origin={100,0}, extent={{-10,-10},{10,10}})));

  // Control input
  Modelica.Blocks.Interfaces.RealInput P_req "Requested mechanical/electrical output power [W] (+motoring, −regen)" annotation(
    Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation=-90)));
  
  // Output
  Modelica.Blocks.Interfaces.RealOutput P_out "Electrical power delivered to motor side [W] (+motoring, −regen)" annotation(
    Placement(transformation(origin = {0, -120}, extent={{-20,-20},{20,20}}, rotation = -90), iconTransformation(origin={0,-110}, extent={{-10,-10},{10,10}}, rotation=-90)));

  // Parameters
  parameter Real eta_mot = 0.97 "Inverter efficiency (motoring)";
  parameter Real eta_reg = 0.95 "Inverter efficiency (regen)";
  parameter SIunits.Voltage V_eps = 1.0 "Small voltage to avoid division by zero";

  // Internal current source
  Modelica.Electrical.Analog.Sources.SignalCurrent I_dc_source annotation(Placement(transformation(origin={0,0}, extent={{-10,-10},{10,10}})));

  // Outputs
  SIunits.Voltage V_dc "Measured DC bus voltage";
  SIunits.Current I_dc "DC current drawn from battery (+discharge)";
  SIunits.Power P_dc "DC electrical power from battery";
  SIunits.Power P_loss "Inverter losses";

protected
  SIunits.Power P_dc_cmd;

equation
  // DC bus measurement
  V_dc = p.v - n.v;
  
  // Drive: draw more DC power than deliver
  // Regen: return less DC power than absorb
  if P_req >= 0 then
    P_dc_cmd = P_req / eta_mot;
  else
    P_dc_cmd = P_req * eta_reg;
  end if;
  
  // DC current command
  I_dc = P_dc_cmd / max(abs(V_dc), V_eps);
  I_dc_source.i = I_dc;

  // Power computation
  P_dc = V_dc * I_dc;
  P_loss = P_dc - P_req;
  P_out = P_req;
  
  connect(p, I_dc_source.p) annotation(
    Line(points = {{-100, 0}, {-10, 0}}, color = {0, 0, 255}));
  connect(I_dc_source.n, n) annotation(
    Line(points = {{10, 0}, {100, 0}}, color = {0, 0, 255}));
end InverterDC;
