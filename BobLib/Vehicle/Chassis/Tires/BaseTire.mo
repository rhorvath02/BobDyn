within BobLib.Vehicle.Chassis.Tires;

model BaseTire
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  // Custom linalg
  import BobLib.Utilities.Math.Vector.angle_between;
  import BobLib.Utilities.Math.Vector.cross;
  import BobLib.Utilities.Math.Vector.dot;
  // Parameters - Tire defn
  final parameter BobLib.Resources.Records.TIRES.Fr_tire tire "MF52 tire parameter record" annotation();
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
  Real Fz "Normal load in global frame";
  // General States
  Real gamma;
  Modelica.Mechanics.MultiBody.Parts.Mounting1D rotation_lock(n = {0, 1, 0})  annotation(
    Placement(transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}})));

  // Common interface
  Real Fx = 0;
  Real Fy = 0;
  Real Mx = 0;
  Real My = 0;
  Real Mz = 0;
  
  Real alpha = 0;
  Real kappa = 0;
  

protected
  // World / ground unit vectors
  Real[3] e_z = {0, 0, 1};
  Real[3] ez_w;
  Real[3] e_xw;
  Real[3] e_xg;
  Real[3] e_yg;
  Real[3] e_spin;
public
  Modelica.Mechanics.Rotational.Interfaces.Flange_b hub_input annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, -12}, extent = {{-10, -10}, {10, 10}})));
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
  e_spin = Modelica.Mechanics.MultiBody.Frames.resolve1(tire2DOF.hub_axis.frame_b.R, {0, 1, 0});
  connect(cp_frame, tire2DOF.cp_frame) annotation(
    Line(points = {{0, -100}, {0, -10}}));
  connect(chassis_frame, tire2DOF.chassis_frame) annotation(
    Line(points = {{-100, 0}, {-10, 0}}));
  connect(rotation_lock.frame_a, tire2DOF.chassis_frame) annotation(
    Line(points = {{-30, 10}, {-30, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(rotation_lock.flange_b, tire2DOF.hub_frame) annotation(
    Line(points = {{-20, 20}, {0, 20}, {0, 10}}));
  connect(hub_input, tire2DOF.hub_frame) annotation(
    Line(points = {{0, 100}, {0, 10}}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-120, -160}, {120, -120}}, textString = "%name", fontSize = 14, horizontalAlignment = TextAlignment.Center), Text(extent = {{-200, -60}, {-100, -20}}, textString = "Frame", fontSize = 12, textColor = {0, 0, 0}, horizontalAlignment = TextAlignment.Center), Text(extent = {{-100, 110}, {0, 140}}, textString = "T_in", fontSize = 12, textColor = {0, 0, 255}, horizontalAlignment = TextAlignment.Center), Text(extent = {{30, -120}, {70, -80}}, textString = "CP", fontSize = 12, textColor = {0, 0, 0}, horizontalAlignment = TextAlignment.Center), // Outer tire
    Ellipse(extent = {{-90, -90}, {90, 90}}, fillPattern = FillPattern.Solid, fillColor = {40, 40, 40}, lineThickness = 3), // Inner rim
    Ellipse(extent = {{-45, -45}, {45, 45}}, fillPattern = FillPattern.Solid, fillColor = {200, 200, 200}, lineThickness = 2), // Hub
    Ellipse(extent = {{-15, -15}, {15, 15}}, fillPattern = FillPattern.Solid, fillColor = {160, 160, 160}, lineThickness = 2), // Spokes (default black)
    Line(points = {{0, 0}, {0, 45}}, thickness = 2), Line(points = {{0, 0}, {0, -45}}, thickness = 2), Line(points = {{0, 0}, {45, 0}}, thickness = 2), Line(points = {{0, 0}, {-45, 0}}, thickness = 2), Line(points = {{0, 0}, {32, 32}}, thickness = 2), Line(points = {{0, 0}, {-32, -32}}, thickness = 2), Line(points = {{0, 0}, {32, -32}}, thickness = 2), Line(points = {{0, 0}, {-32, 32}}, thickness = 2), Text(extent = {{-100, -66}, {100, 66}}, textString = "BASE", fontSize = 225, lineColor = {255, 0, 0}, horizontalAlignment = TextAlignment.Center)}));
end BaseTire;
