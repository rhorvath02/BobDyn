within BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishboneDAE;

model LeftDoubleWishboneDAE
  extends BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishboneDAE.DoubleWishboneDAEBase(position(useSupport = true));

equation
  connect(prismatic_rack.frame_b, sphericalSpherical.frame_a) annotation(
    Line(points = {{60, 0}, {50, 0}}, color = {95, 95, 95}));
  connect(sphericalSpherical.frame_b, upright.tie_frame) annotation(
    Line(points = {{30, 0}, {20, 0}}, color = {95, 95, 95}));
end LeftDoubleWishboneDAE;
