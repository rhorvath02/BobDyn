within BobLib.Vehicle.Chassis.Suspension.Templates.Stabar;

model Stabar "Stabar with rigid arms and compliant torsion bar"
  import Modelica.SIunits;
  
  import BobLib.Utilities.Math.Vector;
  
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Stabar.StabarRecord;
  
  // Record parameters
  parameter StabarRecord pStabar;
  
  // Visual parameters
  parameter SIunits.Length jointDiameter annotation(
    Evaluate = true, Dialog(tab = "Animation"));
  parameter SIunits.Length linkDiameter annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  
  // Frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b leftArmFrame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 20}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b rightArmFrame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 20}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a supportFrame annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {0, -30}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftArmEnd(r = pStabar.leftArmEnd - pStabar.leftBarEnd, width = linkDiameter, height = linkDiameter)  annotation(
    Placement(transformation(origin = {-70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightArmEnd(r = Vector.mirrorXZ(pStabar.leftArmEnd - pStabar.leftBarEnd), width = linkDiameter, height = linkDiameter)  annotation(
    Placement(transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  Modelica.Mechanics.MultiBody.Joints.Revolute stabarAxis(useAxisFlange = true, cylinderLength = jointDiameter, cylinderDiameter = jointDiameter, n = {0, 1, 0})  annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  Modelica.Mechanics.MultiBody.Joints.Revolute mountAxis(n = {0, 1, 0}, animation = false, useAxisFlange = false)  annotation(
    Placement(transformation(origin = {0, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  
  Modelica.Mechanics.Rotational.Components.Spring spring(c = pStabar.barRate)  annotation(
    Placement(transformation(origin = {-34, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftBarEnd(r = pStabar.leftBarEnd - {pStabar.leftBarEnd[1], 0, pStabar.leftBarEnd[3]}, width = linkDiameter, height = linkDiameter)  annotation(
    Placement(transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightBarEnd(r = Vector.mirrorXZ(pStabar.leftBarEnd) - {pStabar.leftBarEnd[1], 0, pStabar.leftBarEnd[3]}, width = linkDiameter, height = linkDiameter)  annotation(
    Placement(transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));

equation
  connect(supportFrame, mountAxis.frame_b) annotation(
    Line(points = {{0, -100}, {0, -80}}));
  connect(stabarAxis.frame_a, mountAxis.frame_a) annotation(
    Line(points = {{-20, 0}, {0, 0}, {0, -60}}, color = {95, 95, 95}));
  connect(stabarAxis.frame_b, toLeftBarEnd.frame_a) annotation(
    Line(points = {{-40, 0}, {-50, 0}, {-50, 20}}, color = {95, 95, 95}));
  connect(toLeftBarEnd.frame_b, toLeftArmEnd.frame_a) annotation(
    Line(points = {{-50, 40}, {-50, 60}, {-70, 60}, {-70, 40}}, color = {95, 95, 95}));
  connect(toLeftArmEnd.frame_b, leftArmFrame) annotation(
    Line(points = {{-70, 20}, {-70, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(stabarAxis.support, spring.flange_b) annotation(
    Line(points = {{-24, -10}, {-24, -20}}));
  connect(stabarAxis.frame_a, toRightBarEnd.frame_a) annotation(
    Line(points = {{-20, 0}, {50, 0}, {50, 20}}, color = {95, 95, 95}));
  connect(toRightBarEnd.frame_b, toRightArmEnd.frame_a) annotation(
    Line(points = {{50, 40}, {50, 60}, {70, 60}, {70, 40}}, color = {95, 95, 95}));
  connect(toRightArmEnd.frame_b, rightArmFrame) annotation(
    Line(points = {{70, 20}, {70, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(spring.flange_a, stabarAxis.axis) annotation(
    Line(points = {{-44, -20}, {-44, -10}, {-30, -10}}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Diagram(graphics),
    Icon(graphics = {Line(origin = {0, -10}, points = {{-80, 0}, {80, 0}}, thickness = 5), Line(origin = {-80, 20}, points = {{0, -30}, {0, 0}}, thickness = 5), Line(origin = {80, 20}, points = {{0, -30}, {0, 0}}, thickness = 5), Ellipse(origin = {-80, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {80, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {-80, -10}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {80, -10}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-92, 20}, points = {{-8, 0}, {8, 0}}), Line(origin = {92, 20}, points = {{-8, 0}, {8, 0}}), Line(origin = {0, -31}, points = {{0, 1}, {0, 17}}), Line(origin = {5, -10}, points = {{-11, 0}, {1, 0}}, color = {255, 0, 0}, thickness = 10)}));
end Stabar;
