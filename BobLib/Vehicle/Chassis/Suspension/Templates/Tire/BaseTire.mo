within BobLib.Vehicle.Chassis.Suspension.Templates.Tire;

model BaseTire
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  // Custom linalg
  import BobLib.Utilities.Math.Vector.cross;
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a cp_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b chassis_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  
  Modelica.Mechanics.Rotational.Interfaces.Flange_b hub_flange annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
  
  // Base states
  SIunits.Force Fz;
  SIunits.Angle gamma;

  // Slip states (from SlipModel)
  SIunits.Angle alpha;
  Real kappa;
  
  replaceable BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel0DOF wheelModel annotation(
    Placement(transformation(extent = {{-30, -30}, {30, 30}})));
  replaceable BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel annotation(
    Placement(transformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}})));
  
  // Force expressions
  Modelica.Blocks.Sources.RealExpression realExpressionFx(y = 0)  annotation(
    Placement(transformation(origin = {-90, -56}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression realExpressionFy(y = 0)  annotation(
    Placement(transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant constantZero(k = 0)  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  
  // Torque expressions
  Modelica.Blocks.Sources.RealExpression realExpressionMx(y = 0)  annotation(
    Placement(transformation(origin = {-90, 54}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression realExpressionMy(y = 0)  annotation(
    Placement(transformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression realExpressionMz(y = 0)  annotation(
    Placement(transformation(origin = {-90, 26}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Forces.WorldForceAndTorque forceAndTorque(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b, animation = true)  annotation(
    Placement(transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}})));
  
protected
  Real[3] e_xw "Unit vector along wheel x-axis, resolved in world frame";
  Real[3] e_yw "Unit vector along wheel y-axis, resolved in world frame";
  Real[3] e_spin "Unit vector along wheel spin axis, resolved in world frame";
  Real[3] e_zw "Unit vector along wheel z-axis, resolved in world frame";
  
  Real[3] e_xg "e_xw projected on the xy-plane (ground) and normalized";
  Real[3] e_yg "e_yw projected on the xy-plane (ground) and normalized";

  // Velocity quantities (for slip calculation)
  Real[3] v_cp "Contact patch velocity in world frame";
  Real[3] v_g "Velocity projected onto ground plane";

  SIunits.Velocity Vx "Longitudinal velocity at contact patch";
  SIunits.Velocity Vy "Lateral velocity at contact patch";

equation
  // Normal load
  Fz = max(0, cp_frame.f[3]);
  
  // World basis (from cp_frame)
  e_xw = Modelica.Mechanics.MultiBody.Frames.resolve1(cp_frame.R, {1, 0, 0});
  e_yw = Modelica.Mechanics.MultiBody.Frames.resolve1(cp_frame.R, {0, 1, 0});

  e_spin = Modelica.Mechanics.MultiBody.Frames.resolve1(wheelModel.hub_axis.frame_b.R, {0, 1, 0});
  e_zw   = wheelModel.hub_axis.frame_b.R.T[:, 3];
  
  // Ground-projected tire basis (CRITICAL FIX)
  e_xg = normalize({e_xw[1], e_xw[2], 0});
  e_yg = normalize({e_yw[1], e_yw[2], 0});
  
  // Inclination angle
  gamma = Modelica.Math.asin(max(-1.0, min(1.0, e_zw[2])));

  // Contact patch velocity
  v_cp = wheelModel.wheel_vel_sensor.v;
  v_g  = {v_cp[1], v_cp[2], 0};

  Vx = v_g[1]*e_xg[1] + v_g[2]*e_xg[2];
  Vy = v_g[1]*e_yg[1] + v_g[2]*e_yg[2];

  // Slip model
  slipModel.Vx    = Vx;
  slipModel.Vy    = Vy;
  slipModel.omega = wheelModel.wheel_rot_speed_sensor.w;
  slipModel.R0    = wheelModel.radius_sensor.s_rel;

  alpha = slipModel.alpha;
  kappa = slipModel.kappa;
  
  connect(chassis_frame, wheelModel.chassis_frame) annotation(
    Line(points = {{-100, 0}, {-30, 0}}));
  connect(wheelModel.cp_frame, cp_frame) annotation(
    Line(points = {{0, -30}, {0, -100}}, color = {95, 95, 95}));
  connect(realExpressionFx.y, forceAndTorque.force[1]) annotation(
    Line(points = {{-78, -56}, {-42, -56}}, color = {0, 0, 127}));
  connect(realExpressionFy.y, forceAndTorque.force[2]) annotation(
    Line(points = {{-78, -70}, {-60, -70}, {-60, -56}, {-42, -56}}, color = {0, 0, 127}));
  connect(constantZero.y, forceAndTorque.force[3]) annotation(
    Line(points = {{-78, -90}, {-50, -90}, {-50, -56}, {-42, -56}}, color = {0, 0, 127}));
  connect(realExpressionMx.y, forceAndTorque.torque[1]) annotation(
    Line(points = {{-78, 54}, {-50, 54}, {-50, -44}, {-42, -44}}, color = {0, 0, 127}));
  connect(realExpressionMy.y, forceAndTorque.torque[2]) annotation(
    Line(points = {{-78, 40}, {-60, 40}, {-60, -44}, {-42, -44}}, color = {0, 0, 127}));
  connect(realExpressionMz.y, forceAndTorque.torque[3]) annotation(
    Line(points = {{-78, 26}, {-70, 26}, {-70, -44}, {-42, -44}}, color = {0, 0, 127}));
  connect(forceAndTorque.frame_b, wheelModel.cp_frame) annotation(
    Line(points = {{-20, -50}, {0, -50}, {0, -30}}, color = {95, 95, 95}));
  connect(wheelModel.hub_flange, hub_flange) annotation(
    Line(points = {{0, 0}, {100, 0}}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Line(origin = {50, 0}, points = {{-10, 0}, {50, 0}}, pattern = LinePattern.Dash, thickness = 1), Line(origin = {-50, 0}, points = {{-50, 0}, {10, 0}}), Rectangle(fillColor = {71, 71, 71}, fillPattern = FillPattern.Solid, extent = {{-40, 80}, {40, -80}}, radius = 5), Line(origin = {0, -90}, points = {{0, -10}, {0, 10}})}),
    Diagram(graphics));
end BaseTire;
