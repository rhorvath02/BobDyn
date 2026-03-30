within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52;

record MF52Record
  import Modelica.SIunits;

  // Setup
  SetupRecord setup
    "Global tire setup parameters (nominal load, radius, etc.)";

  // Longitudinal force (Fx)
  PureSlip.FxPureRecord fxPure
    "Pure slip longitudinal force parameters";

  CombinedSlip.FxCombinedRecord fxCombined
    "Combined slip longitudinal force parameters";

  // Lateral force (Fy)
  PureSlip.FyPureRecord fyPure
    "Pure slip lateral force parameters";

  CombinedSlip.FyCombinedRecord fyCombined
    "Combined slip lateral force parameters";

  // Overturning moment (Mx)
  PureSlip.MxPureRecord mxPure
    "Pure slip overturning moment parameters";

  CombinedSlip.MxCombinedRecord mxCombined
    "Combined slip overturning moment parameters";

  // Rolling resistance moment (My)
  PureSlip.MyPureRecord myPure
    "Pure slip rolling resistance parameters";

  CombinedSlip.MyCombinedRecord myCombined
    "Combined slip rolling resistance parameters";

  // Aligning moment (Mz)
  PureSlip.MzPureRecord mzPure
    "Pure slip aligning moment parameters";

  CombinedSlip.MzCombinedRecord mzCombined
    "Combined slip aligning moment parameters";

end MF52Record;