within BobLib.Vehicle.Chassis.Suspension;

model FrAxleDW
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  parameter BobLib.Resources.Records.SUS.FrAxleDWPushBCARB AxleBC annotation(
    Evaluate = false);
  parameter BobLib.Resources.Records.MASSPROPS.FrUnsprung unsprung_mass annotation(
    Evaluate = false);
  parameter BobLib.Resources.Records.MASSPROPS.FrUCA uca_mass annotation(
    Evaluate = false);
  parameter BobLib.Resources.Records.MASSPROPS.FrLCA lca_mass annotation(
    Evaluate = false);
  parameter BobLib.Resources.Records.MASSPROPS.FrTie tie_mass annotation(
    Evaluate = false);
  parameter BobLib.Resources.Records.TIRES.Fr_tire Fr_tire annotation(
    Evaluate = false);
  extends BobLib.Vehicle.Chassis.Suspension.Templates.AxleDW(Axle = FrAxle, left_unsprung_mass = unsprung_mass, left_uca_mass = uca_mass, left_lca_mass = lca_mass, left_tie_mass = tie_mass, final left_tire(rim_width = Fr_tire.RIM_WIDTH, rim_R0 = Fr_tire.RIM_RADIUS, R0 = Fr_tire.UNLOADED_RADIUS, tire_c = Fr_tire.VERTICAL_STIFFNESS, tire_d = Fr_tire.VERTICAL_DAMPING, FNOMIN = Fr_tire.FNOMIN, tire = Fr_tire), final right_tire(rim_width = Fr_tire.RIM_WIDTH, rim_R0 = Fr_tire.RIM_RADIUS, R0 = Fr_tire.UNLOADED_RADIUS, tire_c = Fr_tire.VERTICAL_STIFFNESS, tire_d = Fr_tire.VERTICAL_DAMPING, FNOMIN = Fr_tire.FNOMIN, tire = Fr_tire));
  // left bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_bellcrank(r = AxleBC.bellcrank_pivot - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -30}, extent = {{10, -10}, {-10, 10}})));
  // left shock
  // right bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_bellcrank(r = {AxleBC.bellcrank_pivot[1], -AxleBC.bellcrank_pivot[2], AxleBC.bellcrank_pivot[3]} - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -30}, extent = {{-10, -10}, {10, 10}})));
  // right shock
  final BobLib.Vehicle.Chassis.Suspension.Linkages.Pushrod right_pushrod(inboard = {AxleBC.bellcrank_pickup_2[1], -AxleBC.bellcrank_pickup_2[2], AxleBC.bellcrank_pickup_2[3]}, outboard = {AxleBC.rod_mount[1], -AxleBC.rod_mount[2], AxleBC.rod_mount[3]}, link_diameter = link_diameter, joint_diameter = joint_diameter, pivot_axis = {AxleBC.bellcrank_pivot_axis[1], -AxleBC.bellcrank_pivot_axis[2], AxleBC.bellcrank_pivot_axis[3]}) annotation(
    Placement(transformation(origin = {120, -30}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  // Fr Stabar
  Modelica.Mechanics.Rotational.Interfaces.Flange_a pinion_flange annotation(
    Placement(transformation(origin = {0, 140}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_apex(r = AxleBC.rod_mount - Axle.lower_outboard, width = link_diameter, height = link_diameter) annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_apex(r = {AxleBC.rod_mount[1], -AxleBC.rod_mount[2], AxleBC.rod_mount[3]} - {Axle.lower_outboard[1], -Axle.lower_outboard[2], Axle.lower_outboard[3]}, width = link_diameter, height = link_diameter) annotation(
    Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_shock(r = AxleBC.shock_mount - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -90}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_shock(r = {AxleBC.shock_mount[1], -AxleBC.shock_mount[2], AxleBC.shock_mount[3]} - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -90}, extent = {{-10, -10}, {10, 10}})));
  Linkages.Pushrod left_pushrod(inboard = AxleBC.bellcrank_pickup_2, outboard = AxleBC.rod_mount, pivot_axis = AxleBC.bellcrank_pivot_axis, link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-120, -30}, extent = {{20, -20}, {-20, 20}})));
  Linkages.Bellcrank3 left_bellcrank(pivot = AxleBC.bellcrank_pivot, pivot_axis = AxleBC.bellcrank_pivot_axis, pickup_1 = AxleBC.bellcrank_pickup_1, pickup_2 = AxleBC.bellcrank_pickup_2, pickup_3 = AxleBC.bellcrank_pickup_3, link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Linkages.ShockLinkage LeftShockLinkage(r_a = AxleBC.bellcrank_pickup_3, r_b = AxleBC.shock_mount, s_0 = norm(AxleBC.bellcrank_pickup_3 - AxleBC.shock_mount), spring_table = [0, 0; 1, 0], damper_table = [0, 0; 1, 0], link_diameter = link_diameter, joint_diameter = joint_diameter, n_a = AxleBC.bellcrank_pivot_axis, n_b = normalize(AxleBC.bellcrank_pivot - AxleBC.bellcrank_pickup_3)) annotation(
    Placement(transformation(origin = {-50, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  Linkages.Bellcrank3 right_bellcrank(pivot_axis = {AxleBC.bellcrank_pivot_axis[1], -AxleBC.bellcrank_pivot_axis[2], AxleBC.bellcrank_pivot_axis[3]}, pivot = {AxleBC.bellcrank_pivot[1], -AxleBC.bellcrank_pivot[2], AxleBC.bellcrank_pivot[3]}, pickup_1 = {AxleBC.bellcrank_pickup_1[1], -AxleBC.bellcrank_pickup_1[2], AxleBC.bellcrank_pickup_1[3]}, pickup_2 = {AxleBC.bellcrank_pickup_2[1], -AxleBC.bellcrank_pickup_2[2], AxleBC.bellcrank_pickup_2[3]}, pickup_3 = {AxleBC.bellcrank_pickup_3[1], -AxleBC.bellcrank_pickup_3[2], AxleBC.bellcrank_pickup_3[3]}, link_diameter = link_diameter, joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {50, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Linkages.ShockLinkage RightShockLinkage(r_a = {AxleBC.bellcrank_pickup_3[1], -AxleBC.bellcrank_pickup_3[2], AxleBC.bellcrank_pickup_3[3]}, r_b = {AxleBC.shock_mount[1], -AxleBC.shock_mount[2], AxleBC.shock_mount[3]}, n_a = {AxleBC.bellcrank_pivot_axis[1], -AxleBC.bellcrank_pivot_axis[2], AxleBC.bellcrank_pivot_axis[3]}, n_b = normalize({AxleBC.bellcrank_pivot[1], -AxleBC.bellcrank_pivot[2], AxleBC.bellcrank_pivot[3]} - {AxleBC.bellcrank_pickup_3[1], -AxleBC.bellcrank_pickup_3[2], AxleBC.bellcrank_pickup_3[3]}), s_0 = norm(AxleBC.bellcrank_pickup_3 - AxleBC.shock_mount), spring_table = [0, 0; 1, 0], damper_table = [0, 0; 1, 0], link_diameter = link_diameter, joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {50, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
equation
  connect(RackAndPinion.pinion_flange, pinion_flange) annotation(
    Line(points = {{0, 114}, {0, 140}}));
  connect(to_left_bellcrank.frame_a, axle_frame) annotation(
    Line(points = {{-10, -30}, {0, -30}, {0, 0}}, color = {95, 95, 95}));
  connect(to_right_bellcrank.frame_a, axle_frame) annotation(
    Line(points = {{10, -30}, {0, -30}, {0, 0}}, color = {95, 95, 95}));
  connect(LeftWishboneUprightLoop.lower_o_frame, to_left_apex.frame_a) annotation(
    Line(points = {{-68, 22}, {-68, 0}, {-80, 0}}, color = {95, 95, 95}));
  connect(RightWishboneUprightLoop.lower_o_frame, to_right_apex.frame_a) annotation(
    Line(points = {{70, 22}, {70, 0}, {80, 0}}, color = {95, 95, 95}));
  connect(to_left_shock.frame_a, axle_frame) annotation(
    Line(points = {{-10, -90}, {0, -90}, {0, 0}}, color = {95, 95, 95}));
  connect(to_right_shock.frame_a, axle_frame) annotation(
    Line(points = {{10, -90}, {0, -90}, {0, 0}}, color = {95, 95, 95}));
  connect(left_pushrod.tie_o_frame, to_left_apex.frame_b) annotation(
    Line(points = {{-140, -30}, {-144, -30}, {-144, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(right_pushrod.tie_o_frame, to_right_apex.frame_b) annotation(
    Line(points = {{140, -30}, {144, -30}, {144, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(left_bellcrank.pickup_2_frame, left_pushrod.tie_i_frame) annotation(
    Line(points = {{-60, -30}, {-100, -30}}, color = {95, 95, 95}));
  connect(left_bellcrank.mount_frame, to_left_bellcrank.frame_b) annotation(
    Line(points = {{-40, -30}, {-30, -30}}, color = {95, 95, 95}));
  connect(left_bellcrank.pickup_3_frame, LeftShockLinkage.frame_a) annotation(
    Line(points = {{-50, -40}, {-50, -50}}, color = {95, 95, 95}));
  connect(LeftShockLinkage.frame_b, to_left_shock.frame_b) annotation(
    Line(points = {{-50, -80}, {-50, -90}, {-30, -90}}, color = {95, 95, 95}));
  connect(to_right_bellcrank.frame_b, right_bellcrank.mount_frame) annotation(
    Line(points = {{30, -30}, {40, -30}}, color = {95, 95, 95}));
  connect(right_bellcrank.pickup_2_frame, right_pushrod.tie_i_frame) annotation(
    Line(points = {{60, -30}, {100, -30}}, color = {95, 95, 95}));
  connect(right_bellcrank.pickup_3_frame, RightShockLinkage.frame_a) annotation(
    Line(points = {{50, -40}, {50, -50}}, color = {95, 95, 95}));
  connect(RightShockLinkage.frame_b, to_right_shock.frame_b) annotation(
    Line(points = {{50, -80}, {50, -90}, {30, -90}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true)),
    Icon(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true)));
end FrAxleDW;
