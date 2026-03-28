within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip;

function FyCombinedEval
  import Modelica.SIunits;
  
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FyPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip.FyCombinedRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;

  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FyPureEval;

  input SIunits.Force Fz;
  input SIunits.Angle alpha;
  input SIunits.DimensionlessRatio kappa;
  input SIunits.Angle gamma;

  input FyPureRecord pPure;
  input FyCombinedRecord pComb;
  input SetupRecord setup;

  output SIunits.Force Fy;

protected
  SIunits.Force Fy_pure;

  Real dfz;

  Real C_ySR;
  Real B_ySR;
  Real E_ySR;
  Real S_HySR;
  Real D_VySR;
  Real S_VySR;
  Real SR_s;
  Real G_ySR;

algorithm
  if Fz > 1e-3 then
    Fy_pure := FyPureEval(Fz, alpha, gamma, pPure, setup);

    dfz := (Fz - setup.Fnomin * pPure.LFZO) / (setup.Fnomin * pPure.LFZO);

    C_ySR := pComb.RCY1;
    B_ySR := pComb.RBY1 * cos(atan(pComb.RBY2 * (alpha - pComb.RBY3))) * pPure.LYKA;
    E_ySR := pComb.REY1 + pComb.REY2 * dfz;
    S_HySR := pComb.RHY1 + pComb.RHY2 * dfz;

    D_VySR := (pPure.PDY1 + pPure.PDY2 * dfz) * (1 - pPure.PDY3 * (gamma * pPure.LGAY)^2)
              * pPure.LMUY * Fz
              * (pComb.RVY1 + pComb.RVY2 * dfz + pComb.RVY3 * gamma)
              * cos(atan(pComb.RVY4 * alpha));

    S_VySR := D_VySR * sin(pComb.RVY5 * atan(pComb.RVY6 * kappa)) * pPure.LVYKA;

    SR_s := kappa + S_HySR;

    G_ySR :=
      cos(C_ySR * atan(B_ySR * SR_s - E_ySR * (B_ySR * SR_s - atan(B_ySR * SR_s))))
      /
      cos(C_ySR * atan(B_ySR * S_HySR - E_ySR * (B_ySR * S_HySR - atan(B_ySR * S_HySR))));

    Fy := Fy_pure * G_ySR + S_VySR;

  else
    Fy := 0;
  end if;

end FyCombinedEval;
