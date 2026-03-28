within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

record MzPureRecord
  // Pneumatic trail (t)
  Real QBZ1 "Slope factor for pneumatic trail (Bpt at Fznom)";
  Real QBZ2 "Variation of trail slope with load";
  Real QBZ3 "Quadratic load variation of trail slope";
  Real QBZ4 "Camber influence on trail slope";
  Real QBZ5 "Absolute camber influence on trail slope";

  Real QCZ1 "Shape factor for pneumatic trail (Cpt)";

  Real QDZ1 "Peak pneumatic trail at nominal load";
  Real QDZ2 "Load dependency of peak pneumatic trail";
  Real QDZ3 "Camber influence on peak pneumatic trail";
  Real QDZ4 "Quadratic camber influence on peak pneumatic trail";

  Real QEZ1 "Curvature factor for pneumatic trail at nominal load";
  Real QEZ2 "Load dependency of trail curvature";
  Real QEZ3 "Quadratic load dependency of trail curvature";
  Real QEZ4 "Sign-dependent curvature influence";
  Real QEZ5 "Camber influence on curvature asymmetry";

  Real QHZ1 "Horizontal shift of trail at nominal load";
  Real QHZ2 "Load dependency of trail shift";
  Real QHZ3 "Camber dependency of trail shift";
  Real QHZ4 "Load-camber interaction in trail shift";

  // Residual aligning torque (Mzr)
  Real QBZ9  "Slope factor for residual torque";
  Real QBZ10 "Coupling of residual torque with lateral force stiffness";

  Real QDZ6 "Peak residual torque scaling at nominal load";
  Real QDZ7 "Load dependency of residual torque";
  Real QDZ8 "Camber influence on residual torque";
  Real QDZ9 "Load-camber interaction in residual torque";

  // Scaling factors
  Real LTR "Scaling factor for pneumatic trail";
  Real LRES "Scaling factor for residual torque";
  Real LKY "Scaling factor for lateral stiffness coupling";
  Real LMUY "Scaling factor for lateral friction coupling";
  Real LGAZ "Scaling factor for camber in aligning torque";

end MzPureRecord;