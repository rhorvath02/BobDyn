within BobLib.Vehicle.Chassis.Suspension.Linkages;

model Bellcrank3
  import Modelica.Math.Vectors.normalize;
  import Modelica.Math.Vectors.norm;
  
  import Modelica.SIunits;
  parameter SIunits.Position pivot[3] "Pivot coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position pivot_axis[3] "Pivot rotational axis" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position pickup_1[3] "First pickup coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position pickup_2[3] "Second pickup coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Position pickup_3[3] "Third pickup coordinates" annotation(
    Dialog(group = "Geometry"));
  parameter SIunits.Length link_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  parameter SIunits.Length joint_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a mount_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b pickup_1_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b pickup_2_frame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b pickup_3_frame annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(n = normalize(pivot_axis), animation = true, cylinderLength = joint_diameter, cylinderDiameter = joint_diameter) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape side_1(lengthDirection = normalize(pickup_1 - pivot), length = norm(pickup_1 - pivot), width = link_diameter*0.75, height = link_diameter*0.75, widthDirection = normalize(pivot_axis), shapeType = "cylinder")  annotation(
    Placement(transformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape side_2(lengthDirection = normalize(pickup_2 - pickup_1), widthDirection = normalize(pivot_axis), length = norm(pickup_2 - pickup_1), width = link_diameter*0.75, height = link_diameter*0.75, shapeType = "cylinder")  annotation(
    Placement(transformation(origin = {10, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape side_3(lengthDirection = normalize(pickup_3 - pickup_2), length = norm(pickup_3 - pickup_2), width = link_diameter*0.75, height = link_diameter*0.75, widthDirection = normalize(pivot_axis), shapeType = "cylinder")  annotation(
    Placement(transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape side_4(lengthDirection = normalize(pivot - pickup_3), widthDirection = normalize(pivot_axis), length = norm(pivot - pickup_3), width = link_diameter*0.75, height = link_diameter*0.75, shapeType = "cylinder")  annotation(
    Placement(transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
protected
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation first_pickup(final r = pickup_1 - pivot, final extra = 0.0) annotation(
    Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation second_pickup(final r = pickup_2 - pickup_1, final extra = 0.0) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation third_pickup(final r = pickup_3 - pickup_2, final extra = 0.0) annotation(
    Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(mount_frame, revolute.frame_a) annotation(
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(revolute.frame_b, first_pickup.frame_a) annotation(
    Line(points = {{-60, 0}, {-50, 0}}, color = {95, 95, 95}));
  connect(first_pickup.frame_b, second_pickup.frame_a) annotation(
    Line(points = {{-30, 0}, {-10, 0}}, color = {95, 95, 95}));
  connect(second_pickup.frame_b, third_pickup.frame_a) annotation(
    Line(points = {{10, 0}, {30, 0}}, color = {95, 95, 95}));
  connect(third_pickup.frame_b, pickup_3_frame) annotation(
    Line(points = {{50, 0}, {60, 0}, {60, 40}, {0, 40}, {0, 100}}, color = {95, 95, 95}));
  connect(pickup_1_frame, first_pickup.frame_b) annotation(
    Line(points = {{0, -100}, {0, -40}, {-20, -40}, {-20, 0}, {-30, 0}}));
  connect(second_pickup.frame_b, pickup_2_frame) annotation(
    Line(points = {{10, 0}, {20, 0}, {20, -40}, {80, -40}, {80, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(side_1.frame_a, first_pickup.frame_a) annotation(
    Line(points = {{-40, -20}, {-50, -20}, {-50, 0}}, color = {95, 95, 95}));
  connect(side_2.frame_a, second_pickup.frame_a) annotation(
    Line(points = {{0, -20}, {-10, -20}, {-10, 0}}, color = {95, 95, 95}));
  connect(side_3.frame_a, third_pickup.frame_a) annotation(
    Line(points = {{40, -20}, {30, -20}, {30, 0}}, color = {95, 95, 95}));
  connect(side_4.frame_a, third_pickup.frame_b) annotation(
    Line(points = {{50, 60}, {60, 60}, {60, 0}, {50, 0}}, color = {95, 95, 95}));
end Bellcrank3;
