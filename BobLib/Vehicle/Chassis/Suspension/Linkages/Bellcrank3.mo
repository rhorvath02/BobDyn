within BobLib.Vehicle.Chassis.Suspension.Linkages;

model Bellcrank3
  import Modelica.SIunits;

  import Modelica.Math.Vectors;

  // Geometry parameters
  parameter SIunits.Position pivot[3] "Pivot coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position pivotAxis[3] "Pivot rotational axis" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position pickup_1[3] "First pickup coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position pickup_2[3] "Second pickup coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position pickup_3[3] "Third pickup coordinates" annotation(
    Dialog(group = "Geometry"));
  
  // Visual parameters
  parameter SIunits.Length linkDiameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  parameter SIunits.Length jointDiameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));

  // Frames  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a mountFrame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b pickupFrame1 annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b pickupFrame2 annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b pickupFrame3 annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  
  // Rotational DOF
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(n = Vectors.normalize(pivotAxis), animation = true, cylinderLength = jointDiameter, cylinderDiameter = jointDiameter, phi(nominal=0.05)) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));

  // Visualization  
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape side_1(lengthDirection = Vectors.normalize(pickup_1 - pivot), length = Vectors.norm(pickup_1 - pivot), width = linkDiameter*0.75, height = linkDiameter*0.75, widthDirection = Vectors.normalize(pivotAxis), shapeType = "cylinder") annotation(
    Placement(transformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape side_2(lengthDirection = Vectors.normalize(pickup_2 - pickup_1), widthDirection = Vectors.normalize(pivotAxis), length = Vectors.norm(pickup_2 - pickup_1), width = linkDiameter*0.75, height = linkDiameter*0.75, shapeType = "cylinder") annotation(
    Placement(transformation(origin = {10, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape side_3(lengthDirection = Vectors.normalize(pickup_3 - pickup_2), length = Vectors.norm(pickup_3 - pickup_2), width = linkDiameter*0.75, height = linkDiameter*0.75, widthDirection = Vectors.normalize(pivotAxis), shapeType = "cylinder") annotation(
    Placement(transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape side_4(lengthDirection = Vectors.normalize(pivot - pickup_3), widthDirection = Vectors.normalize(pivotAxis), length = Vectors.norm(pivot - pickup_3), width = linkDiameter*0.75, height = linkDiameter*0.75, shapeType = "cylinder") annotation(
    Placement(transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

protected
  // Kinematics
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toFirstPickup(final r = pickup_1 - pivot, final extra = 0.0) annotation(
    Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toSecondPickup(final r = pickup_2 - pickup_1, final extra = 0.0) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toThirdPickup(final r = pickup_3 - pickup_2, final extra = 0.0) annotation(
    Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(mountFrame, revolute.frame_a) annotation(
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(revolute.frame_b, toFirstPickup.frame_a) annotation(
    Line(points = {{-60, 0}, {-50, 0}}, color = {95, 95, 95}));
  connect(toFirstPickup.frame_b, toSecondPickup.frame_a) annotation(
    Line(points = {{-30, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(toSecondPickup.frame_b, toThirdPickup.frame_a) annotation(
    Line(points = {{10, 0}, {30, 0}}, color = {95, 95, 95}));
  connect(toThirdPickup.frame_b, pickupFrame3) annotation(
    Line(points = {{50, 0}, {60, 0}, {60, 40}, {0, 40}, {0, 100}}, color = {95, 95, 95}));
  connect(pickupFrame1, toFirstPickup.frame_b) annotation(
    Line(points = {{0, -100}, {0, -40}, {-20, -40}, {-20, 0}, {-30, 0}}));
  connect(toSecondPickup.frame_b, pickupFrame2) annotation(
    Line(points = {{10, 0}, {20, 0}, {20, -40}, {80, -40}, {80, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(side_1.frame_a, toFirstPickup.frame_a) annotation(
    Line(points = {{-40, -20}, {-50, -20}, {-50, 0}}, color = {95, 95, 95}));
  connect(side_2.frame_a, toSecondPickup.frame_a) annotation(
    Line(points = {{0, -20}, {-10, -20}, {-10, 0}}, color = {95, 95, 95}));
  connect(side_3.frame_a, toThirdPickup.frame_a) annotation(
    Line(points = {{40, -20}, {30, -20}, {30, 0}}, color = {95, 95, 95}));
  connect(side_4.frame_a, toThirdPickup.frame_b) annotation(
    Line(points = {{50, 60}, {60, 60}, {60, 0}, {50, 0}}, color = {95, 95, 95}));
  annotation(
    Diagram(graphics),
    Icon(graphics = {Line(points = {{-80, 0}, {0, -80}, {80, 0}, {0, 80}, {-80, 0}}, thickness = 3), Line(origin = {-90, 0}, points = {{10, 0}, {-10, 0}}), Ellipse(origin = {-80, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-10, 10}, {10, -10}}), Line(origin = {0, -90}, points = {{0, 10}, {0, -10}}), Line(origin = {90, 0}, points = {{-10, 0}, {10, 0}}), Line(origin = {0, 90}, points = {{0, -10}, {0, 10}}), Text(origin = {-40, -80}, extent = {{-20, -20}, {20, 20}}, textString = "P1"), Text(origin = {80, -40}, extent = {{-20, -20}, {20, 20}}, textString = "P2"), Text(origin = {40, 80}, extent = {{-20, -20}, {20, 20}}, textString = "P3")}));
end Bellcrank3;
