within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

function MzPureEval
  import Modelica.SIunits;

  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MzPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FyPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FxPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;

  input SIunits.Force Fz;
  input SIunits.Force Fy;
  input SIunits.Angle alpha;
  input SIunits.DimensionlessRatio kappa;
  input SIunits.Angle gamma;

  input FyPureRecord pFy;
  input FxPureRecord pFx;
  input MzPureRecord p;
  input SetupRecord setup;

  output SIunits.Torque Mz_pure;

protected
  Real dfz;
  Real mu_y;
  Real C_y;
  Real K_y;
  Real B_y;
  Real K_x;

  Real IA_z;
  Real eps = 1e-8;

  Real D_t;
  Real C_t;
  Real B_t;
  Real E_t;
  Real S_Ht;
  Real SA_t;
  Real SA_t_eq;

  Real SA_r;
  Real SA_r_eq;

  Real t;
  Real D_r;
  Real B_r;
  Real M_zr;

algorithm
  if Fz > 1e-3 then

    // ------------------------------------------------------------
    // Load normalization
    // ------------------------------------------------------------
    dfz := (Fz - setup.Fnomin * pFy.LFZO) / (setup.Fnomin * pFy.LFZO);

    // ------------------------------------------------------------
    // Fy internals
    // ------------------------------------------------------------
    C_y := pFy.PCY1 * pFy.LCY;

    mu_y := (pFy.PDY1 + pFy.PDY2 * dfz)
            * (1 - pFy.PDY3 * (gamma * pFy.LGAY)^2)
            * pFy.LMUY;

    K_y := pFy.PKY1 * setup.Fnomin *
           sin(2 * atan(Fz / (pFy.PKY2 * setup.Fnomin * pFy.LFZO))) *
           (1 - pFy.PKY3 * abs(gamma * pFy.LGAY)) *
           pFy.LFZO * pFy.LKY;

    B_y := K_y / (C_y * mu_y * Fz + eps);

    // ------------------------------------------------------------
    // Fx stiffness
    // ------------------------------------------------------------
    K_x := Fz * (pFx.PKX1 + pFx.PKX2 * dfz)
           * exp(pFx.PKX3 * dfz)
           * pFx.LKX;

    // ------------------------------------------------------------
    // Trail model
    // ------------------------------------------------------------
    IA_z := gamma;

    D_t := Fz * (p.QDZ1 + p.QDZ2 * dfz)
           * (1 + p.QDZ3 * IA_z * p.LGAZ + p.QDZ4 * (IA_z * p.LGAZ)^2)
           * (setup.R0 / setup.Fnomin)
           * p.LTR;

    C_t := p.QCZ1;

    B_t := (p.QBZ1 + p.QBZ2 * dfz + p.QBZ3 * dfz^2)
           * (1 + p.QBZ4 * IA_z * p.LGAZ + p.QBZ5 * abs(IA_z * p.LGAZ))
           * p.LKY / p.LMUY;

    S_Ht := p.QHZ1 + p.QHZ2 * dfz
            + (p.QHZ3 + p.QHZ4 * dfz) * IA_z * p.LGAZ;

    SA_t := alpha + S_Ht;

    E_t := (p.QEZ1 + p.QEZ2 * dfz + p.QEZ3 * dfz^2)
           * (1 + (p.QEZ4 + p.QEZ5 * IA_z * p.LGAZ)
           * (2 / Modelica.Constants.pi) * atan(B_t * C_t * SA_t));

    SA_t_eq :=
      atan(sqrt((tan(SA_t))^2 + (K_x / (K_y + eps))^2 * kappa^2))
      * sign(SA_t);

    t := D_t
         * cos(C_t * atan(B_t * SA_t_eq - E_t * (B_t * SA_t_eq - atan(B_t * SA_t_eq))))
         * cos(alpha)
         * cos(gamma);

    // ------------------------------------------------------------
    // Residual torque
    // ------------------------------------------------------------
    SA_r := alpha;

    SA_r_eq :=
      atan(sqrt((tan(SA_r))^2 + (K_x / (K_y + eps))^2 * kappa^2))
      * sign(SA_r);

    D_r := Fz * ((p.QDZ6 + p.QDZ7 * dfz) * p.LRES
           + (p.QDZ8 + p.QDZ9 * dfz) * IA_z * p.LGAZ)
           * setup.R0 * p.LMUY;

    B_r := p.QBZ9 * p.LKY / p.LMUY + p.QBZ10 * B_y * C_y;

    M_zr := D_r * cos(atan(B_r * SA_r_eq)) * cos(alpha);

    // ------------------------------------------------------------
    // Final
    // ------------------------------------------------------------
    Mz_pure := -t * Fy + M_zr;

  else
    Mz_pure := 0;
  end if;

end MzPureEval;
