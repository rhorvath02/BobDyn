within BobDyn.Vehicle.Electronics.Controllers;

model SpeedController
  Modelica.Blocks.Interfaces.RealInput v annotation(
    Placement(transformation(origin = {-120, 0},
      extent = {{-20, -20}, {20, 20}}),
      iconTransformation(origin = {-120, 0},
      extent = {{-20, -20}, {20, 20}})));

  Modelica.Blocks.Interfaces.RealInput v_ref annotation(
    Placement(transformation(origin = {0, -120},
      extent = {{-20, -20}, {20, 20}}, rotation = 90),
      iconTransformation(origin = {0, -120},
      extent = {{-20, -20}, {20, 20}}, rotation = 90)));

  Modelica.Blocks.Interfaces.RealOutput drive_torque annotation(
    Placement(transformation(origin = {110, 0},
      extent = {{-10, -10}, {10, 10}}),
      iconTransformation(origin = {110, 0},
      extent = {{-10, -10}, {10, 10}})));

  // =========================
  // Controller Gains
  // =========================
  parameter Real kp = 400
    annotation(Dialog(group="Controller", tab="Gains"));

  parameter Real ki = 80
    annotation(Dialog(group="Controller", tab="Gains"));

  // =========================
  // Torque Limits
  // =========================
  parameter Real torque_max = 4000
    annotation(Dialog(group="Limits", tab="Actuator"));

  parameter Real torque_min = -4000
    annotation(Dialog(group="Limits", tab="Actuator"));

  // =========================
  // Actuator Dynamics
  // =========================
  parameter Real tau = 0.05
    annotation(Dialog(group="Actuator", tab="Dynamics"));

protected
  Real integ(start=0, fixed=true)
    annotation(Dialog(enable=false));

  Real raw_torque
    annotation(Dialog(enable=false));

  Real torque_cmd
    annotation(Dialog(enable=false));

  Real torque_state(start=0, fixed=true)
    annotation(Dialog(enable=false));

equation

  // =========================
  // PI Controller
  // =========================
  der(integ) = v_ref - v;

  raw_torque = kp*(v_ref - v) + ki*integ;

  // =========================
  // Saturation
  // =========================
  torque_cmd = min(max(raw_torque, torque_min), torque_max);

  // =========================
  // First-Order Actuator
  // =========================
  der(torque_state) = (torque_cmd - torque_state)/tau;

  drive_torque = torque_state;

annotation(
  defaultComponentName="speedController",
  Icon(graphics={
    Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
    Text(extent={{-80,40},{80,-40}}, textString="Speed\nPI")
  })
);

end SpeedController;
