within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip;

record MzCombinedRecord
  // Fx-induced moment arm (s)
  Real SSZ1 "Nominal moment arm of longitudinal force contribution";
  Real SSZ2 "Lateral force dependency of moment arm";
  Real SSZ3 "Camber dependency of moment arm";
  Real SSZ4 "Load-camber interaction in moment arm";

  // Combined slip lateral shift (Sv_yk)
  Real RVY1 "Base coefficient for kappa-induced lateral force shift";
  Real RVY2 "Load dependency of kappa-induced lateral force shift";
  Real RVY3 "Camber influence on kappa-induced lateral force shift";
  Real RVY4 "Slip angle influence on kappa-induced lateral force shift";
  Real RVY5 "Shape factor for kappa-induced lateral force shift";
  Real RVY6 "Curvature factor for kappa-induced lateral force shift";

  // Scaling factors
  Real LS "Scaling factor for Fx moment arm contribution";
  Real LVYKA "Scaling factor for kappa-induced lateral force shift";

end MzCombinedRecord;