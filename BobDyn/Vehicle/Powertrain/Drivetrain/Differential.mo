within BobDyn.Vehicle.Powertrain.Drivetrain;

model Differential
  import Modelica.SIunits;
  import Modelica.Math.tanh;

  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_in
    "Input from chain/gearbox" annotation(
      Placement(transformation(origin={-100,0}, extent={{-10,-10},{10,10}})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_left
    "Left halfshaft output" annotation(
      Placement(transformation(origin={100,40}, extent={{-10,-10},{10,10}})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_right
    "Right halfshaft output" annotation(
      Placement(transformation(origin={100,-40}, extent={{-10,-10},{10,10}})));

  // Tunables (start here)
  parameter Real c_lock = 50
    "Locking gain [N·m/(rad/s)]";
  parameter SIunits.Torque T_preload = 20
    "Preload locking torque [Nm]";
  parameter SIunits.AngularVelocity w_scale = 1.0
    "Slip speed scaling for tanh() [rad/s]";

  // Diagnostics
  SIunits.AngularVelocity w_in;
  SIunits.AngularVelocity w_l;
  SIunits.AngularVelocity w_r;
  SIunits.AngularVelocity dw;
  SIunits.Torque T_in;
  SIunits.Torque T_lock;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}})));
equation
  w_in = der(shaft_in.phi);
  w_l  = der(shaft_left.phi);
  w_r  = der(shaft_right.phi);
  dw   = w_l - w_r;

  // Open-diff kinematics (no ratio here)
  w_in = (w_l + w_r)/2;

  // Input torque (positive drives)
  T_in = -shaft_in.tau;

  // Locking torque biases torque to the slower wheel
  // (oppose speed difference)
  T_lock = T_preload * tanh((-dw)/w_scale) + c_lock * (-dw);

  // Equal split + bias
  shaft_left.tau  = -( T_in/2 + T_lock );
  shaft_right.tau = -( T_in/2 - T_lock );
  
  support.tau = -1 * (shaft_left.tau + shaft_right.tau - shaft_in.tau);
  
annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end Differential;
