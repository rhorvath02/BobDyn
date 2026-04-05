within BobLib.Vehicle.Chassis.Body.Templates;

partial model PartialFrame
  import Modelica.SIunits;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.MassRecord;
  
  parameter SIunits.Position frRef[3];
  parameter SIunits.Position rrRef[3];
  parameter SIunits.Velocity initVelX;
  
  parameter MassRecord pSprung;

  // Visual parameters
  outer parameter SIunits.Length linkDiameter annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  outer parameter SIunits.Length jointDiameter annotation(
    Placement(visible = false, transformation(origin = {nan, nan}, extent = {{nan, nan}, {nan, nan}})));
  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frontFrame annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b rearFrame annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));
  
  Modelica.Mechanics.MultiBody.Parts.Body sprungBody(m = pSprung.m, r_CM = pSprung.rCM - frRef, I_11 = pSprung.inertia[1, 1], I_22 = pSprung.inertia[2, 2], I_33 = pSprung.inertia[3, 3], I_21 = pSprung.inertia[2, 1], I_31 = pSprung.inertia[3, 1], I_32 = pSprung.inertia[3, 2], sphereDiameter = jointDiameter, cylinderDiameter = linkDiameter, v_0(start = {initVelX, 0, 0}, each fixed = true), r_0(start =  frRef, each fixed = true)) annotation(
    Placement(transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cgToFront(r = (frRef - rrRef)/2)  annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cgToRear(r = -1*(frRef - rrRef)/2)  annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(cgToFront.frame_b, frontFrame) annotation(
    Line(points = {{-60, 0}, {-100, 0}}, color = {95, 95, 95}));
  connect(sprungBody.frame_a, cgToFront.frame_b) annotation(
    Line(points = {{-10, 40}, {-80, 40}, {-80, 0}, {-60, 0}}, color = {95, 95, 95}));
  connect(cgToRear.frame_b, rearFrame) annotation(
    Line(points = {{60, 0}, {100, 0}}, color = {95, 95, 95}));
  annotation(
    Icon(graphics = {Line(origin = {-60, 0}, points = {{-40, 0}, {40, 0}}, thickness = 5), Line(origin = {60, 0}, points = {{40, 0}, {-40, 0}}, thickness = 5)}));
end PartialFrame;
