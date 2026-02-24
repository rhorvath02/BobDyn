within BobDyn.Vehicle.Electronics.Controllers;

model CurvatureController
  Modelica.Blocks.Interfaces.RealInput yaw_rate annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}),
              iconTransformation(origin = {66, -120}, extent = {{-20, -20}, {20, 20}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealInput v annotation(
    Placement(transformation(origin = {-60, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90),
              iconTransformation(origin = {-66, -120}, extent = {{-20, -20}, {20, 20}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealInput kappa_ref annotation(
    Placement(transformation(origin = {60, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90),
              iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput rack annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}),
              iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));

  parameter Real kp = 0.25 annotation(Dialog(group="Controller"));
  parameter Real ki = 0.05 annotation(Dialog(group="Controller"));

  parameter Real activation_time = 0 annotation(Dialog(group="Activation"));
  parameter Real activation_duration = 1 annotation(Dialog(group="Activation"));
  parameter Real default_output = 0 annotation(Dialog(group="Activation"));

  // --- stability parameters (no interface changes) ---
  parameter Real vx_min = 1.0 "m/s floor for curvature";
  parameter Real Tr = 0.03 "yaw rate filter";
  parameter Real T_rack = 0.05 "rack actuator lag";

protected
  Real integ(start=0);
  Real raw_output;
  Real gamma;
  Real kappa;

  Real r_filt(start=0);
  Real vx_eff;
  Real rack_state(start=default_output);

equation

  // --- yaw filtering (critical for stability) ---
  der(r_filt) = (yaw_rate - r_filt)/Tr;

  // --- sign-preserving velocity floor ---
  vx_eff = sqrt(v*v + vx_min*vx_min);

  kappa = r_filt / vx_eff;

  // --- smooth activation ---
  gamma = smooth(1,
    if time < activation_time then 0
    else min(1, (time - activation_time)/activation_duration));

  // --- PI integrator ---
  der(integ) =
    if time < activation_time then 0
    else (kappa_ref - kappa);

  raw_output = kp*(kappa_ref - kappa) + ki*integ;

  // --- steering actuator dynamics ---
  der(rack_state) = (raw_output - rack_state)/T_rack;

  rack = default_output + gamma*(rack_state - default_output);

end CurvatureController;
