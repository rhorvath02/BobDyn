within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

record MyPureRecord
  // Rolling resistance coefficients
  Real QSY1 "Base rolling resistance coefficient";
  Real QSY2 "Longitudinal force influence on rolling resistance";
  Real QSY3 "Linear speed dependency of rolling resistance";
  Real QSY4 "Quartic speed dependency of rolling resistance";

  // Reference velocity
  Real Vref "Reference longitudinal velocity for normalization";

  // Scaling
  Real LMY "Scaling factor for rolling resistance moment";

end MyPureRecord;
