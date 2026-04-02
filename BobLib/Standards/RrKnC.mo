within BobLib.Standards;

model RrKnC
  import Modelica.SIunits;
  import Modelica.Constants.pi;
  
  import Modelica.Mechanics.MultiBody.Frames;
  import BobLib.Utilities.Math.Vector;
  
  import BobLib.Resources.VehicleDefn.OrionRecord;
  
  parameter OrionRecord pVehicle annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  
  Real leftSpringLength;
  Real rightSpringLength;
  Real stabarAngle;
  
  extends BobLib.Standards.Templates.KnC(final toAxle(r = {pVehicle.pRrDW.wheelCenter[1], 0, pVehicle.pRrDW.wheelCenter[3]}),
                                         final leftCPFixed(r = leftCPInit),
                                         final rightCPFixed(r = rightCPInit));
  
  // Rear axle
  BobLib.Vehicle.Chassis.Suspension.RrAxleDW rrAxleDW(pAxle = pVehicle.pRrAxleDW,
                                                      pRack = pVehicle.pRrRack,
                                                      pStabar = pVehicle.pRrStabar,
                                                      pLeftPartialWheel = pVehicle.pRrPartialWheel,
                                                      pLeftDW = pVehicle.pRrDW,
                                                      pLeftAxleMass = pVehicle.pRrAxleMass,
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire leftTire(
                                                        redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.NoSlip slipModel),
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire rightTire(
                                                        redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.NoSlip slipModel)) annotation(
    Placement(transformation(origin = {0, 50.4444}, extent = {{-34, -26.4444}, {34, 26.4444}})));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D steerLock annotation(
    Placement(transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}})));
protected
  // Calculated parameters
  final parameter Real leftCPInit[3] = pVehicle.pRrDW.wheelCenter + Frames.resolve1(Frames.axesRotations({1, 2, 3},
                                                                                                         {pVehicle.pRrPartialWheel.staticGamma*pi/180, 0, pVehicle.pRrPartialWheel.staticAlpha*pi/180},
                                                                                                         {0, 0, 0}),
                                                                                    {0, 0, -pVehicle.pRrPartialWheel.R0});
  final parameter Real rightCPInit[3] = Vector.mirrorXZ(leftCPInit);
  // Steer input
equation
  leftGamma = rrAxleDW.leftTire.gamma;
  leftDeltaVec = Frames.resolve1(rrAxleDW.leftCP.R, {1, 0, 0});
  leftToe = atan(leftDeltaVec[2]/leftDeltaVec[1]);
  leftKingpinVec = rrAxleDW.leftWishboneUprightLoop.upperFrame_o.r_0 - rrAxleDW.leftWishboneUprightLoop.lowerFrame_o.r_0;
  leftCaster = atan(-1*leftKingpinVec[1]/leftKingpinVec[3]);
  leftKpi = atan(-1*leftKingpinVec[2]/leftKingpinVec[3]);
  leftGroundParam = (rrAxleDW.leftCP.r_0[3] - rrAxleDW.leftWishboneUprightLoop.upperFrame_o.r_0[3])/leftKingpinVec[3];
  leftGroundPoint = rrAxleDW.leftWishboneUprightLoop.upperFrame_o.r_0 + leftGroundParam*leftKingpinVec;
  leftMechTrail = leftGroundPoint[1] - rrAxleDW.leftCP.r_0[1];
  leftMechScrub = rrAxleDW.leftCP.r_0[2] - leftGroundPoint[2];
  rightGamma = rrAxleDW.rightTire.gamma;
  rightDeltaVec = Frames.resolve1(rrAxleDW.rightCP.R, {1, 0, 0});
  rightToe = atan(rightDeltaVec[2]/rightDeltaVec[1]);
  rightKingpinVec = rrAxleDW.rightWishboneUprightLoop.upperFrame_o.r_0 - rrAxleDW.rightWishboneUprightLoop.lowerFrame_o.r_0;
  rightCaster = atan(-1*rightKingpinVec[1]/rightKingpinVec[3]);
  rightKpi = atan(rightKingpinVec[2]/rightKingpinVec[3]);
  rightGroundParam = (rrAxleDW.rightCP.r_0[3] - rrAxleDW.rightWishboneUprightLoop.upperFrame_o.r_0[3])/rightKingpinVec[3];
  rightGroundPoint = rrAxleDW.rightWishboneUprightLoop.upperFrame_o.r_0 + rightGroundParam*rightKingpinVec;
  rightMechTrail = rightGroundPoint[1] - rrAxleDW.rightCP.r_0[1];
  rightMechScrub = rightGroundPoint[2] - rrAxleDW.rightCP.r_0[2];
  leftSpringLength = rrAxleDW.leftShockLinkage.lineForceWithMass.s;
  rightSpringLength = rrAxleDW.rightShockLinkage.lineForceWithMass.s;
  stabarAngle = rrAxleDW.stabar.spring.phi_rel;
  connect(leftCPForce.frame_b, rrAxleDW.leftCP) annotation(
    Line(points = {{-60, 20}, {-47, 20}, {-47, 50}, {-34, 50}}, color = {95, 95, 95}));
  connect(rightCPForce.frame_b, rrAxleDW.rightCP) annotation(
    Line(points = {{60, 20}, {47, 20}, {47, 50}, {34, 50}}, color = {95, 95, 95}));
  connect(left_DOF_xyz.frame_b, rrAxleDW.leftCP) annotation(
    Line(points = {{-40, 0}, {-40, 50}, {-34, 50}}, color = {95, 95, 95}));
  connect(right_DOF_xyz.frame_b, rrAxleDW.rightCP) annotation(
    Line(points = {{40, 0}, {40, 50}, {34, 50}}, color = {95, 95, 95}));
  connect(heaveDOF.frame_b, rrAxleDW.axleFrame) annotation(
    Line(points = {{0, 30}, {0, 60}}, color = {95, 95, 95}));
  connect(steerLock.frame_a, rrAxleDW.axleFrame) annotation(
    Line(points = {{0, 80}, {0, 60}}, color = {95, 95, 95}));
  connect(steerLock.flange_b, rrAxleDW.pinionFlange) annotation(
    Line(points = {{10, 90}, {60, 90}, {60, 56}, {0, 56}}));
  annotation(
    experiment(StartTime = 0, StopTime = 91, Tolerance = 1e-06, Interval = 0.002));
end RrKnC;
