within BobLib.Vehicle.Chassis.Suspension;

model FrAxleDW
  // Modelica units
  import Modelica.SIunits;
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  
  // Custom linalg
  import BobLib.Utilities.Math.Vector;
  
  // Records
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.AxleDWRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Stabar.StabarRecord;
  
  // Load parameters
  parameter AxleDWRecord pAxle;
  parameter StabarRecord pStabar;
  
  extends BobLib.Vehicle.Chassis.Suspension.AxleDWBase;
  
  Modelica.Mechanics.Rotational.Interfaces.Flange_a pinionFlange annotation(
    Placement(transformation(origin = {0, 140}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  
  // Left pushrod  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftApex(r = pAxle.rodMount - pLeftDW.lower_o, width = link_diameter, height = link_diameter) annotation(
    Placement(transformation(origin = {-80, -10}, extent = {{0, 0}, {-20, 20}})));
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod leftPushrod(r_a = pAxle.bellcrankPickup2,
                                                              r_b = pAxle.rodMount,
                                                              n1_a = normalize(pAxle.bellcrankPivotAxis),
                                                              link_diameter = link_diameter,
                                                              joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-120, -20}, extent = {{20, -20}, {-20, 20}})));
  
  // Left bellcrank
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftBellcrank(r = pAxle.bellcrankPivot - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -20}, extent = {{10, -10}, {-10, 10}})));
  Linkages.Bellcrank3 left_bellcrank(pivot = pAxle.bellcrankPivot,
                                     pivot_axis = pAxle.bellcrankPivotAxis,
                                     pickup_1 = pAxle.bellcrankPickup1,
                                     pickup_2 = pAxle.bellcrankPickup2,
                                     pickup_3 = pAxle.bellcrankPickup3,
                                     link_diameter = link_diameter,
                                     joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  // Left shock
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftShock(r = pAxle.shockMount - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, -70}, extent = {{10, -10}, {-10, 10}})));
  Linkages.ShockLinkage leftShockLinkage(r_a = pAxle.bellcrankPickup3,
                                         r_b = pAxle.shockMount,
                                         s_0 = norm(pAxle.bellcrankPickup3 - pAxle.shockMount),
                                         spring_table = [0, 0; 1, 0],
                                         damper_table = [0, 0; 1, 0],
                                         n_a = pAxle.bellcrankPivotAxis,
                                         n_b = normalize(pAxle.bellcrankPivot - pAxle.bellcrankPickup3),
                                         link_diameter = link_diameter,
                                         joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-50, -55}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  
  // Right pushrod
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightApex(r = Vector.mirrorXZ(pAxle.rodMount - pLeftDW.lower_o), width = link_diameter, height = link_diameter) annotation(
    Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod rightPushrod(r_a = Vector.mirrorXZ(pAxle.bellcrankPickup2),
                                                               r_b = Vector.mirrorXZ(pAxle.rodMount),
                                                               n1_a = normalize(Vector.mirrorXZ(pAxle.bellcrankPivotAxis)),
                                                               link_diameter = link_diameter,
                                                               joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {120, -20}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  
  // Right bellcrank
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightBellcrank(r = Vector.mirrorXZ(pAxle.bellcrankPivot) - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -20}, extent = {{-10, -10}, {10, 10}})));
  Linkages.Bellcrank3 rightBellcrank(pivot_axis = Vector.mirrorXZ(pAxle.bellcrankPivotAxis),
                                      pivot = Vector.mirrorXZ(pAxle.bellcrankPivot),
                                      pickup_1 = Vector.mirrorXZ(pAxle.bellcrankPickup1),
                                      pickup_2 = Vector.mirrorXZ(pAxle.bellcrankPickup2),
                                      pickup_3 = Vector.mirrorXZ(pAxle.bellcrankPickup3),
                                      link_diameter = link_diameter,
                                      joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {50, -20}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
    
  // Right shock
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightShock(r = Vector.mirrorXZ(pAxle.shockMount) - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}})));
  Linkages.ShockLinkage rightShockLinkage(r_a = Vector.mirrorXZ(pAxle.bellcrankPickup3),
                                          r_b = Vector.mirrorXZ(pAxle.shockMount),
                                          n_a = Vector.mirrorXZ(pAxle.bellcrankPivotAxis),
                                          n_b = normalize(Vector.mirrorXZ(pAxle.bellcrankPivot - pAxle.bellcrankPickup3)),
                                          s_0 = norm(pAxle.bellcrankPickup3 - pAxle.shockMount),
                                          spring_table = [0, 0; 1, 0],
                                          damper_table = [0, 0; 1, 0],
                                          link_diameter = link_diameter,
                                          joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {50, -55}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  
  // Stabar
  Templates.Stabar.Stabar stabar(pStabar = pStabar, joint_diameter = joint_diameter, link_diameter = link_diameter) annotation(
    Placement(transformation(origin = {0, -116}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toStabar(r = {pStabar.leftBarEnd[1], 0, pStabar.leftBarEnd[3]} - effective_center, animation = false)  annotation(
    Placement(transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical rightDroplink(rodLength = norm(Vector.mirrorXZ(pAxle.bellcrankPickup1 - pStabar.leftArmEnd)), sphereDiameter = joint_diameter, rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical leftDroplink(rodLength = norm(pAxle.bellcrankPickup1 - pStabar.leftArmEnd), sphereDiameter = joint_diameter, rodDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));    

equation
  connect(RackAndPinion.pinionFlange, pinionFlange) annotation(
    Line(points = {{0, 114}, {0, 140}}));
  connect(leftWishboneUprightLoop.lower_o_frame, toLeftApex.frame_a) annotation(
    Line(points = {{-68, 22}, {-68, 0}, {-80, 0}}, color = {95, 95, 95}));
  connect(rightWishboneUprightLoop.lower_o_frame, toRightApex.frame_a) annotation(
    Line(points = {{70, 22}, {70, 0}, {80, 0}}, color = {95, 95, 95}));
  connect(leftPushrod.frame_b, toLeftApex.frame_b) annotation(
    Line(points = {{-140, -20}, {-144, -20}, {-144, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(rightPushrod.frame_b, toRightApex.frame_b) annotation(
    Line(points = {{140, -20}, {144, -20}, {144, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(left_bellcrank.pickup_2_frame, leftPushrod.frame_a) annotation(
    Line(points = {{-60, -20}, {-100, -20}}, color = {95, 95, 95}));
  connect(left_bellcrank.mount_frame, toLeftBellcrank.frame_b) annotation(
    Line(points = {{-40, -20}, {-30, -20}}, color = {95, 95, 95}));
  connect(left_bellcrank.pickup_3_frame, leftShockLinkage.frame_a) annotation(
    Line(points = {{-50, -30}, {-50, -40}}, color = {95, 95, 95}));
  connect(leftShockLinkage.frame_b, toLeftShock.frame_b) annotation(
    Line(points = {{-50, -70}, {-30, -70}}, color = {95, 95, 95}));
  connect(toRightBellcrank.frame_b, rightBellcrank.mount_frame) annotation(
    Line(points = {{30, -20}, {40, -20}}, color = {95, 95, 95}));
  connect(rightBellcrank.pickup_2_frame, rightPushrod.frame_a) annotation(
    Line(points = {{60, -20}, {100, -20}}, color = {95, 95, 95}));
  connect(rightBellcrank.pickup_3_frame, rightShockLinkage.frame_a) annotation(
    Line(points = {{50, -30}, {50, -40}}, color = {95, 95, 95}));
  connect(rightShockLinkage.frame_b, toRightShock.frame_b) annotation(
    Line(points = {{50, -70}, {30, -70}}, color = {95, 95, 95}));
  connect(axleFrame, toLeftBellcrank.frame_a) annotation(
    Line(points = {{0, 0}, {0, -20}, {-10, -20}}));
  connect(axleFrame, toRightBellcrank.frame_a) annotation(
    Line(points = {{0, 0}, {0, -20}, {10, -20}}));
  connect(axleFrame, toLeftShock.frame_a) annotation(
    Line(points = {{0, 0}, {0, -70}, {-10, -70}}));
  connect(toRightBellcrank.frame_a, toRightShock.frame_a) annotation(
    Line(points = {{10, -20}, {0, -20}, {0, -70}, {10, -70}}, color = {95, 95, 95}));
  connect(axleFrame, toStabar.frame_a) annotation(
    Line(points = {{0, 0}, {0, -80}}));
  connect(toStabar.frame_b, stabar.support_frame) annotation(
    Line(points = {{0, -100}, {0, -110}}, color = {95, 95, 95}));
  connect(stabar.right_arm_frame, rightDroplink.frame_a) annotation(
    Line(points = {{20, -120}, {70, -120}, {70, -100}}, color = {95, 95, 95}));
  connect(rightDroplink.frame_b, rightBellcrank.pickup_1_frame) annotation(
    Line(points = {{70, -80}, {70, -10}, {50, -10}}, color = {95, 95, 95}));
  connect(stabar.left_arm_frame, leftDroplink.frame_a) annotation(
    Line(points = {{-20, -120}, {-70, -120}, {-70, -100}}, color = {95, 95, 95}));
  connect(leftDroplink.frame_b, left_bellcrank.pickup_1_frame) annotation(
    Line(points = {{-70, -80}, {-70, -10}, {-50, -10}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true), graphics),
    Icon(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true), graphics = {Line(origin = {0, 67}, points = {{0, -33}, {0, 33}}, thickness = 5), Ellipse(origin = {0, 100}, lineThickness = 5, extent = {{-26, 26}, {26, -26}}), Line(origin = {-10, 110}, points = {{10, -10}, {-14, -2}}, thickness = 5), Line(origin = {10, 110}, points = {{-10, -10}, {14, -2}}, thickness = 5), Ellipse(origin = {0, 100}, lineColor = {255, 255, 255}, lineThickness = 1, extent = {{-28, 28}, {28, -28}})}));
end FrAxleDW;
