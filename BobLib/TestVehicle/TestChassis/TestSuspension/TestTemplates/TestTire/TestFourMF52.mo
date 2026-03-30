within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates.TestTire;

model TestFourMF52
  import Modelica.SIunits;
  import Modelica.Math.Vectors.norm;

  import BobLib.Resources.VehicleDefn.OrionRecord;

  // Record parameters
  parameter OrionRecord pCar;
  
  parameter SIunits.Velocity velocity = 10;

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
    Placement(transformation(origin = {-110, -110}, extent = {{-10, -10}, {10, 10}})));

  BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF5p2Tire tireFL(redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel1DOF_Y wheelModel(partialWheelParams = pCar.pFrTireSetup, wheel1DOF_YParams = pCar.pFrTireDOF),
                                                                    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel,
                                                                    pPartialWheel = pCar.pFrTireSetup,
                                                                    tire = pCar.tireFL) annotation(
    Placement(transformation(origin = {-70, 80}, extent = {{10, -10}, {-10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF5p2Tire tireFR(redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel1DOF_Y wheelModel(partialWheelParams = pCar.pFrTireSetup, wheel1DOF_YParams = pCar.pFrTireDOF), 
                                                                    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel,
                                                                    pPartialWheel = pCar.pFrTireSetup,
                                                                    tire = pCar.tireFR) annotation(
    Placement(transformation(origin = {70, 80}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF5p2Tire tireRL(redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel1DOF_Y wheelModel(partialWheelParams = pCar.pFrTireSetup, wheel1DOF_YParams = pCar.pFrTireDOF), 
                                                                    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel,
                                                                    pPartialWheel = pCar.pFrTireSetup,
                                                                    tire = pCar.tireRL) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{10, -10}, {-10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF5p2Tire tireRR(redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.TirePhysics.Wheel1DOF_Y wheelModel(partialWheelParams = pCar.pFrTireSetup, wheel1DOF_YParams = pCar.pFrTireDOF), 
                                                                    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.KinematicSlip slipModel,
                                                                    pPartialWheel = pCar.pFrTireSetup,
                                                                    tire = pCar.tireRR) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  
  Utilities.Mechanics.Multibody.GroundPhysics groundFL annotation(
    Placement(transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics groundFR annotation(
    Placement(transformation(origin = {70, 40}, extent = {{10, -10}, {-10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics groundRL annotation(
    Placement(transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics groundRR annotation(
    Placement(transformation(origin = {70, -40}, extent = {{10, -10}, {-10, 10}})));
  
  Modelica.Blocks.Sources.Ramp steerRamp(duration = 5, height = 5*Modelica.Constants.pi/180, startTime = 0) annotation(
    Placement(transformation(origin = {-110, 110}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position steerPosition(exact = true)  annotation(
    Placement(transformation(origin = {-70, 110}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Joints.Revolute leftRevolute(useAxisFlange = true) annotation(
    Placement(transformation(origin = {-46, 80}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute rightRevolute(useAxisFlange = true) annotation(
    Placement(transformation(origin = {46, 80}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.Rotational.Sources.Torque2 leftTorque annotation(
    Placement(transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Sources.Torque2 rightTorque annotation(
    Placement(transformation(origin = {40, -20}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D annotation(
    Placement(transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  Modelica.Blocks.Sources.RealExpression velErrorExpression(y = velocity - vCG)  annotation(
    Placement(transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Blocks.Continuous.PI PI(T = 1, k = 200)  annotation(
    Placement(transformation(origin = {-60, -80}, extent = {{-10, -10}, {10, 10}})));

protected
  // Geometry + CG bodyCG
  Modelica.Mechanics.MultiBody.Parts.Fixed fixedFL(r = {1, 1, 0}, animation = false) annotation(
    Placement(transformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixedFR(r = {1, -1, 0}, animation = false) annotation(
    Placement(transformation(origin = {110, 40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixedRL(r = {-1, 1, 0}, animation = false) annotation(
    Placement(transformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixedRR(r = {-1, -1, 0}, animation = false) annotation(
    Placement(transformation(origin = {110, -40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation trackFL(r = {0, 1, 0}, animation = false) annotation(
    Placement(transformation(origin = {-20, 80}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation trackFR(r = {0, -1, 0}, animation = false) annotation(
    Placement(transformation(origin = {20, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation trackRL(r = {0, 1, 0}, animation = false) annotation(
    Placement(transformation(origin = {-20, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation trackRR(r = {0, -1, 0}, animation = false) annotation(
    Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation trackFrToRr(r = {-2, 0, 0}, animation = false) annotation(
    Placement(transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation frToCG(r = {-1, 0, 0}, animation = false) annotation(
    Placement(transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.Body bodyCG(r_CM = {0, 0, 0}, m = 150, I_11 = 40, I_22 = 50, I_33 = 60, animation = true, useQuaternions = false, angles_fixed = true, angles_start (each displayUnit = "rad"), v_0(start = {10, 0, 0})) annotation(
    Placement(transformation(origin = {30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

initial equation
  tireFL.wheelModel.hubAxis.w = velocity / pCar.pFrTireSetup.R0;
  tireFR.wheelModel.hubAxis.w = velocity / pCar.pFrTireSetup.R0;
  tireRL.wheelModel.hubAxis.w = velocity / pCar.pFrTireSetup.R0;
  tireRR.wheelModel.hubAxis.w = velocity / pCar.pFrTireSetup.R0;

equation
  vCG = norm(bodyCG.v_0);
  body_accels = Modelica.Mechanics.MultiBody.Frames.resolve2(bodyCG.frame_a.R, bodyCG.a_0);
  normal_loads[1] = tireFL.Fz;
  normal_loads[2] = tireFR.Fz;
  normal_loads[3] = tireRL.Fz;
  normal_loads[4] = tireRR.Fz;
  long_LT = bodyCG.m*body_accels[1]*bodyCG.r_0[3]/norm(tireFL.cpFrame.r_0 - tireRL.cpFrame.r_0);
  lat_LT = bodyCG.m*body_accels[2]*bodyCG.r_0[3]/norm(tireFL.cpFrame.r_0 - tireFR.cpFrame.r_0);
  
  calc_FL = bodyCG.m*Modelica.Constants.g_n/4 - long_LT/2 - lat_LT/2;
  calc_FR = bodyCG.m*Modelica.Constants.g_n/4 - long_LT/2 + lat_LT/2;
  calc_RL = bodyCG.m*Modelica.Constants.g_n/4 + long_LT/2 - lat_LT/2;
  calc_RR = bodyCG.m*Modelica.Constants.g_n/4 + long_LT/2 + lat_LT/2;
  
  connect(fixedFL.frame_b, groundFL.frame_a) annotation(
    Line(points = {{-100, 40}, {-80, 40}}, color = {95, 95, 95}));
  connect(fixedFR.frame_b, groundFR.frame_a) annotation(
    Line(points = {{100, 40}, {80, 40}}, color = {95, 95, 95}));
  connect(fixedRL.frame_b, groundRL.frame_a) annotation(
    Line(points = {{-100, -40}, {-80, -40}}, color = {95, 95, 95}));
  connect(fixedRR.frame_b, groundRR.frame_a) annotation(
    Line(points = {{100, -40}, {80, -40}}, color = {95, 95, 95}));
  connect(tireFL.cpFrame, groundFL.frame_b) annotation(
    Line(points = {{-70, 70}, {-70, 50}}, color = {95, 95, 95}));
  connect(tireFR.cpFrame, groundFR.frame_b) annotation(
    Line(points = {{70, 70}, {70, 50}}, color = {95, 95, 95}));
  connect(tireRL.cpFrame, groundRL.frame_b) annotation(
    Line(points = {{-70, -10}, {-70, -30}}, color = {95, 95, 95}));
  connect(tireRR.cpFrame, groundRR.frame_b) annotation(
    Line(points = {{70, -10}, {70, -30}}, color = {95, 95, 95}));
  connect(tireFL.chassisFrame, leftRevolute.frame_b) annotation(
    Line(points = {{-60, 80}, {-56, 80}}, color = {95, 95, 95}));
  connect(tireFR.chassisFrame, rightRevolute.frame_b) annotation(
    Line(points = {{60, 80}, {56, 80}}, color = {95, 95, 95}));
  connect(tireRL.chassisFrame, trackRL.frame_b) annotation(
    Line(points = {{-60, 0}, {-30, 0}}, color = {95, 95, 95}));
  connect(tireRR.chassisFrame, trackRR.frame_b) annotation(
    Line(points = {{60, 0}, {30, 0}}, color = {95, 95, 95}));
  connect(leftRevolute.frame_a, trackFL.frame_b) annotation(
    Line(points = {{-36, 80}, {-30, 80}}, color = {95, 95, 95}));
  connect(rightRevolute.frame_a, trackFR.frame_b) annotation(
    Line(points = {{36, 80}, {30, 80}}, color = {95, 95, 95}));
  connect(trackFL.frame_a, trackFrToRr.frame_a) annotation(
    Line(points = {{-10, 80}, {0, 80}, {0, 60}}, color = {95, 95, 95}));
  connect(trackFR.frame_a, trackFrToRr.frame_a) annotation(
    Line(points = {{10, 80}, {0, 80}, {0, 60}}, color = {95, 95, 95}));
  connect(trackFrToRr.frame_b, trackRL.frame_a) annotation(
    Line(points = {{0, 40}, {0, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(trackFrToRr.frame_b, trackRR.frame_a) annotation(
    Line(points = {{0, 40}, {0, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(trackFR.frame_a, frToCG.frame_a) annotation(
    Line(points = {{10, 80}, {0, 80}, {0, 70}, {30, 70}, {30, 60}}, color = {95, 95, 95}));
  connect(frToCG.frame_b, bodyCG.frame_a) annotation(
    Line(points = {{30, 40}, {30, 30}}, color = {95, 95, 95}));
  connect(steerRamp.y, steerPosition.phi_ref) annotation(
    Line(points = {{-98, 110}, {-82, 110}}, color = {0, 0, 127}));
  connect(steerPosition.flange, leftRevolute.axis) annotation(
    Line(points = {{-60, 110}, {-46, 110}, {-46, 90}}));
  connect(steerPosition.flange, rightRevolute.axis) annotation(
    Line(points = {{-60, 110}, {46, 110}, {46, 90}}));
  connect(leftTorque.flange_b, tireRL.hubFlange) annotation(
    Line(points = {{-50, -20}, {-90, -20}, {-90, 0}, {-80, 0}}));
  connect(rightTorque.flange_b, tireRR.hubFlange) annotation(
    Line(points = {{50, -20}, {90, -20}, {90, 0}, {80, 0}}));
  connect(trackFrToRr.frame_b, mounting1D.frame_a) annotation(
    Line(points = {{0, 40}, {0, -10}}, color = {95, 95, 95}));
  connect(mounting1D.flange_b, leftTorque.flange_a) annotation(
    Line(points = {{-10, -20}, {-30, -20}}));
  connect(rightTorque.flange_a, mounting1D.flange_b) annotation(
    Line(points = {{30, -20}, {20, -20}, {20, -30}, {-20, -30}, {-20, -20}, {-10, -20}}));
  connect(velErrorExpression.y, PI.u) annotation(
    Line(points = {{-88, -80}, {-72, -80}}, color = {0, 0, 127}));
  connect(PI.y, leftTorque.tau) annotation(
    Line(points = {{-48, -80}, {-40, -80}, {-40, -24}}, color = {0, 0, 127}));
  connect(PI.y, rightTorque.tau) annotation(
    Line(points = {{-48, -80}, {40, -80}, {40, -24}}, color = {0, 0, 127}));
  
  annotation(
    Diagram(coordinateSystem(extent = {{-120, -120}, {120, 120}})),
    Icon(coordinateSystem(extent = {{-120, -120}, {120, 120}})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
end TestFourMF52;
