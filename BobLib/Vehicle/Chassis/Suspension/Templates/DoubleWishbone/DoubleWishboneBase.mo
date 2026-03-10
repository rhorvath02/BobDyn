within BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone;

partial model DoubleWishboneBase
  // Modelica units
  import Modelica.SIunits;

// Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  // Body template for mass properties
  import BobLib.Resources.Records.TEMPLATES.BodyTemplate;
  // Parameters
  parameter SIunits.Position upper_fore_i[3] "Upper control arm fore inboard joint, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Position upper_aft_i[3] "Upper control arm aft inboard joint, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Position lower_fore_i[3] "Lower control arm fore inboard joint, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Position lower_aft_i[3] "Lower control arm aft inboard joint, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Position upper_o[3] "Upper control arm outboard joint, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Position lower_o[3] "Lower control arm outboard joint, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Position tie_i[3] "Tie rod inboard joint, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Position tie_o[3] "Tie rod outboard joint, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Position wheel_center[3] "Center point of the tightest convex volume enclosing wheel, expressed in chassis frame" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Angle static_gamma "Static inclination angle, in deg, mirrored and consistent with SAE J670 Z-up coordinates (left side)" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  parameter SIunits.Angle static_alpha "Static toe angle, in deg, mirrored and consistent with SAE J670 Z-up coordinates (left side)" annotation(
    Evaluate=false, Dialog(group = "Geometry"));
  
  parameter BodyTemplate unsprung_mass "Unsprung mass" annotation(
    Evaluate=false, Dialog(tab = "Mass Properties", group = "Wheel Properties"));
  parameter BodyTemplate uca_mass "Upper control arm mass" annotation(
    Evaluate=false, Dialog(tab = "Mass Properties", group = "UCA Properties"));
  parameter BodyTemplate lca_mass "Lower control arm mass" annotation(
    Evaluate=false, Dialog(tab = "Mass Properties", group = "LCA Properties"));
  parameter BodyTemplate tie_mass "Tie rod mass" annotation(
    Evaluate=false, Dialog(tab = "Mass Properties", group = "Tie Properties"));
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  parameter SIunits.Length joint_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
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
  final Modelica.Mechanics.MultiBody.Joints.Revolute upper_inboard_joint(animation = false,
                                                                         n = normalize(upper_fore_i - upper_aft_i),
                                                                         phi(start = 0, fixed = true),
                                                                         w(start = 0, fixed = true),
                                                                         stateSelect = StateSelect.always) annotation(
    Placement(transformation(origin = {60, 60}, extent = {{10, -10}, {-10, 10}})));
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation upper_rigid_link(animation = false,
                                                                             shapeType = "cylinder",
                                                                             r = upper_o - (upper_fore_i + upper_aft_i)/2,
                                                                             extra = 0.0) annotation(
    Placement(transformation(origin = {30, 60}, extent = {{10, -10}, {-10, 10}})));
  // Lower wisbone
  final Modelica.Mechanics.MultiBody.Joints.Revolute lower_inboard_joint(animation = false,
                                                                         n = normalize(lower_fore_i - lower_aft_i),
                                                                         phi(start = 0, fixed = true),
                                                                         w(start = 0, fixed = true), stateSelect = StateSelect.always) annotation(
    Placement(transformation(origin = {60, -60}, extent = {{10, -10}, {-10, 10}})));
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation lower_rigid_link(animation = false,
                                                                             r = lower_o - (lower_fore_i + lower_aft_i)/2,
                                                                             shapeType = "cylinder",
                                                                             extra = 0.0) annotation(
    Placement(transformation(origin = {30, -60}, extent = {{10, -10}, {-10, 10}})));
  // Upright
  final BobLib.Vehicle.Chassis.Suspension.Linkages.Upright upright(lower = lower_o,
                                                                   upper = upper_o,
                                                                   tie = tie_o) annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  // Tie rod
  final Modelica.Mechanics.MultiBody.Joints.SphericalSpherical sphericalSpherical(rodLength = norm(tie_o - tie_i),
                                                                                  kinematicConstraint = true,
                                                                                  m = tie_mass.m,
                                                                                  sphereDiameter = joint_diameter,
                                                                                  rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {40, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  // Wheel mass + inertia
  final Modelica.Mechanics.MultiBody.Parts.Body wheel_body(animation = true,
                                                           r_CM = unsprung_mass.r_cm - wheel_center,
                                                           m = unsprung_mass.m,
                                                           I_11 = unsprung_mass.I[1, 1],
                                                           I_22 = unsprung_mass.I[2, 2],
                                                           I_33 = unsprung_mass.I[3, 3],
                                                           I_21 = unsprung_mass.I[2, 1],
                                                           I_31 = unsprung_mass.I[3, 1],
                                                           I_32 = unsprung_mass.I[3, 2],
                                                           useQuaternions = false,
                                                           sphereDiameter = joint_diameter,
                                                           cylinderDiameter = link_diameter,
                                                           angles_start = {0, 0, 0},
                                                           w_0_start = {0, 0, 0},
                                                           z_0_start = {0, 0, 0}) annotation(
    Placement(transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  // UCA mass + inertia
  final Modelica.Mechanics.MultiBody.Parts.Body UCA_body(animation = true,
                                                         r_CM = uca_mass.r_cm - upper_o,
                                                         m = uca_mass.m,
                                                         I_11 = uca_mass.I[1, 1],
                                                         I_22 = uca_mass.I[2, 2],
                                                         I_33 = uca_mass.I[3, 3],
                                                         I_21 = uca_mass.I[2, 1],
                                                         I_31 = uca_mass.I[3, 1],
                                                         I_32 = uca_mass.I[3, 2],
                                                         useQuaternions = false,
                                                         sphereDiameter = joint_diameter,
                                                         cylinderDiameter = link_diameter,
                                                         angles_start = {0, 0, 0},
                                                         w_0_start = {0, 0, 0},
                                                         z_0_start = {0, 0, 0}) annotation(
    Placement(transformation(origin = {-10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  // LCA mass + inertia
  final Modelica.Mechanics.MultiBody.Parts.Body LCA_body(r_CM = lca_mass.r_cm - lower_o,
                                                         m = lca_mass.m,
                                                         I_11 = lca_mass.I[1, 1],
                                                         I_22 = lca_mass.I[2, 2],
                                                         I_33 = lca_mass.I[3, 3],
                                                         I_21 = lca_mass.I[2, 1],
                                                         I_31 = lca_mass.I[3, 1],
                                                         I_32 = lca_mass.I[3, 2],
                                                         useQuaternions = false,
                                                         sphereDiameter = joint_diameter,
                                                         cylinderDiameter = link_diameter,
                                                         angles_start = {0, 0, 0},
                                                         w_0_start = {0, 0, 0},
                                                         z_0_start = {0, 0, 0}) annotation(
          Placement(transformation(origin = {-10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

// Spherical joints
  BobLib.Vehicle.Chassis.Suspension.Joints.xyzSphericalCompliant upper_spherical(trans_x_stiffness = 1e8,
                                               trans_y_stiffness = 1e8,
                                               trans_z_stiffness = 1e8,
                                               trans_x_damping = 1e4,
                                               trans_y_damping = 1e4,
                                               trans_z_damping = 1e4,
                                               diameter = joint_diameter,
                                               r_rel(start = {0, 0, 0}, each fixed = true))  annotation(
    Placement(transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  BobLib.Vehicle.Chassis.Suspension.Joints.xyzSphericalCompliant lower_spherical(trans_x_stiffness = 1e8,
                                               trans_y_stiffness = 1e8,
                                               trans_z_stiffness = 1e8,
                                               trans_x_damping = 1e4,
                                               trans_y_damping = 1e4,
                                               trans_z_damping = 1e4,
                                               diameter = joint_diameter,
                                               r_rel(start = {0, 0, 0}, each fixed = true))  annotation(
    Placement(transformation(origin = {10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));

// Steering interface
  Modelica.Blocks.Interfaces.RealInput steer_input annotation(
    Placement(transformation(origin = {120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {-66, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sources.Position position(useSupport = true) annotation(
    Placement(transformation(origin = {74, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic_rack(n = {0, 1, 0}, useAxisFlange = true, animation = false) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  
protected
  // Connect midpoint of kingpin to center of the wheel
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r = wheel_center - (upper_o + lower_o)/2, animation = false) annotation(
    Placement(transformation(origin = {-10, 0}, extent = {{10, -10}, {-10, 10}})));
  // ==================================================
  // === I dare you to find a better way to do this ===
  // ==================================================
  // Set gamma
  Modelica.Blocks.Sources.RealExpression static_gamma_source(y = static_gamma * Modelica.Constants.pi / 180) annotation(
    Placement(transformation(origin = {-40, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Sources.Position x_angle(exact = true)  annotation(
    Placement(transformation(origin = {-40, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute_x(animation = false,
                                                          n = {1, 0, 0},
                                                          phi(start = static_gamma * Modelica.Constants.pi / 180),
                                                          useAxisFlange = true) annotation(
    Placement(transformation(origin = {-40, 0}, extent = {{10, -10}, {-10, 10}})));
  // Set toe (using alpha sign convention)
  Modelica.Blocks.Sources.RealExpression static_alpha_source(y = static_alpha * Modelica.Constants.pi / 180) annotation(
    Placement(transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Rotational.Sources.Position z_angle(exact = true)  annotation(
    Placement(transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute_z(animation = false,
                                                          n = {0, 0, 1},
                                                          phi(start = static_alpha * Modelica.Constants.pi / 180),
                                                          useAxisFlange = true) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{10, -10}, {-10, 10}})));
  // Rod visualizers
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape upper_fore_shape(shapeType = "cylinder",
                                                                           r = upper_i_frame.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(upper_i_frame.R, (upper_fore_i - upper_aft_i)/2),
                                                                           lengthDirection = Modelica.Mechanics.MultiBody.Frames.resolve1(upper_wishbone_frame.R, upper_o - upper_fore_i),
                                                                           length = norm(upper_o - upper_fore_i),
                                                                           width = link_diameter,
                                                                           color = Modelica.Mechanics.MultiBody.Types.Defaults.RodColor) annotation(
    Placement(transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape upper_aft_shape(shapeType = "cylinder",
                                                                          r = upper_i_frame.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(upper_i_frame.R, (upper_aft_i - upper_fore_i)/2),
                                                                          lengthDirection = Modelica.Mechanics.MultiBody.Frames.resolve1(upper_wishbone_frame.R, upper_o - upper_aft_i),
                                                                          length = norm(upper_o - upper_aft_i),
                                                                          width = link_diameter,
                                                                          color = Modelica.Mechanics.MultiBody.Types.Defaults.RodColor) annotation(
    Placement(transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lower_fore_shape(shapeType = "cylinder",
                                                                           r = lower_i_frame.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(lower_i_frame.R, (lower_fore_i - lower_aft_i)/2),
                                                                           lengthDirection = Modelica.Mechanics.MultiBody.Frames.resolve1(lower_wishbone_frame.R, lower_o - lower_fore_i),
                                                                           length = norm(lower_o - lower_fore_i),
                                                                           width = link_diameter,
                                                                           color = Modelica.Mechanics.MultiBody.Types.Defaults.RodColor) annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lower_aft_shape(shapeType = "cylinder",
                                                                          r = lower_i_frame.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(lower_i_frame.R, (lower_aft_i - lower_fore_i)/2),
                                                                          lengthDirection = Modelica.Mechanics.MultiBody.Frames.resolve1(lower_wishbone_frame.R, lower_o - lower_aft_i),
                                                                          length = norm(lower_o - lower_aft_i),
                                                                          width = link_diameter,
                                                                          color = Modelica.Mechanics.MultiBody.Types.Defaults.RodColor) annotation(
    Placement(transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}})));
  // Joint visualizers
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape upper_fore_i_shape(shapeType = "sphere",
                                                                             r = upper_i_frame.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(upper_i_frame.R, (upper_fore_i - upper_aft_i)/2),
                                                                             r_shape = joint_diameter/2*normalize(upper_aft_i - upper_fore_i),
                                                                             length = joint_diameter,
                                                                             color = Modelica.Mechanics.MultiBody.Types.Defaults.JointColor) annotation(
    Placement(transformation(origin = {50, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape upper_aft_i_shape(shapeType = "sphere",
                                                                            r = upper_i_frame.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(upper_i_frame.R, (upper_aft_i - upper_fore_i)/2),
                                                                            r_shape = joint_diameter/2*normalize(upper_aft_i - upper_fore_i),
                                                                            length = joint_diameter,
                                                                            color = Modelica.Mechanics.MultiBody.Types.Defaults.JointColor) annotation(
    Placement(transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lower_fore_i_shape(shapeType = "sphere",
                                                                             r = lower_i_frame.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(lower_i_frame.R, (lower_fore_i - lower_aft_i)/2),
                                                                             r_shape = joint_diameter/2*normalize(lower_aft_i - lower_fore_i),
                                                                             length = joint_diameter,
                                                                             color = Modelica.Mechanics.MultiBody.Types.Defaults.JointColor) annotation(
    Placement(transformation(origin = {50, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lower_aft_i_shape(shapeType = "sphere",
                                                                            r = lower_i_frame.r_0 + Modelica.Mechanics.MultiBody.Frames.resolve1(lower_i_frame.R, (lower_aft_i - lower_fore_i)/2),
                                                                            r_shape = joint_diameter/2*normalize(lower_aft_i - lower_fore_i),
                                                                            length = joint_diameter,
                                                                            color = Modelica.Mechanics.MultiBody.Types.Defaults.JointColor) annotation(
    Placement(transformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(tie_i_frame, prismatic_rack.frame_a) annotation(
    Line(points = {{100, 0}, {80, 0}}));
  connect(upright.mass_frame, fixedTranslation.frame_a) annotation(
    Line(points = {{10, 0}, {0, 0}}, color = {95, 95, 95}));
  connect(upper_i_frame, upper_inboard_joint.frame_a) annotation(
    Line(points = {{100, 60}, {70, 60}}));
  connect(upper_inboard_joint.frame_b, upper_rigid_link.frame_a) annotation(
    Line(points = {{50, 60}, {40, 60}}, color = {95, 95, 95}));
  connect(upper_wishbone_frame, upper_rigid_link.frame_b) annotation(
    Line(points = {{10, 100}, {10, 60}, {20, 60}}));
  connect(lower_i_frame, lower_inboard_joint.frame_a) annotation(
    Line(points = {{100, -60}, {70, -60}}));
  connect(lower_inboard_joint.frame_b, lower_rigid_link.frame_a) annotation(
    Line(points = {{50, -60}, {40, -60}}, color = {95, 95, 95}));
  connect(lower_wishbone_frame, lower_rigid_link.frame_b) annotation(
    Line(points = {{10, -100}, {10, -60}, {20, -60}}));
  connect(static_gamma_source.y, x_angle.phi_ref) annotation(
    Line(points = {{-40, 49}, {-40, 41}}, color = {0, 0, 127}));
  connect(x_angle.flange, revolute_x.axis) annotation(
    Line(points = {{-40, 20}, {-40, 10}}));
  connect(revolute_x.frame_b, revolute_z.frame_a) annotation(
    Line(points = {{-50, 0}, {-60, 0}}, color = {95, 95, 95}));
  connect(static_alpha_source.y, z_angle.phi_ref) annotation(
    Line(points = {{-70, 50}, {-70, 42}}, color = {0, 0, 127}));
  connect(z_angle.flange, revolute_z.axis) annotation(
    Line(points = {{-70, 20}, {-70, 10}}));
  connect(fixedTranslation.frame_b, revolute_x.frame_a) annotation(
    Line(points = {{-20, 0}, {-30, 0}}, color = {95, 95, 95}));
  connect(revolute_z.frame_b, midpoint_frame) annotation(
    Line(points = {{-80, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(wheel_body.frame_a, fixedTranslation.frame_b) annotation(
    Line(points = {{-20, -20}, {-20, 0}}, color = {95, 95, 95}));
  connect(prismatic_rack.support, position.support) annotation(
    Line(points = {{74, -6}, {74, -20}}, color = {0, 127, 0}));
  connect(position.flange, prismatic_rack.axis) annotation(
    Line(points = {{64, -30}, {62, -30}, {62, -6}}, color = {0, 127, 0}));
  connect(upper_rigid_link.frame_b, UCA_body.frame_a) annotation(
    Line(points = {{20, 60}, {0, 60}}, color = {95, 95, 95}));
  connect(lower_rigid_link.frame_b, LCA_body.frame_a) annotation(
    Line(points = {{20, -60}, {0, -60}}, color = {95, 95, 95}));
  connect(steer_input, position.s_ref) annotation(
    Line(points = {{120, -30}, {86, -30}}, color = {0, 0, 127}));
  connect(upper_rigid_link.frame_b, upper_spherical.frame_a) annotation(
    Line(points = {{20, 60}, {10, 60}, {10, 40}}, color = {95, 95, 95}));
  connect(upper_spherical.frame_b, upright.upper_frame) annotation(
    Line(points = {{10, 20}, {10, 10}}, color = {95, 95, 95}));
  connect(lower_spherical.frame_a, lower_rigid_link.frame_b) annotation(
    Line(points = {{10, -40}, {10, -60}, {20, -60}}, color = {95, 95, 95}));
  connect(upright.lower_frame, lower_spherical.frame_b) annotation(
    Line(points = {{10, -10}, {10, -20}}, color = {95, 95, 95}));
end DoubleWishboneBase;
