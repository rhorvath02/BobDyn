within BobLib.Vehicle.Chassis.Suspension.Templates.SteeringRack;

model RackAndPinion "Rack and pinion"
  // Modelica units
  import Modelica.SIunits;
  
  // Parameters
  parameter SIunits.Position tie_i[3] "Tie rod inboard joint, expressed in chassis frame" annotation(
    Evaluate = false,
    Dialog(group = "Geometry"));
  parameter Real c_factor "Rack C-factor, defined as meters of rack travel per pinion revolution" annotation(
    Evaluate = false, Dialog(group = "Geometry"));
  
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Evaluate = true, Dialog(tab="Animation"));
  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a mount_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -20}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b left_frame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b right_frame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(n = {0, 1, 0}, useAxisFlange = true, animation = false)  annotation(
    Placement(transformation(origin = {0, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation from_left(r = {0, -tie_i[2], 0}, width = link_diameter, height = link_diameter)  annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right(r = {0, -tie_i[2], 0}, width = link_diameter, height = link_diameter)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a pinion_flange annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Sensors.CutForce cutForce(animation = false)  annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D annotation(
    Placement(transformation(origin = {50, -70}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Mechanics.Rotational.Sources.Torque2 torque annotation(
    Placement(transformation(origin = {50, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relAngleSensor annotation(
    Placement(transformation(origin = {70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain rack_conversion(k = c_factor/(2*Modelica.Constants.pi))  annotation(
    Placement(transformation(origin = {13, 30}, extent = {{7, -7}, {-7, 7}}, rotation = -0)));
  Modelica.Mechanics.Translational.Sources.Position rack_travel(useSupport = true, exact = true)  annotation(
    Placement(transformation(origin = {-30, -42}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain torque_conversion(k = 1*c_factor/(2*Modelica.Constants.pi))  annotation(
    Placement(transformation(origin = {-31, 50}, extent = {{-7, -7}, {7, 7}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape pinion_visualizer(length = 2*c_factor/(2*Modelica.Constants.pi), width = 1.25*c_factor/(2*Modelica.Constants.pi), shapeType = "cylinder", lengthDirection = {0, 0, 1}, height = 1.25*c_factor/(2*Modelica.Constants.pi), color = {255, 255, 255})  annotation(
    Placement(transformation(origin = {-30, -70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape travel_visualizer(shapeType = "cylinder", lengthDirection = {0, 1, 0}, widthDirection = {0, 0, 1}, length = link_diameter, width = link_diameter*1.1, height = link_diameter*1.1, color = {0, 0, 0}, r_shape = {0, -link_diameter/2, 0})  annotation(
    Placement(transformation(origin = {30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
equation
  connect(mount_frame, prismatic.frame_a) annotation(
    Line(points = {{0, -100}, {0, -60}}));
  connect(to_right.frame_b, right_frame) annotation(
    Line(points = {{40, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(pinion_flange, torque.flange_a) annotation(
    Line(points = {{0, 100}, {0, 80}, {50, 80}, {50, 60}}));
  connect(torque.flange_b, mounting1D.flange_b) annotation(
    Line(points = {{50, 40}, {50, -60}}));
  connect(relAngleSensor.flange_b, pinion_flange) annotation(
    Line(points = {{70, 40}, {70, 80}, {0, 80}, {0, 100}}));
  connect(relAngleSensor.flange_a, mounting1D.flange_b) annotation(
    Line(points = {{70, 20}, {70, -60}, {50, -60}}));
  connect(relAngleSensor.phi_rel, rack_conversion.u) annotation(
    Line(points = {{60, 30}, {21, 30}}, color = {0, 0, 127}));
  connect(rack_travel.flange, prismatic.axis) annotation(
    Line(points = {{-20, -42}, {-6, -42}}, color = {0, 127, 0}));
  connect(prismatic.support, rack_travel.support) annotation(
    Line(points = {{-6, -54}, {-30, -54}, {-30, -52}}, color = {0, 127, 0}));
  connect(rack_conversion.y, rack_travel.s_ref) annotation(
    Line(points = {{6, 30}, {-50, 30}, {-50, -42}, {-42, -42}}, color = {0, 0, 127}));
  connect(torque_conversion.y, torque.tau) annotation(
    Line(points = {{-24, 50}, {46, 50}}, color = {0, 0, 127}));
  connect(from_left.frame_b, prismatic.frame_b) annotation(
    Line(points = {{-20, 0}, {0, 0}, {0, -40}}, color = {95, 95, 95}));
  connect(to_right.frame_a, from_left.frame_b) annotation(
    Line(points = {{20, 0}, {-20, 0}}, color = {95, 95, 95}));
  connect(cutForce.force[2], torque_conversion.u) annotation(
    Line(points = {{-78, 12}, {-78, 50}, {-40, 50}}, color = {0, 0, 127}));
  connect(left_frame, cutForce.frame_a) annotation(
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(cutForce.frame_b, from_left.frame_a) annotation(
    Line(points = {{-60, 0}, {-40, 0}}, color = {95, 95, 95}));
  connect(pinion_visualizer.frame_a, prismatic.frame_a) annotation(
    Line(points = {{-20, -70}, {0, -70}, {0, -60}}, color = {95, 95, 95}));
  connect(mounting1D.frame_a, prismatic.frame_a) annotation(
    Line(points = {{40, -70}, {0, -70}, {0, -60}}, color = {95, 95, 95}));
  connect(travel_visualizer.frame_a, prismatic.frame_b) annotation(
    Line(points = {{20, -30}, {0, -30}, {0, -40}}, color = {95, 95, 95}));
  annotation(
    Diagram(graphics),
    Icon(graphics = {Line(origin = {-25.8, 3.2}, points = {{-54.2, -3.2}, {25.8, -3.2}, {105.8, -3.2}}, thickness = 15), Line(origin = {-80, 0}, points = {{0, 0}, {-10, 0}, {-10, 0}}, color = {255, 0, 0}, thickness = 10), Line(origin = {100, 0}, points = {{-10, 0}, {-10, 0}, {-20, 0}}, color = {255, 0, 0}, thickness = 10)}));
end RackAndPinion;
