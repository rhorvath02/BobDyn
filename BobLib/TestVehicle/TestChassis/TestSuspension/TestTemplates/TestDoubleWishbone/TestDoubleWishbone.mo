within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates.TestDoubleWishbone;

model TestDoubleWishbone
  // Test parameters
  parameter BobLib.Resources.Records.SUS.FrAxleDW Axle annotation(
    Evaluate = false);
  parameter Real link_diameter = 0.020;
  parameter Real joint_diameter = 0.030;
  Vehicle.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoop WishboneUprightLoop(upper_fore_i = Axle.upper_fore_i, upper_aft_i = Axle.upper_aft_i, lower_fore_i = Axle.lower_fore_i, lower_aft_i = Axle.lower_aft_i, upper_o = Axle.upper_outboard, lower_o = Axle.lower_outboard, link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(extent = {{30, -30}, {-30, 30}})));
  Vehicle.Chassis.Suspension.Templates.DoubleWishbone.TieClosure TieClosure(tie_i = Axle.tie_inboard, tie_o = Axle.tie_outboard, link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-10, 60}, extent = {{20, -20}, {-20, 20}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation tie_connection(r = Axle.lower_outboard - Axle.tie_outboard) annotation(
    Placement(transformation(origin = {-40, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed upper_i_fixed(r = (Axle.upper_fore_i + Axle.upper_aft_i)/2, animation = false) annotation(
    Placement(transformation(origin = {70, 21}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed lower_i_fixed(r = (Axle.lower_fore_i + Axle.lower_aft_i)/2, animation = false) annotation(
    Placement(transformation(origin = {70, -21}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed tie_fixed(r = {Axle.tie_inboard[1], 0, Axle.tie_inboard[3]}, animation = false) annotation(
    Placement(transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Joints.Spherical spherical(animation = false) annotation(
    Placement(transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed jounce_ref_fixed(r = Axle.lower_outboard, animation = false) annotation(
    Placement(transformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(useAxisFlange = true, n = {0, 0, 1}, animation = false) annotation(
    Placement(transformation(origin = {-20, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Position position(useSupport = true, exact = true) annotation(
    Placement(transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp jounce_ramp(height = 2*0.0254, duration = 1, startTime = 1) annotation(
    Placement(transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 1, animation = false) annotation(
    Placement(transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.Body body1(m = 1, r_CM = {0, 0, 0}, animation = false) annotation(
    Placement(transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
    Placement(transformation(origin = {90, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic free_x(n = {1, 0, 0}, animation = false) annotation(
    Placement(transformation(origin = {-80, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic free_y(n = {0, 1, 0}, animation = false) annotation(
    Placement(transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}})));
  Vehicle.Chassis.Suspension.Templates.SteeringRack.RackAndPinion RackAndPinion(tie_i = Axle.tie_inboard, c_factor = 0.088646, link_diameter = link_diameter)  annotation(
    Placement(transformation(origin = {50, 60}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Mechanics.Rotational.Sources.Position handwheel_angle(exact = true) annotation(
    Placement(transformation(origin = {20, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp steer_ramp(duration = 1, height = 100*Modelica.Constants.pi/180, startTime = 1) annotation(
    Placement(transformation(origin = {-20, 90}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(TieClosure.tie_o_frame, tie_connection.frame_a) annotation(
    Line(points = {{-30, 60}, {-40, 60}, {-40, 20}}, color = {95, 95, 95}));
  connect(tie_connection.frame_b, WishboneUprightLoop.steering_frame) annotation(
    Line(points = {{-40, 0}, {-40, -21.375}, {-30, -21.375}, {-30, -21}}, color = {95, 95, 95}));
  connect(lower_i_fixed.frame_b, WishboneUprightLoop.lower_i_frame) annotation(
    Line(points = {{60, -21}, {30, -21}}, color = {95, 95, 95}));
  connect(upper_i_fixed.frame_b, WishboneUprightLoop.upper_i_frame) annotation(
    Line(points = {{60, 21}, {30, 21}}, color = {95, 95, 95}));
  connect(spherical.frame_b, WishboneUprightLoop.lower_o_frame) annotation(
    Line(points = {{0, -50}, {0, -30}}, color = {95, 95, 95}));
  connect(prismatic.frame_b, spherical.frame_a) annotation(
    Line(points = {{-10, -90}, {0, -90}, {0, -70}}, color = {95, 95, 95}));
  connect(position.flange, prismatic.axis) annotation(
    Line(points = {{-40, -50}, {-12, -50}, {-12, -84}}, color = {0, 127, 0}));
  connect(jounce_ramp.y, position.s_ref) annotation(
    Line(points = {{-78, -50}, {-62, -50}}, color = {0, 0, 127}));
  connect(body1.frame_a, WishboneUprightLoop.lower_o_frame) annotation(
    Line(points = {{-60, -30}, {0, -30}}, color = {95, 95, 95}));
  connect(body.frame_a, WishboneUprightLoop.upper_o_frame) annotation(
    Line(points = {{-60, 30}, {0, 30}}, color = {95, 95, 95}));
  connect(jounce_ref_fixed.frame_b, free_x.frame_a) annotation(
    Line(points = {{-100, -90}, {-90, -90}}, color = {95, 95, 95}));
  connect(free_x.frame_b, free_y.frame_a) annotation(
    Line(points = {{-70, -90}, {-60, -90}}, color = {95, 95, 95}));
  connect(free_y.frame_b, prismatic.frame_a) annotation(
    Line(points = {{-40, -90}, {-30, -90}}, color = {95, 95, 95}));
  connect(position.support, prismatic.support) annotation(
    Line(points = {{-50, -60}, {-24, -60}, {-24, -84}}, color = {0, 127, 0}));
  connect(RackAndPinion.left_frame, TieClosure.tie_i_frame) annotation(
    Line(points = {{30, 60}, {10, 60}}, color = {95, 95, 95}));
  connect(tie_fixed.frame_b, RackAndPinion.mount_frame) annotation(
    Line(points = {{80, 50}, {50, 50}, {50, 56}}, color = {95, 95, 95}));
  connect(steer_ramp.y, handwheel_angle.phi_ref) annotation(
    Line(points = {{-8, 90}, {8, 90}}, color = {0, 0, 127}));
  connect(handwheel_angle.flange, RackAndPinion.pinion_flange) annotation(
    Line(points = {{30, 90}, {50, 90}, {50, 64}}));
  annotation(
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
end TestDoubleWishbone;
