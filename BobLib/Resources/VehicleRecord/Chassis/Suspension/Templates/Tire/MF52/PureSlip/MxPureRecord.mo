within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

record MxPureRecord
  // Base overturning moment
  Real QSX1 "Base overturning moment coefficient";

  // Camber influence
  Real QSX2 "Camber-induced overturning moment coefficient";

  // Lateral force coupling
  Real QSX3 "Lateral force contribution to overturning moment";

  // Scaling factors
  Real LMX  "Scaling factor for overturning moment";
  Real LVMX "Scaling factor for vertical-force-induced overturning moment";

end MxPureRecord;