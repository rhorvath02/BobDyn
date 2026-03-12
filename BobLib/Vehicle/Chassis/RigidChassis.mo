within BobLib.Vehicle.Chassis;

model RigidChassis
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  // Custom linalg
  import BobLib.Utilities.Math.Vector.cross;
  import BobLib.Utilities.Math.Vector.dot;
  // Parameters
  parameter BobLib.Resources.Records.SUS.FrAxleDW Fr_axle_props;
  parameter BobLib.Resources.Records.SUS.RrAxleDW Rr_axle_props;
  parameter BobLib.Resources.Records.SUS.FrAxleDWPushBCARB Fr_axle_bc_props;
  parameter BobLib.Resources.Records.SUS.RrAxleDWPullBCARB Rr_axle_bc_props;
  parameter BobLib.Resources.Records.MASSPROPS.Sprung sprung_mass_props;
  parameter BobLib.Resources.Records.MASSPROPS.Driver driver_mass_props;
  
  parameter BobLib.Resources.Records.MASSPROPS.FrUnsprung Fr_unsprung_props annotation(
    Evaluate=false);
  parameter BobLib.Resources.Records.MASSPROPS.RrUnsprung Rr_unsprung_props annotation(
    Evaluate=false);
  
  parameter BobLib.Resources.Records.MASSPROPS.FrUCA Fr_uca_props annotation(
    Evaluate=false);
  parameter BobLib.Resources.Records.MASSPROPS.FrLCA Fr_lca_props annotation(
    Evaluate=false);
  parameter BobLib.Resources.Records.MASSPROPS.FrTie Fr_tie_props annotation(
    Evaluate=false);
  parameter BobLib.Resources.Records.TIRES.Fr_tire Fr_tire_props annotation(
    Evaluate=false);
  
  parameter BobLib.Resources.Records.MASSPROPS.RrUCA Rr_uca_props annotation(
    Evaluate=false);
  parameter BobLib.Resources.Records.MASSPROPS.RrLCA Rr_lca_props annotation(
    Evaluate=false);
  parameter BobLib.Resources.Records.MASSPROPS.RrTie Rr_tie_props annotation(
    Evaluate=false);
  parameter BobLib.Resources.Records.TIRES.Rr_tire Rr_tire_props annotation(
    Evaluate=false);
    
  BobLib.Vehicle.Chassis.Suspension.FrAxleDWPushBCARB FrAxle(FrAxle = Fr_axle_props,
                                                             FrAxleBC = Fr_axle_bc_props,
                                                             unsprung_mass = Fr_unsprung_props,
                                                             uca_mass = Fr_uca_props,
                                                             lca_mass = Fr_lca_props,
                                                             tie_mass = Fr_tie_props,
                                                             final link_diameter = 0.025,
                                                             final joint_diameter = 0.030/*,
                                                             redeclare final BobLib.Vehicle.Chassis.Tires.BaseTire left_tire(rim_width = Fr_tire_props.RIM_WIDTH,
                                                                                                                             rim_R0 = Fr_tire_props.RIM_RADIUS,
                                                                                                                             R0 = Fr_tire_props.UNLOADED_RADIUS,
                                                                                                                             tire_c = Fr_tire_props.VERTICAL_STIFFNESS,
                                                                                                                             tire_d = Fr_tire_props.VERTICAL_DAMPING),
                                                             redeclare final BobLib.Vehicle.Chassis.Tires.BaseTire right_tire(rim_width = Fr_tire_props.RIM_WIDTH,
                                                                                                                              rim_R0 = Fr_tire_props.RIM_RADIUS,
                                                                                                                              R0 = Fr_tire_props.UNLOADED_RADIUS,
                                                                                                                              tire_c = Fr_tire_props.VERTICAL_STIFFNESS,
                                                                                                                              tire_d = Fr_tire_props.VERTICAL_DAMPING)*/) annotation(
    Placement(transformation(origin = {0, 47}, extent = {{-20, -20}, {20, 20}})));
  BobLib.Vehicle.Chassis.Suspension.RrAxleDWPullBCARB RrAxle(RrAxle = Rr_axle_props,
                                                             RrAxleBC = Rr_axle_bc_props,
                                                             unsprung_mass = Rr_unsprung_props,
                                                             uca_mass = Rr_uca_props,
                                                             lca_mass = Rr_lca_props,
                                                             tie_mass = Rr_tie_props,
                                                             final link_diameter = 0.025,
                                                             final joint_diameter = 0.030/*,
                                                             redeclare final BobLib.Vehicle.Chassis.Tires.BaseTire left_tire(rim_width = Rr_tire_props.RIM_WIDTH,
                                                                                                                             rim_R0 = Rr_tire_props.RIM_RADIUS,
                                                                                                                             R0 = Rr_tire_props.UNLOADED_RADIUS,
                                                                                                                             tire_c = Rr_tire_props.VERTICAL_STIFFNESS,
                                                                                                                             tire_d = Rr_tire_props.VERTICAL_DAMPING),
                                                             redeclare final BobLib.Vehicle.Chassis.Tires.BaseTire right_tire(rim_width = Rr_tire_props.RIM_WIDTH,
                                                                                                                              rim_R0 = Rr_tire_props.RIM_RADIUS,
                                                                                                                              R0 = Rr_tire_props.UNLOADED_RADIUS,
                                                                                                                              tire_c = Rr_tire_props.VERTICAL_STIFFNESS,
                                                                                                                              tire_d = Rr_tire_props.VERTICAL_DAMPING)*/
                                                             ) annotation(
    Placement(transformation(origin = {0, -47}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r = RrAxle.effective_center - FrAxle.effective_center) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  // Torque inputs
  Modelica.Mechanics.Rotational.Interfaces.Flange_b FL_torque annotation(
    Placement(transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b FR_torque annotation(
    Placement(transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b RL_torque annotation(
    Placement(transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, -66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b RR_torque annotation(
    Placement(transformation(origin = {100, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -0), iconTransformation(origin = {100, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  // Steering input
  Modelica.Blocks.Interfaces.RealInput rack_input annotation(
    Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  // Sprung mass
  final Modelica.Mechanics.MultiBody.Parts.Body sprung_mass(r_CM = sprung_mass_props.r_cm - FrAxle.effective_center, m = sprung_mass_props.m, I_11 = sprung_mass_props.I[1, 1], I_22 = sprung_mass_props.I[2, 2], I_33 = sprung_mass_props.I[3, 3], I_21 = sprung_mass_props.I[2, 1], I_31 = sprung_mass_props.I[3, 1], I_32 = sprung_mass_props.I[3, 2], enforceStates = true, useQuaternions = false, v_0(start = {15, 0, 0}, each fixed = true)) annotation(
    Placement(transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}})));
  // Driver mass
  final Modelica.Mechanics.MultiBody.Parts.Body driver_mass(r_CM = driver_mass_props.r_cm - FrAxle.effective_center, m = driver_mass_props.m, I_11 = driver_mass_props.I[1, 1], I_22 = driver_mass_props.I[2, 2], I_33 = driver_mass_props.I[3, 3], I_21 = driver_mass_props.I[2, 1], I_31 = driver_mass_props.I[3, 1], I_32 = driver_mass_props.I[3, 2], useQuaternions = false) annotation(
    Placement(transformation(origin = {70, 90}, extent = {{-10, -10}, {10, 10}})));
  // World frame for "grounding"
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b world_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  // Frame height sensing
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation FL_frame_sens(r = Fr_axle_props.frame_height_sensor - FrAxle.effective_center) annotation(
    Placement(transformation(origin = {-20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation FR_frame_sens(r = {Fr_axle_props.frame_height_sensor[1], -Fr_axle_props.frame_height_sensor[2], Fr_axle_props.frame_height_sensor[3]} - FrAxle.effective_center) annotation(
    Placement(transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}})));
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation RL_frame_sens(r = Rr_axle_props.frame_height_sensor - RrAxle.effective_center) annotation(
    Placement(transformation(origin = {-20, -10}, extent = {{10, -10}, {-10, 10}})));
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation RR_frame_sens(r = {Rr_axle_props.frame_height_sensor[1], -Rr_axle_props.frame_height_sensor[2], Rr_axle_props.frame_height_sensor[3]} - RrAxle.effective_center) annotation(
    Placement(transformation(origin = {20, -10}, extent = {{-10, -10}, {10, 10}})));
  final Modelica.Mechanics.MultiBody.Sensors.RelativePosition FL_frame_coord annotation(
    Placement(transformation(origin = {-50, 20}, extent = {{-10, -10}, {10, 10}})));
  final Modelica.Mechanics.MultiBody.Sensors.RelativePosition FR_frame_coord annotation(
    Placement(transformation(origin = {50, 20}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  final Modelica.Mechanics.MultiBody.Sensors.RelativePosition RL_frame_coord annotation(
    Placement(transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}})));
  final Modelica.Mechanics.MultiBody.Sensors.RelativePosition RR_frame_coord annotation(
    Placement(transformation(origin = {50, -10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Frames.Orientation R_IMF;
  Real ex[3];
  Real ey_raw[3];
  Real ey[3];
  Real ez[3];
  Real r_front[3];
  Real r_rear[3];
  Real r_left[3];
  Real r_right[3];
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles absoluteAngles annotation(
    Placement(transformation(origin = {-90, 90}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Utilities.Mechanics.Multibody.GroundPhysics FL_ground(c = 98947, d = 115.844)  annotation(
    Placement(transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics FR_ground(c = 98947, d = 115.844)  annotation(
    Placement(transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Utilities.Mechanics.Multibody.GroundPhysics RL_ground(c = 98947, d = 115.844)  annotation(
    Placement(transformation(origin = {-50, -64}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics RR_ground(c = 98947, d = 115.844)  annotation(
    Placement(transformation(origin = {50, -64}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
protected
  // Ground elements
initial equation
  sprung_mass.r_0[1] = 0;
  sprung_mass.r_0[2] = 0;
equation
// Determine coordinate system
  r_front = 0.5*(FrAxle.left_cp.r_0 + FrAxle.right_cp.r_0);
  r_rear = 0.5*(RrAxle.left_cp.r_0 + RrAxle.right_cp.r_0);
  r_left = 0.5*(FrAxle.left_cp.r_0 + RrAxle.left_cp.r_0);
  r_right = 0.5*(FrAxle.right_cp.r_0 + RrAxle.right_cp.r_0);
// Local longitudinal axis
  ex = normalize(r_front - r_rear);
// Raw lateral axis, removing any longitudinal component (Gram-Schmidt)
  ey_raw = (r_left - r_right) - (dot(r_left - r_right, ex))*ex;
// Normalize + build vertical
  ez = normalize(cross(ex, normalize(ey_raw)));
// re-orthogonalize ey (optional but recommended)
  ey = normalize(cross(ez, ex));
// Orientation inertial frame
  R_IMF = Modelica.Mechanics.MultiBody.Frames.from_nxy(ex, ey);
  connect(rack_input, FrAxle.steer_input) annotation(
    Line(points = {{0, 120}, {0, 72}}, color = {0, 0, 127}));
  connect(FrAxle.axle_frame, fixedTranslation.frame_a) annotation(
    Line(points = {{0, 28}, {0, 10}}, color = {95, 95, 95}));
  connect(fixedTranslation.frame_b, RrAxle.axle_frame) annotation(
    Line(points = {{0, -10}, {0, -26}}, color = {95, 95, 95}));
  connect(FL_frame_sens.frame_a, FrAxle.axle_frame) annotation(
    Line(points = {{-10, 20}, {0, 20}, {0, 28}}, color = {95, 95, 95}));
  connect(RL_frame_sens.frame_a, RrAxle.axle_frame) annotation(
    Line(points = {{-10, -10}, {0, -10}, {0, -26}}, color = {95, 95, 95}));
  connect(FR_frame_sens.frame_a, FrAxle.axle_frame) annotation(
    Line(points = {{10, 20}, {0, 20}, {0, 28}}, color = {95, 95, 95}));
  connect(RR_frame_sens.frame_a, RrAxle.axle_frame) annotation(
    Line(points = {{10, -10}, {0, -10}, {0, -26}}, color = {95, 95, 95}));
  connect(sprung_mass.frame_a, FrAxle.axle_frame) annotation(
    Line(points = {{60, 70}, {0, 70}, {0, 28}}, color = {95, 95, 95}));
  connect(driver_mass.frame_a, FrAxle.axle_frame) annotation(
    Line(points = {{60, 90}, {0, 90}, {0, 28}}, color = {95, 95, 95}));
  connect(FL_frame_coord.frame_b, FL_frame_sens.frame_b) annotation(
    Line(points = {{-40, 20}, {-30, 20}}, color = {95, 95, 95}));
  connect(FR_frame_coord.frame_b, FR_frame_sens.frame_b) annotation(
    Line(points = {{40, 20}, {30, 20}}, color = {95, 95, 95}));
  connect(RL_frame_sens.frame_b, RL_frame_coord.frame_b) annotation(
    Line(points = {{-30, -10}, {-40, -10}}, color = {95, 95, 95}));
  connect(RR_frame_sens.frame_b, RR_frame_coord.frame_b) annotation(
    Line(points = {{30, -10}, {40, -10}}, color = {95, 95, 95}));
  connect(FL_torque, FrAxle.left_torque) annotation(
    Line(points = {{-100, 60}, {-20, 60}}));
  connect(FR_torque, FrAxle.right_torque) annotation(
    Line(points = {{100, 60}, {20, 60}}));
  connect(RL_torque, RrAxle.left_torque) annotation(
    Line(points = {{-100, -60}, {-20, -60}}));
  connect(RR_torque, RrAxle.right_torque) annotation(
    Line(points = {{100, -60}, {20, -60}}));
  connect(sprung_mass.frame_a, absoluteAngles.frame_a) annotation(
    Line(points = {{60, 70}, {-60, 70}, {-60, 90}, {-80, 90}}, color = {95, 95, 95}));
  connect(FL_frame_coord.frame_a, world_frame) annotation(
    Line(points = {{-60, 20}, {-140, 20}, {-140, -100}, {0, -100}}, color = {95, 95, 95}));
  connect(RL_frame_coord.frame_a, world_frame) annotation(
    Line(points = {{-60, -10}, {-120, -10}, {-120, -100}, {0, -100}}, color = {95, 95, 95}));
  connect(RR_frame_coord.frame_a, world_frame) annotation(
    Line(points = {{60, -10}, {120, -10}, {120, -100}, {0, -100}}, color = {95, 95, 95}));
  connect(FR_frame_coord.frame_a, world_frame) annotation(
    Line(points = {{60, 20}, {140, 20}, {140, -100}, {0, -100}}, color = {95, 95, 95}));
  connect(FrAxle.left_cp, FL_ground.frame_b) annotation(
    Line(points = {{-20, 48}, {-70, 48}, {-70, -20}}, color = {95, 95, 95}));
  connect(RrAxle.left_cp, RL_ground.frame_b) annotation(
    Line(points = {{-20, -46}, {-50, -46}, {-50, -54}}, color = {95, 95, 95}));
  connect(FrAxle.right_cp, FR_ground.frame_b) annotation(
    Line(points = {{20, 48}, {70, 48}, {70, -20}}, color = {95, 95, 95}));
  connect(RrAxle.right_cp, RR_ground.frame_b) annotation(
    Line(points = {{20, -46}, {50, -46}, {50, -54}}, color = {95, 95, 95}));
  connect(FL_ground.frame_a, world_frame) annotation(
    Line(points = {{-80, -30}, {-90, -30}, {-90, -100}, {0, -100}}, color = {95, 95, 95}));
  connect(RL_ground.frame_a, world_frame) annotation(
    Line(points = {{-60, -64}, {-70, -64}, {-70, -100}, {0, -100}}, color = {95, 95, 95}));
  connect(RR_ground.frame_a, world_frame) annotation(
    Line(points = {{60, -64}, {70, -64}, {70, -100}, {0, -100}}, color = {95, 95, 95}));
  connect(FR_ground.frame_a, world_frame) annotation(
    Line(points = {{80, -30}, {90, -30}, {90, -100}, {0, -100}}, color = {95, 95, 95}));
annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end RigidChassis;
