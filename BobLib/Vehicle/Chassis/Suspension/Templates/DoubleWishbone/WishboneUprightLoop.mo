within BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone;

model WishboneUprightLoop "Kinematic loop consisting of upright, lower wishbone, and upper wishbone"
  // Modelica units
  import Modelica.SIunits;
  
  // Modelica linalg
  import Modelica.Math.Vectors.normalize;
  
  // Records
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoopRecord;
  
  // Load parameters
  parameter WishboneUprightLoopRecord pDW;
  
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Evaluate = true,
    Dialog(tab = "Animation"));
  parameter SIunits.Length joint_diameter annotation(
    Evaluate = true,
    Dialog(tab = "Animation"));
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a upper_i_frame annotation(
    Placement(transformation(origin = {-100, 60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 70}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a lower_i_frame annotation(
    Placement(transformation(origin = {-100, -60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, -70}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b upper_o_frame annotation(
    Placement(transformation(origin = {0, 100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b lower_o_frame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b steering_frame annotation(
    Placement(transformation(origin = {100, -60}, extent = {{16, -16}, {-16, 16}}), iconTransformation(origin = {100, -70}, extent = {{-16, -16}, {16, 16}})));
  
  // Upper wishbone + upright
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSR upper_wishbone_upright(n1_a = {1, 0, 0},
                                                                                 n_b = normalize(pDW.upperFore_i - pDW.upperAft_i),
                                                                                 rRod1_ia = pDW.upper_o - pDW.lower_o,
                                                                                 rRod2_ib = pDW.upper_o - (pDW.upperFore_i + pDW.upperAft_i) / 2,
                                                                                 sphereDiameter = joint_diameter,
                                                                                 rod1Diameter = link_diameter,
                                                                                 rod2Diameter = link_diameter,
                                                                                 revoluteDiameter = joint_diameter,
                                                                                 revoluteLength = joint_diameter,
                                                                                 cylinderLength = joint_diameter*0.125,
                                                                                 cylinderDiameter = joint_diameter*0.125) annotation(
    Placement(transformation(origin = {0, 16}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
  
  // Lower wisbone
  Modelica.Mechanics.MultiBody.Joints.Revolute lower_inboard_joint(n = normalize(pDW.lowerFore_i - pDW.lowerAft_i),
                                                                   cylinderLength = joint_diameter,
                                                                   cylinderDiameter = joint_diameter) annotation(
    Placement(transformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation lower_link(r = pDW.lower_o - (pDW.lowerFore_i + pDW.lowerAft_i) / 2,
                                                                 width = link_diameter,
                                                                 height = link_diameter) annotation(
    Placement(transformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  
  // Steering interface
  Modelica.Mechanics.MultiBody.Joints.Revolute steering_axis(n = normalize(pDW.upper_o - pDW.lower_o),
                                                             cylinderLength = joint_diameter,
                                                             cylinderDiameter = joint_diameter) annotation(
    Placement(transformation(origin = {50, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));

equation
  connect(upper_i_frame, upper_wishbone_upright.frame_b) annotation(
    Line(points = {{-100, 60}, {0, 60}, {0, 36}}));
  connect(lower_i_frame, lower_inboard_joint.frame_a) annotation(
    Line(points = {{-100, -60}, {-80, -60}}));
  connect(lower_inboard_joint.frame_b, lower_link.frame_a) annotation(
    Line(points = {{-60, -60}, {-40, -60}}, color = {95, 95, 95}));
  connect(lower_link.frame_b, upper_wishbone_upright.frame_a) annotation(
    Line(points = {{-20, -60}, {0, -60}, {0, -4}}, color = {95, 95, 95}));
  connect(upper_wishbone_upright.frame_ia, steering_axis.frame_a) annotation(
    Line(points = {{20, 0}, {30, 0}, {30, -60}, {40, -60}}, color = {95, 95, 95}));
  connect(steering_axis.frame_b, steering_frame) annotation(
    Line(points = {{60, -60}, {100, -60}}, color = {95, 95, 95}));
  connect(upper_wishbone_upright.frame_im, upper_o_frame) annotation(
    Line(points = {{20, 16}, {40, 16}, {40, 80}, {0, 80}, {0, 100}}, color = {95, 95, 95}));
  connect(lower_link.frame_b, lower_o_frame) annotation(
    Line(points = {{-20, -60}, {0, -60}, {0, -100}}, color = {95, 95, 95}));
  annotation(
    Icon(graphics = {Line(origin = {-45.8, 73.2}, points = {{-42.2, -3.2}, {45.8, -3.2}, {45.8, -3.2}}, thickness = 5), Line(origin = {-43.8, -66.8}, points = {{-44.2, -3.2}, {45.8, -3.2}, {45.8, -3.2}}, thickness = 5), Ellipse(origin = {0, -2}, lineThickness = 5, extent = {{-20, 20}, {20, -20}}), Ellipse(origin = {0, 70}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {0, -70}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-0.08, 0}, points = {{-21.9178, 0}, {-9.9178, 60}, {10.0822, 60}, {22.0822, 0}, {10.0822, -60}, {-9.9178, -60}, {-21.9178, 0}, {-21.9178, 0}}, thickness = 5), Line(origin = {6, -87}, points = {{-6, -13}, {-6, 13}, {-6, 13}}), Line(origin = {0, 87}, points = {{0, 13}, {0, -13}, {0, -13}}), Line(origin = {50, -65}, points = {{50, -5}, {-10, -5}, {-10, 5}, {-50, 5}, {-50, 5}}), Ellipse(origin = {-88, -70}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {-88, 70}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(points = {{0, 60}, {0, -60}, {0, -60}}, pattern = LinePattern.Dash)}),
    Diagram(graphics));
end WishboneUprightLoop;
