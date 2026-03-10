within BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone;

model RightDoubleWishbone
  extends BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.DoubleWishboneBase;

equation
  connect(sphericalSpherical.frame_a, upright.tie_frame) annotation(
    Line(points = {{50, 0}, {50, -20}, {20, -20}, {20, 0}}, color = {95, 95, 95}));
  connect(sphericalSpherical.frame_b, prismatic_rack.frame_b) annotation(
    Line(points = {{30, 0}, {30, 20}, {60, 20}, {60, 0}}, color = {95, 95, 95}));
end RightDoubleWishbone;
