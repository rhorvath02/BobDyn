within BobDyn.TestVehicle.TestChassis.TestTires;
model TestMF5p2RigidVehicle
  import Modelica.Math.Vectors.norm;
  
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1})  annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  // Outputs
  Real body_accels[3];
  Real normal_loads[4];
  Real long_LT;
  Real lat_LT;
  Real calc_RL;
  // Tires
  BobDyn.Vehicle.Chassis.Tires.MF5p2Tire FL_tire  annotation(
    Placement(transformation(origin = {-70, 80}, extent = {{10, -10}, {-10, 10}})));
  BobDyn.Vehicle.Chassis.Tires.MF5p2Tire FR_tire  annotation(
    Placement(transformation(origin = {70, 80}, extent = {{-10, -10}, {10, 10}})));
  BobDyn.Vehicle.Chassis.Tires.MF5p2Tire RL_tire  annotation(
    Placement(transformation(origin = {-50, -20}, extent = {{10, -10}, {-10, 10}})));
  BobDyn.Vehicle.Chassis.Tires.MF5p2Tire RR_tire  annotation(
    Placement(transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 3.31)  annotation(
    Placement(transformation(origin = {-98, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp P_ramp(height = 80e3, duration = 3, startTime = 2)  annotation(
    Placement(transformation(origin = {-200, 50}, extent = {{-10, -10}, {10, 10}})));
protected
  // System inputs
  Modelica.Blocks.Sources.Ramp rack_disp(height = 10*Modelica.Constants.pi/180, duration = 0.5, startTime = 10)  annotation(
    Placement(transformation(origin = {-70, 130}, extent = {{-10, -10}, {10, 10}})));

// Ground interfaces
  Modelica.Mechanics.MultiBody.Parts.Fixed FL_fixed(r = {1, 1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed FR_fixed(r = {1, -1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {90, 40}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed RL_fixed(r = {-1, 1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed RR_fixed(r = {-1, -1, 0}, animation = false)  annotation(
    Placement(transformation(origin = {90, -60}, extent = {{10, -10}, {-10, 10}})));

  Utilities.Mechanics.Multibody.GroundPhysics FL_ground(c = 1e8, d = 1e4)  annotation(
    Placement(transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics FR_ground(c = 1e8, d = 1e4)  annotation(
    Placement(transformation(origin = {50, 40}, extent = {{10, -10}, {-10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics RL_ground(c = 1e8, d = 1e4)  annotation(
    Placement(transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}})));
  Utilities.Mechanics.Multibody.GroundPhysics RR_ground(c = 1e8, d = 1e4)  annotation(
    Placement(transformation(origin = {50, -60}, extent = {{10, -10}, {-10, 10}})));
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
  Modelica.Mechanics.MultiBody.Parts.Body Body(r_CM = {0, 0, 0}, m = 150, r_0(start = {0, 0, FL_tire.R0}, each fixed = true), I_11 = 40, I_22 = 50, I_33 = 60, animation = true, w_a(start = {0, 0, 0}, each fixed = true), v_0(start = {0, 0, 0}, each fixed = true))  annotation(
    Placement(transformation(origin = {20, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  // Steering interface
  Modelica.Mechanics.MultiBody.Joints.Revolute left_revolute(useAxisFlange = true, animation = false, w(start = 0, each fixed = true))  annotation(
    Placement(transformation(origin = {-44, 80}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute right_revolute(useAxisFlange = true, animation = false, w(start = 0, each fixed = true))  annotation(
    Placement(transformation(origin = {44, 80}, extent = {{-10, -10}, {10, 10}})));
    
  Modelica.Mechanics.Rotational.Sources.Position left_steer(useSupport = true)  annotation(
    Placement(transformation(origin = {-44, 106}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Sources.Position right_steer(useSupport = true) annotation(
    Placement(transformation(origin = {44, 106}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  BobDyn.Vehicle.Powertrain.Battery.BatteryPack batt(Np = 4, Ns = 140, SOC_start = 1.0, E_cell = 38880, R_cell = 0.017) annotation(
    Placement(transformation(origin = {-170, -20}, extent = {{-10, -10}, {10, 10}})));
  BobDyn.Vehicle.Powertrain.Electronics.InverterDC inv annotation(
    Placement(transformation(origin = {-170, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground g annotation(
    Placement(transformation(origin = {-200, -50}, extent = {{-10, -10}, {10, 10}})));
  BobDyn.Vehicle.Powertrain.Drivetrain.Motor motor annotation(
    Placement(transformation(origin = {-130, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  body_accels = Modelica.Mechanics.MultiBody.Frames.resolve2(Body.frame_a.R, Body.a_0);
  normal_loads[1] = FL_tire.Fz;
  normal_loads[2] = FR_tire.Fz;
  normal_loads[3] = RL_tire.Fz;
  normal_loads[4] = RR_tire.Fz;
  long_LT = Body.m*body_accels[1]*Body.r_0[3]/norm(FL_tire.cp_frame.r_0 - RL_tire.cp_frame.r_0);
  lat_LT = Body.m*body_accels[2]*Body.r_0[3]/norm(FL_tire.cp_frame.r_0 - FR_tire.cp_frame.r_0);
  calc_RL = Body.m*Modelica.Constants.g_n/4 + long_LT/2 - lat_LT/2;
  connect(FL_fixed.frame_b, FL_ground.frame_a) annotation(
    Line(points = {{-80, 40}, {-60, 40}}, color = {95, 95, 95}));
  connect(FL_ground.frame_b, FL_tire.cp_frame) annotation(
    Line(points = {{-50, 50}, {-50, 60}, {-70, 60}, {-70, 70}}, color = {95, 95, 95}));
  connect(FR_fixed.frame_b, FR_ground.frame_a) annotation(
    Line(points = {{80, 40}, {60, 40}}, color = {95, 95, 95}));
  connect(FR_ground.frame_b, FR_tire.cp_frame) annotation(
    Line(points = {{50, 50}, {50, 60}, {70, 60}, {70, 70}}, color = {95, 95, 95}));
  connect(RL_fixed.frame_b, RL_ground.frame_a) annotation(
    Line(points = {{-80, -60}, {-60, -60}}, color = {95, 95, 95}));
  connect(RL_ground.frame_b, RL_tire.cp_frame) annotation(
    Line(points = {{-50, -50}, {-50, -30}}, color = {95, 95, 95}));
  connect(RR_fixed.frame_b, RR_ground.frame_a) annotation(
    Line(points = {{80, -60}, {60, -60}}, color = {95, 95, 95}));
  connect(RR_ground.frame_b, RR_tire.cp_frame) annotation(
    Line(points = {{50, -50}, {50, -30}}, color = {95, 95, 95}));
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
  connect(FL_track.frame_b, left_revolute.frame_a) annotation(
    Line(points = {{-30, 80}, {-34, 80}}, color = {95, 95, 95}));
  connect(left_revolute.frame_b, FL_tire.chassis_frame) annotation(
    Line(points = {{-54, 80}, {-60, 80}}, color = {95, 95, 95}));
  connect(FR_track.frame_b, right_revolute.frame_a) annotation(
    Line(points = {{30, 80}, {34, 80}}, color = {95, 95, 95}));
  connect(right_revolute.frame_b, FR_tire.chassis_frame) annotation(
    Line(points = {{54, 80}, {60, 80}}, color = {95, 95, 95}));
  connect(left_steer.support, left_revolute.support) annotation(
    Line(points = {{-34, 106}, {-34, 90}, {-38, 90}}));
  connect(rack_disp.y, left_steer.phi_ref) annotation(
    Line(points = {{-58, 130}, {-44, 130}, {-44, 118}}, color = {0, 0, 127}));
  connect(left_steer.flange, left_revolute.axis) annotation(
    Line(points = {{-44, 96}, {-44, 90}}));
  connect(right_steer.support, right_revolute.support) annotation(
    Line(points = {{34, 106}, {34, 90}, {38, 90}}));
  connect(right_steer.flange, right_revolute.axis) annotation(
    Line(points = {{44, 96}, {44, 90}}));
  connect(right_steer.phi_ref, rack_disp.y) annotation(
    Line(points = {{44, 118}, {44, 130}, {-58, 130}}, color = {0, 0, 127}));
  connect(g.p, batt.p) annotation(
    Line(points = {{-200, -40}, {-200, -20}, {-180, -20}}, color = {0, 0, 255}));
  connect(inv.p, batt.p) annotation(
    Line(points = {{-180, 30}, {-190, 30}, {-190, -20}, {-180, -20}}, color = {0, 0, 255}));
  connect(inv.n, batt.n) annotation(
    Line(points = {{-160, 30}, {-150, 30}, {-150, -20}, {-160, -20}}, color = {0, 0, 255}));
  connect(inv.P_out, motor.P_elec) annotation(
    Line(points = {{-170, 19}, {-170, -1}, {-142, -1}}, color = {0, 0, 127}));
  connect(motor.shaft, idealGear.flange_a) annotation(
    Line(points = {{-120, 0}, {-108, 0}}));
  connect(idealGear.flange_b, RL_tire.hub_input) annotation(
    Line(points = {{-88, 0}, {-60, 0}, {-60, -20}}));
  connect(idealGear.flange_b, RR_tire.hub_input) annotation(
    Line(points = {{-88, 0}, {60, 0}, {60, -20}}));
  connect(P_ramp.y, inv.P_req) annotation(
    Line(points = {{-188, 50}, {-170, 50}, {-170, 42}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"),
  Diagram(coordinateSystem(extent = {{-240, 140}, {100, -120}})));
end TestMF5p2RigidVehicle;
