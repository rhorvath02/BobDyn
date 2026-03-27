within BobLib.TestVehicle.TestChassis.TestTires;
model TestMF5p2RigidVehicle
  import Modelica.Math.Vectors.norm;
  
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-110, -110}, extent = {{-10, -10}, {10, 10}})));
  // Outputs
  Real body_accels[3];
  Real normal_loads[4];
  Real long_LT;
  Real lat_LT;
  Real calc_RL;
  
  // Tires
  BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF5p2Tire FL_tire  annotation(
    Placement(transformation(origin = {-70, 80}, extent = {{10, -10}, {-10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF5p2Tire FR_tire  annotation(
    Placement(transformation(origin = {70, 80}, extent = {{-10, -10}, {10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF5p2Tire RL_tire  annotation(
    Placement(transformation(origin = {-50, -20}, extent = {{10, -10}, {-10, 10}})));
  BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF5p2Tire RR_tire  annotation(
    Placement(transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics FL_ground annotation(
    Placement(transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics FR_ground annotation(
    Placement(transformation(origin = {70, 40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Utilities.Mechanics.Multibody.GroundPhysics RL_ground annotation(
    Placement(transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics RR_ground annotation(
    Placement(transformation(origin = {50, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.Ramp ramp(height = 230, duration = 5, startTime = 1)  annotation(
    Placement(transformation(origin = {-210, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(transformation(origin = {-150, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position left_steer annotation(
    Placement(transformation(origin = {-46, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Rotational.Sources.Position right_steer annotation(
    Placement(transformation(origin = {46, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute left_revolute(useAxisFlange = true)  annotation(
    Placement(transformation(origin = {-46, 80}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute right_revolute(useAxisFlange = true)  annotation(
    Placement(transformation(origin = {46, 80}, extent = {{-10, -10}, {10, 10}})));

protected

  // System inputs
  
  // Ground interfaces
  Modelica.Mechanics.MultiBody.Parts.Fixed FL_fixed(r = {1, 1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {-130, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed FR_fixed(r = {1, -1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {130, 40}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed RL_fixed(r = {-1, 1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed RR_fixed(r = {-1, -1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {110, -60}, extent = {{10, -10}, {-10, 10}})));
      // Vehicle geometry
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation FL_track(r = {0, 1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {-20, 80}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation FR_track(r = {0, -1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {20, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation RL_track(r = {0, 1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {-20, -20}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation RR_track(r = {0, -1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {20, -20}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_Rr_track(r = {-2, 0, 0}, animation = false)  annotation(
    Placement(transformation(origin = {0, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_CG(r = {-1, 0, 0}, animation = false)  annotation(
    Placement(transformation(origin = {20, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  // Vehicle mass
  Modelica.Mechanics.MultiBody.Parts.Body Body(r_CM = {0, 0, 0}, m = 150, I_11 = 40, I_22 = 50, I_33 = 60, animation = true, useQuaternions = false, angles_fixed = true, angles_start = {0, 0, 0})  annotation(
    Placement(transformation(origin = {20, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  // Steering interface
public
  Modelica.Blocks.Sources.Ramp ramp1(duration = 5, height = 15*Modelica.Constants.pi/180, startTime = 1) annotation(
    Placement(transformation(origin = {-210, 130}, extent = {{-10, -10}, {10, 10}})));
equation
  body_accels = Modelica.Mechanics.MultiBody.Frames.resolve2(Body.frame_a.R, Body.a_0);
  normal_loads[1] = FL_tire.Fz;
  normal_loads[2] = FR_tire.Fz;
  normal_loads[3] = RL_tire.Fz;
  normal_loads[4] = RR_tire.Fz;
  long_LT = Body.m*body_accels[1]*Body.r_0[3]/norm(FL_tire.cp_frame.r_0 - RL_tire.cp_frame.r_0);
  lat_LT = Body.m*body_accels[2]*Body.r_0[3]/norm(FL_tire.cp_frame.r_0 - FR_tire.cp_frame.r_0);
  calc_RL = Body.m*Modelica.Constants.g_n/4 + long_LT/2 - lat_LT/2;
  connect(Fr_to_Rr_track.frame_a, FL_track.frame_a) annotation(
    Line(points = {{0, 40}, {0, 80}, {-10, 80}}, color = {95, 95, 95}));
  connect(Fr_to_Rr_track.frame_a, FR_track.frame_a) annotation(
    Line(points = {{0, 40}, {0, 80}, {10, 80}}, color = {95, 95, 95}));
  connect(Fr_to_Rr_track.frame_b, RL_track.frame_a) annotation(
    Line(points = {{0, 20}, {0, -20}, {-10, -20}}, color = {95, 95, 95}));
  connect(RL_track.frame_b, RL_tire.chassis_frame) annotation(
    Line(points = {{-30, -20}, {-40, -20}}, color = {95, 95, 95}));
  connect(Fr_to_Rr_track.frame_b, RR_track.frame_a) annotation(
    Line(points = {{0, 20}, {0, -20}, {10, -20}}, color = {95, 95, 95}));
  connect(RR_track.frame_b, RR_tire.chassis_frame) annotation(
    Line(points = {{30, -20}, {40, -20}}, color = {95, 95, 95}));
  connect(Fr_to_CG.frame_a, Fr_to_Rr_track.frame_a) annotation(
    Line(points = {{20, 40}, {20, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(Body.frame_a, Fr_to_CG.frame_b) annotation(
    Line(points = {{20, 10}, {20, 20}}, color = {95, 95, 95}));
  connect(FL_tire.cp_frame, FL_ground.frame_b) annotation(
    Line(points = {{-70, 70}, {-70, 50}}, color = {95, 95, 95}));
  connect(FL_ground.frame_a, FL_fixed.frame_b) annotation(
    Line(points = {{-80, 40}, {-120, 40}}, color = {95, 95, 95}));
  connect(FR_fixed.frame_b, FR_ground.frame_a) annotation(
    Line(points = {{120, 40}, {80, 40}}, color = {95, 95, 95}));
  connect(FR_tire.cp_frame, FR_ground.frame_b) annotation(
    Line(points = {{70, 70}, {70, 50}}, color = {95, 95, 95}));
  connect(RL_fixed.frame_b, RL_ground.frame_a) annotation(
    Line(points = {{-100, -60}, {-60, -60}}, color = {95, 95, 95}));
  connect(RL_ground.frame_b, RL_tire.cp_frame) annotation(
    Line(points = {{-50, -50}, {-50, -30}}, color = {95, 95, 95}));
  connect(RR_fixed.frame_b, RR_ground.frame_a) annotation(
    Line(points = {{100, -60}, {60, -60}}, color = {95, 95, 95}));
  connect(RR_ground.frame_b, RR_tire.cp_frame) annotation(
    Line(points = {{50, -50}, {50, -30}}, color = {95, 95, 95}));
  connect(ramp.y, torque.tau) annotation(
    Line(points = {{-198, -40}, {-162, -40}}, color = {0, 0, 127}));
  connect(torque.flange, RL_tire.hub_input) annotation(
    Line(points = {{-140, -40}, {-60, -40}, {-60, -20}}));
  connect(torque.flange, RR_tire.hub_input) annotation(
    Line(points = {{-140, -40}, {60, -40}, {60, -20}}));
  connect(FL_track.frame_b, left_revolute.frame_a) annotation(
    Line(points = {{-30, 80}, {-36, 80}}, color = {95, 95, 95}));
  connect(left_revolute.frame_b, FL_tire.chassis_frame) annotation(
    Line(points = {{-56, 80}, {-60, 80}}, color = {95, 95, 95}));
  connect(FR_track.frame_b, right_revolute.frame_a) annotation(
    Line(points = {{30, 80}, {36, 80}}, color = {95, 95, 95}));
  connect(right_revolute.frame_b, FR_tire.chassis_frame) annotation(
    Line(points = {{56, 80}, {60, 80}}, color = {95, 95, 95}));
  connect(right_steer.flange, right_revolute.axis) annotation(
    Line(points = {{46, 100}, {46, 90}}));
  connect(left_steer.flange, left_revolute.axis) annotation(
    Line(points = {{-46, 100}, {-46, 90}}));
  connect(ramp1.y, left_steer.phi_ref) annotation(
    Line(points = {{-198, 130}, {-46, 130}, {-46, 122}}, color = {0, 0, 127}));
  connect(ramp1.y, right_steer.phi_ref) annotation(
    Line(points = {{-198, 130}, {46, 130}, {46, 122}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian -d=bltdump",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"),
  Diagram(coordinateSystem(extent = {{-240, 140}, {100, -120}})));
end TestMF5p2RigidVehicle;
