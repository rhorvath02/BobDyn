within BobLib.Standards;

model FrKnC
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
  
  extends BobLib.Standards.Templates.KnC(final toAxle(r = {pVehicle.pFrDW.wheelCenter[1], 0, pVehicle.pFrDW.wheelCenter[3]}),
                                         final leftCPFixed(r = leftCPInit),
                                         final rightCPFixed(r = rightCPInit));
  // Front axle
  BobLib.Vehicle.Chassis.Suspension.FrAxleDW frAxleDW(pAxle = pVehicle.pFrAxleDW,
                                                      pRack = pVehicle.pFrRack,
                                                      pStabar = pVehicle.pFrStabar,
                                                      pLeftPartialWheel = pVehicle.pFrPartialWheel,
                                                      pLeftDW = pVehicle.pFrDW,
                                                      pLeftAxleMass = pVehicle.pFrAxleMass,
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire leftTire(
                                                        redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.NoSlip slipModel),
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire rightTire(
                                                        redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.NoSlip slipModel)) annotation(
    Placement(transformation(origin = {0, 50.4444}, extent = {{-34, -26.4444}, {34, 26.4444}})));
  
protected
  // Calculated parameters
  final parameter Real leftCPInit[3] = pVehicle.pFrDW.wheelCenter + Frames.resolve1(Frames.axesRotations({1, 2, 3},
                                                                                                         {pVehicle.pFrPartialWheel.staticGamma*pi/180, 0, pVehicle.pFrPartialWheel.staticAlpha*pi/180},
                                                                                                         {0, 0, 0}),
                                                                                    {0, 0, -pVehicle.pFrPartialWheel.R0});
  final parameter Real rightCPInit[3] = Vector.mirrorXZ(leftCPInit);
  
  // Steer input
  Modelica.Blocks.Sources.Ramp steerRamp(duration = 1, height = 0*Modelica.Constants.pi/180, startTime = 1) annotation(
    Placement(transformation(origin = {-70, 110}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position steerPosition(exact = true) annotation(
    Placement(transformation(origin = {-30, 110}, extent = {{-10, -10}, {10, 10}})));
  
equation
  leftGamma = frAxleDW.leftTire.gamma;

  leftDeltaVec = Frames.resolve1(frAxleDW.leftCP.R, {1, 0, 0});
  leftToe = atan(leftDeltaVec[2]/leftDeltaVec[1]);

  leftKingpinVec = frAxleDW.leftWishboneUprightLoop.upperFrame_o.r_0 - frAxleDW.leftWishboneUprightLoop.lowerFrame_o.r_0;
  leftCaster = atan(-1*leftKingpinVec[1]/leftKingpinVec[3]);
  leftKpi = atan(-1*leftKingpinVec[2]/leftKingpinVec[3]);

  leftGroundParam = (frAxleDW.leftCP.r_0[3] - frAxleDW.leftWishboneUprightLoop.upperFrame_o.r_0[3])/leftKingpinVec[3];
  leftGroundPoint = frAxleDW.leftWishboneUprightLoop.upperFrame_o.r_0 + leftGroundParam*leftKingpinVec;
  leftMechTrail = leftGroundPoint[1] - frAxleDW.leftCP.r_0[1];
  leftMechScrub = frAxleDW.leftCP.r_0[2] - leftGroundPoint[2];

  rightGamma = frAxleDW.rightTire.gamma;

  rightDeltaVec = Frames.resolve1(frAxleDW.rightCP.R, {1, 0, 0});
  rightToe = atan(rightDeltaVec[2]/rightDeltaVec[1]);

  rightKingpinVec = frAxleDW.rightWishboneUprightLoop.upperFrame_o.r_0 - frAxleDW.rightWishboneUprightLoop.lowerFrame_o.r_0;
  rightCaster = atan(-1*rightKingpinVec[1]/rightKingpinVec[3]);
  rightKpi = atan(rightKingpinVec[2]/rightKingpinVec[3]);

  rightGroundParam = (frAxleDW.rightCP.r_0[3] - frAxleDW.rightWishboneUprightLoop.upperFrame_o.r_0[3])/rightKingpinVec[3];
  rightGroundPoint = frAxleDW.rightWishboneUprightLoop.upperFrame_o.r_0 + rightGroundParam*rightKingpinVec;
  rightMechTrail = rightGroundPoint[1] - frAxleDW.rightCP.r_0[1];
  rightMechScrub = rightGroundPoint[2] - frAxleDW.rightCP.r_0[2];

  leftSpringLength = frAxleDW.leftShockLinkage.lineForceWithMass.s;
  rightSpringLength = frAxleDW.rightShockLinkage.lineForceWithMass.s;
  stabarAngle = frAxleDW.stabar.spring.phi_rel;

  connect(steerRamp.y, steerPosition.phi_ref) annotation(
    Line(points = {{-59, 110}, {-43, 110}}, color = {0, 0, 127}));
  connect(steerPosition.flange, frAxleDW.pinionFlange) annotation(
    Line(points = {{-20, 110}, {0, 110}, {0, 70}}));
  connect(leftCPForce.frame_b, frAxleDW.leftCP) annotation(
    Line(points = {{-60, 20}, {-47, 20}, {-47, 50}, {-34, 50}}, color = {95, 95, 95}));
  connect(rightCPForce.frame_b, frAxleDW.rightCP) annotation(
    Line(points = {{60, 20}, {47, 20}, {47, 50}, {34, 50}}, color = {95, 95, 95}));
  connect(left_DOF_xyz.frame_b, frAxleDW.leftCP) annotation(
    Line(points = {{-40, 0}, {-40, 50}, {-34, 50}}, color = {95, 95, 95}));
  connect(right_DOF_xyz.frame_b, frAxleDW.rightCP) annotation(
    Line(points = {{40, 0}, {40, 50}, {34, 50}}, color = {95, 95, 95}));
  connect(heaveDOF.frame_b, frAxleDW.axleFrame) annotation(
    Line(points = {{0, 30}, {0, 60}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 91, Tolerance = 1e-06, Interval = 0.002));
end FrKnC;
