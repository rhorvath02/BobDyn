within BobLib.Vehicle.Chassis.Suspension.Templates.Tire;

model MF5p2TireV2
  // Modelica units
  import Modelica.SIunits;

  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  
  // Custom linalg
  import BobLib.Utilities.Math.Vector.angle_between;
  import BobLib.Utilities.Math.Vector.cross;
  import BobLib.Utilities.Math.Vector.dot;
  
  // MF52 functions
  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.Records.Mz_record;
  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.Fx_eval;
  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.Fy_eval;
  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.Mx_eval;
  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.My_eval;
  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.Mz_eval;
  
  // Parameters - Tire defn
  parameter BobLib.Resources.Records.TIRES.Fr_tire tire "MF52 tire parameter record" annotation();
  
  // Parameters - Dimensions
  parameter SIunits.Length rim_width = tire.RIM_WIDTH "Rim width" annotation(
    Dialog(group = "Dimensions"));
  parameter SIunits.Length rim_R0 = tire.RIM_RADIUS "Rim unloaded static radius" annotation(
    Dialog(group = "Dimensions"));
  
  // Parameters - Mass properties
  parameter SIunits.Inertia wheel_J = tire.INERTIA "Wheel + hub inertia tensor (y-axis as spindle)";
  
  // General .tir parameters
  parameter Real R0 = tire.UNLOADED_RADIUS "Unloaded tire radius";
  parameter Real tire_c = tire.VERTICAL_STIFFNESS "Wheel vertical stiffness";
  parameter Real tire_d = tire.VERTICAL_DAMPING "Wheel vertical damping";
  parameter Real FNOMIN = tire.FNOMIN "Nominal normal load, FZ0";
  
  // Pure longitudinal slip coefficients
  parameter Real PCX1 = tire.PCX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PDX1 = tire.PDX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PDX2 = tire.PDX2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PDX3 = tire.PDX3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PEX1 = tire.PEX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PEX2 = tire.PEX2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PEX3 = tire.PEX3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PEX4 = tire.PEX4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PKX1 = tire.PKX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PKX2 = tire.PKX2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PKX3 = tire.PKX3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PHX1 = tire.PHX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PHX2 = tire.PHX2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PVX1 = tire.PVX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  parameter Real PVX2 = tire.PVX2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fx"));
  // Combined longitudinal slip coefficients
  parameter Real RBX1 = tire.RBX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fx"));
  parameter Real RBX2 = tire.RBX2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fx"));
  parameter Real RCX1 = tire.RCX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fx"));
  parameter Real REX1 = tire.REX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fx"));
  parameter Real REX2 = tire.REX2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fx"));
  parameter Real RHX1 = tire.RHX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fx"));
  // Pure lateral slip coefficients
  parameter Real PCY1 = tire.PCY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PDY1 = tire.PDY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PDY2 = tire.PDY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PDY3 = tire.PDY3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PEY1 = tire.PEY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PEY2 = tire.PEY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PEY3 = tire.PEY3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PEY4 = tire.PEY4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PKY1 = tire.PKY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PKY2 = tire.PKY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PKY3 = tire.PKY3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PHY1 = tire.PHY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PHY2 = tire.PHY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PHY3 = tire.PHY3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PVY1 = tire.PVY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PVY2 = tire.PVY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PVY3 = tire.PVY3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  parameter Real PVY4 = tire.PVY4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Fy"));
  // Combined lateral slip coefficients
  parameter Real RBY1 = tire.RBY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RBY2 = tire.RBY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RBY3 = tire.RBY3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RCY1 = tire.RCY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real REY1 = tire.REY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real REY2 = tire.REY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RHY1 = tire.RHY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RHY2 = tire.RHY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RVY1 = tire.RVY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RVY2 = tire.RVY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RVY3 = tire.RVY3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RVY4 = tire.RVY4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RVY5 = tire.RVY5 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  parameter Real RVY6 = tire.RVY6 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Fy"));
  // Overturning coefficients
  parameter Real QSX1 = tire.QSX1 annotation(
    Dialog(tab = "Tire Coeffs", group = "All Mx"));
  parameter Real QSX2 = tire.QSX2 annotation(
    Dialog(tab = "Tire Coeffs", group = "All Mx"));
  parameter Real QSX3 = tire.QSX3 annotation(
    Dialog(tab = "Tire Coeffs", group = "All Mx"));
  // Rolling resistance coefficients
  parameter Real QSY1 = tire.QSY1 annotation(
    Dialog(tab = "Tire Coeffs", group = "All My"));
  parameter Real QSY2 = tire.QSY2 annotation(
    Dialog(tab = "Tire Coeffs", group = "All My"));
  parameter Real QSY3 = tire.QSY3 annotation(
    Dialog(tab = "Tire Coeffs", group = "All My"));
  parameter Real QSY4 = tire.QSY4 annotation(
    Dialog(tab = "Tire Coeffs", group = "All My"));
  // Pure aligning coefficients
  parameter Real QBZ1 = tire.QBZ1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QBZ2 = tire.QBZ2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QBZ3 = tire.QBZ3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QBZ4 = tire.QBZ4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QBZ5 = tire.QBZ5 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QBZ9 = tire.QBZ9 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QBZ10 = tire.QBZ10 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QCZ1 = tire.QCZ1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QDZ1 = tire.QDZ1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QDZ2 = tire.QDZ2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QDZ3 = tire.QDZ3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QDZ4 = tire.QDZ4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QDZ6 = tire.QDZ6 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QDZ7 = tire.QDZ7 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QDZ8 = tire.QDZ8 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QDZ9 = tire.QDZ9 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QEZ1 = tire.QEZ1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QEZ2 = tire.QEZ2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QEZ3 = tire.QEZ3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QEZ4 = tire.QEZ4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QEZ5 = tire.QEZ5 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QHZ1 = tire.QHZ1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QHZ2 = tire.QHZ2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QHZ3 = tire.QHZ3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  parameter Real QHZ4 = tire.QHZ4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Pure Mz"));
  // Combined aligning coefficients
  parameter Real SSZ1 = tire.SSZ1 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Mz"));
  parameter Real SSZ2 = tire.SSZ2 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Mz"));
  parameter Real SSZ3 = tire.SSZ3 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Mz"));
  parameter Real SSZ4 = tire.SSZ4 annotation(
    Dialog(tab = "Tire Coeffs", group = "Combined Mz"));
  // Scaling coefficients
  parameter Real LFZO = tire.LFZO annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LCX = tire.LCX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LMUX = tire.LMUX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LEX = tire.LEX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LKX = tire.LKX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LHX = tire.LHX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LVX = tire.LVX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LXAL = tire.LXAL annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LGAX = tire.LGAX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LCY = tire.LCY annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LMUY = tire.LMUY annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LEY = tire.LEY annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LKY = tire.LKY annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LHY = tire.LHY annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LVY = tire.LVY annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LGAY = tire.LGAY annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LKYG = tire.LKYG annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LTR = tire.LTR annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LRES = tire.LRES annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LCZ = tire.LCZ annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LGAZ = tire.LGAZ annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LYKA = tire.LYKA annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LVYKA = tire.LVYKA annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LS = tire.LS annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LSGKP = tire.LSGKP annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LSGAL = tire.LSGAL annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LGYR = tire.LGYR annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LMX = tire.LMX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LVMX = tire.LVMX annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LMY = tire.LMY annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  parameter Real LIP = tire.LIP annotation(
    Dialog(tab = "Tire Coeffs", group = "Scaling"));
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a cp_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b chassis_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  // 2DOF Tire physics
  TirePhysics.Tire2DOF tire2DOF(R0 = R0, rim_width = rim_width, rim_R0 = rim_R0, tire_c = tire_c, tire_d = tire_d, wheel_J = wheel_J) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  // Torque input
  // Loads / forces
  Real Fx "Longitudinal force in global frame";
  Real Fy "Lateral force in global frame";
  Real Fz "Normal load in global frame";
  Real Mx "Overturning moment in global frame";
  Real My "Rolling resistance in global frame";
  Real Mz "Aligning moment in global frame";
  // General States
  Real alpha;
  Real kappa;
  Real gamma;
  // Relaxation lengths
//  Real sigma_kappa;
//  Real sigma_alpha;
  Modelica.Mechanics.Rotational.Interfaces.Flange_b hub_input annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
protected
  // Numerical stability
  parameter Real v_min = 0.1 "Low-speed threshold for force gating (m/s)" annotation(
    Dialog(group = "Numerical Conditions"));
  parameter Real eps = 1e-6 "Small constant to prevent division by zero" annotation(
    Dialog(group = "Numerical Conditions"));
  // Diagnostics
  Real P_contact;
  // Off-axis torque input
  // MF52 load application
  Modelica.Mechanics.MultiBody.Forces.WorldForce force(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world, animation = true) annotation(
    Placement(transformation(origin = {-30, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Forces.WorldTorque torque(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world) annotation(
    Placement(transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}})));
  // World / ground unit vectors
  Real[3] e_z = {0, 0, 1};
  Real[3] ez_w;
  Real[3] e_xw;
  Real[3] e_xg;
  Real[3] e_yg;
  Real[3] M_world;
  Real[3] e_spin;
  // Velocity vectors
  Real[3] v_cp;
  Real[3] v_g;
  // Velocity components
  Real Vx;
  Real Vy;
  // Protected loads
  Real[3] F_world;
  // Long and lat slip velocities
  Real Vsx;
//  Real Vsy;
  // Transient slip states
//  Real u(start = 0, fixed = true) "Longitudinal slip state";
//  Real v(start = 0, fixed = true) "Lateral slip state";
  parameter Real Vx_relax_max = 8.0;
  Real speed_gate;
//  Real relax_rate;
algorithm
  Fx := MF52.Fx_eval(Fz, alpha, kappa, gamma, PCX1, PDX1, PDX2, PDX3, PEX1, PEX2, PEX3, PEX4, PKX1, PKX2, PKX3, PHX1, PHX2, PVX1, PVX2, RBX1, RBX2, RCX1, REX1, REX2, RHX1, LFZO, LCX, LMUX, LEX, LKX, LHX, LVX, LXAL, LGAX, LCY, LMUY, LEY, LKY, LHY, LVY, LGAY, LKYG, LTR, LRES, LCZ, LGAZ, LYKA, LVYKA, LS, LSGKP, LSGAL, LGYR, LMX, LVMX, LMY, LIP, FNOMIN, R0);
  Fy := MF52.Fy_eval(Fz, alpha, kappa, gamma, PCY1, PDY1, PDY2, PDY3, PEY1, PEY2, PEY3, PEY4, PKY1, PKY2, PKY3, PHY1, PHY2, PHY3, PVY1, PVY2, PVY3, PVY4, RBY1, RBY2, RBY3, RCY1, REY1, REY2, RHY1, RHY2, RVY1, RVY2, RVY3, RVY4, RVY5, RVY6, LFZO, LCX, LMUX, LEX, LKX, LHX, LVX, LXAL, LGAX, LCY, LMUY, LEY, LKY, LHY, LVY, LGAY, LKYG, LTR, LRES, LCZ, LGAZ, LYKA, LVYKA, LS, LSGKP, LSGAL, LGYR, LMX, LVMX, LMY, LIP, FNOMIN, R0);
  Mx := MF52.Mx_eval(Fz, Fy, alpha, kappa, gamma, QSX1, QSX2, QSX3, LFZO, LCX, LMUX, LEX, LKX, LHX, LVX, LXAL, LGAX, LCY, LMUY, LEY, LKY, LHY, LVY, LGAY, LKYG, LTR, LRES, LCZ, LGAZ, LYKA, LVYKA, LS, LSGKP, LSGAL, LGYR, LMX, LVMX, LMY, LIP, FNOMIN, R0);
  My := MF52.My_eval(Fz, alpha, kappa, gamma, QSY1, QSY2, QSY3, QSY4, PKX1, PKX2, PKX3, PHX1, PHX2, PVX1, PVX2, LFZO, LCX, LMUX, LEX, LKX, LHX, LVX, LXAL, LGAX, LCY, LMUY, LEY, LKY, LHY, LVY, LGAY, LKYG, LTR, LRES, LCZ, LGAZ, LYKA, LVYKA, LS, LSGKP, LSGAL, LGYR, LMX, LVMX, LMY, LIP, FNOMIN, R0);
  Mz := MF52.Mz_eval(Fz, Fx, Fy, alpha, kappa, gamma, QBZ1, QBZ2, QBZ3, QBZ4, QBZ5, QBZ9, QBZ10, QCZ1, QDZ1, QDZ2, QDZ3, QDZ4, QDZ6, QDZ7, QDZ8, QDZ9, QEZ1, QEZ2, QEZ3, QEZ4, QEZ5, QHZ1, QHZ2, QHZ3, QHZ4, SSZ1, SSZ2, SSZ3, SSZ4, PCY1, PDY1, PDY2, PDY3, PKY1, PKY2, PKY3, PHY1, PHY2, PHY3, PVY1, PVY2, PVY3, PVY4, RVY1, RVY2, RVY3, RVY4, RVY5, RVY6, PKX1, PKX2, PKX3, LFZO, LCX, LMUX, LEX, LKX, LHX, LVX, LXAL, LGAX, LCY, LMUY, LEY, LKY, LHY, LVY, LGAY, LKYG, LTR, LRES, LCZ, LGAZ, LYKA, LVYKA, LS, LSGKP, LSGAL, LGYR, LMX, LVMX, LMY, LIP, FNOMIN, R0);
equation
// Normal load
  Fz = max(0, cp_frame.f[3]);
// World basis
  e_xw = Modelica.Mechanics.MultiBody.Frames.resolve1(cp_frame.R, {1, 0, 0});
  e_xg = normalize({e_xw[1], e_xw[2], 0});
  e_yg = normalize(cross(e_z, e_xg));
// Inclination angle
  ez_w = tire2DOF.hub_axis.frame_b.R.T[:, 3];
  gamma = Modelica.Math.asin(max(-1.0, min(1.0, ez_w[2])));
// Contact velocity
  v_cp = tire2DOF.wheel_vel.v;
  v_g = {v_cp[1], v_cp[2], 0};
  Vx = dot(v_g, e_xg);
  Vy = dot(v_g, e_yg);
//// Lateral slip
//  Vsy = -Vy;
//  relax_rate = min(sqrt(Vx*Vx + v_min*v_min), Vx_relax_max);
//  der(v) = (Vsy - relax_rate*v)/sigma_alpha;
//  alpha = atan(v/max(abs(Vx), eps));
//// Kinematic slip definition below
//// alpha = atan2(-Vy, abs(Vx));
//  sigma_kappa = max(0.03, 1.2e-4*Fz);
//  sigma_alpha = max(0.03, 0.7e-4*Fz);
//// Longitudinal slip
//  Vsx = Vx - R0*tire2DOF.hub_axis.w;
//  der(u) = (-Vsx - relax_rate*u)/sigma_kappa;
//  kappa = u/max(abs(Vx), eps);

  speed_gate = abs(Vx)/(abs(Vx) + v_min);

  // Lateral slip (kinematic)
  alpha = speed_gate * atan2(-Vy, max(abs(Vx), eps));
  
  // Longitudinal slip (kinematic)
  Vsx = Vx - R0*tire2DOF.hub_axis.w;
  kappa = speed_gate * (-Vsx / max(abs(Vx), eps));

// Low-speed gating
// w_speed = abs(Vx) / (abs(Vx) + v_min);
// Apply force
  F_world = Fx*e_xg + Fy*e_yg;
  force.force = F_world;
// Apply moment
  e_spin = Modelica.Mechanics.MultiBody.Frames.resolve1(tire2DOF.hub_axis.frame_b.R, {0, 1, 0});
  M_world = Mx*e_xg + My*e_spin + Mz*e_z;
  torque.torque = M_world;
// Diagnostics
  P_contact = dot(F_world, v_g);
  connect(cp_frame, tire2DOF.cp_frame) annotation(
    Line(points = {{0, -100}, {0, -10}}));
  connect(force.frame_b, cp_frame) annotation(
    Line(points = {{-20, -70}, {0, -70}, {0, -100}}, color = {95, 95, 95}));
  connect(chassis_frame, tire2DOF.chassis_frame) annotation(
    Line(points = {{-100, 0}, {-10, 0}}));
  connect(torque.frame_b, cp_frame) annotation(
    Line(points = {{-20, -40}, {0, -40}, {0, -100}}, color = {95, 95, 95}));
  connect(hub_input, tire2DOF.hub_frame) annotation(
    Line(points = {{0, 100}, {0, 10}}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-120, -160}, {120, -120}}, textString = "%name", fontSize = 14, horizontalAlignment = TextAlignment.Center), Text(extent = {{-200, -60}, {-100, -20}}, textString = "Frame", fontSize = 12, textColor = {0, 0, 0}, horizontalAlignment = TextAlignment.Center), Text(extent = {{-100, 110}, {0, 140}}, textString = "T_in", fontSize = 12, textColor = {0, 0, 255}, horizontalAlignment = TextAlignment.Center), Text(extent = {{30, -120}, {70, -80}}, textString = "CP", fontSize = 12, textColor = {0, 0, 0}, horizontalAlignment = TextAlignment.Center), // Outer tire
    Ellipse(extent = {{-90, -90}, {90, 90}}, fillPattern = FillPattern.Solid, fillColor = {40, 40, 40}, lineThickness = 3), // Inner rim
    Ellipse(extent = {{-45, -45}, {45, 45}}, fillPattern = FillPattern.Solid, fillColor = {200, 200, 200}, lineThickness = 2), // Hub
    Ellipse(extent = {{-15, -15}, {15, 15}}, fillPattern = FillPattern.Solid, fillColor = {160, 160, 160}, lineThickness = 2), // Spokes (default black)
    Line(points = {{0, 0}, {0, 45}}, thickness = 2), Line(points = {{0, 0}, {0, -45}}, thickness = 2), Line(points = {{0, 0}, {45, 0}}, thickness = 2), Line(points = {{0, 0}, {-45, 0}}, thickness = 2), Line(points = {{0, 0}, {32, 32}}, thickness = 2), Line(points = {{0, 0}, {-32, -32}}, thickness = 2), Line(points = {{0, 0}, {32, -32}}, thickness = 2), Line(points = {{0, 0}, {-32, 32}}, thickness = 2)}),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end MF5p2TireV2;
