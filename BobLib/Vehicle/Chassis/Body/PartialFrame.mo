within BobLib.Vehicle.Chassis.Body;
partial model PartialFrame
  import Modelica.SIunits;
  
  parameter SIunits.Position CG_location[3] annotation(Dialog(group="Geometry"));
  
  // Mass parameters
  parameter SIunits.Mass front_mass annotation(Dialog(group="Mass"));
  parameter SIunits.Mass rear_mass annotation(Dialog(group="Mass"));
  
  // FL node parameters
  parameter SIunits.Position FL_upper_fore_i[3] annotation(Dialog(group="Geometry"));
  parameter SIunits.Position FL_upper_aft_i[3] annotation(Dialog(group="Geometry"));
  parameter SIunits.Position FL_tie_i[3] annotation(Dialog(group="Geometry"));
  parameter SIunits.Position FL_lower_fore_i[3] annotation(Dialog(group="Geometry"));
  parameter SIunits.Position FL_lower_aft_i[3] annotation(Dialog(group="Geometry"));
  
  // FR node parameters
  parameter SIunits.Position FR_upper_fore_i[3] = {FL_upper_fore_i[1], -FL_upper_fore_i[2], FL_upper_fore_i[3]} annotation(Dialog(group="Geometry"));
  parameter SIunits.Position FR_upper_aft_i[3] = {FL_upper_aft_i[1], -FL_upper_aft_i[2], FL_upper_aft_i[3]} annotation(Dialog(group="Geometry"));
  parameter SIunits.Position FR_tie_i[3] = {FL_tie_i[1], -FL_tie_i[2], FL_tie_i[3]} annotation(Dialog(group="Geometry"));
  parameter SIunits.Position FR_lower_fore_i[3] = {FL_lower_fore_i[1], -FL_lower_fore_i[2], FL_lower_fore_i[3]} annotation(Dialog(group="Geometry"));
  parameter SIunits.Position FR_lower_aft_i[3] = {FL_lower_aft_i[1], -FL_lower_aft_i[2], FL_lower_aft_i[3]} annotation(Dialog(group="Geometry"));
  
  // RL node parameters
  parameter SIunits.Position RL_upper_fore_i[3] annotation(Dialog(group="Geometry"));
  parameter SIunits.Position RL_upper_aft_i[3] annotation(Dialog(group="Geometry"));
  parameter SIunits.Position RL_tie_i[3] annotation(Dialog(group="Geometry"));
  parameter SIunits.Position RL_lower_fore_i[3] annotation(Dialog(group="Geometry"));
  parameter SIunits.Position RL_lower_aft_i[3] annotation(Dialog(group="Geometry"));
  
  // RR node parameters
  parameter SIunits.Position RR_upper_fore_i[3] = {RL_upper_fore_i[1], -RL_upper_fore_i[2], RL_upper_fore_i[3]} annotation(Dialog(group="Geometry"));
  parameter SIunits.Position RR_upper_aft_i[3] = {RL_upper_aft_i[1], -RL_upper_aft_i[2], RL_upper_aft_i[3]} annotation(Dialog(group="Geometry"));
  parameter SIunits.Position RR_tie_i[3] = {RL_tie_i[1], -RL_tie_i[2], RL_tie_i[3]} annotation(Dialog(group="Geometry"));
  parameter SIunits.Position RR_lower_fore_i[3] = {RL_lower_fore_i[1], -RL_lower_fore_i[2], RL_lower_fore_i[3]} annotation(Dialog(group="Geometry"));
  parameter SIunits.Position RR_lower_aft_i[3] = {RL_lower_aft_i[1], -RL_lower_aft_i[2], RL_lower_aft_i[3]} annotation(Dialog(group="Geometry"));
  
  // Fr/Rr reference points
  final parameter Real Fr_avg[3] = (FL_upper_fore_i + FL_upper_aft_i + FL_lower_fore_i + FL_lower_aft_i + FR_upper_fore_i + FR_upper_aft_i + FR_lower_fore_i + FR_lower_aft_i) / 8;
  final parameter Real Rr_avg[3] = (RL_upper_fore_i + RL_upper_aft_i + RL_lower_fore_i + RL_lower_aft_i + RR_upper_fore_i + RR_upper_aft_i + RR_lower_fore_i + RR_lower_aft_i) / 8;
  
  // Masses
  Modelica.Mechanics.MultiBody.Parts.Body front_body(r_CM = {0, 0, 0}, m = front_mass)  annotation(
    Placement(transformation(origin = {-20, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.Body rear_body(r_CM = {0, 0, 0}, m = rear_mass)  annotation(
    Placement(transformation(origin = {-20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

  
  // CG Frame
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(extent = {{-16, -16}, {16, 16}}, rotation = -90)));

  // FL Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FL_upper_fore_i_frame annotation(
    Placement(transformation(origin = {-100, 220}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, 566}, extent = {{-16, -16}, {16, 16}})));  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FL_upper_aft_i_frame annotation(
    Placement(transformation(origin = {-100, 180}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, 434}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FL_tie_i_frame annotation(
    Placement(transformation(origin = {-100, 120}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, 298}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FL_lower_fore_i_frame annotation(
    Placement(transformation(origin = {-100, 60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, 166}, extent = {{-16, -16}, {16, 16}})));  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FL_lower_aft_i_frame annotation(
    Placement(transformation(origin = {-100, 20}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, 33}, extent = {{-16, -16}, {16, 16}})));
    
  // FR Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FR_upper_fore_i_frame annotation(
    Placement(transformation(origin = {100, 220}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, 566}, extent = {{-16, -16}, {16, 16}})));  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FR_upper_aft_i_frame annotation(
    Placement(transformation(origin = {100, 180}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, 434}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FR_tie_i_frame annotation(
    Placement(transformation(origin = {100, 120}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, 298}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FR_lower_fore_i_frame annotation(
    Placement(transformation(origin = {100, 60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, 166}, extent = {{-16, -16}, {16, 16}})));  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b FR_lower_aft_i_frame annotation(
    Placement(transformation(origin = {100, 20}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, 33}, extent = {{-16, -16}, {16, 16}})));
  
  // RL Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RL_upper_fore_i_frame annotation(
    Placement(transformation(origin = {-100, -20}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, -33}, extent = {{-16, -16}, {16, 16}})));  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RL_upper_aft_i_frame annotation(
    Placement(transformation(origin = {-100, -60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, -166}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RL_tie_i_frame annotation(
    Placement(transformation(origin = {-100, -120}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, -298}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RL_lower_fore_i_frame annotation(
    Placement(transformation(origin = {-100, -180}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, -434}, extent = {{-16, -16}, {16, 16}})));  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RL_lower_aft_i_frame annotation(
    Placement(transformation(origin = {-100, -220}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-300, -566}, extent = {{-16, -16}, {16, 16}})));
  
  // RR Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RR_upper_fore_i_frame annotation(
    Placement(transformation(origin = {100, -20}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, -33}, extent = {{-16, -16}, {16, 16}})));  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RR_upper_aft_i_frame annotation(
    Placement(transformation(origin = {100, -60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, -166}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RR_tie_i_frame annotation(
    Placement(transformation(origin = {100, -120}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, -298}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RR_lower_fore_i_frame annotation(
    Placement(transformation(origin = {100, -180}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, -434}, extent = {{-16, -16}, {16, 16}})));  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b RR_lower_aft_i_frame annotation(
    Placement(transformation(origin = {100, -220}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {300, -566}, extent = {{-16, -16}, {16, 16}})));
  
  // Fr/Rr translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation CG_to_Fr(r = Fr_avg - CG_location, animation = true)  annotation(
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation CG_to_Rr(r = Rr_avg - CG_location, animation = true)  annotation(
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  // FL translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FL_lower_aft_i(r = FL_lower_aft_i - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {-70, 20}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FL_lower_fore_i(r = FL_lower_fore_i - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {-70, 60}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FL_tie_i(animation = false)  annotation(
    Placement(transformation(origin = {-70, 120}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FL_upper_aft_i(r = FL_upper_aft_i - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {-70, 180}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FL_upper_fore_i(r = FL_upper_fore_i - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {-70, 220}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  
  // FR translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FR_lower_aft_i(r = FR_lower_aft_i - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FR_lower_fore_i(r = FR_lower_fore_i - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FR_tie_i(animation = false)  annotation(
    Placement(transformation(origin = {70, 120}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FR_upper_aft_i(r = FR_upper_aft_i - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {70, 180}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Fr_to_FR_upper_fore_i(r = FR_upper_fore_i - Fr_avg, animation = false)  annotation(
    Placement(transformation(origin = {70, 220}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  
  // RL translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RL_lower_aft_i(r = RL_lower_aft_i - Rr_avg, animation = true)  annotation(
    Placement(transformation(origin = {-70, -220}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RL_lower_fore_i(r = RL_lower_fore_i - Rr_avg, animation = true)  annotation(
    Placement(transformation(origin = {-70, -180}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RL_tie_i(animation = false)  annotation(
    Placement(transformation(origin = {-70, -120}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RL_upper_aft_i(r = RL_upper_aft_i - Rr_avg, animation = true)  annotation(
    Placement(transformation(origin = {-70, -60}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RL_upper_fore_i(r = RL_upper_fore_i - Rr_avg, animation = true)  annotation(
    Placement(transformation(origin = {-70, -20}, extent = {{10, -10}, {-10, 10}})));
  
  // RR translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RR_lower_aft_i(r = RR_lower_aft_i - Rr_avg, animation = true)  annotation(
    Placement(transformation(origin = {70, -220}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RR_lower_fore_i(r = RR_lower_fore_i - Rr_avg, animation = true)  annotation(
    Placement(transformation(origin = {70, -180}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RR_tie_i(animation = false)  annotation(
    Placement(transformation(origin = {70, -120}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RR_upper_aft_i(r = RR_upper_aft_i - Rr_avg, animation = true)  annotation(
    Placement(transformation(origin = {70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Rr_to_RR_upper_fore_i(r = RR_upper_fore_i - Rr_avg, animation = true)  annotation(
    Placement(transformation(origin = {70, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));

equation
  connect(Fr_to_FL_lower_aft_i.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{-60, 20}, {-40, 20}, {-40, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(Fr_to_FL_lower_fore_i.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{-60, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(Fr_to_FL_upper_aft_i.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{-60, 180}, {-40, 180}, {-40, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(Fr_to_FR_lower_aft_i.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{60, 20}, {40, 20}, {40, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(Fr_to_FR_lower_fore_i.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{60, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(Fr_to_FR_upper_aft_i.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{60, 180}, {40, 180}, {40, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(CG_to_Fr.frame_a, CG_to_Rr.frame_a) annotation(
    Line(points = {{0, 20}, {0, -20}}, color = {95, 95, 95}));
  connect(Rr_to_RL_upper_fore_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{-60, -20}, {-40, -20}, {-40, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(Rr_to_RL_upper_aft_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{-60, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(Rr_to_RL_lower_fore_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{-60, -180}, {-40, -180}, {-40, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(Rr_to_RL_lower_aft_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{-60, -220}, {-40, -220}, {-40, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(Rr_to_RR_upper_fore_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{60, -20}, {40, -20}, {40, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(Rr_to_RR_upper_aft_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{60, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(Rr_to_RR_lower_fore_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{60, -180}, {40, -180}, {40, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(Rr_to_RR_lower_aft_i.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{60, -220}, {40, -220}, {40, -60}, {0, -60}, {0, -40}}, color = {95, 95, 95}));
  connect(FL_upper_fore_i_frame, Fr_to_FL_upper_fore_i.frame_b) annotation(
    Line(points = {{-100, 220}, {-80, 220}}));
  connect(FL_upper_aft_i_frame, Fr_to_FL_upper_aft_i.frame_b) annotation(
    Line(points = {{-100, 180}, {-80, 180}}));
  connect(FL_tie_i_frame, Fr_to_FL_tie_i.frame_b) annotation(
    Line(points = {{-100, 120}, {-80, 120}}));
  connect(FL_lower_fore_i_frame, Fr_to_FL_lower_fore_i.frame_b) annotation(
    Line(points = {{-100, 60}, {-80, 60}}));
  connect(FL_lower_aft_i_frame, Fr_to_FL_lower_aft_i.frame_b) annotation(
    Line(points = {{-100, 20}, {-80, 20}}));
  connect(RL_upper_fore_i_frame, Rr_to_RL_upper_fore_i.frame_b) annotation(
    Line(points = {{-100, -20}, {-80, -20}}));
  connect(RL_upper_aft_i_frame, Rr_to_RL_upper_aft_i.frame_b) annotation(
    Line(points = {{-100, -60}, {-80, -60}}));
  connect(RL_tie_i_frame, Rr_to_RL_tie_i.frame_b) annotation(
    Line(points = {{-100, -120}, {-80, -120}}));
  connect(RL_lower_fore_i_frame, Rr_to_RL_lower_fore_i.frame_b) annotation(
    Line(points = {{-100, -180}, {-80, -180}}));
  connect(RL_lower_aft_i_frame, Rr_to_RL_lower_aft_i.frame_b) annotation(
    Line(points = {{-100, -220}, {-80, -220}}));
  connect(Fr_to_FR_upper_fore_i.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{60, 220}, {40, 220}, {40, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(Fr_to_FR_upper_fore_i.frame_b, FR_upper_fore_i_frame) annotation(
    Line(points = {{80, 220}, {100, 220}}, color = {95, 95, 95}));
  connect(Fr_to_FR_upper_aft_i.frame_b, FR_upper_aft_i_frame) annotation(
    Line(points = {{80, 180}, {100, 180}}, color = {95, 95, 95}));
  connect(Fr_to_FR_tie_i.frame_b, FR_tie_i_frame) annotation(
    Line(points = {{80, 120}, {100, 120}}, color = {95, 95, 95}));
  connect(Fr_to_FR_lower_fore_i.frame_b, FR_lower_fore_i_frame) annotation(
    Line(points = {{80, 60}, {100, 60}}, color = {95, 95, 95}));
  connect(Fr_to_FR_lower_aft_i.frame_b, FR_lower_aft_i_frame) annotation(
    Line(points = {{80, 20}, {100, 20}}, color = {95, 95, 95}));
  connect(Rr_to_RR_upper_fore_i.frame_b, RR_upper_fore_i_frame) annotation(
    Line(points = {{80, -20}, {100, -20}}, color = {95, 95, 95}));
  connect(Rr_to_RR_upper_aft_i.frame_b, RR_upper_aft_i_frame) annotation(
    Line(points = {{80, -60}, {100, -60}}, color = {95, 95, 95}));
  connect(Rr_to_RR_tie_i.frame_b, RR_tie_i_frame) annotation(
    Line(points = {{80, -120}, {100, -120}}, color = {95, 95, 95}));
  connect(Rr_to_RR_lower_fore_i.frame_b, RR_lower_fore_i_frame) annotation(
    Line(points = {{80, -180}, {100, -180}}, color = {95, 95, 95}));
  connect(Rr_to_RR_lower_aft_i.frame_b, RR_lower_aft_i_frame) annotation(
    Line(points = {{80, -220}, {100, -220}}, color = {95, 95, 95}));
  connect(Fr_to_FL_upper_fore_i.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{-60, 220}, {-40, 220}, {-40, 60}, {0, 60}, {0, 40}}, color = {95, 95, 95}));
  connect(frame_a, CG_to_Rr.frame_a) annotation(
    Line(points = {{0, 0}, {0, -20}}));
  connect(rear_body.frame_a, CG_to_Rr.frame_b) annotation(
    Line(points = {{-10, -70}, {0, -70}, {0, -40}}, color = {95, 95, 95}));
  connect(front_body.frame_a, CG_to_Fr.frame_b) annotation(
    Line(points = {{-10, 70}, {0, 70}, {0, 40}}, color = {95, 95, 95}));
  annotation(
    Icon(
      coordinateSystem(
        extent={{-300, -600}, {300, 600}},
        preserveAspectRatio=false),graphics={
      Rectangle(
        extent={{-280, -600}, {280, 600}},
        lineColor={0, 0, 0},
        fillColor={173, 216, 230},
        fillPattern=FillPattern.None,
        lineThickness=10),
      Line(
        points={{-300, 298}, {300, 298}},
        color={255, 0, 0},
        thickness=15)
      }),
    Diagram(coordinateSystem(extent = {{-100, -240}, {100, 240}},
    preserveAspectRatio=false)),
    Placement(transformation(
      extent={{-50,-20},{50,20}}
    ))
    );
end PartialFrame;