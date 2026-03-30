within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip;

function MzCombinedEval
  import Modelica.SIunits;

  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MzPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip.MzCombinedRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FyPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FxPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;

  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MzPureEval;

  input SIunits.Force Fz;
  input SIunits.Force Fx;
  input SIunits.Force Fy;
  input SIunits.Angle alpha;
  input SIunits.DimensionlessRatio kappa;
  input SIunits.Angle gamma;

  input FyPureRecord pFy;
  input FxPureRecord pFx;
  input MzPureRecord pPure;
  input MzCombinedRecord pComb;
  input SetupRecord setup;

  output SIunits.Torque Mz;
  output SIunits.Length t;
  output SIunits.Length s;

protected
  Real dfz;
  Real mu_y;

  Real D_VySR;
  Real S_VySR;

  Real Fy_eff;
  Real Mz_pure;

algorithm
  if Fz > 1e-3 then

    // ------------------------------------------------------------
    // Load normalization
    // ------------------------------------------------------------
    dfz := (Fz - setup.FNOMIN * pFy.LFZO) / (setup.FNOMIN * pFy.LFZO);

    mu_y := (pFy.PDY1 + pFy.PDY2 * dfz)
            * (1 - pFy.PDY3 * (gamma * pFy.LGAY)^2)
            * pFy.LMUY;

    // ------------------------------------------------------------
    // Combined Fy shift
    // ------------------------------------------------------------
    D_VySR := mu_y * Fz
              * (pComb.RVY1 + pComb.RVY2 * dfz + pComb.RVY3 * gamma)
              * cos(atan(pComb.RVY4 * alpha));

    S_VySR := D_VySR
              * sin(pComb.RVY5 * atan(pComb.RVY6 * kappa))
              * pFy.LVYKA;

    // Effective Fy used in Mz model
    Fy_eff := Fy - S_VySR;

    // ------------------------------------------------------------
    // Pure aligning moment
    // ------------------------------------------------------------
    Mz_pure := MzPureEval(
      Fz,
      Fy_eff,
      alpha,
      kappa,
      gamma,
      pFy,
      pFx,
      pPure,
      setup
    );

    // ------------------------------------------------------------
    // Pneumatic trail extraction
    // ------------------------------------------------------------
    if abs(Fy_eff) > 1e-6 then
      t := -Mz_pure / Fy_eff;
    else
      t := 0;
    end if;

    // ------------------------------------------------------------
    // Residual arm (already correct in your model)
    // ------------------------------------------------------------
    s := (pComb.SSZ1
         + pComb.SSZ2 * (Fy / setup.FNOMIN)
         + (pComb.SSZ3 + pComb.SSZ4 * dfz) * gamma)
         * setup.UNLOADED_RADIUS * pComb.LS;

    // ------------------------------------------------------------
    // Final Mz
    // ------------------------------------------------------------
    Mz := Mz_pure + s * Fx;

  else
    Mz := 0;
    t := 0;
    s := 0;
  end if;

end MzCombinedEval;
