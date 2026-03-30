within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates;

model TestAxleDW
  import Modelica.Constants.pi;
  import Modelica.Mechanics.MultiBody.Frames;
  import BobLib.Resources.VehicleDefn.OrionRecord;
  
  // Custom linalg
  import BobLib.Utilities.Math.Vector;
  
  parameter OrionRecord pVehicle;
  
  inner parameter Real linkDiameter = 0.020;
  inner parameter Real jointDiameter = 0.030;
  
  parameter Real leftCPInit[3] = pVehicle.pFrDW.wheelCenter + Frames.resolve1(Frames.axesRotations({1, 2, 3}, 
                                                                                                     {pVehicle.pFrTireSetup.staticGamma*pi/180, 0, pVehicle.pFrTireSetup.staticAlpha*pi/180},
                                                                                                     {0, 0, 0}),
                                                                                {0, 0, -pVehicle.pFrTireSetup.R0});
  parameter Real rightCPInit[3] = Vector.mirrorXZ(leftCPInit);
  
  BobLib.Vehicle.Chassis.Suspension.FrAxleDW AxleDW(
    pLeftPartialWheel = pVehicle.pFrTireSetup,
    pLeftDW = pVehicle.pFrDW,
    pRack = pVehicle.pRack,
    pStabar = pVehicle.pFrStabar,
    pLeftAxleMass = pVehicle.pFrAxleMass,
    pAxle = pVehicle.pFrAxleDW,
    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire leftTire(redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.NoSlip slipModel),
    redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire rightTire(redeclare BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel.NoSlip slipModel)) annotation(
    Placement(transformation(origin = {2.72478e-07, 6.44444}, extent = {{-34, -26.4444}, {34, 26.4444}})));
  
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = {pVehicle.pFrDW.wheelCenter[1], 0, pVehicle.pFrDW.wheelCenter[3]})  annotation(
    Placement(transformation(origin = {0, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical left_spherical(animation = false) annotation(
    Placement(transformation(origin = {-40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed left_jounce_ref_fixed(animation = false, r = leftCPInit) annotation(
    Placement(transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_prismatic(animation = false, n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Position left_position(exact = true, useSupport = true) annotation(
    Placement(transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp left_jounce_ramp(duration = 1, height = 1*0.0254, startTime = 1) annotation(
    Placement(transformation(origin = {-30, 60}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_free_x(animation = false, n = {1, 0, 0}) annotation(
    Placement(transformation(origin = {-80, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_free_y(animation = false, n = {0, 1, 0}) annotation(
    Placement(transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Spherical right_spherical(animation = false) annotation(
    Placement(transformation(origin = {40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic right_prismatic(animation = false, n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {80, -20}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic right_free_x(animation = false, n = {1, 0, 0}) annotation(
    Placement(transformation(origin = {80, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic right_free_y(animation = false, n = {0, 1, 0}) annotation(
    Placement(transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed right_jounce_ref_fixed(animation = false, r = rightCPInit) annotation(
    Placement(transformation(origin = {50, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Position right_position(exact = true, useSupport = true) annotation(
    Placement(transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp right_jounce_ramp(duration = 1, height = -1*0.0254, startTime = 1) annotation(
    Placement(transformation(origin = {30, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position handwheel_angle(exact = true)  annotation(
    Placement(transformation(origin = {-70, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp steer_ramp(duration = 1, height = 90*Modelica.Constants.pi/180, startTime = 1) annotation(
    Placement(transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(fixed.frame_b, AxleDW.axleFrame) annotation(
    Line(points = {{0, -40}, {0, 16}}, color = {95, 95, 95}));
  connect(left_jounce_ramp.y, left_position.s_ref) annotation(
    Line(points = {{-41, 60}, {-49, 60}, {-49, 30}, {-58, 30}}, color = {0, 0, 127}));
  connect(right_jounce_ramp.y, right_position.s_ref) annotation(
    Line(points = {{41, 60}, {50, 60}, {50, 30}, {58, 30}}, color = {0, 0, 127}));
  connect(left_position.flange, left_prismatic.axis) annotation(
    Line(points = {{-80, 30}, {-80, -14}, {-72, -14}}, color = {0, 127, 0}));
  connect(left_position.support, left_prismatic.support) annotation(
    Line(points = {{-70, 20}, {-84, 20}, {-84, -14}}, color = {0, 127, 0}));
  connect(right_position.flange, right_prismatic.axis) annotation(
    Line(points = {{80, 30}, {80, -14}, {72, -14}}, color = {0, 127, 0}));
  connect(right_position.support, right_prismatic.support) annotation(
    Line(points = {{70, 20}, {84, 20}, {84, -14}}, color = {0, 127, 0}));
  connect(left_prismatic.frame_b, left_spherical.frame_a) annotation(
    Line(points = {{-70, -20}, {-40, -20}}, color = {95, 95, 95}));
  connect(left_spherical.frame_b, AxleDW.leftCP) annotation(
    Line(points = {{-40, 0}, {-40, 5.5}, {-34, 5.5}, {-34, 6}}, color = {95, 95, 95}));
  connect(right_spherical.frame_b, AxleDW.rightCP) annotation(
    Line(points = {{40, 0}, {40, 5.5}, {34, 5.5}, {34, 6}}, color = {95, 95, 95}));
  connect(right_spherical.frame_a, right_prismatic.frame_b) annotation(
    Line(points = {{40, -20}, {70, -20}}, color = {95, 95, 95}));
  connect(left_prismatic.frame_a, left_free_y.frame_b) annotation(
    Line(points = {{-90, -20}, {-100, -20}, {-100, -30}}, color = {95, 95, 95}));
  connect(left_free_y.frame_a, left_free_x.frame_b) annotation(
    Line(points = {{-100, -50}, {-100, -60}, {-90, -60}}, color = {95, 95, 95}));
  connect(left_free_x.frame_a, left_jounce_ref_fixed.frame_b) annotation(
    Line(points = {{-70, -60}, {-60, -60}}, color = {95, 95, 95}));
  connect(right_prismatic.frame_a, right_free_y.frame_b) annotation(
    Line(points = {{90, -20}, {100, -20}, {100, -30}}, color = {95, 95, 95}));
  connect(right_free_y.frame_a, right_free_x.frame_b) annotation(
    Line(points = {{100, -50}, {100, -60}, {90, -60}}, color = {95, 95, 95}));
  connect(right_free_x.frame_a, right_jounce_ref_fixed.frame_b) annotation(
    Line(points = {{70, -60}, {60, -60}}, color = {95, 95, 95}));
  connect(steer_ramp.y, handwheel_angle.phi_ref) annotation(
    Line(points = {{-88, 80}, {-82, 80}}, color = {0, 0, 127}));
  connect(handwheel_angle.flange, AxleDW.pinionFlange) annotation(
    Line(points = {{-60, 80}, {0, 80}, {0, 25}}));  

  annotation(
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  Diagram(coordinateSystem(extent = {{-120, -100}, {120, 100}})),
  Icon(coordinateSystem(extent = {{-120, -100}, {120, 100}})),
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_INIT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end TestAxleDW;
