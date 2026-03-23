within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates;

model TestAxleDW
  import Modelica.Mechanics.MultiBody.Frames;
  
  parameter BobLib.Resources.Records.SUS.FrAxleDW FrAxle;
  parameter BobLib.Resources.Records.SUS.FrAxleDWPushBCARB FrAxleBC;
  
  parameter BobLib.Resources.Records.MASSPROPS.FrUnsprung unsprung_mass;
  parameter BobLib.Resources.Records.MASSPROPS.FrUCA uca_mass;
  parameter BobLib.Resources.Records.MASSPROPS.FrLCA lca_mass;
  parameter BobLib.Resources.Records.MASSPROPS.FrTie tie_mass;
  
  parameter BobLib.Resources.Records.TIRES.Fr_tire Fr_tire;
  
  parameter Real link_diameter = 0.020;
  parameter Real joint_diameter = 0.030;
  
  parameter Real left_cp_init[3] = FrAxle.wheel_center + Frames.resolve1(Frames.axesRotations({1, 2, 3}, {FrAxle.static_gamma*Modelica.Constants.pi/180, 0, FrAxle.static_alpha*Modelica.Constants.pi/180}, {0, 0, 0}), {0, 0, -Fr_tire.UNLOADED_RADIUS});
  parameter Real right_cp_init[3] = {left_cp_init[1], -left_cp_init[2], left_cp_init[3]};
  
  BobLib.Vehicle.Chassis.Suspension.FrAxleDW AxleDW(Axle = FrAxle,
                                                    redeclare BobLib.Vehicle.Chassis.Tires.BaseTire left_tire(tire=Fr_tire),
                                                    redeclare BobLib.Vehicle.Chassis.Tires.BaseTire right_tire(tire=Fr_tire),
                                                    left_unsprung_mass=unsprung_mass,
                                                    left_uca_mass=uca_mass,
                                                    left_lca_mass=lca_mass,
                                                    left_tie_mass=tie_mass,
                                                    link_diameter = link_diameter,
                                                    joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {2.72478e-07, 6.44444}, extent = {{-34, -26.4444}, {34, 26.4444}})));
  
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = {FrAxle.wheel_center[1], 0, FrAxle.wheel_center[3]})  annotation(
    Placement(transformation(origin = {0, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Spherical left_spherical(animation = false) annotation(
    Placement(transformation(origin = {-40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed left_jounce_ref_fixed(animation = false, r = left_cp_init) annotation(
    Placement(transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic left_prismatic(animation = false, n = {0, 0, 1}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Position left_position(exact = true, useSupport = true) annotation(
    Placement(transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp left_jounce_ramp(duration = 1, height = 2*0.0254, startTime = 1) annotation(
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
  Modelica.Mechanics.MultiBody.Parts.Fixed right_jounce_ref_fixed(animation = false, r = right_cp_init) annotation(
    Placement(transformation(origin = {50, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Position right_position(exact = true, useSupport = true) annotation(
    Placement(transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp right_jounce_ramp(duration = 1, height = 2*0.0254, startTime = 1) annotation(
    Placement(transformation(origin = {30, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position handwheel_angle(exact = true) annotation(
    Placement(transformation(origin = {-70, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp steer_ramp(duration = 1, height = 100*Modelica.Constants.pi/180, startTime = 1) annotation(
    Placement(transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(fixed.frame_b, AxleDW.axle_frame) annotation(
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
  connect(left_spherical.frame_b, AxleDW.left_cp) annotation(
    Line(points = {{-40, 0}, {-40, 5.5}, {-34, 5.5}, {-34, 6}}, color = {95, 95, 95}));
  connect(right_spherical.frame_b, AxleDW.right_cp) annotation(
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
  connect(handwheel_angle.flange, AxleDW.pinion_flange) annotation(
    Line(points = {{-60, 80}, {0, 80}, {0, 25}}));  
annotation(
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  Diagram(coordinateSystem(extent = {{-120, -100}, {120, 100}})),
  Icon(coordinateSystem(extent = {{-120, -100}, {120, 100}})));
end TestAxleDW;
