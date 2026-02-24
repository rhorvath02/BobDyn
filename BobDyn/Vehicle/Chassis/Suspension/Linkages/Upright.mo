within BobDyn.Vehicle.Chassis.Suspension.Linkages;
model Upright
  import Modelica.SIunits;
  
  parameter SIunits.Position lower[3] "Lower node coordinates";
  parameter SIunits.Position upper[3] "Upper node coordinates";
  parameter SIunits.Position tie[3] "Tie node coordinates";
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a mass_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {0, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b lower_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b tie_frame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b upper_frame annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  
protected
  // Fixed translations
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation lower_to_upper(r = upper - lower, animation = false)  annotation(
    Placement(transformation( extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation lower_to_tie(r = tie - lower, animation = false)  annotation(
    Placement(transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation lower_to_center(r = (upper + lower)/2 - lower, animation = false)  annotation(
    Placement(transformation(origin = {-30, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));

equation
  connect(lower_frame, lower_to_upper.frame_a) annotation(
    Line(points = {{0, -100}, {0, -10}}));
  connect(lower_to_upper.frame_b, upper_frame) annotation(
    Line(points = {{0, 10}, {0, 100}}, color = {95, 95, 95}));
  connect(lower_frame, lower_to_tie.frame_a) annotation(
    Line(points = {{0, -100}, {0, -80}, {50, -80}, {50, -60}}));
  connect(lower_to_tie.frame_b, tie_frame) annotation(
    Line(points = {{50, -40}, {50, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(lower_to_center.frame_a, lower_frame) annotation(
    Line(points = {{-30, -60}, {-30, -80}, {0, -80}, {0, -100}}, color = {95, 95, 95}));
  connect(mass_frame, lower_to_center.frame_b) annotation(
    Line(points = {{-100, 0}, {-30, 0}, {-30, -40}}));

annotation(
  Icon(
    graphics = {
    Line(
          points = {{0, -80}, {0, 80}},
          color = {0, 0, 0},
          thickness = 15
        ),
    Line(
          points = {{0, -80}, {80, 0}},
          color = {0, 0, 0},
          thickness = 15
        ),
    Line(
          points = {{0, 80}, {80, 0}},
          color = {0, 0, 0},
          thickness = 15
        ),
    Ellipse(
      extent = {{-10, 70}, {10, 90}},
      lineColor = {255, 255, 255},
      fillColor = {0, 0, 0},
      fillPattern = FillPattern.Solid
    ),
    Ellipse(
      extent = {{-10, -90}, {10, -70}},
      lineColor = {255, 255, 255},
      fillColor = {0, 0, 0},
      fillPattern = FillPattern.Solid
    ),
    Ellipse(
      extent = {{70, -10}, {90, 10}},
      lineColor = {255, 255, 255},
      fillColor = {0, 0, 0},
      fillPattern = FillPattern.Solid
    )
        }));
end Upright;
