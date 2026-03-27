within BobLib.Vehicle.Chassis.Suspension;

model FrAxleDW
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  // Custom linalg
  import BobLib.Utilities.Math.Vector;
  
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
  extends BobLib.Vehicle.Chassis.Suspension.Templates.AxleDW(Axle = FrAxle, left_unsprung_mass = unsprung_mass, left_uca_mass = uca_mass, left_lca_mass = lca_mass, left_tie_mass = tie_mass);
  // left bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_bellcrank(r = AxleBC.bellcrank_pivot - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -20}, extent = {{10, -10}, {-10, 10}})));
  // left shock
  // right bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_bellcrank(r = {AxleBC.bellcrank_pivot[1], -AxleBC.bellcrank_pivot[2], AxleBC.bellcrank_pivot[3]} - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -20}, extent = {{-10, -10}, {10, 10}})));
  // right shock
  final BobLib.Vehicle.Chassis.Suspension.Linkages.Rod right_pushrod(r_a = Vector.mirrorXZ(AxleBC.bellcrank_pickup_2), r_b = Vector.mirrorXZ(AxleBC.rod_mount), n1_a = normalize(Vector.mirrorXZ(AxleBC.bellcrank_pivot_axis)), link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {120, -20}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  // Fr Stabar
  Modelica.Mechanics.Rotational.Interfaces.Flange_a pinion_flange annotation(
    Placement(transformation(origin = {0, 140}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_apex(r = AxleBC.rod_mount - Axle.lower_outboard, width = link_diameter, height = link_diameter) annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_apex(r = {AxleBC.rod_mount[1], -AxleBC.rod_mount[2], AxleBC.rod_mount[3]} - {Axle.lower_outboard[1], -Axle.lower_outboard[2], Axle.lower_outboard[3]}, width = link_diameter, height = link_diameter) annotation(
    Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_shock(r = AxleBC.shock_mount - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_shock(r = {AxleBC.shock_mount[1], -AxleBC.shock_mount[2], AxleBC.shock_mount[3]} - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod left_pushrod(r_a = AxleBC.bellcrank_pickup_2, r_b = AxleBC.rod_mount, n1_a = normalize(AxleBC.bellcrank_pivot_axis), link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-120, -20}, extent = {{20, -20}, {-20, 20}})));
  
  Linkages.Bellcrank3 left_bellcrank(pivot = AxleBC.bellcrank_pivot, pivot_axis = AxleBC.bellcrank_pivot_axis, pickup_1 = AxleBC.bellcrank_pickup_1, pickup_2 = AxleBC.bellcrank_pickup_2, pickup_3 = AxleBC.bellcrank_pickup_3, link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Linkages.ShockLinkage LeftShockLinkage(r_a = AxleBC.bellcrank_pickup_3, r_b = AxleBC.shock_mount, s_0 = norm(AxleBC.bellcrank_pickup_3 - AxleBC.shock_mount), spring_table = [0, 0; 1, 0], damper_table = [0, 0; 1, 0], link_diameter = link_diameter, joint_diameter = joint_diameter, n_a = AxleBC.bellcrank_pivot_axis, n_b = normalize(AxleBC.bellcrank_pivot - AxleBC.bellcrank_pickup_3)) annotation(
    Placement(transformation(origin = {-50, -55}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  Linkages.Bellcrank3 right_bellcrank(pivot_axis = {AxleBC.bellcrank_pivot_axis[1], -AxleBC.bellcrank_pivot_axis[2], AxleBC.bellcrank_pivot_axis[3]}, pivot = {AxleBC.bellcrank_pivot[1], -AxleBC.bellcrank_pivot[2], AxleBC.bellcrank_pivot[3]}, pickup_1 = {AxleBC.bellcrank_pickup_1[1], -AxleBC.bellcrank_pickup_1[2], AxleBC.bellcrank_pickup_1[3]}, pickup_2 = {AxleBC.bellcrank_pickup_2[1], -AxleBC.bellcrank_pickup_2[2], AxleBC.bellcrank_pickup_2[3]}, pickup_3 = {AxleBC.bellcrank_pickup_3[1], -AxleBC.bellcrank_pickup_3[2], AxleBC.bellcrank_pickup_3[3]}, link_diameter = link_diameter, joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {50, -20}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Linkages.ShockLinkage RightShockLinkage(r_a = {AxleBC.bellcrank_pickup_3[1], -AxleBC.bellcrank_pickup_3[2], AxleBC.bellcrank_pickup_3[3]}, r_b = {AxleBC.shock_mount[1], -AxleBC.shock_mount[2], AxleBC.shock_mount[3]}, n_a = {AxleBC.bellcrank_pivot_axis[1], -AxleBC.bellcrank_pivot_axis[2], AxleBC.bellcrank_pivot_axis[3]}, n_b = normalize({AxleBC.bellcrank_pivot[1], -AxleBC.bellcrank_pivot[2], AxleBC.bellcrank_pivot[3]} - {AxleBC.bellcrank_pickup_3[1], -AxleBC.bellcrank_pickup_3[2], AxleBC.bellcrank_pickup_3[3]}), s_0 = norm(AxleBC.bellcrank_pickup_3 - AxleBC.shock_mount), spring_table = [0, 0; 1, 0], damper_table = [0, 0; 1, 0], link_diameter = link_diameter, joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {50, -55}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  Templates.Stabar.Stabar stabar(left_bar_end = AxleBC.left_bar_end, left_arm_end = AxleBC.left_arm_end, joint_diameter = joint_diameter, link_diameter = link_diameter) annotation(
    Placement(transformation(origin = {0, -116}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_stabar(r = {AxleBC.left_bar_end[1], 0, AxleBC.left_bar_end[3]} - effective_center, animation = false)  annotation(
    Placement(transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical right_droplink(rodLength = norm({AxleBC.bellcrank_pickup_1[1], -AxleBC.bellcrank_pickup_1[2], AxleBC.bellcrank_pickup_1[3]} - {AxleBC.left_arm_end[1], -AxleBC.left_arm_end[2], AxleBC.left_arm_end[3]}), sphereDiameter = joint_diameter, rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical left_droplink(rodLength = norm(AxleBC.bellcrank_pickup_1 - AxleBC.left_arm_end), sphereDiameter = joint_diameter, rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(RackAndPinion.pinion_flange, pinion_flange) annotation(
    Line(points = {{0, 114}, {0, 140}}));
  connect(LeftWishboneUprightLoop.lower_o_frame, to_left_apex.frame_a) annotation(
    Line(points = {{-68, 22}, {-68, 0}, {-80, 0}}, color = {95, 95, 95}));
  connect(RightWishboneUprightLoop.lower_o_frame, to_right_apex.frame_a) annotation(
    Line(points = {{70, 22}, {70, 0}, {80, 0}}, color = {95, 95, 95}));
  connect(left_pushrod.frame_b, to_left_apex.frame_b) annotation(
    Line(points = {{-140, -20}, {-144, -20}, {-144, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(right_pushrod.frame_b, to_right_apex.frame_b) annotation(
    Line(points = {{140, -20}, {144, -20}, {144, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(left_bellcrank.pickup_2_frame, left_pushrod.frame_a) annotation(
    Line(points = {{-60, -20}, {-100, -20}}, color = {95, 95, 95}));
  connect(left_bellcrank.mount_frame, to_left_bellcrank.frame_b) annotation(
    Line(points = {{-40, -20}, {-30, -20}}, color = {95, 95, 95}));
  connect(left_bellcrank.pickup_3_frame, LeftShockLinkage.frame_a) annotation(
    Line(points = {{-50, -30}, {-50, -40}}, color = {95, 95, 95}));
  connect(LeftShockLinkage.frame_b, to_left_shock.frame_b) annotation(
    Line(points = {{-50, -70}, {-30, -70}}, color = {95, 95, 95}));
  connect(to_right_bellcrank.frame_b, right_bellcrank.mount_frame) annotation(
    Line(points = {{30, -20}, {40, -20}}, color = {95, 95, 95}));
  connect(right_bellcrank.pickup_2_frame, right_pushrod.frame_a) annotation(
    Line(points = {{60, -20}, {100, -20}}, color = {95, 95, 95}));
  connect(right_bellcrank.pickup_3_frame, RightShockLinkage.frame_a) annotation(
    Line(points = {{50, -30}, {50, -40}}, color = {95, 95, 95}));
  connect(RightShockLinkage.frame_b, to_right_shock.frame_b) annotation(
    Line(points = {{50, -70}, {30, -70}}, color = {95, 95, 95}));
  connect(axle_frame, to_left_bellcrank.frame_a) annotation(
    Line(points = {{0, 0}, {0, -20}, {-10, -20}}));
  connect(axle_frame, to_right_bellcrank.frame_a) annotation(
    Line(points = {{0, 0}, {0, -20}, {10, -20}}));
  connect(axle_frame, to_left_shock.frame_a) annotation(
    Line(points = {{0, 0}, {0, -70}, {-10, -70}}));
  connect(to_right_bellcrank.frame_a, to_right_shock.frame_a) annotation(
    Line(points = {{10, -20}, {0, -20}, {0, -70}, {10, -70}}, color = {95, 95, 95}));
  connect(axle_frame, to_stabar.frame_a) annotation(
    Line(points = {{0, 0}, {0, -80}}));
  connect(to_stabar.frame_b, stabar.support_frame) annotation(
    Line(points = {{0, -100}, {0, -110}}, color = {95, 95, 95}));
  connect(stabar.right_arm_frame, right_droplink.frame_a) annotation(
    Line(points = {{20, -120}, {70, -120}, {70, -100}}, color = {95, 95, 95}));
  connect(right_droplink.frame_b, right_bellcrank.pickup_1_frame) annotation(
    Line(points = {{70, -80}, {70, -10}, {50, -10}}, color = {95, 95, 95}));
  connect(stabar.left_arm_frame, left_droplink.frame_a) annotation(
    Line(points = {{-20, -120}, {-70, -120}, {-70, -100}}, color = {95, 95, 95}));
  connect(left_droplink.frame_b, left_bellcrank.pickup_1_frame) annotation(
    Line(points = {{-70, -80}, {-70, -10}, {-50, -10}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true)),
    Icon(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true)));
end FrAxleDW;
