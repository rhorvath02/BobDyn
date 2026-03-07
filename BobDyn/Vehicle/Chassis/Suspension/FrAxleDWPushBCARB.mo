within BobDyn.Vehicle.Chassis.Suspension;

model FrAxleDWPushBCARB
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.norm;
  
  parameter BobDyn.Resources.Records.SUS.FrAxleDW FrAxle annotation(
    Evaluate=false);
  parameter BobDyn.Resources.Records.SUS.FrAxleDWPushBCARB FrAxleBC annotation(
    Evaluate=false);
  
  parameter BobDyn.Resources.Records.MASSPROPS.FrUnsprung unsprung_mass annotation(
    Evaluate=false);
  parameter BobDyn.Resources.Records.MASSPROPS.FrUCA uca_mass annotation(
    Evaluate=false);
  parameter BobDyn.Resources.Records.MASSPROPS.FrLCA lca_mass annotation(
    Evaluate=false);
  parameter BobDyn.Resources.Records.MASSPROPS.FrTie tie_mass annotation(
    Evaluate=false);
  
  parameter BobDyn.Resources.Records.TIRES.Fr_tire Fr_tire annotation(
    Evaluate=false);
  
  extends BobDyn.Vehicle.Chassis.Suspension.Templates.AxleDoubleWishboneBase(Axle = FrAxle,
                                                                             left_unsprung_mass = unsprung_mass,
                                                                             left_uca_mass = uca_mass,
                                                                             left_lca_mass = lca_mass,
                                                                             left_tie_mass = tie_mass,
                                                                             final left_tire(rim_width = Fr_tire.RIM_WIDTH,
                                                                                             rim_R0 = Fr_tire.RIM_RADIUS,
                                                                                             R0 = Fr_tire.UNLOADED_RADIUS,
                                                                                             tire_c = Fr_tire.VERTICAL_STIFFNESS,
                                                                                             tire_d = Fr_tire.VERTICAL_DAMPING,
                                                                                             FNOMIN = Fr_tire.FNOMIN,
                                                                                             PCX1 = Fr_tire.PCX1, PDX1 = Fr_tire.PDX1, PDX2 = Fr_tire.PDX2,
                                                                                             PDX3 = Fr_tire.PDX3, PEX1 = Fr_tire.PEX1, PEX2 = Fr_tire.PEX2,
                                                                                             PEX3 = Fr_tire.PEX3, PEX4 = Fr_tire.PEX4, PKX1 = Fr_tire.PKX1,
                                                                                             PKX2 = Fr_tire.PKX2, PKX3 = Fr_tire.PKX3, PHX1 = Fr_tire.PHX1,
                                                                                             PHX2 = Fr_tire.PHX2, PVX1 = Fr_tire.PVX1, PVX2 = Fr_tire.PVX2,
                                                                                             RBX1 = Fr_tire.RBX1, RBX2 = Fr_tire.RBX2, RCX1 = Fr_tire.RCX1,
                                                                                             REX1 = Fr_tire.REX1, REX2 = Fr_tire.REX2, RHX1 = Fr_tire.RHX1,
                                                                                             PCY1 = Fr_tire.PCY1, PDY1 = Fr_tire.PDY1, PDY2 = Fr_tire.PDY2,
                                                                                             PDY3 = Fr_tire.PDY3, PEY1 = Fr_tire.PEY1, PEY2 = Fr_tire.PEY2,
                                                                                             PEY3 = Fr_tire.PEY3, PEY4 = Fr_tire.PEY4, PKY1 = Fr_tire.PKY1,
                                                                                             PKY2 = Fr_tire.PKY2, PKY3 = Fr_tire.PKY3, PHY1 = Fr_tire.PHY1,
                                                                                             PHY2 = Fr_tire.PHY2, PHY3 = Fr_tire.PHY3, PVY1 = Fr_tire.PVY1,
                                                                                             PVY2 = Fr_tire.PVY2, PVY3 = Fr_tire.PVY3, PVY4 = Fr_tire.PVY4,
                                                                                             RBY1 = Fr_tire.RBY1, RBY2 = Fr_tire.RBY2, RBY3 = Fr_tire.RBY3,
                                                                                             RCY1 = Fr_tire.RCY1, REY1 = Fr_tire.REY1, REY2 = Fr_tire.REY2,
                                                                                             RHY1 = Fr_tire.RHY1, RHY2 = Fr_tire.RHY2, RVY1 = Fr_tire.RVY1,
                                                                                             RVY2 = Fr_tire.RVY2, RVY3 = Fr_tire.RVY3, RVY4 = Fr_tire.RVY4,
                                                                                             RVY5 = Fr_tire.RVY4, RVY6 = Fr_tire.RVY6, QSX1 = Fr_tire.QSX1,
                                                                                             QSX2 = Fr_tire.QSX2, QSX3 = Fr_tire.QSX3, QSY1 = Fr_tire.QSY1,
                                                                                             QSY2 = Fr_tire.QSY2, QSY3 = Fr_tire.QSY3, QSY4 = Fr_tire.QSY4,
                                                                                             QBZ1 = Fr_tire.QBZ1, QBZ2 = Fr_tire.QBZ2, QBZ3 = Fr_tire.QBZ3,
                                                                                             QBZ4 = Fr_tire.QBZ4, QBZ5 = Fr_tire.QBZ5, QBZ9 = Fr_tire.QBZ9,
                                                                                             QBZ10 = Fr_tire.QBZ10, QCZ1 = Fr_tire.QCZ1, QDZ1 = Fr_tire.QDZ1,
                                                                                             QDZ2 = Fr_tire.QDZ2, QDZ3 = Fr_tire.QDZ3, QDZ4 = Fr_tire.QDZ4,
                                                                                             QDZ6 = Fr_tire.QDZ6, QDZ7 = Fr_tire.QDZ7, QDZ8 = Fr_tire.QDZ8,
                                                                                             QDZ9 = Fr_tire.QDZ9, QEZ1 = Fr_tire.QEZ1, QEZ2 = Fr_tire.QEZ2,
                                                                                             QEZ3 = Fr_tire.QEZ3, QEZ4 = Fr_tire.QEZ4, QEZ5 = Fr_tire.QEZ5,
                                                                                             QHZ1 = Fr_tire.QHZ1, QHZ2 = Fr_tire.QHZ2, QHZ3 = Fr_tire.QHZ3,
                                                                                             QHZ4 = Fr_tire.QHZ4, SSZ1 = Fr_tire.SSZ1, SSZ2 = Fr_tire.SSZ2,
                                                                                             SSZ3 = Fr_tire.SSZ3, SSZ4 = Fr_tire.SSZ4, LFZO = Fr_tire.LFZO,
                                                                                             LCX = Fr_tire.LCX, LMUX = Fr_tire.LMUX, LEX = Fr_tire.LEX,
                                                                                             LKX = Fr_tire.LKX, LHX = Fr_tire.LHX, LVX = Fr_tire.LVX,
                                                                                             LXAL = Fr_tire.LXAL, LGAX = Fr_tire.LGAX, LCY = Fr_tire.LCY,
                                                                                             LMUY = Fr_tire.LMUY, LEY = Fr_tire.LEY, LKY = Fr_tire.LKY,
                                                                                             LHY = Fr_tire.LHY, LVY = Fr_tire.LVY, LGAY = Fr_tire.LGAY,
                                                                                             LKYG = Fr_tire.LKYG, LTR = Fr_tire.LTR, LRES = Fr_tire.LRES,
                                                                                             LCZ = Fr_tire.LCZ, LGAZ = Fr_tire.LGAZ, LYKA = Fr_tire.LYKA,
                                                                                             LVYKA = Fr_tire.LVYKA, LS = Fr_tire.LS, LSGKP = Fr_tire.LSGKP,
                                                                                             LSGAL = Fr_tire.LSGAL, LGYR = Fr_tire.LGYR, LMX = Fr_tire.LMX,
                                                                                             LVMX = Fr_tire.LVMX, LMY = Fr_tire.LMY, LIP = Fr_tire.LIP),
                                                                              final right_tire(rim_width = Fr_tire.RIM_WIDTH,
                                                                                               rim_R0 = Fr_tire.RIM_RADIUS,
                                                                                               R0 = Fr_tire.UNLOADED_RADIUS,
                                                                                               tire_c = Fr_tire.VERTICAL_STIFFNESS,
                                                                                               tire_d = Fr_tire.VERTICAL_DAMPING,
                                                                                               FNOMIN = Fr_tire.FNOMIN,
                                                                                               PCX1 = Fr_tire.PCX1, PDX1 = Fr_tire.PDX1, PDX2 = Fr_tire.PDX2,
                                                                                               PDX3 = Fr_tire.PDX3, PEX1 = Fr_tire.PEX1, PEX2 = Fr_tire.PEX2,
                                                                                               PEX3 = Fr_tire.PEX3, PEX4 = Fr_tire.PEX4, PKX1 = Fr_tire.PKX1,
                                                                                               PKX2 = Fr_tire.PKX2, PKX3 = Fr_tire.PKX3, PHX1 = Fr_tire.PHX1,
                                                                                               PHX2 = Fr_tire.PHX2, PVX1 = Fr_tire.PVX1, PVX2 = Fr_tire.PVX2,
                                                                                               RBX1 = Fr_tire.RBX1, RBX2 = Fr_tire.RBX2, RCX1 = Fr_tire.RCX1,
                                                                                               REX1 = Fr_tire.REX1, REX2 = Fr_tire.REX2, RHX1 = Fr_tire.RHX1,
                                                                                               PCY1 = Fr_tire.PCY1, PDY1 = Fr_tire.PDY1, PDY2 = Fr_tire.PDY2,
                                                                                               PDY3 = Fr_tire.PDY3, PEY1 = Fr_tire.PEY1, PEY2 = Fr_tire.PEY2,
                                                                                               PEY3 = Fr_tire.PEY3, PEY4 = Fr_tire.PEY4, PKY1 = Fr_tire.PKY1,
                                                                                               PKY2 = Fr_tire.PKY2, PKY3 = Fr_tire.PKY3, PHY1 = Fr_tire.PHY1,
                                                                                               PHY2 = Fr_tire.PHY2, PHY3 = Fr_tire.PHY3, PVY1 = Fr_tire.PVY1,
                                                                                               PVY2 = Fr_tire.PVY2, PVY3 = Fr_tire.PVY3, PVY4 = Fr_tire.PVY4,
                                                                                               RBY1 = Fr_tire.RBY1, RBY2 = Fr_tire.RBY2, RBY3 = Fr_tire.RBY3,
                                                                                               RCY1 = Fr_tire.RCY1, REY1 = Fr_tire.REY1, REY2 = Fr_tire.REY2,
                                                                                               RHY1 = Fr_tire.RHY1, RHY2 = Fr_tire.RHY2, RVY1 = Fr_tire.RVY1,
                                                                                               RVY2 = Fr_tire.RVY2, RVY3 = Fr_tire.RVY3, RVY4 = Fr_tire.RVY4,
                                                                                               RVY5 = Fr_tire.RVY4, RVY6 = Fr_tire.RVY6, QSX1 = Fr_tire.QSX1,
                                                                                               QSX2 = Fr_tire.QSX2, QSX3 = Fr_tire.QSX3, QSY1 = Fr_tire.QSY1,
                                                                                               QSY2 = Fr_tire.QSY2, QSY3 = Fr_tire.QSY3, QSY4 = Fr_tire.QSY4,
                                                                                               QBZ1 = Fr_tire.QBZ1, QBZ2 = Fr_tire.QBZ2, QBZ3 = Fr_tire.QBZ3,
                                                                                               QBZ4 = Fr_tire.QBZ4, QBZ5 = Fr_tire.QBZ5, QBZ9 = Fr_tire.QBZ9,
                                                                                               QBZ10 = Fr_tire.QBZ10, QCZ1 = Fr_tire.QCZ1, QDZ1 = Fr_tire.QDZ1,
                                                                                               QDZ2 = Fr_tire.QDZ2, QDZ3 = Fr_tire.QDZ3, QDZ4 = Fr_tire.QDZ4,
                                                                                               QDZ6 = Fr_tire.QDZ6, QDZ7 = Fr_tire.QDZ7, QDZ8 = Fr_tire.QDZ8,
                                                                                               QDZ9 = Fr_tire.QDZ9, QEZ1 = Fr_tire.QEZ1, QEZ2 = Fr_tire.QEZ2,
                                                                                               QEZ3 = Fr_tire.QEZ3, QEZ4 = Fr_tire.QEZ4, QEZ5 = Fr_tire.QEZ5,
                                                                                               QHZ1 = Fr_tire.QHZ1, QHZ2 = Fr_tire.QHZ2, QHZ3 = Fr_tire.QHZ3,
                                                                                               QHZ4 = Fr_tire.QHZ4, SSZ1 = Fr_tire.SSZ1, SSZ2 = Fr_tire.SSZ2,
                                                                                               SSZ3 = Fr_tire.SSZ3, SSZ4 = Fr_tire.SSZ4, LFZO = Fr_tire.LFZO,
                                                                                               LCX = Fr_tire.LCX, LMUX = Fr_tire.LMUX, LEX = Fr_tire.LEX,
                                                                                               LKX = Fr_tire.LKX, LHX = Fr_tire.LHX, LVX = Fr_tire.LVX,
                                                                                               LXAL = Fr_tire.LXAL, LGAX = Fr_tire.LGAX, LCY = Fr_tire.LCY,
                                                                                               LMUY = Fr_tire.LMUY, LEY = Fr_tire.LEY, LKY = Fr_tire.LKY,
                                                                                               LHY = Fr_tire.LHY, LVY = Fr_tire.LVY, LGAY = Fr_tire.LGAY,
                                                                                               LKYG = Fr_tire.LKYG, LTR = Fr_tire.LTR, LRES = Fr_tire.LRES,
                                                                                               LCZ = Fr_tire.LCZ, LGAZ = Fr_tire.LGAZ, LYKA = Fr_tire.LYKA,
                                                                                               LVYKA = Fr_tire.LVYKA, LS = Fr_tire.LS, LSGKP = Fr_tire.LSGKP,
                                                                                               LSGAL = Fr_tire.LSGAL, LGYR = Fr_tire.LGYR, LMX = Fr_tire.LMX,
                                                                                               LVMX = Fr_tire.LVMX, LMY = Fr_tire.LMY, LIP = Fr_tire.LIP));

  parameter SIunits.Position FL_bellcrank_pivot[3] = FrAxleBC.bellcrank_pivot annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position FL_bellcrank_pivot_ref[3] = FrAxleBC.bellcrank_pivot_ref annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position FL_bellcrank_pickup_1[3] = FrAxleBC.bellcrank_pickup_1 annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position FL_bellcrank_pickup_2[3] = FrAxleBC.bellcrank_pickup_2 annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position FL_bellcrank_pickup_3[3] = FrAxleBC.bellcrank_pickup_3 annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position FL_LCA_mount[3] = FrAxleBC.rod_mount annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position FL_shock_mount[3] = FrAxleBC.shock_mount annotation(
    Dialog(group = "Geometry"));
  // FL apex geometry
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation FL_apex(r = FL_LCA_mount - Axle.lower_outboard) annotation(
    Placement(transformation(origin = {-110, -10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  // FL pushrod
  final Modelica.Mechanics.MultiBody.Joints.SphericalSpherical FL_pushrod(rodLength = norm(FL_bellcrank_pickup_2 - FL_LCA_mount),
                                                                          sphereDiameter = joint_diameter,
                                                                          rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}})));
  // FL bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation FL_bellcrank_mount(r = FL_bellcrank_pivot - effective_center) annotation(
    Placement(transformation(origin = {-30, 40}, extent = {{10, -10}, {-10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.Bellcrank3pu1p left_bellcrank(pickup_1 = left_bellcrank_pickup_1,
                                                                                    pickup_2 = left_bellcrank_pickup_2,
                                                                                    pickup_3 = left_bellcrank_pickup_3,
                                                                                    pivot = left_bellcrank_pivot,
                                                                                    pivot_ref = left_bellcrank_pivot_ref) annotation(
    Placement(transformation(origin = {-60, 40}, extent = {{10, -10}, {-10, 10}})));
  // FL shock
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation FL_shock_pickup(r = FL_shock_mount - effective_center) annotation(
    Placement(transformation(origin = {-20, 70}, extent = {{10, -10}, {-10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularSpring FL_tabular_spring(spring_table = FrAxle.spring_table,
                                                                                        free_length = FrAxle.free_length,
                                                                                        spring_diameter = 0.050) annotation(
    Placement(transformation(origin = {-50, 70}, extent = {{10, -10}, {-10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularDamper FL_tabular_damper(damper_table = FrAxle.damper_table,
                                                                                        inner_diameter = 0.004,
                                                                                        outer_diameter = 0.008)  annotation(
    Placement(transformation(origin = {-50, 130}, extent = {{10, -10}, {-10, 10}})));
  // FR apex geometry
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation FR_apex(r = {FL_LCA_mount[1], -FL_LCA_mount[2], FL_LCA_mount[3]} - {Axle.lower_outboard[1], -Axle.lower_outboard[2], Axle.lower_outboard[3]}) annotation(
    Placement(transformation(origin = {110, -10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));

// FR pushrod
  final Modelica.Mechanics.MultiBody.Joints.SphericalSpherical FR_pushrod(rodLength = norm(FL_bellcrank_pickup_2 - FL_LCA_mount),
                                                                          sphereDiameter = joint_diameter,
                                                                          rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {90, 40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));

// FR bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation FR_bellcrank_mount(r = {FL_bellcrank_pivot[1], -FL_bellcrank_pivot[2], FL_bellcrank_pivot[3]} - effective_center) annotation(
    Placement(transformation(origin = {30, 40}, extent = {{-10, -10}, {10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.Bellcrank3pu1p right_bellcrank(pickup_1 = {left_bellcrank_pickup_1[1], -left_bellcrank_pickup_1[2], left_bellcrank_pickup_1[3]},
                                                                                    pickup_2 = {left_bellcrank_pickup_2[1], -left_bellcrank_pickup_2[2], left_bellcrank_pickup_2[3]},
                                                                                    pickup_3 = {left_bellcrank_pickup_3[1], -left_bellcrank_pickup_3[2], left_bellcrank_pickup_3[3]},
                                                                                    pivot = {left_bellcrank_pivot[1], -left_bellcrank_pivot[2], left_bellcrank_pivot[3]},
                                                                                    pivot_ref = {left_bellcrank_pivot_ref[1], -left_bellcrank_pivot_ref[2], left_bellcrank_pivot_ref[3]}) annotation(
    Placement(transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}})));
  // FR shock
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation FR_shock_pickup(r = {FL_shock_mount[1], -FL_shock_mount[2], FL_shock_mount[3]} - effective_center) annotation(
    Placement(transformation(origin = {20, 70}, extent = {{-10, -10}, {10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularSpring FR_tabular_spring(spring_table = FrAxle.spring_table,
                                                                                        free_length = FrAxle.free_length,
                                                                                        spring_diameter = 0.050)  annotation(
    Placement(transformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularDamper FR_tabular_damper(damper_table = FrAxle.damper_table,
                                                                                        inner_diameter = 0.004,
                                                                                        outer_diameter = 0.008) annotation(
    Placement(transformation(origin = {50, 130}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  // Fr Stabar
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation stabar_frame(r = {FrAxleBC.left_bar_end[1], 0, FrAxleBC.left_bar_end[3]} - effective_center) annotation(
    Placement(transformation(origin = {-20, -10}, extent = {{10, -10}, {-10, 10}})));
//  final BobDyn.Vehicle.Chassis.Suspension.Linkages.Stabar stabar(left_bar_end = FrAxleBC.left_bar_end,
//                                                                      left_arm_end = FrAxleBC.left_arm_end,
//                                                                      left_droplink_end = FrAxleBC.bellcrank_pickup_1,
//                                                                      bar_rate = FrAxleBC.bar_rate,
//                                                                      joint_diameter = joint_diameter * 0.75,
//                                                                      link_diameter = link_diameter / 2)  annotation(
//    Placement(transformation(origin = {-40, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));  

// Steering interface
  Modelica.Blocks.Interfaces.RealInput steer_input annotation(
    Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation=-90)));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.Stabar stabar(bar_rate = FrAxleBC.bar_rate, joint_diameter = joint_diameter*0.5, left_arm_end = FrAxleBC.left_arm_end, left_bar_end = FrAxleBC.left_bar_end, left_droplink_end = FrAxleBC.bellcrank_pickup_1, link_diameter = link_diameter*0.5) annotation(
    Placement(transformation(origin = {-40, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
equation
  connect(left_apex.frame_a, left_double_wishbone.lower_wishbone_frame) annotation(
    Line(points = {{-110, -20}, {-110, -90}, {-70, -90}, {-70, -80}}, color = {95, 95, 95}));
  connect(left_apex.frame_b, left_pushrod.frame_a) annotation(
    Line(points = {{-110, 0}, {-110, 40}, {-100, 40}}, color = {95, 95, 95}));
  connect(left_pushrod.frame_b, left_bellcrank.pickup_2_frame) annotation(
    Line(points = {{-80, 40}, {-70, 40}}, color = {95, 95, 95}));
  connect(left_bellcrank.pickup_3_frame, left_tabular_spring.frame_b) annotation(
    Line(points = {{-60, 50}, {-60, 70}}, color = {95, 95, 95}));
  connect(left_tabular_spring.frame_a, left_shock_pickup.frame_b) annotation(
    Line(points = {{-40, 70}, {-30, 70}}, color = {95, 95, 95}));
  connect(left_bellcrank.mount_frame, left_bellcrank_mount.frame_b) annotation(
    Line(points = {{-50, 40}, {-40, 40}}, color = {95, 95, 95}));
  connect(left_shock_pickup.frame_a, axle_frame) annotation(
    Line(points = {{-10, 70}, {0, 70}, {0, -100}}, color = {95, 95, 95}));
  connect(left_bellcrank_mount.frame_a, axle_frame) annotation(
    Line(points = {{-20, 40}, {0, 40}, {0, -100}}, color = {95, 95, 95}));
  connect(right_apex.frame_a, right_double_wishbone.lower_wishbone_frame) annotation(
    Line(points = {{110, -20}, {110, -90}, {70, -90}, {70, -80}}, color = {95, 95, 95}));
  connect(right_apex.frame_b, right_pushrod.frame_a) annotation(
    Line(points = {{110, 0}, {110, 40}, {100, 40}}, color = {95, 95, 95}));
  connect(right_pushrod.frame_b, right_bellcrank.pickup_2_frame) annotation(
    Line(points = {{80, 40}, {70, 40}}, color = {95, 95, 95}));
  connect(right_bellcrank.pickup_3_frame, right_tabular_spring.frame_b) annotation(
    Line(points = {{60, 50}, {60, 70}}, color = {95, 95, 95}));
  connect(right_tabular_spring.frame_a, right_shock_pickup.frame_b) annotation(
    Line(points = {{40, 70}, {30, 70}}, color = {95, 95, 95}));
  connect(right_bellcrank.mount_frame, right_bellcrank_mount.frame_b) annotation(
    Line(points = {{50, 40}, {40, 40}}, color = {95, 95, 95}));
  connect(right_shock_pickup.frame_a, axle_frame) annotation(
    Line(points = {{10, 70}, {0, 70}, {0, -100}}, color = {95, 95, 95}));
  connect(right_bellcrank_mount.frame_a, axle_frame) annotation(
    Line(points = {{20, 40}, {0, 40}, {0, -100}}, color = {95, 95, 95}));
  connect(left_tabular_damper.frame_b, left_tabular_spring.frame_b) annotation(
    Line(points = {{-60, 130}, {-60, 70}}, color = {95, 95, 95}));
  connect(left_tabular_damper.frame_a, left_tabular_spring.frame_a) annotation(
    Line(points = {{-40, 130}, {-40, 70}}, color = {95, 95, 95}));
  connect(right_tabular_damper.frame_a, right_tabular_spring.frame_a) annotation(
    Line(points = {{40, 130}, {40, 70}}, color = {95, 95, 95}));
  connect(right_tabular_damper.frame_b, right_tabular_spring.frame_b) annotation(
    Line(points = {{60, 130}, {60, 70}}, color = {95, 95, 95}));
  connect(left_double_wishbone.steer_input, steer_input) annotation(
    Line(points = {{-90, -14}, {-90, 90}, {0, 90}, {0, 120}}, color = {0, 0, 127}));
  connect(right_double_wishbone.steer_input, steer_input) annotation(
    Line(points = {{90, -14}, {90, 90}, {0, 90}, {0, 120}}, color = {0, 0, 127}));
  connect(stabar_frame.frame_a, axle_frame) annotation(
    Line(points = {{-10, -10}, {0, -10}, {0, -100}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end FrAxleDWPushBCARB;
