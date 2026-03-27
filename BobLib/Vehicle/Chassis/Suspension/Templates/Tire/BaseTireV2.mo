within BobLib.Vehicle.Chassis.Suspension.Templates.Tire;

model BaseTireV2
  // Modelica units
  import Modelica.SIunits;
  
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  
  // Custom linalg
  import BobLib.Utilities.Math.Vector.cross;
  
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
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  
  Modelica.Mechanics.Rotational.Interfaces.Flange_b hub_input annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
  
  
  
  // Loads / forces
  Real Fz "Normal load in global frame";
  // General States
  Real gamma;
  
protected
  // World / ground unit vectors
  Real[3] e_z = {0, 0, 1};
  Real[3] ez_w;
  Real[3] e_xw;
  Real[3] e_xg;
  Real[3] e_yg;
  Real[3] e_spin;
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
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Line(origin = {50, 0}, points = {{-10, 0}, {50, 0}}, pattern = LinePattern.Dash, thickness = 1), Line(origin = {-50, 0}, points = {{-50, 0}, {10, 0}}), Rectangle(fillColor = {71, 71, 71}, fillPattern = FillPattern.Solid, extent = {{-40, 80}, {40, -80}}, radius = 5), Line(origin = {0, -90}, points = {{0, -10}, {0, 10}})}),
    Diagram(graphics));
end BaseTireV2;
