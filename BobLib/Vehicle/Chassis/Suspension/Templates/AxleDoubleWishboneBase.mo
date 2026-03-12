within BobLib.Vehicle.Chassis.Suspension.Templates;

partial model AxleDoubleWishboneBase
  // Modelica units
  import Modelica.SIunits;
  
  // Custom body template
  import BobLib.Resources.Records.TEMPLATES.BodyTemplate;

  // Geometry Parameters
  parameter BobLib.Resources.Records.TEMPLATES.AxleDWTemplate Axle annotation(
    Evaluate=false);
  
  // ======================
  // Mass Properties (Left)
  // ======================
  parameter BodyTemplate left_unsprung_mass "Left unsprung mass" annotation(
    Evaluate=false, Dialog(tab = "Mass Properties", group = "Wheel Properties"));
  parameter BodyTemplate left_uca_mass "Left upper control arm mass" annotation(
    Evaluate=false, Dialog(tab = "Mass Properties", group = "UCA Properties"));
  parameter BodyTemplate left_lca_mass "Left lower control arm mass" annotation(
    Evaluate=false, Dialog(tab = "Mass Properties", group = "LCA Properties"));
  parameter BodyTemplate left_tie_mass "Left tie rod mass" annotation(
    Evaluate=false, Dialog(tab = "Mass Properties", group = "Tie Properties"));
  
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
      Evaluate=false, Dialog(tab = "Mass Properties", group = "Wheel Properties"));
  
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
      Evaluate=false, Dialog(tab = "Mass Properties", group = "UCA Properties"));
  
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
      Evaluate=false, Dialog(tab = "Mass Properties", group = "LCA Properties"));
  
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
      Evaluate=false, Dialog(tab = "Mass Properties", group = "Tie Properties"));
  
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  parameter SIunits.Length joint_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  
  // Effective center for internal calculations
  final parameter SIunits.Position[3] effective_center = {Axle.wheel_center[1], 0, Axle.wheel_center[3]};
  
  // Interface frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a axle_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b left_cp annotation(
    Placement(transformation(origin = {-120, -100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {-100, -80}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b right_cp annotation(
    Placement(transformation(origin = {120, -100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  
  // Double wishbone assemblies
  BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishboneV2.LeftDoubleWishboneV2 left_double_wishbone(upper_fore_i = Axle.upper_fore_i,
                                                                                                     upper_aft_i = Axle.upper_aft_i,
                                                                                                     lower_fore_i = Axle.lower_fore_i,
                                                                                                     lower_aft_i = Axle.lower_aft_i,
                                                                                                     upper_o = Axle.upper_outboard,
                                                                                                     lower_o = Axle.lower_outboard,
                                                                                                     tie_i = Axle.tie_inboard,
                                                                                                     tie_o = Axle.tie_outboard,
                                                                                                     wheel_center = Axle.wheel_center,
                                                                                                     static_gamma = Axle.static_gamma,
                                                                                                     static_alpha = Axle.static_alpha,
                                                                                                     link_diameter = link_diameter,
                                                                                                     joint_diameter = joint_diameter,
                                                                                                     unsprung_mass = left_unsprung_mass,
                                                                                                     uca_mass = left_uca_mass,
                                                                                                     lca_mass = left_lca_mass,
                                                                                                     tie_mass = left_tie_mass) annotation(
    Evaluate=false, Placement(transformation(origin = {-70, -50}, extent = {{-30, -30}, {30, 30}})));
  
  BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishboneV2.RightDoubleWishboneV2 right_double_wishbone(upper_fore_i = {Axle.upper_fore_i[1], -Axle.upper_fore_i[2], Axle.upper_fore_i[3]},
                                                                                                       upper_aft_i = {Axle.upper_aft_i[1], -Axle.upper_aft_i[2], Axle.upper_aft_i[3]},
                                                                                                       lower_fore_i = {Axle.lower_fore_i[1], -Axle.lower_fore_i[2], Axle.lower_fore_i[3]},
                                                                                                       lower_aft_i = {Axle.lower_aft_i[1], -Axle.lower_aft_i[2], Axle.lower_aft_i[3]},
                                                                                                       upper_o = {Axle.upper_outboard[1], -Axle.upper_outboard[2], Axle.upper_outboard[3]},
                                                                                                       lower_o = {Axle.lower_outboard[1], -Axle.lower_outboard[2], Axle.lower_outboard[3]},
                                                                                                       tie_i = {Axle.tie_inboard[1], -Axle.tie_inboard[2], Axle.tie_inboard[3]},
                                                                                                       tie_o = {Axle.tie_outboard[1], -Axle.tie_outboard[2], Axle.tie_outboard[3]},
                                                                                                       wheel_center = {Axle.wheel_center[1], -Axle.wheel_center[2], Axle.wheel_center[3]},
                                                                                                       static_gamma = -Axle.static_gamma,
                                                                                                       static_alpha = -Axle.static_alpha,
                                                                                                       link_diameter = link_diameter,
                                                                                                       joint_diameter = joint_diameter,
                                                                                                       unsprung_mass = right_unsprung_mass,
                                                                                                       uca_mass = right_uca_mass,
                                                                                                       lca_mass = right_lca_mass,
                                                                                                       tie_mass = right_tie_mass) annotation(
    Evaluate=false, Placement(transformation(origin = {70, -50}, extent = {{30, -30}, {-30, 30}})));
  
  // Tires
  replaceable BobLib.Vehicle.Chassis.Tires.MF5p2Tire left_tire annotation(
    Placement(transformation(origin = {-130, -50}, extent = {{10, -10}, {-10, 10}})));
  replaceable BobLib.Vehicle.Chassis.Tires.MF5p2Tire right_tire annotation(
    Placement(transformation(origin = {130, -50}, extent = {{-10, -10}, {10, 10}})));
  // Wheel torque inputs
  Modelica.Mechanics.Rotational.Interfaces.Flange_b left_torque annotation(
    Placement(transformation(origin = {-140, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b right_torque annotation(
    Placement(transformation(origin = {140, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b left_hub annotation(
    Placement(transformation(origin = {-140, 80}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b right_hub annotation(
    Placement(transformation(origin = {140, 80}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
protected
  // Fixed geometry from effective center to nodes
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_upper_i_trans(r = (Axle.upper_fore_i + Axle.upper_aft_i) / 2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_lower_i_trans(r = (Axle.lower_fore_i + Axle.lower_aft_i) / 2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_tie_i_trans(r = Axle.tie_inboard - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -50}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_upper_i_trans(r = ({Axle.upper_fore_i[1], -Axle.upper_fore_i[2], Axle.upper_fore_i[3]} + {Axle.upper_aft_i[1], -Axle.upper_aft_i[2], Axle.upper_aft_i[3]}) / 2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_lower_i_trans(r = ({Axle.lower_fore_i[1], -Axle.lower_fore_i[2], Axle.lower_fore_i[3]} + {Axle.lower_aft_i[1], -Axle.lower_aft_i[2], Axle.lower_aft_i[3]}) / 2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_tie_i_trans(r = {Axle.tie_inboard[1], -Axle.tie_inboard[2], Axle.tie_inboard[3]} - effective_center, animation = false) annotation(
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
  connect(left_double_wishbone.midpoint_frame, left_hub) annotation(
    Line(points = {{-100, -50}, {-120, -50}, {-120, 80}, {-140, 80}}, color = {95, 95, 95}));
  connect(right_double_wishbone.midpoint_frame, right_hub) annotation(
    Line(points = {{100, -50}, {120, -50}, {120, 80}, {140, 80}}, color = {95, 95, 95}));
  annotation(
    Diagram(coordinateSystem(extent = {{-140, 100}, {140, -100}})));
end AxleDoubleWishboneBase;
