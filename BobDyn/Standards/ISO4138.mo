within BobDyn.Standards;

model ISO4138
  import Modelica.Math.Vectors.norm;
  final inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  // Chassis
  BobDyn.Vehicle.Chassis.RigidChassis chassisBase annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}})));
  // Wheel torques
  Modelica.Blocks.Sources.Constant Fr_torque_in(k = 0) annotation(
    Placement(transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  // Sensor package
  output BobDyn.Resources.Records.SENSING.VehicleTelemetry telem;
  Real a_body[3];
  Real vel_body[3];
  Real w_body[3];
  Real phi_body[3];
  Real left_delta_vec[3];
  Real right_delta_vec[3];
  Real RL_delta_vec[3];
  Real RR_delta_vec[3];
  Real path_curv;
  parameter Real k = 450;
  parameter Real Ti = 0.8;
  parameter Real Td = 0;
  parameter Real yMax = 2000;
  final Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}})));
  final Modelica.Mechanics.Rotational.Sources.Torque Rr_torque annotation(
    Placement(transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}})));
  final Modelica.Blocks.Continuous.LimPID PID(k = k, Ti = Ti, Td = Td, yMax = yMax, initType = Modelica.Blocks.Types.InitPID.InitialOutput, y_start = 0) annotation(
    Placement(transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
  final Modelica.Blocks.Sources.Ramp speed_target_sig(height = 7, duration = 20, offset = 8, startTime = 15) annotation(
    Placement(transformation(origin = {-130, -30}, extent = {{-10, -10}, {10, 10}})));
  final Modelica.Blocks.Sources.RealExpression speed_measure_sig(y = telem.kin_sigs.speed) annotation(
    Placement(transformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}})));
  //  Modelica.Blocks.Sources.RealExpression yaw_rate_sig(y = telem.kin_sigs.r) annotation(
  //    Placement(transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}})));
  //  BobDyn.Vehicle.Electronics.Controllers.CurvatureController curvatureController(activation_time = 7.5, kp = 0.35, ki = 0.08, Tr = 0.05, T_rack = 0.08) annotation(
  //    Placement(transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}})));
  //  Modelica.Blocks.Sources.Constant curv_const(k = 1/20) annotation(
  //    Placement(transformation(origin = {50, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 0.75*0.0254, duration = 10, offset = 0, startTime = 10)  annotation(
    Placement(transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}})));
equation
  a_body = Modelica.Mechanics.MultiBody.Frames.resolve2(chassisBase.R_IMF, chassisBase.sprung_mass.a_0);
  vel_body = Modelica.Mechanics.MultiBody.Frames.resolve2(chassisBase.R_IMF, chassisBase.sprung_mass.v_0);
  w_body = Modelica.Mechanics.MultiBody.Frames.resolve2(chassisBase.R_IMF, chassisBase.sprung_mass.w_a);
  phi_body = Modelica.Mechanics.MultiBody.Frames.resolve2(chassisBase.R_IMF, chassisBase.absoluteAngles.angles);
// Input sensing
  telem.input_sigs.handwheel_angle = chassisBase.FrAxle.steer_input;
  telem.input_sigs.torque_command = 0;
// Aero sensing
  telem.aero_sigs.drag = 0;
  telem.aero_sigs.side_force = 0;
  telem.aero_sigs.lift = 0;
  telem.aero_sigs.roll_moment = 0;
  telem.aero_sigs.pitch_moment = 0;
  telem.aero_sigs.yaw_moment = 0;
// Kinematic sensing
  telem.kin_sigs.roll = phi_body[1];
  telem.kin_sigs.pitch = phi_body[2];
  telem.kin_sigs.yaw = chassisBase.absoluteAngles.angles[3];
  telem.kin_sigs.p = w_body[1];
  telem.kin_sigs.q = w_body[2];
  telem.kin_sigs.r = w_body[3];
  telem.kin_sigs.vx = vel_body[1];
  telem.kin_sigs.vy = vel_body[2];
  telem.kin_sigs.vz = vel_body[3];
  telem.kin_sigs.speed = norm(chassisBase.sprung_mass.v_0);
  telem.kin_sigs.beta = atan2(vel_body[2], vel_body[1]);
  telem.kin_sigs.X = chassisBase.sprung_mass.r_0[1];
  telem.kin_sigs.Y = chassisBase.sprung_mass.r_0[2];
  telem.kin_sigs.Z = chassisBase.sprung_mass.r_0[3];
// Dynamic sensing
  telem.dyn_sigs.ax = a_body[1];
  telem.dyn_sigs.ay = a_body[2];
  telem.dyn_sigs.az = a_body[3];
  telem.dyn_sigs.Fx = 0;
  telem.dyn_sigs.Fy = 0;
  telem.dyn_sigs.Fz = 0;
  telem.dyn_sigs.Mx = 0;
  telem.dyn_sigs.My = 0;
  telem.dyn_sigs.Mz = 0;
// Powertrain sensing
  telem.powertrain_sigs.wheel_torque[1] = 0;
  telem.powertrain_sigs.wheel_torque[2] = 0;
  telem.powertrain_sigs.wheel_torque[3] = 0;
  telem.powertrain_sigs.wheel_torque[4] = 0;
  telem.powertrain_sigs.wheel_power[1] = 0;
  telem.powertrain_sigs.wheel_power[2] = 0;
  telem.powertrain_sigs.wheel_power[3] = 0;
  telem.powertrain_sigs.wheel_power[4] = 0;
// Suspension sensing
  telem.sus_sigs[1].frame_height = chassisBase.FL_frame_coord.r_rel[3];
  telem.sus_sigs[1].shock_deflection = chassisBase.FrAxle.left_tabular_spring.defl_abs*chassisBase.FrAxle.left_tabular_spring.sgn;
  telem.sus_sigs[1].shock_velocity = chassisBase.FrAxle.left_tabular_damper.v_abs*chassisBase.FrAxle.left_tabular_damper.vel_sgn;
  telem.sus_sigs[1].stabar_torque = chassisBase.FrAxle.stabar.spring.tau;
  telem.sus_sigs[1].stabar_angle = chassisBase.FrAxle.stabar.spring.phi_rel;

  telem.sus_sigs[2].frame_height = chassisBase.FR_frame_coord.r_rel[3];
  telem.sus_sigs[2].shock_deflection = chassisBase.FrAxle.right_tabular_spring.defl_abs*chassisBase.FrAxle.right_tabular_spring.sgn;
  telem.sus_sigs[2].shock_velocity = chassisBase.FrAxle.right_tabular_damper.v_abs*chassisBase.FrAxle.right_tabular_damper.vel_sgn;
  telem.sus_sigs[2].stabar_torque = chassisBase.FrAxle.stabar.spring.tau;
  telem.sus_sigs[2].stabar_angle = chassisBase.FrAxle.stabar.spring.phi_rel;
  
  telem.sus_sigs[3].frame_height = chassisBase.RL_frame_coord.r_rel[3];
  telem.sus_sigs[3].shock_deflection = chassisBase.RrAxle.left_tabular_spring.defl_abs*chassisBase.RrAxle.left_tabular_spring.sgn;
  telem.sus_sigs[3].shock_velocity = chassisBase.RrAxle.left_tabular_damper.v_abs*chassisBase.RrAxle.left_tabular_damper.vel_sgn;
  telem.sus_sigs[3].stabar_torque = chassisBase.RrAxle.stabar.spring.tau;
  telem.sus_sigs[3].stabar_angle = chassisBase.RrAxle.stabar.spring.phi_rel;
  
  telem.sus_sigs[4].frame_height = chassisBase.RR_frame_coord.r_rel[3];
  telem.sus_sigs[4].shock_deflection = chassisBase.RrAxle.right_tabular_spring.defl_abs*chassisBase.RrAxle.right_tabular_spring.sgn;
  telem.sus_sigs[4].shock_velocity = chassisBase.RrAxle.right_tabular_damper.v_abs*chassisBase.RrAxle.right_tabular_damper.vel_sgn;
  telem.sus_sigs[4].stabar_torque = chassisBase.RrAxle.stabar.spring.tau;
  telem.sus_sigs[4].stabar_angle = chassisBase.RrAxle.stabar.spring.phi_rel;
  
  // Wheel sensing
  telem.wheel_sigs[1].Fx = chassisBase.FrAxle.left_tire.Fx;
  telem.wheel_sigs[1].Fy = chassisBase.FrAxle.left_tire.Fy;
  telem.wheel_sigs[1].Mx = chassisBase.FrAxle.left_tire.Mx;
  telem.wheel_sigs[1].My = chassisBase.FrAxle.left_tire.My;
  telem.wheel_sigs[1].Mz = chassisBase.FrAxle.left_tire.Mz;
  telem.wheel_sigs[1].Fz = chassisBase.FrAxle.left_tire.Fz;
  telem.wheel_sigs[1].alpha = chassisBase.FrAxle.left_tire.alpha;
  telem.wheel_sigs[1].kappa = chassisBase.FrAxle.left_tire.kappa;
  telem.wheel_sigs[1].gamma = chassisBase.FrAxle.left_tire.gamma;
  telem.wheel_sigs[1].omega = chassisBase.FrAxle.left_tire.tire2DOF.wheel_speed.w;
  left_delta_vec = Modelica.Mechanics.MultiBody.Frames.resolve2(chassisBase.R_IMF, Modelica.Mechanics.MultiBody.Frames.resolve1(chassisBase.FrAxle.left_cp.R, {1, 0, 0}));
  telem.wheel_sigs[1].delta = atan2(left_delta_vec[2], left_delta_vec[1]);
  telem.wheel_sigs[2].Fx = chassisBase.FrAxle.right_tire.Fx;
  telem.wheel_sigs[2].Fy = chassisBase.FrAxle.right_tire.Fy;
  telem.wheel_sigs[2].Mx = chassisBase.FrAxle.right_tire.Mx;
  telem.wheel_sigs[2].My = chassisBase.FrAxle.right_tire.My;
  telem.wheel_sigs[2].Mz = chassisBase.FrAxle.right_tire.Mz;
  telem.wheel_sigs[2].Fz = chassisBase.FrAxle.right_tire.Fz;
  telem.wheel_sigs[2].alpha = chassisBase.FrAxle.right_tire.alpha;
  telem.wheel_sigs[2].kappa = chassisBase.FrAxle.right_tire.kappa;
  telem.wheel_sigs[2].gamma = chassisBase.FrAxle.right_tire.gamma;
  telem.wheel_sigs[2].omega = chassisBase.FrAxle.right_tire.tire2DOF.wheel_speed.w;
  right_delta_vec = Modelica.Mechanics.MultiBody.Frames.resolve2(chassisBase.R_IMF, Modelica.Mechanics.MultiBody.Frames.resolve1(chassisBase.FrAxle.right_cp.R, {1, 0, 0}));
  telem.wheel_sigs[2].delta = atan2(right_delta_vec[2], right_delta_vec[1]);
  telem.wheel_sigs[3].Fx = chassisBase.RrAxle.left_tire.Fx;
  telem.wheel_sigs[3].Fy = chassisBase.RrAxle.left_tire.Fy;
  telem.wheel_sigs[3].Mx = chassisBase.RrAxle.left_tire.Mx;
  telem.wheel_sigs[3].My = chassisBase.RrAxle.left_tire.My;
  telem.wheel_sigs[3].Mz = chassisBase.RrAxle.left_tire.Mz;
  telem.wheel_sigs[3].Fz = chassisBase.RrAxle.left_tire.Fz;
  telem.wheel_sigs[3].alpha = chassisBase.RrAxle.left_tire.alpha;
  telem.wheel_sigs[3].kappa = chassisBase.RrAxle.left_tire.kappa;
  telem.wheel_sigs[3].gamma = chassisBase.RrAxle.left_tire.gamma;
  telem.wheel_sigs[3].omega = chassisBase.RrAxle.left_tire.tire2DOF.wheel_speed.w;
  RL_delta_vec = Modelica.Mechanics.MultiBody.Frames.resolve2(chassisBase.R_IMF, Modelica.Mechanics.MultiBody.Frames.resolve1(chassisBase.RrAxle.left_cp.R, {1, 0, 0}));
  telem.wheel_sigs[3].delta = atan2(RL_delta_vec[2], RL_delta_vec[1]);
  telem.wheel_sigs[4].Fx = chassisBase.RrAxle.right_tire.Fx;
  telem.wheel_sigs[4].Fy = chassisBase.RrAxle.right_tire.Fy;
  telem.wheel_sigs[4].Mx = chassisBase.RrAxle.right_tire.Mx;
  telem.wheel_sigs[4].My = chassisBase.RrAxle.right_tire.My;
  telem.wheel_sigs[4].Mz = chassisBase.RrAxle.right_tire.Mz;
  telem.wheel_sigs[4].Fz = chassisBase.RrAxle.right_tire.Fz;
  telem.wheel_sigs[4].alpha = chassisBase.RrAxle.right_tire.alpha;
  telem.wheel_sigs[4].kappa = chassisBase.RrAxle.right_tire.kappa;
  telem.wheel_sigs[4].gamma = chassisBase.RrAxle.right_tire.gamma;
  telem.wheel_sigs[4].omega = chassisBase.RrAxle.right_tire.tire2DOF.wheel_speed.w;
  RR_delta_vec = Modelica.Mechanics.MultiBody.Frames.resolve2(chassisBase.R_IMF, Modelica.Mechanics.MultiBody.Frames.resolve1(chassisBase.RrAxle.right_cp.R, {1, 0, 0}));
  telem.wheel_sigs[4].delta = atan2(RR_delta_vec[2], RR_delta_vec[1]);
//  long_LT = chassisBase.sprung_mass.m*a_body[1]*Body.r_0[3]/norm(left_tire.cp_frame.r_0 - RL_tire.cp_frame.r_0);
//  lat_LT = Body.m*body_accels[2]*Body.r_0[3]/norm(left_tire.cp_frame.r_0 - right_tire.cp_frame.r_0);
//  calc_RL = Body.m*Modelica.Constants.g_n/4 + long_LT/2 - lat_LT/2;
  if time < 7.5 then
    path_curv = 0;
  else
    path_curv = telem.kin_sigs.r/max(0.5, telem.kin_sigs.vx);
  end if;
  connect(world.frame_b, chassisBase.world_frame) annotation(
    Line(points = {{-80, -90}, {0, -90}, {0, -20}}, color = {95, 95, 95}));
  connect(speed_target_sig.y, PID.u_s) annotation(
    Line(points = {{-118, -30}, {-102, -30}}, color = {0, 0, 127}));
  connect(PID.y, Rr_torque.tau) annotation(
    Line(points = {{-78, -30}, {-62, -30}}, color = {0, 0, 127}));
  connect(Rr_torque.flange, chassisBase.RL_torque) annotation(
    Line(points = {{-40, -30}, {-20, -30}, {-20, -14}}));
  connect(Rr_torque.flange, chassisBase.RR_torque) annotation(
    Line(points = {{-40, -30}, {20, -30}, {20, -14}}));
  connect(ramp.y, chassisBase.rack_input) annotation(
    Line(points = {{-18, 50}, {0, 50}, {0, 24}}, color = {0, 0, 127}));
  connect(Fr_torque_in.y, torque.tau) annotation(
    Line(points = {{-78, 30}, {-72, 30}}, color = {0, 0, 127}));
  connect(torque.flange, chassisBase.FL_torque) annotation(
    Line(points = {{-50, 30}, {-20, 30}, {-20, 14}}));
  connect(torque.flange, chassisBase.FR_torque) annotation(
    Line(points = {{-50, 30}, {20, 30}, {20, 14}}));
  connect(speed_measure_sig.y, PID.u_m) annotation(
    Line(points = {{-98, -50}, {-90, -50}, {-90, -42}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-05, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --maxSizeLinearTearing=2000 -d=bltdump",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*", noEventEmit = "()"));
end ISO4138;
