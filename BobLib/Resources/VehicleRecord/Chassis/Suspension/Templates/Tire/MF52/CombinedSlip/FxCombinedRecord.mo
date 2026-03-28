within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip;

record FxCombinedRecord
  // Reduction (Gx)
  Real RBX1 "Slope factor for combined slip reduction [-]";
  Real RBX2 "Slip influence on combined reduction [-]";
  Real RCX1 "Shape factor of reduction function [-]";
  Real REX1 "Curvature base for reduction [-]";
  Real REX2 "Load dependency of reduction curvature [-]";

  // Shift (Shxa)
  Real RHX1 "Slip angle shift for combined slip [-]";

  // Shift (Svxa) (not yet used, included for completeness)
  Real RVX1 "Vertical shift base for combined slip [-]";
  Real RVX2 "Vertical shift load dependency [-]";

end FxCombinedRecord;

