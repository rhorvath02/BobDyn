within BobLib.Standards;

model RrKnC

parameter BobLib.Resources.Records.SUS.RrAxleDW RrAxle;
parameter BobLib.Resources.Records.SUS.RrAxleDWPullBCARB RrAxleBC;

parameter BobLib.Resources.Records.MASSPROPS.RrUnsprung unsprung_mass;
parameter BobLib.Resources.Records.MASSPROPS.RrUCA uca_mass;
parameter BobLib.Resources.Records.MASSPROPS.RrLCA lca_mass;
parameter BobLib.Resources.Records.MASSPROPS.RrTie tie_mass;

parameter BobLib.Resources.Records.TIRES.Rr_tire Rr_tire;

extends BobLib.Standards.Templates.KnC(redeclare BobLib.Vehicle.Chassis.Suspension.FrAxleDW Axle(RrAxle = RrAxle,
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
