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
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_apex(r = AxleBC.rod_mount - Axle.lower_outboard, width = link_diameter, height = link_diameter)  annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_apex(r = {AxleBC.rod_mount[1], -AxleBC.rod_mount[2], AxleBC.rod_mount[3]} - {Axle.lower_outboard[1], -Axle.lower_outboard[2], Axle.lower_outboard[3]}, width = link_diameter, height = link_diameter)  annotation(
    Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_shock(r = AxleBC.shock_mount - effective_center, animation = false)  annotation(
    Placement(transformation(origin = {-20, -100}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_shock(r = {AxleBC.shock_mount[1], -AxleBC.shock_mount[2], AxleBC.shock_mount[3]} - effective_center, animation = false)  annotation(
    Placement(transformation(origin = {20, -100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute right_bellcrank_pivot(n = {AxleBC.bellcrank_pivot_axis[1], -AxleBC.bellcrank_pivot_axis[2], AxleBC.bellcrank_pivot_axis[3]}, cylinderLength = joint_diameter, cylinderDiameter = joint_diameter) annotation(
    Placement(transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_pivot_to_pushrod(r = {AxleBC.bellcrank_pickup_2[1], -AxleBC.bellcrank_pickup_2[2], AxleBC.bellcrank_pickup_2[3]} - {AxleBC.bellcrank_pivot[1], -AxleBC.bellcrank_pivot[2], AxleBC.bellcrank_pivot[3]}, width = link_diameter*0.75, height = link_diameter*0.75) annotation(
    Placement(transformation(origin = {80, -30}, extent = {{-10, -10}, {10, 10}})));
  Linkages.Pushrod left_pushrod(inboard = AxleBC.bellcrank_pickup_2, outboard = AxleBC.rod_mount, pivot_axis = AxleBC.bellcrank_pivot_axis, link_diameter = link_diameter, joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {-120, -30}, extent = {{20, -20}, {-20, 20}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute left_bellcrank_pivot(n = AxleBC.bellcrank_pivot_axis, cylinderLength = joint_diameter, cylinderDiameter = joint_diameter)  annotation(
    Placement(transformation(origin = {-50, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_pivot_to_pushrod(r = AxleBC.bellcrank_pickup_2 - AxleBC.bellcrank_pivot)  annotation(
    Placement(transformation(origin = {-80, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_pushrod_to_shock(r = AxleBC.bellcrank_pickup_3 - AxleBC.bellcrank_pickup_2)  annotation(
    Placement(transformation(origin = {-100, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_shock_axis(n = normalize(AxleBC.shock_mount - AxleBC.bellcrank_pickup_3), boxWidth = joint_diameter*0.5)  annotation(
    Placement(transformation(origin = {-80, -100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical left_shock_spherical_joint(sphereDiameter = joint_diameter)  annotation(
    Placement(transformation(origin = {-50, -100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Universal left_shock_universal_joint(n_a = AxleBC.bellcrank_pivot_axis, cylinderLength = joint_diameter, cylinderDiameter = joint_diameter, n_b = normalize(AxleBC.bellcrank_pivot - AxleBC.bellcrank_pickup_3))  annotation(
    Placement(transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
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
    Line(points = {{-10, -100}, {0, -100}, {0, 0}}, color = {95, 95, 95}));
  connect(to_right_shock.frame_a, axle_frame) annotation(
    Line(points = {{10, -100}, {0, -100}, {0, 0}}, color = {95, 95, 95}));
  connect(to_right_bellcrank.frame_b, right_bellcrank_pivot.frame_a) annotation(
    Line(points = {{30, -30}, {40, -30}}, color = {95, 95, 95}));
  connect(right_bellcrank_pivot.frame_b, right_pivot_to_pushrod.frame_a) annotation(
    Line(points = {{60, -30}, {70, -30}}, color = {95, 95, 95}));
  connect(right_pivot_to_pushrod.frame_b, right_pushrod.tie_i_frame) annotation(
    Line(points = {{90, -30}, {100, -30}}, color = {95, 95, 95}));
  connect(to_left_bellcrank.frame_b, left_bellcrank_pivot.frame_a) annotation(
    Line(points = {{-30, -30}, {-40, -30}}, color = {95, 95, 95}));
  connect(left_bellcrank_pivot.frame_b, left_pivot_to_pushrod.frame_a) annotation(
    Line(points = {{-60, -30}, {-70, -30}}, color = {95, 95, 95}));
  connect(left_pivot_to_pushrod.frame_b, left_pushrod.tie_i_frame) annotation(
    Line(points = {{-90, -30}, {-100, -30}}, color = {95, 95, 95}));
  connect(left_pushrod.tie_i_frame, left_pushrod_to_shock.frame_a) annotation(
    Line(points = {{-100, -30}, {-100, -40}}, color = {95, 95, 95}));
  connect(left_pushrod.tie_o_frame, to_left_apex.frame_b) annotation(
    Line(points = {{-140, -30}, {-144, -30}, {-144, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(right_pushrod.tie_o_frame, to_right_apex.frame_b) annotation(
    Line(points = {{140, -30}, {144, -30}, {144, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(left_pushrod_to_shock.frame_b, left_shock_universal_joint.frame_a) annotation(
    Line(points = {{-100, -60}, {-100, -70}}, color = {95, 95, 95}));
  connect(left_shock_universal_joint.frame_b, left_shock_axis.frame_a) annotation(
    Line(points = {{-100, -90}, {-100, -100}, {-90, -100}}, color = {95, 95, 95}));
  connect(left_shock_axis.frame_b, left_shock_spherical_joint.frame_a) annotation(
    Line(points = {{-70, -100}, {-60, -100}}, color = {95, 95, 95}));
  connect(left_shock_spherical_joint.frame_b, to_left_shock.frame_b) annotation(
    Line(points = {{-40, -100}, {-30, -100}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true)),
    Icon(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true)));
end FrAxleDW;
