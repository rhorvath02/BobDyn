within BobDyn.Vehicle.Chassis.Suspension.Templates;

partial model AxleDoubleWishboneBase
  // Modelica units
  import Modelica.SIunits;
  // Custom body template
  import BobDyn.Resources.Records.TEMPLATES.BodyTemplate;

// Parameters
  parameter SIunits.Position left_upper_fore_i[3] annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_upper_aft_i[3] annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_lower_fore_i[3] annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_lower_aft_i[3] annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_upper_o[3] annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_lower_o[3] annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_tie_i[3] annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_tie_o[3] annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position left_wheel_center[3] annotation(
    Dialog(group = "Geometry"));
  
  parameter SIunits.Angle left_static_gamma annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Angle left_static_alpha annotation(
    Dialog(group = "Geometry"));
  
  parameter SIunits.Position right_upper_fore_i[3] = {left_upper_fore_i[1], -left_upper_fore_i[2], left_upper_fore_i[3]} annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position right_upper_aft_i[3] = {left_upper_aft_i[1], -left_upper_aft_i[2], left_upper_aft_i[3]} annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position right_lower_fore_i[3] = {left_lower_fore_i[1], -left_lower_fore_i[2], left_lower_fore_i[3]} annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position right_lower_aft_i[3] = {left_lower_aft_i[1], -left_lower_aft_i[2], left_lower_aft_i[3]} annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position right_upper_o[3] = {left_upper_o[1], -left_upper_o[2], left_upper_o[3]} annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position right_lower_o[3] = {left_lower_o[1], -left_lower_o[2], left_lower_o[3]} annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position right_tie_i[3] = {left_tie_i[1], -left_tie_i[2], left_tie_i[3]} annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position right_tie_o[3] = {left_tie_o[1], -left_tie_o[2], left_tie_o[3]} annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position right_wheel_center[3] = {left_wheel_center[1], -left_wheel_center[2], left_wheel_center[3]} annotation(
    Dialog(group = "Geometry"));
  
  parameter SIunits.Angle right_static_gamma = -1 * left_static_gamma annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Angle right_static_alpha = -1 * left_static_alpha annotation(
    Dialog(group = "Geometry"));
  // ======================
  // Mass Properties (Left)
  // ======================
  parameter BodyTemplate left_unsprung_mass "Left unsprung mass" annotation(
    Dialog(tab = "Mass Properties", group = "Wheel Properties"));
  parameter BodyTemplate left_uca_mass "Left upper control arm mass" annotation(
    Dialog(tab = "Mass Properties", group = "UCA Properties"));
  parameter BodyTemplate left_lca_mass "Left lower control arm mass" annotation(
  Dialog(tab = "Mass Properties", group = "LCA Properties"));
  parameter BodyTemplate left_tie_mass "Left tie rod mass" annotation(
    Dialog(tab = "Mass Properties", group = "Tie Properties"));
    // ============================================
  // Mass Properties (Right – mirrored from left)
  // ============================================
  parameter BodyTemplate right_unsprung_mass = BodyTemplate(m = left_unsprung_mass.m,
                                                            r_cm = {
                                                              left_unsprung_mass.r_cm[1],
                                                             -left_unsprung_mass.r_cm[2],
                                                              left_unsprung_mass.r_cm[3]
                                                            },
                                                            I = {
                                                              {  left_unsprung_mass.I[1,1], -left_unsprung_mass.I[1,2],  left_unsprung_mass.I[1,3] },
                                                              { -left_unsprung_mass.I[2,1],  left_unsprung_mass.I[2,2], -left_unsprung_mass.I[2,3] },
                                                              {  left_unsprung_mass.I[3,1], -left_unsprung_mass.I[3,2],  left_unsprung_mass.I[3,3] }
                                                            }) "Right unsprung mass" annotation(
      Dialog(tab = "Mass Properties", group = "Wheel Properties"));
  
  parameter BodyTemplate right_uca_mass = BodyTemplate(m = left_uca_mass.m,
                                                       r_cm = {
                                                         left_uca_mass.r_cm[1],
                                                        -left_uca_mass.r_cm[2],
                                                         left_uca_mass.r_cm[3]
                                                       },
                                                       I = {
                                                           {  left_uca_mass.I[1,1], -left_uca_mass.I[1,2],  left_uca_mass.I[1,3] },
                                                           { -left_uca_mass.I[2,1],  left_uca_mass.I[2,2], -left_uca_mass.I[2,3] },
                                                           {  left_uca_mass.I[3,1], -left_uca_mass.I[3,2],  left_uca_mass.I[3,3] }
                                                       }) "Right upper control arm mass" annotation(
      Dialog(tab = "Mass Properties", group = "UCA Properties"));
  
  parameter BodyTemplate right_lca_mass = BodyTemplate(m = left_lca_mass.m,
                                                       r_cm = {
                                                         left_lca_mass.r_cm[1],
                                                        -left_lca_mass.r_cm[2],
                                                         left_lca_mass.r_cm[3]
                                                       },
                                                       I = {
                                                           {  left_lca_mass.I[1,1], -left_lca_mass.I[1,2],  left_lca_mass.I[1,3] },
                                                           { -left_lca_mass.I[2,1],  left_lca_mass.I[2,2], -left_lca_mass.I[2,3] },
                                                           {  left_lca_mass.I[3,1], -left_lca_mass.I[3,2],  left_lca_mass.I[3,3] }
                                                       }) "Right lower control arm mass" annotation(
      Dialog(tab = "Mass Properties", group = "LCA Properties"));
  
  parameter BodyTemplate right_tie_mass = BodyTemplate(m = left_tie_mass.m,
                                                       r_cm = {
                                                         left_tie_mass.r_cm[1],
                                                        -left_tie_mass.r_cm[2],
                                                         left_tie_mass.r_cm[3]
                                                       },
                                                       I = {
                                                           {  left_tie_mass.I[1,1], -left_tie_mass.I[1,2],  left_tie_mass.I[1,3] },
                                                           { -left_tie_mass.I[2,1],  left_tie_mass.I[2,2], -left_tie_mass.I[2,3] },
                                                           {  left_tie_mass.I[3,1], -left_tie_mass.I[3,2],  left_tie_mass.I[3,3] }
                                                       }) "Right tie rod mass" annotation(
      Dialog(tab = "Mass Properties", group = "Tie Properties"));
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  parameter SIunits.Length joint_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  // Effective center for internal calculations
  final parameter Real[3] effective_center = {left_wheel_center[1], 0, left_wheel_center[3]};
  // Interface frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a axle_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b left_cp annotation(
    Placement(transformation(origin = {-120, -100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b right_cp annotation(
    Placement(transformation(origin = {120, -100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  // Double wishbone assemblies
  final BobDyn.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.LeftDoubleWishbone left_double_wishbone(upper_fore_i = left_upper_fore_i,
                                                                                                                upper_aft_i = left_upper_aft_i,
                                                                                                                lower_fore_i = left_lower_fore_i,
                                                                                                                lower_aft_i = left_lower_aft_i,
                                                                                                                upper_o = left_upper_o,
                                                                                                                lower_o = left_lower_o,
                                                                                                                tie_i = left_tie_i,
                                                                                                                tie_o = left_tie_o,
                                                                                                                wheel_center = left_wheel_center,
                                                                                                                static_gamma = left_static_gamma,
                                                                                                                static_alpha = left_static_alpha,
                                                                                                                link_diameter = link_diameter,
                                                                                                                joint_diameter = joint_diameter,
                                                                                                                unsprung_mass = left_unsprung_mass,
                                                                                                                uca_mass = left_uca_mass,
                                                                                                                lca_mass = left_lca_mass,
                                                                                                                tie_mass = left_tie_mass) annotation(
    Placement(transformation(origin = {-70, -50}, extent = {{-30, -30}, {30, 30}})));
  
  final BobDyn.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.RightDoubleWishbone right_double_wishbone(upper_fore_i = right_upper_fore_i,
                                                                                                                  upper_aft_i = right_upper_aft_i,
                                                                                                                  lower_fore_i = right_lower_fore_i,
                                                                                                                  lower_aft_i = right_lower_aft_i,
                                                                                                                  upper_o = right_upper_o,
                                                                                                                  lower_o = right_lower_o,
                                                                                                                  tie_i = right_tie_i,
                                                                                                                  tie_o = right_tie_o,
                                                                                                                  wheel_center = right_wheel_center,
                                                                                                                  static_gamma = right_static_gamma,
                                                                                                                  static_alpha = right_static_alpha,
                                                                                                                  link_diameter = link_diameter,
                                                                                                                  joint_diameter = joint_diameter,
                                                                                                                  unsprung_mass = right_unsprung_mass,
                                                                                                                  uca_mass = right_uca_mass,
                                                                                                                  lca_mass = right_lca_mass,
                                                                                                                  tie_mass = right_tie_mass) annotation(
          Placement(transformation(origin = {70, -50}, extent = {{30, -30}, {-30, 30}})));
  // Tires
  BobDyn.Vehicle.Chassis.Tires.MF5p2Tire left_tire annotation(
    Placement(transformation(origin = {-130, -50}, extent = {{10, -10}, {-10, 10}})));
  BobDyn.Vehicle.Chassis.Tires.MF5p2Tire right_tire annotation(
    Placement(transformation(origin = {130, -50}, extent = {{-10, -10}, {10, 10}})));

  // Wheel torque inputs
  Modelica.Mechanics.Rotational.Interfaces.Flange_b left_torque annotation(
    Placement(transformation(origin = {-140, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b right_torque annotation(
    Placement(transformation(origin = {140, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 66}, extent = {{-10, -10}, {10, 10}})));

protected
  // Fixed geometry from effective center to nodes
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_upper_i_trans(r = (left_upper_fore_i + left_upper_aft_i) / 2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_lower_i_trans(r = (left_lower_fore_i + left_lower_aft_i) / 2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_tie_i_trans(r = left_tie_i - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -50}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_upper_i_trans(r = (right_upper_fore_i + right_upper_aft_i) / 2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_lower_i_trans(r = (right_lower_fore_i + right_lower_aft_i) / 2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_tie_i_trans(r = right_tie_i - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -50}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(left_cp, left_tire.cp_frame) annotation(
    Line(points = {{-120, -100}, {-120, -80}, {-130, -80}, {-130, -60}, {-130, -60}}));
  connect(right_cp, right_tire.cp_frame) annotation(
    Line(points = {{120, -100}, {120, -80}, {130, -80}, {130, -60}, {130, -60}}));
  connect(axle_frame, left_lower_i_trans.frame_a) annotation(
    Line(points = {{0, -100}, {0, -70}, {-10, -70}}));
  connect(axle_frame, right_lower_i_trans.frame_a) annotation(
    Line(points = {{0, -100}, {0, -70}, {10, -70}}));
  connect(axle_frame, left_tie_i_trans.frame_a) annotation(
    Line(points = {{0, -100}, {0, -50}, {-10, -50}}));
  connect(axle_frame, right_tie_i_trans.frame_a) annotation(
    Line(points = {{0, -100}, {0, -50}, {10, -50}}));
  connect(axle_frame, left_upper_i_trans.frame_a) annotation(
    Line(points = {{0, -100}, {0, -30}, {-10, -30}}));
  connect(axle_frame, right_upper_i_trans.frame_a) annotation(
    Line(points = {{0, -100}, {0, -30}, {10, -30}}));
  connect(left_lower_i_trans.frame_b, left_double_wishbone.lower_i_frame) annotation(
    Line(points = {{-30, -70}, {-40, -70}}, color = {95, 95, 95}));
  connect(left_tie_i_trans.frame_b, left_double_wishbone.tie_i_frame) annotation(
    Line(points = {{-30, -50}, {-40, -50}}, color = {95, 95, 95}));
  connect(left_upper_i_trans.frame_b, left_double_wishbone.upper_i_frame) annotation(
    Line(points = {{-30, -30}, {-40, -30}}, color = {95, 95, 95}));
  connect(right_upper_i_trans.frame_b, right_double_wishbone.upper_i_frame) annotation(
    Line(points = {{30, -30}, {40, -30}}, color = {95, 95, 95}));
  connect(right_tie_i_trans.frame_b, right_double_wishbone.tie_i_frame) annotation(
    Line(points = {{30, -50}, {40, -50}}, color = {95, 95, 95}));
  connect(right_lower_i_trans.frame_b, right_double_wishbone.lower_i_frame) annotation(
    Line(points = {{30, -70}, {40, -70}}, color = {95, 95, 95}));
  connect(left_double_wishbone.midpoint_frame, left_tire.chassis_frame) annotation(
    Line(points = {{-100, -50}, {-120, -50}}, color = {95, 95, 95}));
  connect(right_tire.chassis_frame, right_double_wishbone.midpoint_frame) annotation(
    Line(points = {{120, -50}, {100, -50}}, color = {95, 95, 95}));
  connect(left_torque, left_tire.hub_input) annotation(
    Line(points = {{-140, 20}, {-140, -50}}));
  connect(right_torque, right_tire.hub_input) annotation(
    Line(points = {{140, 20}, {140, -50}}));
  annotation(
    Diagram(coordinateSystem(extent = {{-140, 100}, {140, -100}})));
end AxleDoubleWishboneBase;
