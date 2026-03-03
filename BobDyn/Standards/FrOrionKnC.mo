within BobDyn.Standards;

model FrOrionKnC

extends BobDyn.Standards.Templates.KnC(redeclare BobDyn.Vehicle.Chassis.Suspension.FrAxleDWPushBCARBLocked Axle);
equation
  connect(steer_input.y, Axle.steer_input) annotation(
    Line(points = {{-18, 70}, {0, 70}, {0, 52}}, color = {0, 0, 127}));
end FrOrionKnC;
