within BobDyn.Standards;

model RrKnC

parameter BobDyn.Resources.Records.SUS.RrAxleDW RrAxle;
parameter BobDyn.Resources.Records.SUS.RrAxleDWPullBCARB RrAxleBC;

parameter BobDyn.Resources.Records.MASSPROPS.RrUnsprung unsprung_mass;
parameter BobDyn.Resources.Records.MASSPROPS.RrUCA uca_mass;
parameter BobDyn.Resources.Records.MASSPROPS.RrLCA lca_mass;
parameter BobDyn.Resources.Records.MASSPROPS.RrTie tie_mass;

parameter BobDyn.Resources.Records.TIRES.Rr_tire Rr_tire;

extends BobDyn.Standards.Templates.KnC(redeclare BobDyn.Vehicle.Chassis.Suspension.RrAxleDWPullBCARBLocked Axle(RrAxle = RrAxle,
                                                                                                                RrAxleBC=RrAxleBC,
                                                                                                                unsprung_mass=unsprung_mass,
                                                                                                                uca_mass=uca_mass,
                                                                                                                lca_mass=lca_mass,
                                                                                                                tie_mass=tie_mass,
                                                                                                                link_diameter = 0.025,
                                                                                                                joint_diameter = 0.030));

equation

annotation(
    experiment(StartTime = 0, StopTime = 42, Tolerance = 1e-05, Interval = 0.05),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --maxSizeLinearTearing=2000");
end RrKnC;
