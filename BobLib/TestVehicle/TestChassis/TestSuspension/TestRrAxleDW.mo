within BobLib.TestVehicle.TestChassis.TestSuspension;

model TestRrAxleDW
  import Modelica.Constants.pi;
  import Modelica.Mechanics.MultiBody.Frames;
  import BobLib.Resources.VehicleDefn.OrionRecord;
  
  import BobLib.Utilities.Math.Vector;
  
  parameter OrionRecord pVehicle;
  
  inner parameter Real linkDiameter = 0.020;
  inner parameter Real jointDiameter = 0.030;
  
  parameter Real leftCPInit[3] = pVehicle.pRrDW.wheelCenter + Frames.resolve1(Frames.axesRotations({1, 2, 3},
                                                                                                   {pVehicle.pRrPartialWheel.staticGamma*pi/180, 0, pVehicle.pRrPartialWheel.staticAlpha*pi/180},
                                                                                                   {0, 0, 0}),
                                                                              {0, 0, -pVehicle.pRrPartialWheel.R0});
  parameter Real rightCPInit[3] = Vector.mirrorXZ(leftCPInit);
  
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}})));
  
  // Steer input
  Modelica.Blocks.Sources.Ramp steerRamp(duration = 1,
                                         height = 0,
                                         startTime = 1) annotation(
    Placement(transformation(origin = {-80, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position steerPosition(exact = true) annotation(
    Placement(transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}})));
  
  // Left jounce input
  Modelica.Blocks.Sources.Ramp leftJounceRamp(duration = 1,
                                              height = 1*0.0254,
                                              startTime = 1) annotation(
    Placement(transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  
  // Right jounce input
  Modelica.Blocks.Sources.Ramp rightJounceRamp(duration = 1,
                                               height = -1*0.0254,
                                               startTime = 1) annotation(
    Placement(transformation(origin = {110, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  
  // Front axle
  BobLib.Vehicle.Chassis.Suspension.RrAxleDW frAxleDW(pAxle = pVehicle.pRrAxleDW,
                                                      pRack = pVehicle.pRrRack,
                                                      pStabar = pVehicle.pRrStabar,
                                                      pLeftPartialWheel = pVehicle.pRrPartialWheel,
                                                      pLeftDW = pVehicle.pRrDW,
                                                      pLeftAxleMass = pVehicle.pRrAxleMass,                                                      
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire leftTire(redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.NoSlip slipModel),
                                                      redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire rightTire(redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.NoSlip slipModel)) annotation(
    Placement(transformation(origin = {2.72478e-07, 6.44444}, extent = {{-34, -26.4444}, {34, 26.4444}})));
  
protected
  // Left jounce input
  Modelica.Mechanics.MultiBody.Parts.Fixed leftJounceRef(animation = false, r = leftCPInit) annotation(
    Placement(transformation(origin = {-30, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Translational.Sources.Position leftJouncePosition(exact = true, useSupport = true) annotation(
    Placement(transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  
  // Right jounce input
  Modelica.Mechanics.MultiBody.Parts.Fixed rightJounceRef(animation = false, r = rightCPInit) annotation(
    Placement(transformation(origin = {30, -70}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Mechanics.Translational.Sources.Position rightJouncePosition(exact = true, useSupport = true) annotation(
    Placement(transformation(origin = {80, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  
  // Axle support
  Modelica.Mechanics.MultiBody.Parts.Fixed axleFixed(r = {pVehicle.pRrDW.wheelCenter[1], 0, pVehicle.pRrDW.wheelCenter[3]}) annotation(
    Placement(transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  // Left jounce DOFs
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_DOF_x(animation = false, n = {1, 0, 0}) annotation(
    Placement(transformation(origin = {-60, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_DOF_y(animation = false, n = {0, 1, 0}) annotation(
    Placement(transformation(origin = {-80, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_DOF_z(animation = false, n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {-60, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical left_DOF_xyz(animation = false) annotation(
    Placement(transformation(origin = {-40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  // Right jounce DOFs
  Modelica.Mechanics.MultiBody.Joints.Prismatic right_DOF_x(animation = false, n = {1, 0, 0}) annotation(
    Placement(transformation(origin = {60, -70}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic right_DOF_y(animation = false, n = {0, 1, 0}) annotation(
    Placement(transformation(origin = {80, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic right_DOF_z(animation = false, n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {60, -30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical right_DOF_xyz(animation = false) annotation(
    Placement(transformation(origin = {40, -10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  
equation
  connect(axleFixed.frame_b, frAxleDW.axleFrame) annotation(
    Line(points = {{0, 0}, {0, 16}}, color = {95, 95, 95}));
  connect(steerRamp.y, steerPosition.phi_ref) annotation(
    Line(points = {{-68, 70}, {-62, 70}}, color = {0, 0, 127}));
  connect(leftJounceRamp.y, leftJouncePosition.s_ref) annotation(
    Line(points = {{-98, 0}, {-92, 0}}, color = {0, 0, 127}));
  connect(leftJouncePosition.support, left_DOF_z.support) annotation(
    Line(points = {{-80, -10}, {-64, -10}, {-64, -24}}, color = {0, 127, 0}));
  connect(leftJouncePosition.flange, left_DOF_z.axis) annotation(
    Line(points = {{-70, 0}, {-52, 0}, {-52, -24}}, color = {0, 127, 0}));
  connect(rightJounceRamp.y, rightJouncePosition.s_ref) annotation(
    Line(points = {{100, 0}, {92, 0}}, color = {0, 0, 127}));
  connect(rightJouncePosition.support, right_DOF_z.support) annotation(
    Line(points = {{80, -10}, {64, -10}, {64, -24}}, color = {0, 127, 0}));
  connect(rightJouncePosition.flange, right_DOF_z.axis) annotation(
    Line(points = {{70, 0}, {52, 0}, {52, -24}}, color = {0, 127, 0}));
  connect(leftJounceRef.frame_b, left_DOF_x.frame_a) annotation(
    Line(points = {{-40, -70}, {-50, -70}}, color = {95, 95, 95}));
  connect(left_DOF_x.frame_b, left_DOF_y.frame_a) annotation(
    Line(points = {{-70, -70}, {-80, -70}, {-80, -60}}, color = {95, 95, 95}));
  connect(left_DOF_y.frame_b, left_DOF_z.frame_a) annotation(
    Line(points = {{-80, -40}, {-80, -30}, {-70, -30}}, color = {95, 95, 95}));
  connect(left_DOF_z.frame_b, left_DOF_xyz.frame_a) annotation(
    Line(points = {{-50, -30}, {-40, -30}, {-40, -20}}, color = {95, 95, 95}));
  connect(rightJounceRef.frame_b, right_DOF_x.frame_a) annotation(
    Line(points = {{40, -70}, {50, -70}}, color = {95, 95, 95}));
  connect(right_DOF_x.frame_b, right_DOF_y.frame_a) annotation(
    Line(points = {{70, -70}, {80, -70}, {80, -60}}, color = {95, 95, 95}));
  connect(right_DOF_y.frame_b, right_DOF_z.frame_a) annotation(
    Line(points = {{80, -40}, {80, -30}, {70, -30}}, color = {95, 95, 95}));
  connect(right_DOF_z.frame_b, right_DOF_xyz.frame_a) annotation(
    Line(points = {{50, -30}, {40, -30}, {40, -20}}, color = {95, 95, 95}));
  connect(left_DOF_xyz.frame_b, frAxleDW.leftCP) annotation(
    Line(points = {{-40, 0}, {-40, 6}, {-34, 6}}, color = {95, 95, 95}));
  connect(right_DOF_xyz.frame_b, frAxleDW.rightCP) annotation(
    Line(points = {{40, 0}, {40, 6}, {34, 6}}, color = {95, 95, 95}));
  connect(steerPosition.flange, frAxleDW.pinionFlange) annotation(
    Line(points = {{-40, 70}, {0, 70}, {0, 12}}));
  annotation(
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    Diagram(coordinateSystem(extent = {{-120, -100}, {120, 100}})),
    Icon(coordinateSystem(extent = {{-120, -100}, {120, 100}})),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_INIT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end TestRrAxleDW;
