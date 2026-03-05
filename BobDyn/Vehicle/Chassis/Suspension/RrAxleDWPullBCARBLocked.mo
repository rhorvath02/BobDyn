within BobDyn.Vehicle.Chassis.Suspension;

model RrAxleDWPullBCARBLocked
  import Modelica.Math.Vectors.norm;
  import Modelica.SIunits;
  
  parameter BobDyn.Resources.Records.SUS.RrAxleDW RrAxle;
  parameter BobDyn.Resources.Records.SUS.RrAxleDWPullBCARB RrAxleBC;
  
  parameter BobDyn.Resources.Records.MASSPROPS.RrUnsprung unsprung_mass;
  parameter BobDyn.Resources.Records.MASSPROPS.RrUCA uca_mass;
  parameter BobDyn.Resources.Records.MASSPROPS.RrLCA lca_mass;
  parameter BobDyn.Resources.Records.MASSPROPS.RrTie tie_mass;
  
  parameter BobDyn.Resources.Records.TIRES.Rr_tire Rr_tire;

  extends BobDyn.Vehicle.Chassis.Suspension.Templates.AxleDoubleWishboneBase(left_upper_fore_i = RrAxle.upper_fore_i,
                                                                             left_upper_aft_i = RrAxle.upper_aft_i,
                                                                             left_lower_fore_i = RrAxle.lower_fore_i,
                                                                             left_lower_aft_i = RrAxle.lower_aft_i,
                                                                             left_upper_o = RrAxle.upper_outboard,
                                                                             left_lower_o = RrAxle.lower_outboard,
                                                                             left_tie_i = RrAxle.tie_inboard,
                                                                             left_tie_o = RrAxle.tie_outboard,
                                                                             left_wheel_center = RrAxle.wheel_center,
                                                                             left_static_gamma = RrAxle.static_gamma,
                                                                             left_static_alpha = RrAxle.static_alpha,
                                                                             left_unsprung_mass = unsprung_mass,
                                                                             left_uca_mass = uca_mass,
                                                                             left_lca_mass = lca_mass,
                                                                             left_tie_mass = tie_mass,
                                                                             redeclare final BobDyn.Vehicle.Chassis.Tires.BaseTire left_tire(rim_width = Rr_tire.RIM_WIDTH,
                                                                                                                                             rim_R0 = Rr_tire.RIM_RADIUS,
                                                                                                                                             R0 = Rr_tire.UNLOADED_RADIUS,
                                                                                                                                             tire_c = Rr_tire.VERTICAL_STIFFNESS,
                                                                                                                                             tire_d = Rr_tire.VERTICAL_DAMPING),
                                                                             redeclare final BobDyn.Vehicle.Chassis.Tires.BaseTire right_tire(rim_width = Rr_tire.RIM_WIDTH,
                                                                                                                                              rim_R0 = Rr_tire.RIM_RADIUS,
                                                                                                                                              R0 = Rr_tire.UNLOADED_RADIUS,
                                                                                                                                              tire_c = Rr_tire.VERTICAL_STIFFNESS,
                                                                                                                                              tire_d = Rr_tire.VERTICAL_DAMPING));
  
  final parameter SIunits.Position left_bellcrank_pivot[3] = RrAxleBC.bellcrank_pivot annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position left_bellcrank_pivot_ref[3] = RrAxleBC.bellcrank_pivot_ref annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position left_bellcrank_pickup_1[3] = RrAxleBC.bellcrank_pickup_1 annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position left_bellcrank_pickup_2[3] = RrAxleBC.bellcrank_pickup_2 annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position left_bellcrank_pickup_3[3] = RrAxleBC.bellcrank_pickup_3 annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position left_UCA_mount[3] = RrAxleBC.rod_mount annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position left_shock_mount[3] = RrAxleBC.shock_mount annotation(
    Dialog(group = "Geometry"));
  // left apex geometry
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_apex(r = left_UCA_mount - left_upper_o) annotation(
    Placement(transformation(origin = {-110, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  // left pushrod
  final Modelica.Mechanics.MultiBody.Joints.SphericalSpherical left_pushrod(rodLength = norm(left_bellcrank_pickup_1 - left_UCA_mount),
                                                                          sphereDiameter = joint_diameter,
                                                                          rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  // left bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_bellcrank_mount(r = left_bellcrank_pivot - effective_center) annotation(
    Placement(transformation(origin = {-30, 40}, extent = {{10, -10}, {-10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.Bellcrank3pu1p left_bellcrank(pickup_1 = left_bellcrank_pickup_1,
                                                                                        pickup_2 = left_bellcrank_pickup_2,
                                                                                        pickup_3 = left_bellcrank_pickup_3,
                                                                                        pivot = left_bellcrank_pivot,
                                                                                        pivot_ref = left_bellcrank_pivot_ref) annotation(
    Placement(transformation(origin = {-60, 40}, extent = {{10, -10}, {-10, 10}})));
  // left shock
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_shock_pickup(r = left_shock_mount - effective_center) annotation(
    Placement(transformation(origin = {-20, 70}, extent = {{10, -10}, {-10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularSpring left_tabular_spring(spring_table = [0, 0; 1, 0],
                                                                                            free_length = RrAxle.free_length,
                                                                                            spring_diameter = 0.050) annotation(
    Placement(transformation(origin = {-50, 70}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularDamper left_tabular_damper(damper_table = [0, 0; 1, 0],
                                                                                    inner_diameter = 0.004,
                                                                                    outer_diameter = 0.008) annotation(
    Placement(transformation(origin = {-50, 130}, extent = {{10, -10}, {-10, 10}})));
  // right apex geometry
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_apex(r = {left_UCA_mount[1], -left_UCA_mount[2], left_UCA_mount[3]} - right_upper_o) annotation(
    Placement(transformation(origin = {110, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  // right pushrod
  final Modelica.Mechanics.MultiBody.Joints.SphericalSpherical right_pushrod(rodLength = norm(left_bellcrank_pickup_1 - left_UCA_mount),
                                                                          sphereDiameter = joint_diameter,
                                                                          rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {90, 30}, extent = {{10, -10}, {-10, 10}})));
  // right bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_bellcrank_mount(r = {left_bellcrank_pivot[1], -left_bellcrank_pivot[2], left_bellcrank_pivot[3]} - effective_center) annotation(
    Placement(transformation(origin = {30, 40}, extent = {{-10, -10}, {10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.Bellcrank3pu1p right_bellcrank(pickup_1 = {left_bellcrank_pickup_1[1], -left_bellcrank_pickup_1[2], left_bellcrank_pickup_1[3]},
                                                                                    pickup_2 = {left_bellcrank_pickup_2[1], -left_bellcrank_pickup_2[2], left_bellcrank_pickup_2[3]},
                                                                                    pickup_3 = {left_bellcrank_pickup_3[1], -left_bellcrank_pickup_3[2], left_bellcrank_pickup_3[3]},
                                                                                    pivot = {left_bellcrank_pivot[1], -left_bellcrank_pivot[2], left_bellcrank_pivot[3]},
                                                                                    pivot_ref = {left_bellcrank_pivot_ref[1], -left_bellcrank_pivot_ref[2], left_bellcrank_pivot_ref[3]}) annotation(
    Placement(transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}})));
  // right shock
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_shock_pickup(r = {left_shock_mount[1], -left_shock_mount[2], left_shock_mount[3]} - effective_center) annotation(
    Placement(transformation(origin = {20, 70}, extent = {{-10, -10}, {10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularSpring right_tabular_spring(spring_table = [0, 0; 1, 0],
                                                                                        free_length = RrAxle.free_length,
                                                                                        spring_diameter = 0.050) annotation(
    Placement(transformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularDamper right_tabular_damper(damper_table = [0, 0; 1, 0],
                                                                                        inner_diameter = 0.004,
                                                                                        outer_diameter = 0.008) annotation(
    Placement(transformation(origin = {50, 130}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  // Rr Stabar
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation stabar_frame(r = {RrAxleBC.left_bar_end[1], 0, RrAxleBC.left_bar_end[3]} - effective_center) annotation(
    Placement(transformation(origin = {-20, -10}, extent = {{10, -10}, {-10, 10}})));
  // Zero steer (for typical rear axle)
  final Modelica.Blocks.Sources.RealExpression zero_steer annotation(
    Placement(transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  BobDyn.Vehicle.Chassis.Suspension.Linkages.Stabar stabar(bar_rate = RrAxleBC.bar_rate, joint_diameter = joint_diameter*0.5, left_arm_end = RrAxleBC.left_arm_end, left_bar_end = RrAxleBC.left_bar_end, left_droplink_end = RrAxleBC.bellcrank_pickup_3, link_diameter = link_diameter*0.5) annotation(
    Placement(transformation(origin = {-40, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
equation
  connect(left_apex.frame_b, left_pushrod.frame_a) annotation(
    Line(points = {{-110, 20}, {-110, 30}, {-100, 30}}, color = {95, 95, 95}));
  connect(left_bellcrank.mount_frame, left_bellcrank_mount.frame_b) annotation(
    Line(points = {{-50, 40}, {-40, 40}}, color = {95, 95, 95}));
  connect(left_shock_pickup.frame_a, axle_frame) annotation(
    Line(points = {{-10, 70}, {0, 70}, {0, -100}}, color = {95, 95, 95}));
  connect(left_bellcrank_mount.frame_a, axle_frame) annotation(
    Line(points = {{-20, 40}, {0, 40}, {0, -100}}, color = {95, 95, 95}));
  connect(right_apex.frame_b, right_pushrod.frame_a) annotation(
    Line(points = {{110, 20}, {110, 30}, {100, 30}}, color = {95, 95, 95}));
  connect(right_bellcrank.mount_frame, right_bellcrank_mount.frame_b) annotation(
    Line(points = {{50, 40}, {40, 40}}, color = {95, 95, 95}));
  connect(right_shock_pickup.frame_a, axle_frame) annotation(
    Line(points = {{10, 70}, {0, 70}, {0, -100}}, color = {95, 95, 95}));
  connect(right_bellcrank_mount.frame_a, axle_frame) annotation(
    Line(points = {{20, 40}, {0, 40}, {0, -100}}, color = {95, 95, 95}));
  connect(zero_steer.y, left_double_wishbone.steer_input) annotation(
    Line(points = {{-90, 59}, {-90, -14}}, color = {0, 0, 127}));
  connect(zero_steer.y, right_double_wishbone.steer_input) annotation(
    Line(points = {{-90, 59}, {-90, 20}, {90, 20}, {90, -14}}, color = {0, 0, 127}));
  connect(left_pushrod.frame_b, left_bellcrank.pickup_1_frame) annotation(
    Line(points = {{-80, 30}, {-60, 30}}, color = {95, 95, 95}));
  connect(right_pushrod.frame_b, right_bellcrank.pickup_1_frame) annotation(
    Line(points = {{80, 30}, {60, 30}}, color = {95, 95, 95}));
  connect(left_apex.frame_a, left_double_wishbone.upper_wishbone_frame) annotation(
    Line(points = {{-110, 0}, {-70, 0}, {-70, -20}}, color = {95, 95, 95}));
  connect(right_apex.frame_a, right_double_wishbone.upper_wishbone_frame) annotation(
    Line(points = {{110, 0}, {70, 0}, {70, -20}}, color = {95, 95, 95}));
  connect(stabar_frame.frame_a, axle_frame) annotation(
    Line(points = {{-10, -10}, {0, -10}, {0, -100}}, color = {95, 95, 95}));
  connect(stabar_frame.frame_b, stabar.support_pickup) annotation(
    Line(points = {{-30, -10}, {-40, -10}, {-40, 0}}, color = {95, 95, 95}));
  connect(stabar.left_pickup, left_bellcrank.pickup_3_frame) annotation(
    Line(points = {{-50, 10}, {-60, 10}, {-60, 50}}, color = {95, 95, 95}));
  connect(stabar.right_pickup, right_bellcrank.pickup_3_frame) annotation(
    Line(points = {{-30, 10}, {60, 10}, {60, 50}}, color = {95, 95, 95}));
  connect(left_bellcrank.pickup_3_frame, left_tabular_spring.frame_b) annotation(
    Line(points = {{-60, 50}, {-60, 70}}, color = {95, 95, 95}));
  connect(left_tabular_spring.frame_a, left_shock_pickup.frame_b) annotation(
    Line(points = {{-40, 70}, {-30, 70}}, color = {95, 95, 95}));
  connect(right_bellcrank.pickup_3_frame, right_tabular_spring.frame_b) annotation(
    Line(points = {{60, 50}, {60, 70}}, color = {95, 95, 95}));
  connect(right_tabular_spring.frame_a, right_shock_pickup.frame_b) annotation(
    Line(points = {{40, 70}, {30, 70}}, color = {95, 95, 95}));
  connect(left_tabular_damper.frame_b, left_tabular_spring.frame_b) annotation(
    Line(points = {{-60, 130}, {-60, 70}}, color = {95, 95, 95}));
  connect(left_tabular_damper.frame_a, left_tabular_spring.frame_a) annotation(
    Line(points = {{-40, 130}, {-40, 70}}, color = {95, 95, 95}));
  connect(right_tabular_damper.frame_a, right_tabular_spring.frame_a) annotation(
    Line(points = {{40, 130}, {40, 70}}, color = {95, 95, 95}));
  connect(right_tabular_damper.frame_b, right_tabular_spring.frame_b) annotation(
    Line(points = {{60, 130}, {60, 70}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end RrAxleDWPullBCARBLocked;
