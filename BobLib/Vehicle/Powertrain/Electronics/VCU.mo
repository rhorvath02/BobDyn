within BobLib.Vehicle.Powertrain.Electronics;

model VCU
  import Modelica.SIunits;

  /**********************
   * Inputs (Commands)
   **********************/
  Modelica.Blocks.Interfaces.RealInput cmd_torque_motor
    "Requested motor torque [Nm]" annotation(
      Placement(transformation(origin={-120,40}, extent={{-20,-20},{20,20}})));

  Modelica.Blocks.Interfaces.RealInput cmd_regen_limit
    "Max allowed regen torque (positive magnitude) [Nm]" annotation(
      Placement(transformation(origin={-120,-40}, extent={{-20,-20},{20,20}})));

  Modelica.Blocks.Interfaces.BooleanInput cmd_inverter_enable
    "Inverter enable / R2D" annotation(
      Placement(transformation(origin={-120,0}, extent={{-20,-20},{20,20}})));

  /**********************
   * Inputs (Sensors)
   **********************/
  Modelica.Blocks.Interfaces.RealInput sens_motor_speed
    "Motor speed [rad/s]" annotation(
      Placement(transformation(origin={-120,80}, extent={{-20,-20},{20,20}})));

  Modelica.Blocks.Interfaces.RealInput sens_hv_bus_voltage
    "HV bus voltage [V]" annotation(
      Placement(transformation(origin={-120,-80}, extent={{-20,-20},{20,20}})));

  Modelica.Blocks.Interfaces.RealInput sens_hv_bus_current
    "HV bus current [A]" annotation(
      Placement(transformation(origin={-120,-120}, extent={{-20,-20},{20,20}})));

  /**********************
   * Outputs
   **********************/
  Modelica.Blocks.Interfaces.RealOutput P_req
    "Power request to inverter [W]" annotation(
      Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));

  Modelica.Blocks.Interfaces.RealOutput tau_cmd_limited
    "Final torque command after limits [Nm]" annotation(
      Placement(transformation(origin={120,40}, extent={{-20,-20},{20,20}})));

  Modelica.Blocks.Interfaces.BooleanOutput vcu_active
    "VCU active / inverter enabled" annotation(
      Placement(transformation(origin={120,-40}, extent={{-20,-20},{20,20}})));

  /**********************
   * Parameters
   **********************/
  parameter SIunits.Torque tau_max = 240
    "Max motoring torque [Nm]";

  parameter SIunits.AngularVelocity w_eps = 1e-2
    "Small speed for launch protection";

protected
  SIunits.Torque tau_cmd_raw;
  SIunits.AngularVelocity w_eff;

equation
  // Safety / enable
  vcu_active = cmd_inverter_enable;

  // Raw torque command
  tau_cmd_raw =
    if not cmd_inverter_enable then
      0
    else
      min(
        max(cmd_torque_motor, -cmd_regen_limit),
        tau_max
      );

  tau_cmd_limited = tau_cmd_raw;

  // Effective speed (avoid zero divide)
  w_eff = if abs(sens_motor_speed) > w_eps
          then sens_motor_speed
          else w_eps * sign(sens_motor_speed + 1e-6);

  // Torque -> Power
  P_req = tau_cmd_limited * w_eff;

end VCU;
