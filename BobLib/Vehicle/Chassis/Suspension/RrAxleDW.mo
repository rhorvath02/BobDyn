within BobLib.Vehicle.Chassis.Suspension;

model RrAxleDW
  import Modelica.SIunits;
  
  import Modelica.Math.Vectors;
  import BobLib.Utilities.Math.Vector.mirrorXZ;
  
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.AxleDWRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Stabar.StabarRecord;
  // Record parameters
  parameter AxleDWRecord pAxle;
  parameter StabarRecord pStabar;
  
  extends BobLib.Vehicle.Chassis.Suspension.AxleDWBase;
  
  Modelica.Mechanics.Rotational.Interfaces.Flange_a pinionFlange annotation(
    Placement(transformation(origin = {0, 140}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
  // Left pullrod
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod leftPullrod(r_a = pAxle.bellcrankPickup1,
                                                             r_b = pAxle.rodMount,
                                                             n1_a = Vectors.normalize(pAxle.bellcrankPivotAxis),
                                                             linkDiameter = linkDiameter,
                                                             jointDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {-120, -10}, extent = {{20, -20}, {-20, 20}})));
  // Left bellcrank
  Linkages.Bellcrank3 leftBellcrank(pivot = pAxle.bellcrankPivot,
                                    pivotAxis = pAxle.bellcrankPivotAxis,
                                    pickup_1 = pAxle.bellcrankPickup1,
                                    pickup_2 = pAxle.bellcrankPickup2,
                                    pickup_3 = pAxle.bellcrankPickup3,
                                    linkDiameter = linkDiameter,
                                    jointDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

// Left shock
  Linkages.ShockLinkage leftShockLinkage(r_a = pAxle.bellcrankPickup2,
                                         r_b = pAxle.shockMount,
                                         s_0 = Vectors.norm(pAxle.bellcrankPickup2 - pAxle.shockMount),
                                         springTable = [0, 0; 1, 0],
                                         damperTable = [0, 0; 1, 0],
                                         n_a = pAxle.bellcrankPivotAxis,
                                         n_b = Vectors.normalize(pAxle.bellcrankPivot - pAxle.bellcrankPickup2),
                                         linkDiameter = linkDiameter,
                                         jointDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {-80, -55}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  // Right pullrod
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod rightPullrod(r_a = mirrorXZ(pAxle.bellcrankPickup1),
                                                              r_b = mirrorXZ(pAxle.rodMount),
                                                              n1_a = Vectors.normalize(mirrorXZ(pAxle.bellcrankPivotAxis)),
                                                              linkDiameter = linkDiameter,
                                                              jointDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {120, -10}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  // Right bellcrank
  Linkages.Bellcrank3 rightBellcrank(pivot = mirrorXZ(pAxle.bellcrankPivot),
                                     pivotAxis = mirrorXZ(pAxle.bellcrankPivotAxis),
                                     pickup_1 = mirrorXZ(pAxle.bellcrankPickup1),
                                     pickup_2 = mirrorXZ(pAxle.bellcrankPickup2),
                                     pickup_3 = mirrorXZ(pAxle.bellcrankPickup3),
                                     linkDiameter = linkDiameter,
                                     jointDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {50, -20}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  // Right shock
  Linkages.ShockLinkage rightShockLinkage(r_a = mirrorXZ(pAxle.bellcrankPickup2),
                                          r_b = mirrorXZ(pAxle.shockMount),
                                          s_0 = Vectors.norm(pAxle.bellcrankPickup2 - pAxle.shockMount),
                                          springTable = [0, 0; 1, 0],
                                          damperTable = [0, 0; 1, 0],
                                          n_a = mirrorXZ(pAxle.bellcrankPivotAxis),
                                          n_b = Vectors.normalize(mirrorXZ(pAxle.bellcrankPivot - pAxle.bellcrankPickup2)),
                                          linkDiameter = linkDiameter,
                                          jointDiameter = jointDiameter)  annotation(
    Placement(transformation(origin = {80, -55}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  // Stabar
  Templates.Stabar.Stabar stabar(pStabar = pStabar, jointDiameter = jointDiameter, linkDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {0, -116}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical rightDroplink(rodLength = Vectors.norm(mirrorXZ(pAxle.bellcrankPickup3 - pStabar.leftArmEnd)), sphereDiameter = jointDiameter, rodDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {50, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical leftDroplink(rodLength = Vectors.norm(pAxle.bellcrankPickup3 - pStabar.leftArmEnd), sphereDiameter = jointDiameter, rodDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));    
  
protected
  // Kinematics
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftApex(r = pAxle.rodMount - pLeftDW.upper_o, width = linkDiameter, height = linkDiameter) annotation(
    Placement(transformation(origin = {-100, -10}, extent = {{0, 0}, {-20, 20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftBellcrank(r = pAxle.bellcrankPivot - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {-20, -20}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftShock(r = pAxle.shockMount - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {-20, -70}, extent = {{10, -10}, {-10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightApex(r = mirrorXZ(pAxle.rodMount - pLeftDW.upper_o), width = linkDiameter, height = linkDiameter) annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightBellcrank(r = mirrorXZ(pAxle.bellcrankPivot) - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {20, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightShock(r = mirrorXZ(pAxle.shockMount) - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toStabar(r = {pStabar.leftBarEnd[1], 0, pStabar.leftBarEnd[3]} - effectiveCenter, animation = false)  annotation(
    Placement(transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    
equation
  connect(rackAndPinion.pinionFlange, pinionFlange) annotation(
    Line(points = {{0, 114}, {0, 140}}));
  connect(leftPullrod.frame_b, toLeftApex.frame_b) annotation(
    Line(points = {{-140, -10}, {-144, -10}, {-144, 0}, {-120, 0}}, color = {95, 95, 95}));
  connect(rightPullrod.frame_b, toRightApex.frame_b) annotation(
    Line(points = {{140, -10}, {144, -10}, {144, 0}, {120, 0}}, color = {95, 95, 95}));
  connect(leftBellcrank.mountFrame, toLeftBellcrank.frame_b) annotation(
    Line(points = {{-40, -20}, {-30, -20}}, color = {95, 95, 95}));
  connect(leftShockLinkage.frame_b, toLeftShock.frame_b) annotation(
    Line(points = {{-80, -70}, {-30, -70}}, color = {95, 95, 95}));
  connect(toRightBellcrank.frame_b, rightBellcrank.mountFrame) annotation(
    Line(points = {{30, -20}, {40, -20}}, color = {95, 95, 95}));
  connect(rightShockLinkage.frame_b, toRightShock.frame_b) annotation(
    Line(points = {{80, -70}, {30, -70}}, color = {95, 95, 95}));
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
  connect(toStabar.frame_b, stabar.supportFrame) annotation(
    Line(points = {{0, -100}, {0, -110}}, color = {95, 95, 95}));
  connect(leftPullrod.frame_a, leftBellcrank.pickupFrame1) annotation(
    Line(points = {{-100, -10}, {-50, -10}}, color = {95, 95, 95}));
  connect(rightPullrod.frame_a, rightBellcrank.pickupFrame1) annotation(
    Line(points = {{100, -10}, {50, -10}}, color = {95, 95, 95}));
  connect(leftShockLinkage.frame_a, leftBellcrank.pickupFrame2) annotation(
    Line(points = {{-80, -40}, {-80, -20}, {-60, -20}}, color = {95, 95, 95}));
  connect(rightShockLinkage.frame_a, rightBellcrank.pickupFrame2) annotation(
    Line(points = {{80, -40}, {80, -20}, {60, -20}}, color = {95, 95, 95}));
  connect(leftBellcrank.pickupFrame3, leftDroplink.frame_b) annotation(
    Line(points = {{-50, -30}, {-50, -80}}, color = {95, 95, 95}));
  connect(leftDroplink.frame_a, stabar.leftArmFrame) annotation(
    Line(points = {{-50, -100}, {-50, -120}, {-20, -120}}, color = {95, 95, 95}));
  connect(rightBellcrank.pickupFrame3, rightDroplink.frame_b) annotation(
    Line(points = {{50, -30}, {50, -80}}, color = {95, 95, 95}));
  connect(rightDroplink.frame_a, stabar.rightArmFrame) annotation(
    Line(points = {{50, -100}, {50, -120}, {20, -120}}, color = {95, 95, 95}));
  connect(toLeftApex.frame_a, leftWishboneUprightLoop.upperFrame_o) annotation(
    Line(points = {{-100, 0}, {-90, 0}, {-90, 80}, {-68, 80}}, color = {95, 95, 95}));
  connect(toRightApex.frame_a, rightWishboneUprightLoop.upperFrame_o) annotation(
    Line(points = {{100, 0}, {90, 0}, {90, 80}, {70, 80}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true), graphics),
    Icon(coordinateSystem(extent = {{-180, -140}, {180, 140}}, preserveAspectRatio = true)));
end RrAxleDW;
