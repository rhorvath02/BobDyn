within BobLib.Vehicle.Chassis.Suspension.Joints;

model xyzSphericalCompliant
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  import Modelica.SIunits;
  // Kinematic elements
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  // User parameters
  parameter Boolean animation = true "Show sphere in animation";
  parameter SIunits.TranslationalSpringConstant trans_x_stiffness = 1e8 "Translational x-stiffness";
  parameter SIunits.TranslationalSpringConstant trans_y_stiffness = 1e8 "Translational y-stiffness";
  parameter SIunits.TranslationalSpringConstant trans_z_stiffness = 1e8 "Translational z-stiffness";
  
  parameter SIunits.TranslationalDampingConstant trans_x_damping = 1e4 "Translational x-damping";
  parameter SIunits.TranslationalDampingConstant trans_y_damping = 1e4 "Translational y-damping";
  parameter SIunits.TranslationalDampingConstant trans_z_damping = 1e4 "Translational z-damping";
  
  parameter SIunits.Length diameter = 0.825*0.0254 "Diameter of bearing";

  // Internal force and torque
  Modelica.Blocks.Sources.RealExpression force_expression[3](y = -force_internal) annotation(
    Placement(transformation(origin = {-16, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.RealExpression torque_expression[3](y = -torque_internal) annotation(
    Placement(transformation(origin = {24, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Forces.Internal.BasicForce basic_force(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)  annotation(
    Placement(transformation(origin = {-10, -20}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Forces.Internal.BasicTorque basic_torque(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));

// Visualization
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape_a(final shapeType = "sphere", length = diameter, width = diameter, height = diameter, animation = animation, r_shape = {-diameter/2, 0, 0}, color = Modelica.Mechanics.MultiBody.Types.Defaults.JointColor) annotation(
    Placement(transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape_b(animation = animation, height = diameter, length = diameter, r_shape = {-diameter/2, 0, 0}, final shapeType = "sphere", width = diameter, color = Modelica.Mechanics.MultiBody.Types.Defaults.JointColor) annotation(
    Placement(transformation(origin = {70, 20}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));

// Force and torque variables
  Real force_internal[3];
  Real torque_internal[3];
  
  SIunits.Position r_rel[3](start = {0, 0, 0}) "Spring elongation vector (state)";
  SIunits.Position v_rel[3](start = {0, 0, 0}) "Derivative of spring elongation vector";
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zero_position annotation(
    Placement(transformation(origin = {50, -70}, extent = {{-10, -10}, {10, 10}})));
equation
  r_rel = frame_b.r_0 - frame_a.r_0;
  der(r_rel) = v_rel;
  force_internal = {trans_x_stiffness*r_rel[1] + trans_x_damping*v_rel[1], trans_y_stiffness*r_rel[2] + trans_y_damping*v_rel[2], trans_z_stiffness*r_rel[3] + trans_z_damping*v_rel[3]};
// No torque applied in spherical joint
  torque_internal = {0, 0, 0};
  connect(shape_a.frame_a, frame_a) annotation(
    Line(points = {{-80, 20}, {-80, 19.5}, {-100, 19.5}, {-100, 0}}, color = {95, 95, 95}));
  connect(shape_b.frame_a, frame_b) annotation(
    Line(points = {{80, 20}, {100, 20}, {100, 0}}, color = {95, 95, 95}));
  connect(frame_a, basic_force.frame_a) annotation(
    Line(points = {{-100, 0}, {-60, 0}, {-60, -20}, {-20, -20}}));
  connect(basic_force.frame_b, frame_b) annotation(
    Line(points = {{0, -20}, {60, -20}, {60, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(frame_a, basic_torque.frame_a) annotation(
    Line(points = {{-100, 0}, {20, 0}}));
  connect(basic_torque.frame_b, frame_b) annotation(
    Line(points = {{40, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(force_expression.y, basic_force.force) annotation(
    Line(points = {{-16, -38}, {-16, -32}}, color = {0, 0, 127}, thickness = 0.5));
  connect(torque_expression.y, basic_torque.torque) annotation(
    Line(points = {{24, -38}, {24, -12}}, color = {0, 0, 127}, thickness = 0.5));
  connect(zero_position.frame_resolve, basic_torque.frame_resolve) annotation(
    Line(points = {{40, -70}, {34, -70}, {34, -10}}, color = {95, 95, 95}));
  connect(zero_position.frame_resolve, basic_force.frame_resolve) annotation(
    Line(points = {{40, -70}, {-6, -70}, {-6, -30}}, color = {95, 95, 95}));
  annotation(
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-60,-60},{60,60}},
          fillPattern=FillPattern.Solid,
          fillColor={192,192,192},
          lineColor={0,0,0},
          closure=EllipseClosure.Radial,
          startAngle=60,
          endAngle=300),
        Ellipse(
          extent={{-44,-44},{44,44}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          closure=EllipseClosure.Radial,
          startAngle=55,
          endAngle=305),
        Ellipse(
          extent={{-44,-44},{44,44}},
          startAngle=60,
          endAngle=300,
          lineColor={0,0,0},
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-26,26},{26,-26}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192},
          lineColor={0,0,0}),
        Line(
          points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},
              {100,0}},
          color={255, 0, 0}),
        Text(
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor={0,0,255})}));
end xyzSphericalCompliant;
