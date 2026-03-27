within BobLib.Standards;

model FrKnC

parameter BobLib.Resources.Records.SUS.FrAxleDW FrAxle;
parameter BobLib.Resources.Records.SUS.FrAxleDWPushBCARB FrAxleBC;

parameter BobLib.Resources.Records.MASSPROPS.FrUnsprung unsprung_mass;
parameter BobLib.Resources.Records.MASSPROPS.FrUCA uca_mass;
parameter BobLib.Resources.Records.MASSPROPS.FrLCA lca_mass;
parameter BobLib.Resources.Records.MASSPROPS.FrTie tie_mass;

parameter BobLib.Resources.Records.TIRES.Fr_tire Fr_tire;

extends BobLib.Standards.Templates.KnC(redeclare BobLib.Vehicle.Chassis.Suspension.FrAxleDW Axle(FrAxle=FrAxle,
                                                                                                 FrAxleBC=FrAxleBC,
                                                                                                 unsprung_mass=unsprung_mass,
                                                                                                 uca_mass=uca_mass,
                                                                                                 lca_mass=lca_mass,
                                                                                                 tie_mass=tie_mass,
                                                                                                 final link_diameter = 0.025,
                                                                                                 final joint_diameter = 0.030));

equation
  connect(steer_input.y, Axle.steer_input) annotation(
    Line(points = {{-18, 70}, {0, 70}, {0, 52}}, color = {0, 0, 127}));
end FrKnC;
