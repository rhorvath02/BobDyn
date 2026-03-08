within BobDyn.Vehicle.Chassis.Suspension.Templates.DoubleWishboneMSL;

partial model DoubleWishboneMSLBase
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  // Body template for mass properties
  import BobDyn.Resources.Records.TEMPLATES.BodyTemplate;
  // Parameters
  parameter SIunits.Position upper_fore_i[3] "Upper control arm fore inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position upper_aft_i[3] "Upper control arm aft inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position lower_fore_i[3] "Lower control arm fore inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position lower_aft_i[3] "Lower control arm aft inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position upper_o[3] "Upper control arm outboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position lower_o[3] "Lower control arm outboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position tie_i[3] "Tie rod inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position tie_o[3] "Tie rod outboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Position wheel_center[3] "Center point of the tightest convex volume enclosing wheel, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Angle static_gamma "Static inclination angle, in deg, mirrored and consistent with SAE J670 Z-up coordinates (left side)" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter SIunits.Angle static_alpha "Static toe angle, in deg, mirrored and consistent with SAE J670 Z-up coordinates (left side)" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter BodyTemplate unsprung_mass "Unsprung mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "Wheel Properties"));
  parameter BodyTemplate uca_mass "Upper control arm mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "UCA Properties"));
  parameter BodyTemplate lca_mass "Lower control arm mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "LCA Properties"));
  parameter BodyTemplate tie_mass "Tie rod mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "Tie Properties"));
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  parameter SIunits.Length joint_diameter annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a upper_i_frame annotation(
    Placement(transformation(origin = {100, 60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 66}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a lower_i_frame annotation(
    Placement(transformation(origin = {100, -60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, -66}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a tie_i_frame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b upper_wishbone_frame annotation(
    Placement(transformation(origin = {10, 100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b lower_wishbone_frame annotation(
    Placement(transformation(origin = {10, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b midpoint_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{16, -16}, {-16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  // Upper wishbone
  // Lower wisbone
  final Modelica.Mechanics.MultiBody.Joints.Revolute lower_inboard_joint(animation = true, n = normalize(lower_fore_i - lower_aft_i), phi(displayUnit = "rad")) annotation(
    Placement(transformation(origin = {60, -60}, extent = {{10, -10}, {-10, 10}})));
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation lower_rigid_link(animation = true, r = lower_o - (lower_fore_i + lower_aft_i)/2, shapeType = "cylinder", extra = 0.0) annotation(
    Placement(transformation(origin = {30, -60}, extent = {{10, -10}, {-10, 10}})));
  // Upright
  // Tie rod
  // Wheel mass + inertia
  final Modelica.Mechanics.MultiBody.Parts.Body wheel_body(animation = true, r_CM = unsprung_mass.r_cm - wheel_center, m = unsprung_mass.m, I_11 = unsprung_mass.I[1, 1], I_22 = unsprung_mass.I[2, 2], I_33 = unsprung_mass.I[3, 3], I_21 = unsprung_mass.I[2, 1], I_31 = unsprung_mass.I[3, 1], I_32 = unsprung_mass.I[3, 2], useQuaternions = false, sphereDiameter = joint_diameter, cylinderDiameter = link_diameter, angles_start = {0, 0, 0}, w_0_start = {0, 0, 0}, z_0_start = {0, 0, 0}) annotation(
    Placement(transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  // UCA mass + inertia
  final Modelica.Mechanics.MultiBody.Parts.Body UCA_body(animation = true, r_CM = uca_mass.r_cm - upper_o, m = uca_mass.m, I_11 = uca_mass.I[1, 1], I_22 = uca_mass.I[2, 2], I_33 = uca_mass.I[3, 3], I_21 = uca_mass.I[2, 1], I_31 = uca_mass.I[3, 1], I_32 = uca_mass.I[3, 2], useQuaternions = false, sphereDiameter = joint_diameter, cylinderDiameter = link_diameter, angles_start = {0, 0, 0}, w_0_start = {0, 0, 0}, z_0_start = {0, 0, 0}) annotation(
    Placement(transformation(origin = {-30, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  // LCA mass + inertia
  final Modelica.Mechanics.MultiBody.Parts.Body LCA_body(r_CM = lca_mass.r_cm - lower_o, m = lca_mass.m, I_11 = lca_mass.I[1, 1], I_22 = lca_mass.I[2, 2], I_33 = lca_mass.I[3, 3], I_21 = lca_mass.I[2, 1], I_31 = lca_mass.I[3, 1], I_32 = lca_mass.I[3, 2], useQuaternions = false, sphereDiameter = joint_diameter, cylinderDiameter = link_diameter, angles_start = {0, 0, 0}, w_0_start = {0, 0, 0}, z_0_start = {0, 0, 0}) annotation(
    Placement(transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  // Spherical joints
  // Steering interface
  Modelica.Blocks.Interfaces.RealInput steer_input annotation(
    Placement(transformation(origin = {120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {-66, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sources.Position position(useSupport = true) annotation(
    Placement(transformation(origin = {74, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic_rack(n = {0, 1, 0}, useAxisFlange = true, animation = false) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(r = wheel_center -tie_o, rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence, angles = {0, 0, 0})  annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSR jointSSR(rod1Length = norm(upper_o - lower_o), n_b = normalize(upper_fore_i - upper_aft_i), rRod2_ib = upper_o - (upper_fore_i + upper_aft_i)/2, sphereDiameter = joint_diameter, rod1Diameter = link_diameter, rod2Diameter = link_diameter, revoluteDiameter = joint_diameter, revoluteLength = joint_diameter)  annotation(
    Placement(transformation(origin = {60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical universalSpherical(n1_a = {0, 0, 1}, rRod_ia = tie_o - tie_i)  annotation(
    Placement(transformation(origin = {20, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical spherical annotation(
    Placement(transformation(origin = {0, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r = tie_o - lower_o)  annotation(
    Placement(transformation(origin = {0, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
protected
  // Connect midpoint of kingpin to center of the wheel
  // ==================================================
  // === I dare you to find a better way to do this ===
  // ==================================================
  // Set gamma
  // Set toe (using alpha sign convention)
  // Rod visualizers
  // Joint visualizers
equation
  connect(prismatic_rack.support, position.support) annotation(
    Line(points = {{74, -6}, {74, -20}}, color = {0, 127, 0}));
  connect(position.flange, prismatic_rack.axis) annotation(
    Line(points = {{64, -30}, {62, -30}, {62, -6}}, color = {0, 127, 0}));
  connect(steer_input, position.s_ref) annotation(
    Line(points = {{120, -30}, {86, -30}}, color = {0, 0, 127}));
  connect(upper_i_frame, jointSSR.frame_b) annotation(
    Line(points = {{100, 60}, {80, 60}}));
  connect(jointSSR.frame_im, upper_wishbone_frame) annotation(
    Line(points = {{60, 80}, {10, 80}, {10, 100}}, color = {95, 95, 95}));
  connect(UCA_body.frame_a, upper_wishbone_frame) annotation(
    Line(points = {{-20, 80}, {10, 80}, {10, 100}}, color = {95, 95, 95}));
  connect(lower_i_frame, lower_inboard_joint.frame_a) annotation(
    Line(points = {{100, -60}, {70, -60}}));
  connect(lower_inboard_joint.frame_b, lower_rigid_link.frame_a) annotation(
    Line(points = {{50, -60}, {40, -60}}, color = {95, 95, 95}));
  connect(lower_rigid_link.frame_b, spherical.frame_a) annotation(
    Line(points = {{20, -60}, {0, -60}, {0, -54}}, color = {95, 95, 95}));
  connect(spherical.frame_b, fixedTranslation.frame_a) annotation(
    Line(points = {{0, -34}, {0, -26}}, color = {95, 95, 95}));
  connect(fixedTranslation.frame_b, universalSpherical.frame_b) annotation(
    Line(points = {{0, -6}, {0, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(fixedRotation.frame_a, universalSpherical.frame_b) annotation(
    Line(points = {{-20, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(fixedRotation.frame_b, midpoint_frame) annotation(
    Line(points = {{-40, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(fixedRotation.frame_b, wheel_body.frame_a) annotation(
    Line(points = {{-40, 0}, {-70, 0}, {-70, -20}}, color = {95, 95, 95}));
  connect(LCA_body.frame_a, lower_rigid_link.frame_b) annotation(
    Line(points = {{-40, -60}, {20, -60}}, color = {95, 95, 95}));
  connect(lower_rigid_link.frame_b, lower_wishbone_frame) annotation(
    Line(points = {{20, -60}, {10, -60}, {10, -100}}, color = {95, 95, 95}));
  connect(jointSSR.frame_a, lower_rigid_link.frame_b) annotation(
    Line(points = {{40, 60}, {20, 60}, {20, -60}}, color = {95, 95, 95}));
  connect(universalSpherical.frame_a, prismatic_rack.frame_b) annotation(
    Line(points = {{30, 0}, {60, 0}}, color = {95, 95, 95}));
  connect(tie_i_frame, prismatic_rack.frame_a) annotation(
    Line(points = {{100, 0}, {80, 0}}));
end DoubleWishboneMSLBase;
