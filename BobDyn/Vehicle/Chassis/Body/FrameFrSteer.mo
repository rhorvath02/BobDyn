within BobDyn.Vehicle.Chassis.Body;
model FrameFrSteer
  import Modelica.Math.Vectors.norm;
  
  extends PartialFrame(Fr_to_FL_tie_i(r = FL_tie_i - Fr_rack), Fr_to_FR_tie_i(r = FR_tie_i - Fr_rack), Rr_to_RL_tie_i(r = RL_tie_i - Rr_avg), Rr_to_RR_tie_i(r = RR_tie_i - Rr_avg));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_rack(r = Fr_rack - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic rack_travel_left(s(fixed = true), n = {0, 1, 0}, useAxisFlange = true) annotation(
    Placement(transformation(origin = {-20, 120}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic rack_travel_right(s(fixed = true), n = {0, 1, 0}, useAxisFlange = true, animation = true)  annotation(
    Placement(transformation(origin = {20, 120}, extent = {{-10, -10}, {10, 10}})));
  
  final parameter Real Fr_rack[3] = (FL_tie_i + FR_tie_i)/2;
  
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(transformation(origin = {0, 250}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 298}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sources.Position position(useSupport = false)  annotation(
    Placement(transformation(origin = {0, 180}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

equation
  connect(Fr_to_rack.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{0, 80}, {0, 40}}, color = {95, 95, 95}));
  connect(Fr_to_rack.frame_b, rack_travel_right.frame_a) annotation(
    Line(points = {{0, 100}, {0, 120}, {10, 120}}, color = {95, 95, 95}));
  connect(rack_travel_right.frame_b, Fr_to_FR_tie_i.frame_a) annotation(
    Line(points = {{30, 120}, {60, 120}}, color = {95, 95, 95}));
  connect(position.flange, rack_travel_left.axis) annotation(
    Line(points = {{0, 170}, {0, 140}, {-28, 140}, {-28, 126}}, color = {0, 127, 0}));
  connect(position.flange, rack_travel_right.axis) annotation(
    Line(points = {{0, 170}, {0, 140}, {28, 140}, {28, 126}}, color = {0, 127, 0}));
  connect(u, position.s_ref) annotation(
    Line(points = {{0, 250}, {0, 192}}, color = {0, 0, 127}));
  connect(Rr_to_RL_tie_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{-60, -120}, {-40, -120}, {-40, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(Rr_to_RR_tie_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{60, -120}, {40, -120}, {40, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(rack_travel_left.frame_a, Fr_to_rack.frame_b) annotation(
    Line(points = {{-10, 120}, {0, 120}, {0, 100}}, color = {95, 95, 95}));
  connect(Fr_to_FL_tie_i.frame_a, rack_travel_left.frame_b) annotation(
    Line(points = {{-60, 120}, {-30, 120}}, color = {95, 95, 95}));
end FrameFrSteer;
