within BobLib.Vehicle.Chassis;

model ChassisBase
  import Modelica.Math.Vectors.norm;
  // Axles
  BobLib.Vehicle.Chassis.Suspension.FrAxleBellcrank FrAxle annotation(
    Placement(transformation(origin = {0, 47}, extent = {{-20, -20}, {20, 20}})));
  BobLib.Vehicle.Chassis.Suspension.RrAxleBellcrank RrAxle annotation(
    Placement(transformation(origin = {0, -47}, extent = {{20, -20}, {-20, 20}}, rotation = -180)));
  // Torque inputs
  Modelica.Blocks.Interfaces.RealInput FL_torque annotation(
    Placement(transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 66}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput FR_torque annotation(
    Placement(transformation(origin = {120, 60}, extent = {{20, -20}, {-20, 20}}, rotation = -0), iconTransformation(origin = {120, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput RL_torque annotation(
    Placement(transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -66}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput RR_torque annotation(
    Placement(transformation(origin = {120, -60}, extent = {{20, -20}, {-20, 20}}, rotation = -0), iconTransformation(origin = {120, -66}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
  // Steering input
  Modelica.Blocks.Interfaces.RealInput rack_input annotation(
    Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  // Sprung mass
  Modelica.Mechanics.MultiBody.Parts.Body sprung_mass(r_CM = (RrAxle.effective_center - FrAxle.effective_center)/2,
                                                      m = 200, I_11 = 30, I_22 = 40, I_33 = 50,
                                                      r_0(start = {0, 0, 0.187959}),
                                                      final angles_start = {0, 0, 0},
                                                      final w_0_start = {0, 0, 0},
                                                      final z_0_start = {0, 0, 0}) annotation(
    Placement(transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b world_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation=90)));
protected
  // Ground elements
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics FL_ground annotation(
    Placement(transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics FR_ground annotation(
    Placement(transformation(origin = {50, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics RL_ground annotation(
    Placement(transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Utilities.Mechanics.Multibody.GroundPhysics RR_ground annotation(
    Placement(transformation(origin = {50, -40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  
  // Front to rear connection
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r = RrAxle.effective_center - FrAxle.effective_center,
                                                                       final extra = 0.0) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(FL_torque, FrAxle.FL_torque) annotation(
    Line(points = {{-120, 60}, {-24, 60}}, color = {0, 0, 127}));
  connect(FR_torque, FrAxle.FR_torque) annotation(
    Line(points = {{120, 60}, {24, 60}}, color = {0, 0, 127}));
  connect(RL_torque, RrAxle.RL_torque) annotation(
    Line(points = {{-120, -60}, {-24, -60}}, color = {0, 0, 127}));
  connect(RR_torque, RrAxle.RR_torque) annotation(
    Line(points = {{120, -60}, {24, -60}}, color = {0, 0, 127}));
  connect(FL_ground.frame_b, FrAxle.FL_cp) annotation(
    Line(points = {{-50, 20}, {-50, 28}, {-18, 28}}, color = {95, 95, 95}));
  connect(FR_ground.frame_b, FrAxle.FR_cp) annotation(
    Line(points = {{50, 20}, {50, 28}, {18, 28}}, color = {95, 95, 95}));
  connect(RL_ground.frame_b, RrAxle.RL_cp) annotation(
    Line(points = {{-50, -30}, {-50, -26}, {-18, -26}}, color = {95, 95, 95}));
  connect(RR_ground.frame_b, RrAxle.RR_cp) annotation(
    Line(points = {{50, -30}, {50, -26}, {18, -26}}, color = {95, 95, 95}));
  connect(sprung_mass.frame_a, FrAxle.axle_frame) annotation(
    Line(points = {{40, 50}, {40, 50.5}, {0, 50.5}, {0, 28}}, color = {95, 95, 95}));
  connect(FrAxle.axle_frame, fixedTranslation.frame_a) annotation(
    Line(points = {{0, 28}, {0, 10}}, color = {95, 95, 95}));
  connect(fixedTranslation.frame_b, RrAxle.axle_frame) annotation(
    Line(points = {{0, -10}, {0, -26}}, color = {95, 95, 95}));
  connect(rack_input, FrAxle.steer_input) annotation(
    Line(points = {{0, 120}, {0, 72}}, color = {0, 0, 127}));
  connect(FL_ground.frame_a, world_frame) annotation(
    Line(points = {{-60, 10}, {-80, 10}, {-80, -80}, {0, -80}, {0, -100}}, color = {95, 95, 95}));
  connect(RL_ground.frame_a, world_frame) annotation(
    Line(points = {{-60, -40}, {-80, -40}, {-80, -80}, {0, -80}, {0, -100}}, color = {95, 95, 95}));
  connect(RR_ground.frame_a, world_frame) annotation(
    Line(points = {{60, -40}, {80, -40}, {80, -80}, {0, -80}, {0, -100}}, color = {95, 95, 95}));
  connect(FR_ground.frame_a, world_frame) annotation(
    Line(points = {{60, 10}, {80, 10}, {80, -80}, {0, -80}, {0, -100}}, color = {95, 95, 95}));
end ChassisBase;
