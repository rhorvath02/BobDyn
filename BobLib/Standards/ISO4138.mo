within BobLib.Standards;

model ISO4138
  import Modelica.SIunits;
  import Modelica.Constants.pi;
  
  import Modelica.Math.Vectors.norm;
  import Modelica.Mechanics.MultiBody.Frames;
  import BobLib.Utilities.Math.Vector;
  
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Templates.PartialWheelRecord;
  import BobLib.Resources.VehicleDefn.OrionRecord;
  
  inner parameter SIunits.Length linkDiameter = 0.020;
  inner parameter SIunits.Length jointDiameter = 0.030;
  
  // Record parameters
  parameter OrionRecord pVehicle;
  
  parameter SIunits.Velocity testVel = 15;
  parameter SIunits.Length testRad = 20;
  
  parameter Real curvGain = 4;
  parameter Real curvTi = 0.02;
  
  discrete Real t_hit(start = -1);
  
  Real curvError;
  Real radError;
  
  // Outputs
  Real body_accels[3];
  Real normal_loads[4];
  
  Real long_LT;
  Real lat_LT;
  Real calc_FL;
  Real calc_FR;
  Real calc_RL;
  Real calc_RR;

  Real vCG;

  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-130, -110}, extent = {{-10, -10}, {10, 10}})));
  
  // Front axle
  BobLib.Vehicle.Chassis.Suspension.FrAxleDW frAxleDW(pAxle = pVehicle.pFrAxleDW,
                                                      pRack = pVehicle.pFrRack,
                                                      pStabar = pVehicle.pFrStabar,
                                                      pLeftPartialWheel = pVehicle.pFrPartialWheel,
                                                      pLeftDW = pVehicle.pFrDW,
                                                      pLeftAxleMass = pVehicle.pFrAxleMass,
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52Tire leftTire(pPartialWheel = pVehicle.pFrPartialWheel,
                                                                                                                                   pTireModel = pVehicle.pFrTireModel,
                                                                                                                                   redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel1DOF_Y wheelModel(partialWheelParams = pVehicle.pFrPartialWheel,
                                                                                                                                                                                                                                 wheel1DOF_YParams = pVehicle.pFrTireDOF),
                                                                                                                                   redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel),
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52Tire rightTire(pPartialWheel = pVehicle.pFrPartialWheel,
                                                                                                                                    pTireModel = pVehicle.pFrTireModel,
                                                                                                                                    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel1DOF_Y wheelModel(partialWheelParams = pVehicle.pFrPartialWheel,
                                                                                                                                                                                                                                  wheel1DOF_YParams = pVehicle.pFrTireDOF), 
                                                                                                                                    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel)) annotation(
    Placement(transformation(origin = {0, 70.4444}, extent = {{-34, -26.4444}, {34, 26.4444}})));
  
  // Rear axle
  BobLib.Vehicle.Chassis.Suspension.RrAxleDW rrAxleDW(pAxle = pVehicle.pRrAxleDW,
                                                      pRack = pVehicle.pRrRack,
                                                      pStabar = pVehicle.pRrStabar,
                                                      pLeftPartialWheel = pVehicle.pRrPartialWheel,
                                                      pLeftDW = pVehicle.pRrDW,
                                                      pLeftAxleMass = pVehicle.pRrAxleMass,
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52Tire leftTire(pPartialWheel = pVehicle.pRrPartialWheel,
                                                                                                                                   pTireModel = pVehicle.pRrTireModel,
                                                                                                                                   redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel1DOF_Y wheelModel(partialWheelParams = pVehicle.pRrPartialWheel,
                                                                                                                                                                                                                                 wheel1DOF_YParams = pVehicle.pRrTireDOF),
                                                                                                                                   redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel),
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52Tire rightTire(pPartialWheel = pVehicle.pRrPartialWheel,
                                                                                                                                    pTireModel = pVehicle.pRrTireModel,
                                                                                                                                    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel1DOF_Y wheelModel(partialWheelParams = pVehicle.pRrPartialWheel,
                                                                                                                                                                                                                                  wheel1DOF_YParams = pVehicle.pRrTireDOF), 
                                                                                                                                    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel)) annotation(
    Placement(transformation(origin = {0, -29.5556}, extent = {{-34, -26.4444}, {34, 26.4444}})));
  
  // Frame
  BobLib.Vehicle.Chassis.Body.CompliantFrame compliantFrame(frRef = frAxleDW.effectiveCenter,
                                                            rrRef = rrAxleDW.effectiveCenter,
                                                            pSprung = pVehicle.pSprungMass, initVelX = testVel)  annotation(
    Placement(transformation(origin = {0, 30}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));

  // Curvature controller
  Modelica.Blocks.Continuous.PI curvPI(T = curvTi, k = curvGain, initType = Modelica.Blocks.Types.Init.InitialOutput)  annotation(
    Placement(transformation(origin = {-70, 110}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression curvErrorExpression(y = curvError)  annotation(
    Placement(transformation(origin = {-110, 110}, extent = {{-10, -10}, {10, 10}})));

protected
  // Calculated parameters
  final parameter Real cpInitFL[3] = pVehicle.pFrDW.wheelCenter + Frames.resolve1(Frames.axesRotations({1, 2, 3},
                                                                                                       {pVehicle.pFrPartialWheel.staticGamma*pi/180, 0, pVehicle.pFrPartialWheel.staticAlpha*pi/180},
                                                                                                       {0, 0, 0}),
                                                                                  {0, 0, -pVehicle.pFrPartialWheel.R0});
  final parameter Real cpInitFR[3] = Vector.mirrorXZ(cpInitFL);
  final parameter Real cpInitRL[3] = pVehicle.pRrDW.wheelCenter + Frames.resolve1(Frames.axesRotations({1, 2, 3},
                                                                                                       {pVehicle.pRrPartialWheel.staticGamma*pi/180, 0, pVehicle.pRrPartialWheel.staticAlpha*pi/180},
                                                                                                       {0, 0, 0}),
                                                                                  {0, 0, -pVehicle.pRrPartialWheel.R0});
  final parameter Real cpInitRR[3] = Vector.mirrorXZ(cpInitRL);
  
  // Initial geometry
  Modelica.Mechanics.MultiBody.Parts.Fixed fixedFL(r = cpInitFL, animation = false) annotation(
    Placement(transformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixedFR(r = cpInitFR, animation = false) annotation(
    Placement(transformation(origin = {110, 50}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixedRL(r = cpInitRL, animation = false) annotation(
    Placement(transformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixedRR(r = cpInitRR, animation = false) annotation(
    Placement(transformation(origin = {110, -70}, extent = {{10, -10}, {-10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.Fixed frAxleFixed(r = frAxleDW.effectiveCenter)  annotation(
    Placement(transformation(origin = {110, 100}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.FreeMotion frFreeMotion(animation = false, useQuaternions = true)  annotation(
    Placement(transformation(origin = {70, 90}, extent = {{10, -10}, {-10, 10}})));
  
  // Ground interface
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics groundFL annotation(
    Placement(transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics groundFR annotation(
    Placement(transformation(origin = {50, 50}, extent = {{10, -10}, {-10, 10}})));
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics groundRL annotation(
    Placement(transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics groundRR annotation(
    Placement(transformation(origin = {70, -70}, extent = {{10, -10}, {-10, 10}})));
  
  // Rear torque input (locked diff)
  Modelica.Mechanics.Rotational.Sources.Torque2 leftTorque annotation(
    Placement(transformation(origin = {-40, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Sources.Torque2 rightTorque annotation(
    Placement(transformation(origin = {40, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D annotation(
    Placement(transformation(origin = {0, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  Modelica.Blocks.Sources.RealExpression velErrorExpression(y = testVel - vCG) annotation(
    Placement(transformation(origin = {-100, -110}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.PI speedPI(T = 1, k = 200) annotation(
    Placement(transformation(origin = {-60, -110}, extent = {{-10, -10}, {10, 10}})));
  // Front steer input
  Modelica.Mechanics.Rotational.Sources.Position frSteerPosition(exact = false) annotation(
    Placement(transformation(origin = {-30, 110}, extent = {{-10, -10}, {10, 10}})));
  
  // Rear steer input
  Modelica.Mechanics.MultiBody.Parts.Mounting1D rearSteerLock annotation(
    Placement(transformation(origin = {70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
initial equation
  frAxleDW.leftTire.wheelModel.hubAxis.w = testVel / pVehicle.pFrPartialWheel.R0;
  frAxleDW.rightTire.wheelModel.hubAxis.w = testVel / pVehicle.pFrPartialWheel.R0;
  rrAxleDW.leftTire.wheelModel.hubAxis.w = testVel / pVehicle.pRrPartialWheel.R0;
  rrAxleDW.rightTire.wheelModel.hubAxis.w = testVel / pVehicle.pRrPartialWheel.R0;

equation
  radError = abs(vCG / max(compliantFrame.sprungBody.w_a[3], 0.1) - testRad);
  
  // Steady-state detection
  when radError < 0.01 and pre(t_hit) < 0 then
    t_hit = time;
  end when;
  
  when t_hit > 0 and time > t_hit + 0.5 then
    terminate("Reached steady-state (held 0.5s)");
  end when;
  
  curvError = smooth(1, min(1, max(0, (time - 1)/0.2))) * (1/testRad - compliantFrame.sprungBody.w_a[3] / max(vCG, 0.1));
  
  // General quantities for validation
  vCG = norm(compliantFrame.sprungBody.v_0);
  body_accels = Modelica.Mechanics.MultiBody.Frames.resolve2(compliantFrame.sprungBody.frame_a.R, compliantFrame.sprungBody.a_0);
  
  normal_loads[1] = frAxleDW.leftTire.Fz;
  normal_loads[2] = frAxleDW.rightTire.Fz;
  normal_loads[3] = rrAxleDW.leftTire.Fz;
  normal_loads[4] = rrAxleDW.rightTire.Fz;
  
  long_LT = compliantFrame.sprungBody.m*body_accels[1]*compliantFrame.sprungBody.r_0[3]/norm(frAxleDW.leftCP.r_0 - rrAxleDW.leftCP.r_0);
  lat_LT = compliantFrame.sprungBody.m*body_accels[2]*compliantFrame.sprungBody.r_0[3]/norm(frAxleDW.leftCP.r_0 - frAxleDW.rightCP.r_0);
  
  calc_FL = compliantFrame.sprungBody.m*Modelica.Constants.g_n/4 - long_LT/2 - lat_LT/2;
  calc_FR = compliantFrame.sprungBody.m*Modelica.Constants.g_n/4 - long_LT/2 + lat_LT/2;
  calc_RL = compliantFrame.sprungBody.m*Modelica.Constants.g_n/4 + long_LT/2 - lat_LT/2;
  calc_RR = compliantFrame.sprungBody.m*Modelica.Constants.g_n/4 + long_LT/2 + lat_LT/2;
  
  connect(frSteerPosition.flange, frAxleDW.pinionFlange) annotation(
    Line(points = {{-20, 110}, {0, 110}, {0, 90}}));
  connect(rearSteerLock.frame_a, rrAxleDW.axleFrame) annotation(
    Line(points = {{60, -10}, {0, -10}, {0, -20}}, color = {95, 95, 95}));
  connect(rearSteerLock.flange_b, rrAxleDW.pinionFlange) annotation(
    Line(points = {{70, -20}, {70, -24}, {0, -24}}));
  connect(frAxleFixed.frame_b, frFreeMotion.frame_a) annotation(
    Line(points = {{100, 100}, {90, 100}, {90, 90}, {80, 90}}, color = {95, 95, 95}));
  connect(frFreeMotion.frame_b, frAxleDW.axleFrame) annotation(
    Line(points = {{60, 90}, {20, 90}, {20, 80}, {0, 80}}, color = {95, 95, 95}));
  connect(rrAxleDW.axleFrame, mounting1D.frame_a) annotation(
    Line(points = {{0, -20}, {0, -40}}, color = {95, 95, 95}));
  connect(mounting1D.flange_b, leftTorque.flange_a) annotation(
    Line(points = {{-10, -50}, {-30, -50}}));
  connect(mounting1D.flange_b, rightTorque.flange_a) annotation(
    Line(points = {{-10, -50}, {30, -50}}));
  connect(leftTorque.flange_b, rrAxleDW.leftTorque) annotation(
    Line(points = {{-50, -50}, {-60, -50}, {-60, -20}, {-34, -20}}));
  connect(rightTorque.flange_b, rrAxleDW.rightTorque) annotation(
    Line(points = {{50, -50}, {60, -50}, {60, -20}, {34, -20}}));
  connect(velErrorExpression.y, speedPI.u) annotation(
    Line(points = {{-88, -110}, {-72, -110}}, color = {0, 0, 127}));
  connect(speedPI.y, leftTorque.tau) annotation(
    Line(points = {{-48, -110}, {0, -110}, {0, -80}, {-40, -80}, {-40, -54}}, color = {0, 0, 127}));
  connect(speedPI.y, rightTorque.tau) annotation(
    Line(points = {{-48, -110}, {0, -110}, {0, -80}, {40, -80}, {40, -54}}, color = {0, 0, 127}));
  connect(fixedFL.frame_b, groundFL.frame_a) annotation(
    Line(points = {{-100, 50}, {-60, 50}}, color = {95, 95, 95}));
  connect(fixedFR.frame_b, groundFR.frame_a) annotation(
    Line(points = {{100, 50}, {60, 50}}, color = {95, 95, 95}));
  connect(fixedRL.frame_b, groundRL.frame_a) annotation(
    Line(points = {{-100, -70}, {-80, -70}}, color = {95, 95, 95}));
  connect(fixedRR.frame_b, groundRR.frame_a) annotation(
    Line(points = {{100, -70}, {80, -70}}, color = {95, 95, 95}));
  connect(frAxleDW.leftCP, groundFL.frame_b) annotation(
    Line(points = {{-34, 70}, {-50, 70}, {-50, 60}}, color = {95, 95, 95}));
  connect(frAxleDW.rightCP, groundFR.frame_b) annotation(
    Line(points = {{34, 70}, {50, 70}, {50, 60}}, color = {95, 95, 95}));
  connect(rrAxleDW.leftCP, groundRL.frame_b) annotation(
    Line(points = {{-34, -30}, {-70, -30}, {-70, -60}}, color = {95, 95, 95}));
  connect(rrAxleDW.rightCP, groundRR.frame_b) annotation(
    Line(points = {{34, -30}, {70, -30}, {70, -60}}, color = {95, 95, 95}));
  connect(frAxleDW.axleFrame, compliantFrame.frontFrame) annotation(
    Line(points = {{0, 80}, {0, 50}}, color = {95, 95, 95}));
  connect(compliantFrame.rearFrame, rrAxleDW.axleFrame) annotation(
    Line(points = {{0, 10}, {0, -20}}, color = {95, 95, 95}));
  connect(curvErrorExpression.y, curvPI.u) annotation(
    Line(points = {{-98, 110}, {-82, 110}}, color = {0, 0, 127}));
  connect(curvPI.y, frSteerPosition.phi_ref) annotation(
    Line(points = {{-58, 110}, {-42, 110}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-140, -120}, {140, 120}})),
    Icon(coordinateSystem(extent = {{-140, -120}, {140, 120}})),
  experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --maxSizeLinearTearing=5000");
end ISO4138;
