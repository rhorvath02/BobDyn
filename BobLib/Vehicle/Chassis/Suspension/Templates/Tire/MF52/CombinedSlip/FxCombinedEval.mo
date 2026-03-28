within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip;

function FxCombinedEval
  // Modelica units
  import Modelica.SIunits;
  
  // MF imports
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FxPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip.FxCombinedRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;
  
  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FxPureEval;

  input SIunits.Force Fz;
  input SIunits.DimensionlessRatio kappa;
  input SIunits.Angle alpha;
  input SIunits.Angle gamma;

  input FxPureRecord pPure;
  input FxCombinedRecord pComb;
  input SetupRecord setup;

  output SIunits.Force Fx;

protected
  SIunits.Force Fx_pure;

  Real dfz;

  Real C_xSA;
  Real B_xSA;
  Real E_xSA;
  Real S_HxSA;
  Real SA_s;
  Real G_xSA;

algorithm
  if Fz > 1e-3 then
    // Pure slip
    Fx_pure := FxPureEval(Fz, kappa, gamma, pPure, setup);

    // Normalized load
    dfz := (Fz - setup.Fnomin * pPure.LFZO) / (setup.Fnomin * pPure.LFZO);

    // Combined slip coefficients
    C_xSA := pComb.RCX1;
    B_xSA := pComb.RBX1 * cos(atan(pComb.RBX2 * kappa)) * pPure.LXAL;
    E_xSA := pComb.REX1 + pComb.REX2 * dfz;
    S_HxSA := pComb.RHX1;

    // Shifted slip angle
    SA_s := alpha + S_HxSA;

    // Normalized reduction factor
    G_xSA :=
      cos(C_xSA * atan(B_xSA * SA_s - E_xSA * (B_xSA * SA_s - atan(B_xSA * SA_s))))
      /
      cos(C_xSA * atan(B_xSA * S_HxSA - E_xSA * (B_xSA * S_HxSA - atan(B_xSA * S_HxSA))));

    // Final force
    Fx := Fx_pure * G_xSA;

  else
    Fx := 0;
  end if;

end FxCombinedEval;
