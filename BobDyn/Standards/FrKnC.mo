within BobDyn.Standards;

model FrKnC

parameter BobDyn.Resources.Records.SUS.FrAxleDW FrAxle;
parameter BobDyn.Resources.Records.SUS.FrAxleDWPushBCARB FrAxleBC;

parameter BobDyn.Resources.Records.MASSPROPS.FrUnsprung unsprung_mass;
parameter BobDyn.Resources.Records.MASSPROPS.FrUCA uca_mass;
parameter BobDyn.Resources.Records.MASSPROPS.FrLCA lca_mass;
parameter BobDyn.Resources.Records.MASSPROPS.FrTie tie_mass;

parameter BobDyn.Resources.Records.TIRES.Fr_tire Fr_tire;

extends BobDyn.Standards.Templates.KnC(redeclare BobDyn.Vehicle.Chassis.Suspension.FrAxleDWPushBCARBLocked Axle(FrAxle=FrAxle,
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
