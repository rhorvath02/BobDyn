within BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone;

model WishboneUprightLoop "Kinematic loop consisting of upright, lower wishbone, and upper wishbone"
  import Modelica.SIunits;

  import Modelica.Math.Vectors.normalize;
  
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoopRecord;
  
  // Record parameters
  parameter WishboneUprightLoopRecord pDW;
  
  // Visual parameters
  parameter SIunits.Length linkDiameter annotation(
    Evaluate = true, Dialog(tab = "Animation"));
  parameter SIunits.Length jointDiameter annotation(
    Evaluate = true, Dialog(tab = "Animation"));
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a upperFrame_i annotation(
    Placement(transformation(origin = {-100, 60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 70}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a lowerFrame_i annotation(
    Placement(transformation(origin = {-100, -60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, -70}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b upperFrame_o annotation(
    Placement(transformation(origin = {0, 100}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b lowerFrame_o annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b steeringFrame annotation(
    Placement(transformation(origin = {100, -60}, extent = {{16, -16}, {-16, 16}}), iconTransformation(origin = {100, -70}, extent = {{-16, -16}, {16, 16}})));
  
  // Upper wishbone + upright
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSR upperWishboneUpright(n1_a = {1, 0, 0},
                                                                               n_b = normalize(pDW.upperFore_i - pDW.upperAft_i),
                                                                               rRod1_ia = pDW.upper_o - pDW.lower_o,
                                                                               rRod2_ib = pDW.upper_o - (pDW.upperFore_i + pDW.upperAft_i) / 2,
                                                                               sphereDiameter = jointDiameter,
                                                                               rod1Diameter = linkDiameter,
                                                                               rod2Diameter = linkDiameter,
                                                                               revoluteDiameter = jointDiameter,
                                                                               revoluteLength = jointDiameter,
                                                                               cylinderLength = jointDiameter*0.125,
                                                                               cylinderDiameter = jointDiameter*0.125) annotation(
    Placement(transformation(origin = {0, 16}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
  
  // Lower wisbone
  Modelica.Mechanics.MultiBody.Joints.Revolute lowerJoint_i(n = normalize(pDW.lowerFore_i - pDW.lowerAft_i),
                                                            cylinderLength = jointDiameter,
                                                            cylinderDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation lowerLink(r = pDW.lower_o - (pDW.lowerFore_i + pDW.lowerAft_i) / 2,
                                                                width = linkDiameter,
                                                                height = linkDiameter) annotation(
    Placement(transformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  
  // Steering interface
  Modelica.Mechanics.MultiBody.Joints.Revolute steeringAxis(n = normalize(pDW.upper_o - pDW.lower_o),
                                                            cylinderLength = jointDiameter,
                                                            cylinderDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {50, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));

equation
  connect(upperFrame_i, upperWishboneUpright.frame_b) annotation(
    Line(points = {{-100, 60}, {0, 60}, {0, 36}}));
  connect(lowerFrame_i, lowerJoint_i.frame_a) annotation(
    Line(points = {{-100, -60}, {-80, -60}}));
  connect(lowerJoint_i.frame_b, lowerLink.frame_a) annotation(
    Line(points = {{-60, -60}, {-40, -60}}, color = {95, 95, 95}));
  connect(lowerLink.frame_b, upperWishboneUpright.frame_a) annotation(
    Line(points = {{-20, -60}, {0, -60}, {0, -4}}, color = {95, 95, 95}));
  connect(upperWishboneUpright.frame_ia, steeringAxis.frame_a) annotation(
    Line(points = {{20, 0}, {30, 0}, {30, -60}, {40, -60}}, color = {95, 95, 95}));
  connect(steeringAxis.frame_b, steeringFrame) annotation(
    Line(points = {{60, -60}, {100, -60}}, color = {95, 95, 95}));
  connect(upperWishboneUpright.frame_im, upperFrame_o) annotation(
    Line(points = {{20, 16}, {40, 16}, {40, 80}, {0, 80}, {0, 100}}, color = {95, 95, 95}));
  connect(lowerLink.frame_b, lowerFrame_o) annotation(
    Line(points = {{-20, -60}, {0, -60}, {0, -100}}, color = {95, 95, 95}));
  annotation(
    Icon(graphics = {Line(origin = {-45.8, 73.2}, points = {{-42.2, -3.2}, {45.8, -3.2}, {45.8, -3.2}}, thickness = 5), Line(origin = {-43.8, -66.8}, points = {{-44.2, -3.2}, {45.8, -3.2}, {45.8, -3.2}}, thickness = 5), Ellipse(origin = {0, -2}, lineThickness = 5, extent = {{-20, 20}, {20, -20}}), Ellipse(origin = {0, 70}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {0, -70}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-0.08, 0}, points = {{-21.9178, 0}, {-9.9178, 60}, {10.0822, 60}, {22.0822, 0}, {10.0822, -60}, {-9.9178, -60}, {-21.9178, 0}, {-21.9178, 0}}, thickness = 5), Line(origin = {6, -87}, points = {{-6, -13}, {-6, 13}, {-6, 13}}), Line(origin = {0, 87}, points = {{0, 13}, {0, -13}, {0, -13}}), Line(origin = {50, -65}, points = {{50, -5}, {-10, -5}, {-10, 5}, {-50, 5}, {-50, 5}}), Ellipse(origin = {-88, -70}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {-88, 70}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(points = {{0, 60}, {0, -60}, {0, -60}}, pattern = LinePattern.Dash)}),
    Diagram(graphics));
end WishboneUprightLoop;
