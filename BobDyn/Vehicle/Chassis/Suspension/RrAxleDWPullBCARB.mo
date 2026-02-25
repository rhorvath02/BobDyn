within BobDyn.Vehicle.Chassis.Suspension;

model RrAxleDWPullBCARB
  import Modelica.Math.Vectors.norm;
  import Modelica.SIunits;
  
  final parameter BobDyn.Resources.Records.SUS.RrAxleDW RrAxle;
  final parameter BobDyn.Resources.Records.SUS.RrAxleDWPullBCARB RrAxleBC;
  
  final parameter BobDyn.Resources.Records.MASSPROPS.RrUnsprung unsprung_mass;
  final parameter BobDyn.Resources.Records.MASSPROPS.RrUCA uca_mass;
  final parameter BobDyn.Resources.Records.MASSPROPS.RrLCA lca_mass;
  final parameter BobDyn.Resources.Records.MASSPROPS.RrTie tie_mass;
  
  final parameter BobDyn.Resources.Records.TIRES.Rr_tire Rr_tire;

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
                                                                                  final left_tire(rim_width = Rr_tire.RIM_WIDTH,
                                                                                                  rim_R0 = Rr_tire.RIM_RADIUS,
                                                                                                  wheel_J = Rr_tire.INERTIA,
                                                                                                  R0 = Rr_tire.UNLOADED_RADIUS,
                                                                                                  tire_c = Rr_tire.VERTICAL_STIFFNESS,
                                                                                                  tire_d = Rr_tire.VERTICAL_DAMPING,
                                                                                                  FNOMIN = Rr_tire.FNOMIN,
                                                                                                  PCX1 = Rr_tire.PCX1, PDX1 = Rr_tire.PDX1, PDX2 = Rr_tire.PDX2,
                                                                                                  PDX3 = Rr_tire.PDX3, PEX1 = Rr_tire.PEX1, PEX2 = Rr_tire.PEX2,
                                                                                                  PEX3 = Rr_tire.PEX3, PEX4 = Rr_tire.PEX4, PKX1 = Rr_tire.PKX1,
                                                                                                  PKX2 = Rr_tire.PKX2, PKX3 = Rr_tire.PKX3, PHX1 = Rr_tire.PHX1,
                                                                                                  PHX2 = Rr_tire.PHX2, PVX1 = Rr_tire.PVX1, PVX2 = Rr_tire.PVX2,
                                                                                                  RBX1 = Rr_tire.RBX1, RBX2 = Rr_tire.RBX2, RCX1 = Rr_tire.RCX1,
                                                                                                  REX1 = Rr_tire.REX1, REX2 = Rr_tire.REX2, RHX1 = Rr_tire.RHX1,
                                                                                                  PCY1 = Rr_tire.PCY1, PDY1 = Rr_tire.PDY1, PDY2 = Rr_tire.PDY2,
                                                                                                  PDY3 = Rr_tire.PDY3, PEY1 = Rr_tire.PEY1, PEY2 = Rr_tire.PEY2,
                                                                                                  PEY3 = Rr_tire.PEY3, PEY4 = Rr_tire.PEY4, PKY1 = Rr_tire.PKY1,
                                                                                                  PKY2 = Rr_tire.PKY2, PKY3 = Rr_tire.PKY3, PHY1 = Rr_tire.PHY1,
                                                                                                  PHY2 = Rr_tire.PHY2, PHY3 = Rr_tire.PHY3, PVY1 = Rr_tire.PVY1,
                                                                                                  PVY2 = Rr_tire.PVY2, PVY3 = Rr_tire.PVY3, PVY4 = Rr_tire.PVY4,
                                                                                                  RBY1 = Rr_tire.RBY1, RBY2 = Rr_tire.RBY2, RBY3 = Rr_tire.RBY3,
                                                                                                  RCY1 = Rr_tire.RCY1, REY1 = Rr_tire.REY1, REY2 = Rr_tire.REY2,
                                                                                                  RHY1 = Rr_tire.RHY1, RHY2 = Rr_tire.RHY2, RVY1 = Rr_tire.RVY1,
                                                                                                  RVY2 = Rr_tire.RVY2, RVY3 = Rr_tire.RVY3, RVY4 = Rr_tire.RVY4,
                                                                                                  RVY5 = Rr_tire.RVY4, RVY6 = Rr_tire.RVY6, QSX1 = Rr_tire.QSX1,
                                                                                                  QSX2 = Rr_tire.QSX2, QSX3 = Rr_tire.QSX3, QSY1 = Rr_tire.QSY1,
                                                                                                  QSY2 = Rr_tire.QSY2, QSY3 = Rr_tire.QSY3, QSY4 = Rr_tire.QSY4,
                                                                                                  QBZ1 = Rr_tire.QBZ1, QBZ2 = Rr_tire.QBZ2, QBZ3 = Rr_tire.QBZ3,
                                                                                                  QBZ4 = Rr_tire.QBZ4, QBZ5 = Rr_tire.QBZ5, QBZ9 = Rr_tire.QBZ9,
                                                                                                  QBZ10 = Rr_tire.QBZ10, QCZ1 = Rr_tire.QCZ1, QDZ1 = Rr_tire.QDZ1,
                                                                                                  QDZ2 = Rr_tire.QDZ2, QDZ3 = Rr_tire.QDZ3, QDZ4 = Rr_tire.QDZ4,
                                                                                                  QDZ6 = Rr_tire.QDZ6, QDZ7 = Rr_tire.QDZ7, QDZ8 = Rr_tire.QDZ8,
                                                                                                  QDZ9 = Rr_tire.QDZ9, QEZ1 = Rr_tire.QEZ1, QEZ2 = Rr_tire.QEZ2,
                                                                                                  QEZ3 = Rr_tire.QEZ3, QEZ4 = Rr_tire.QEZ4, QEZ5 = Rr_tire.QEZ5,
                                                                                                  QHZ1 = Rr_tire.QHZ1, QHZ2 = Rr_tire.QHZ2, QHZ3 = Rr_tire.QHZ3,
                                                                                                  QHZ4 = Rr_tire.QHZ4, SSZ1 = Rr_tire.SSZ1, SSZ2 = Rr_tire.SSZ2,
                                                                                                  SSZ3 = Rr_tire.SSZ3, SSZ4 = Rr_tire.SSZ4, LFZO = Rr_tire.LFZO,
                                                                                                  LCX = Rr_tire.LCX, LMUX = Rr_tire.LMUX, LEX = Rr_tire.LEX,
                                                                                                  LKX = Rr_tire.LKX, LHX = Rr_tire.LHX, LVX = Rr_tire.LVX,
                                                                                                  LXAL = Rr_tire.LXAL, LGAX = Rr_tire.LGAX, LCY = Rr_tire.LCY,
                                                                                                  LMUY = Rr_tire.LMUY, LEY = Rr_tire.LEY, LKY = Rr_tire.LKY,
                                                                                                  LHY = Rr_tire.LHY, LVY = Rr_tire.LVY, LGAY = Rr_tire.LGAY,
                                                                                                  LKYG = Rr_tire.LKYG, LTR = Rr_tire.LTR, LRES = Rr_tire.LRES,
                                                                                                  LCZ = Rr_tire.LCZ, LGAZ = Rr_tire.LGAZ, LYKA = Rr_tire.LYKA,
                                                                                                  LVYKA = Rr_tire.LVYKA, LS = Rr_tire.LS, LSGKP = Rr_tire.LSGKP,
                                                                                                  LSGAL = Rr_tire.LSGAL, LGYR = Rr_tire.LGYR, LMX = Rr_tire.LMX,
                                                                                                  LVMX = Rr_tire.LVMX, LMY = Rr_tire.LMY, LIP = Rr_tire.LIP),
                                                                                  final right_tire(rim_width = Rr_tire.RIM_WIDTH,
                                                                                                   rim_R0 = Rr_tire.RIM_RADIUS,
                                                                                                   wheel_J = Rr_tire.INERTIA,
                                                                                                   R0 = Rr_tire.UNLOADED_RADIUS,
                                                                                                   tire_c = Rr_tire.VERTICAL_STIFFNESS,
                                                                                                   tire_d = Rr_tire.VERTICAL_DAMPING,
                                                                                                   FNOMIN = Rr_tire.FNOMIN,
                                                                                                   PCX1 = Rr_tire.PCX1, PDX1 = Rr_tire.PDX1, PDX2 = Rr_tire.PDX2,
                                                                                                   PDX3 = Rr_tire.PDX3, PEX1 = Rr_tire.PEX1, PEX2 = Rr_tire.PEX2,
                                                                                                   PEX3 = Rr_tire.PEX3, PEX4 = Rr_tire.PEX4, PKX1 = Rr_tire.PKX1,
                                                                                                   PKX2 = Rr_tire.PKX2, PKX3 = Rr_tire.PKX3, PHX1 = Rr_tire.PHX1,
                                                                                                   PHX2 = Rr_tire.PHX2, PVX1 = Rr_tire.PVX1, PVX2 = Rr_tire.PVX2,
                                                                                                   RBX1 = Rr_tire.RBX1, RBX2 = Rr_tire.RBX2, RCX1 = Rr_tire.RCX1,
                                                                                                   REX1 = Rr_tire.REX1, REX2 = Rr_tire.REX2, RHX1 = Rr_tire.RHX1,
                                                                                                   PCY1 = Rr_tire.PCY1, PDY1 = Rr_tire.PDY1, PDY2 = Rr_tire.PDY2,
                                                                                                   PDY3 = Rr_tire.PDY3, PEY1 = Rr_tire.PEY1, PEY2 = Rr_tire.PEY2,
                                                                                                   PEY3 = Rr_tire.PEY3, PEY4 = Rr_tire.PEY4, PKY1 = Rr_tire.PKY1,
                                                                                                   PKY2 = Rr_tire.PKY2, PKY3 = Rr_tire.PKY3, PHY1 = Rr_tire.PHY1,
                                                                                                   PHY2 = Rr_tire.PHY2, PHY3 = Rr_tire.PHY3, PVY1 = Rr_tire.PVY1,
                                                                                                   PVY2 = Rr_tire.PVY2, PVY3 = Rr_tire.PVY3, PVY4 = Rr_tire.PVY4,
                                                                                                   RBY1 = Rr_tire.RBY1, RBY2 = Rr_tire.RBY2, RBY3 = Rr_tire.RBY3,
                                                                                                   RCY1 = Rr_tire.RCY1, REY1 = Rr_tire.REY1, REY2 = Rr_tire.REY2,
                                                                                                   RHY1 = Rr_tire.RHY1, RHY2 = Rr_tire.RHY2, RVY1 = Rr_tire.RVY1,
                                                                                                   RVY2 = Rr_tire.RVY2, RVY3 = Rr_tire.RVY3, RVY4 = Rr_tire.RVY4,
                                                                                                   RVY5 = Rr_tire.RVY4, RVY6 = Rr_tire.RVY6, QSX1 = Rr_tire.QSX1,
                                                                                                   QSX2 = Rr_tire.QSX2, QSX3 = Rr_tire.QSX3, QSY1 = Rr_tire.QSY1,
                                                                                                   QSY2 = Rr_tire.QSY2, QSY3 = Rr_tire.QSY3, QSY4 = Rr_tire.QSY4,
                                                                                                   QBZ1 = Rr_tire.QBZ1, QBZ2 = Rr_tire.QBZ2, QBZ3 = Rr_tire.QBZ3,
                                                                                                   QBZ4 = Rr_tire.QBZ4, QBZ5 = Rr_tire.QBZ5, QBZ9 = Rr_tire.QBZ9,
                                                                                                   QBZ10 = Rr_tire.QBZ10, QCZ1 = Rr_tire.QCZ1, QDZ1 = Rr_tire.QDZ1,
                                                                                                   QDZ2 = Rr_tire.QDZ2, QDZ3 = Rr_tire.QDZ3, QDZ4 = Rr_tire.QDZ4,
                                                                                                   QDZ6 = Rr_tire.QDZ6, QDZ7 = Rr_tire.QDZ7, QDZ8 = Rr_tire.QDZ8,
                                                                                                   QDZ9 = Rr_tire.QDZ9, QEZ1 = Rr_tire.QEZ1, QEZ2 = Rr_tire.QEZ2,
                                                                                                   QEZ3 = Rr_tire.QEZ3, QEZ4 = Rr_tire.QEZ4, QEZ5 = Rr_tire.QEZ5,
                                                                                                   QHZ1 = Rr_tire.QHZ1, QHZ2 = Rr_tire.QHZ2, QHZ3 = Rr_tire.QHZ3,
                                                                                                   QHZ4 = Rr_tire.QHZ4, SSZ1 = Rr_tire.SSZ1, SSZ2 = Rr_tire.SSZ2,
                                                                                                   SSZ3 = Rr_tire.SSZ3, SSZ4 = Rr_tire.SSZ4, LFZO = Rr_tire.LFZO,
                                                                                                   LCX = Rr_tire.LCX, LMUX = Rr_tire.LMUX, LEX = Rr_tire.LEX,
                                                                                                   LKX = Rr_tire.LKX, LHX = Rr_tire.LHX, LVX = Rr_tire.LVX,
                                                                                                   LXAL = Rr_tire.LXAL, LGAX = Rr_tire.LGAX, LCY = Rr_tire.LCY,
                                                                                                   LMUY = Rr_tire.LMUY, LEY = Rr_tire.LEY, LKY = Rr_tire.LKY,
                                                                                                   LHY = Rr_tire.LHY, LVY = Rr_tire.LVY, LGAY = Rr_tire.LGAY,
                                                                                                   LKYG = Rr_tire.LKYG, LTR = Rr_tire.LTR, LRES = Rr_tire.LRES,
                                                                                                   LCZ = Rr_tire.LCZ, LGAZ = Rr_tire.LGAZ, LYKA = Rr_tire.LYKA,
                                                                                                   LVYKA = Rr_tire.LVYKA, LS = Rr_tire.LS, LSGKP = Rr_tire.LSGKP,
                                                                                                   LSGAL = Rr_tire.LSGAL, LGYR = Rr_tire.LGYR, LMX = Rr_tire.LMX,
                                                                                                   LVMX = Rr_tire.LVMX, LMY = Rr_tire.LMY, LIP = Rr_tire.LIP));
  
  final parameter SIunits.Position RL_bellcrank_pivot[3] = RrAxleBC.bellcrank_pivot annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position RL_bellcrank_pivot_ref[3] = RrAxleBC.bellcrank_pivot_ref annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position RL_bellcrank_pickup_1[3] = RrAxleBC.bellcrank_pickup_1 annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position RL_bellcrank_pickup_2[3] = RrAxleBC.bellcrank_pickup_2 annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position RL_bellcrank_pickup_3[3] = RrAxleBC.bellcrank_pickup_3 annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position RL_UCA_mount[3] = RrAxleBC.rod_mount annotation(
    Dialog(group = "Geometry"));
  final parameter SIunits.Position RL_shock_mount[3] = RrAxleBC.shock_mount annotation(
    Dialog(group = "Geometry"));
  // RL apex geometry
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation RL_apex(r = RL_UCA_mount - left_upper_o) annotation(
    Placement(transformation(origin = {-110, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  // RL pushrod
  final Modelica.Mechanics.MultiBody.Joints.SphericalSpherical RL_pushrod(rodLength = norm(RL_bellcrank_pickup_1 - RL_UCA_mount),
                                                                          sphereDiameter = joint_diameter,
                                                                          rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  // RL bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation RL_bellcrank_mount(r = RL_bellcrank_pivot - effective_center) annotation(
    Placement(transformation(origin = {-30, 40}, extent = {{10, -10}, {-10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.Bellcrank3pu1p RL_bellcrank(pickup_1 = RL_bellcrank_pickup_1,
                                                                                        pickup_2 = RL_bellcrank_pickup_2,
                                                                                        pickup_3 = RL_bellcrank_pickup_3,
                                                                                        pivot = RL_bellcrank_pivot,
                                                                                        pivot_ref = RL_bellcrank_pivot_ref) annotation(
    Placement(transformation(origin = {-60, 40}, extent = {{10, -10}, {-10, 10}})));
  // RL shock
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation RL_shock_pickup(r = RL_shock_mount - effective_center) annotation(
    Placement(transformation(origin = {-20, 70}, extent = {{10, -10}, {-10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularSpring RL_tabular_spring(spring_table = RrAxle.spring_table,
                                                                                            free_length = RrAxle.free_length,
                                                                                            spring_diameter = 0.050) annotation(
    Placement(transformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}})));
  
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularDamper RL_tabular_damper(damper_table = [0, 0; 1, 1e3],
                                                                                    inner_diameter = 0.004,
                                                                                    outer_diameter = 0.008) annotation(
    Placement(transformation(origin = {-50, 130}, extent = {{10, -10}, {-10, 10}})));
  // RR apex geometry
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation RR_apex(r = {RL_UCA_mount[1], -RL_UCA_mount[2], RL_UCA_mount[3]} - right_upper_o) annotation(
    Placement(transformation(origin = {110, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  // RR pushrod
  final Modelica.Mechanics.MultiBody.Joints.SphericalSpherical RR_pushrod(rodLength = norm(RL_bellcrank_pickup_1 - RL_UCA_mount),
                                                                          sphereDiameter = joint_diameter,
                                                                          rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {90, 30}, extent = {{10, -10}, {-10, 10}})));
  // RR bellcrank
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation RR_bellcrank_mount(r = {RL_bellcrank_pivot[1], -RL_bellcrank_pivot[2], RL_bellcrank_pivot[3]} - effective_center) annotation(
    Placement(transformation(origin = {30, 40}, extent = {{-10, -10}, {10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.Bellcrank3pu1p RR_bellcrank(pickup_1 = {RL_bellcrank_pickup_1[1], -RL_bellcrank_pickup_1[2], RL_bellcrank_pickup_1[3]},
                                                                                    pickup_2 = {RL_bellcrank_pickup_2[1], -RL_bellcrank_pickup_2[2], RL_bellcrank_pickup_2[3]},
                                                                                    pickup_3 = {RL_bellcrank_pickup_3[1], -RL_bellcrank_pickup_3[2], RL_bellcrank_pickup_3[3]},
                                                                                    pivot = {RL_bellcrank_pivot[1], -RL_bellcrank_pivot[2], RL_bellcrank_pivot[3]},
                                                                                    pivot_ref = {RL_bellcrank_pivot_ref[1], -RL_bellcrank_pivot_ref[2], RL_bellcrank_pivot_ref[3]}) annotation(
    Placement(transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}})));
  // RR shock
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation RR_shock_pickup(r = {RL_shock_mount[1], -RL_shock_mount[2], RL_shock_mount[3]} - effective_center) annotation(
    Placement(transformation(origin = {20, 70}, extent = {{-10, -10}, {10, 10}})));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularSpring RR_tabular_spring(spring_table = RrAxle.spring_table,
                                                                                        free_length = RrAxle.free_length,
                                                                                        spring_diameter = 0.050) annotation(
    Placement(transformation(origin = {-50, 70}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  final BobDyn.Vehicle.Chassis.Suspension.Linkages.TabularDamper RR_tabular_damper(damper_table = RrAxle.damper_table,
                                                                                        inner_diameter = 0.004,
                                                                                        outer_diameter = 0.008) annotation(
    Placement(transformation(origin = {50, 130}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  // Rr Stabar
  final Modelica.Mechanics.MultiBody.Parts.FixedTranslation stabar_frame(r = {RrAxleBC.left_bar_end[1], 0, RrAxleBC.left_bar_end[3]} - effective_center) annotation(
    Placement(transformation(origin = {-20, -10}, extent = {{10, -10}, {-10, 10}})));
  // Zero steer (for typical rear axle)
  final Modelica.Blocks.Sources.RealExpression zero_steer annotation(
    Placement(transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(RL_apex.frame_b, RL_pushrod.frame_a) annotation(
    Line(points = {{-110, 20}, {-110, 30}, {-100, 30}}, color = {95, 95, 95}));
  connect(RR_tabular_spring.frame_a, RL_shock_pickup.frame_b) annotation(
    Line(points = {{-40, 70}, {-30, 70}}, color = {95, 95, 95}));
  connect(RL_bellcrank.mount_frame, RL_bellcrank_mount.frame_b) annotation(
    Line(points = {{-50, 40}, {-40, 40}}, color = {95, 95, 95}));
  connect(RL_shock_pickup.frame_a, axle_frame) annotation(
    Line(points = {{-10, 70}, {0, 70}, {0, -100}}, color = {95, 95, 95}));
  connect(RL_bellcrank_mount.frame_a, axle_frame) annotation(
    Line(points = {{-20, 40}, {0, 40}, {0, -100}}, color = {95, 95, 95}));
  connect(RR_apex.frame_b, RR_pushrod.frame_a) annotation(
    Line(points = {{110, 20}, {110, 30}, {100, 30}}, color = {95, 95, 95}));
  connect(RL_tabular_spring.frame_a, RR_shock_pickup.frame_b) annotation(
    Line(points = {{40, 70}, {30, 70}}, color = {95, 95, 95}));
  connect(RR_bellcrank.mount_frame, RR_bellcrank_mount.frame_b) annotation(
    Line(points = {{50, 40}, {40, 40}}, color = {95, 95, 95}));
  connect(RR_shock_pickup.frame_a, axle_frame) annotation(
    Line(points = {{10, 70}, {0, 70}, {0, -100}}, color = {95, 95, 95}));
  connect(RR_bellcrank_mount.frame_a, axle_frame) annotation(
    Line(points = {{20, 40}, {0, 40}, {0, -100}}, color = {95, 95, 95}));
  connect(RL_tabular_damper.frame_b, RR_tabular_spring.frame_b) annotation(
    Line(points = {{-60, 130}, {-60, 70}}, color = {95, 95, 95}));
  connect(RL_tabular_damper.frame_a, RR_tabular_spring.frame_a) annotation(
    Line(points = {{-40, 130}, {-40, 70}}, color = {95, 95, 95}));
  connect(RR_tabular_damper.frame_a, RL_tabular_spring.frame_a) annotation(
    Line(points = {{40, 130}, {40, 70}}, color = {95, 95, 95}));
  connect(RR_tabular_damper.frame_b, RL_tabular_spring.frame_b) annotation(
    Line(points = {{60, 130}, {60, 70}}, color = {95, 95, 95}));
  connect(zero_steer.y, left_double_wishbone.steer_input) annotation(
    Line(points = {{-90, 59}, {-90, -14}}, color = {0, 0, 127}));
  connect(zero_steer.y, right_double_wishbone.steer_input) annotation(
    Line(points = {{-90, 59}, {-90, 20}, {90, 20}, {90, -14}}, color = {0, 0, 127}));
  connect(RL_pushrod.frame_b, RL_bellcrank.pickup_1_frame) annotation(
    Line(points = {{-80, 30}, {-60, 30}}, color = {95, 95, 95}));
  connect(RR_tabular_spring.frame_b, RL_bellcrank.pickup_2_frame) annotation(
    Line(points = {{-60, 70}, {-70, 70}, {-70, 40}}, color = {95, 95, 95}));
  connect(RR_pushrod.frame_b, RR_bellcrank.pickup_1_frame) annotation(
    Line(points = {{80, 30}, {60, 30}}, color = {95, 95, 95}));
  connect(RL_apex.frame_a, left_double_wishbone.upper_wishbone_frame) annotation(
    Line(points = {{-110, 0}, {-70, 0}, {-70, -20}}, color = {95, 95, 95}));
  connect(RR_apex.frame_a, right_double_wishbone.upper_wishbone_frame) annotation(
    Line(points = {{110, 0}, {70, 0}, {70, -20}}, color = {95, 95, 95}));
  connect(RL_tabular_spring.frame_b, RR_bellcrank.pickup_2_frame) annotation(
    Line(points = {{60, 70}, {70, 70}, {70, 40}}, color = {95, 95, 95}));
  connect(stabar_frame.frame_a, axle_frame) annotation(
    Line(points = {{-10, -10}, {0, -10}, {0, -100}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end RrAxleDWPullBCARB;
