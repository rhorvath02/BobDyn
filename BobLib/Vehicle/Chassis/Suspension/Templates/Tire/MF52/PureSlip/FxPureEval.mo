within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

function FxPureEval
  // Modelica units
  import Modelica.SIunits;
  
  // MF imports
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FxPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;
  
  input SIunits.Force Fz;
  input SIunits.DimensionlessRatio kappa;
  input SIunits.Angle gamma;
  
  input FxPureRecord p;
  input SetupRecord setup;

  output SIunits.Force Fx;

protected
  Real IA_x;
  Real dfz;
  Real mu_x;

  Real C;
  Real D;
  Real K;
  Real B;
  Real Sh;
  Real Sv;
  Real SR_x;
  Real E;

algorithm
  if Fz > 1e-3 then
    // Camber influence
    IA_x := gamma * p.LGAX;

    // Normalized load
    dfz := (Fz - setup.Fnomin * p.LFZO) / (setup.Fnomin * p.LFZO);

    // Friction
    mu_x := (p.PDX1 + p.PDX2 * dfz) * (1 - p.PDX3 * IA_x^2) * p.LMUX;

    // Shape / peak
    C := p.PCX1 * p.LCX;
    D := mu_x * Fz;

    // Stiffness
    K := Fz * (p.PKX1 + p.PKX2 * dfz) * exp(p.PKX3 * dfz) * p.LKX;
    B := K / (C * D + 1e-8);

    // Shifts
    Sh := (p.PHX1 + p.PHX2 * dfz) * p.LHX;
    Sv := Fz * (p.PVX1 + p.PVX2 * dfz) * p.LVX * p.LMUX;

    SR_x := kappa + Sh;

    // Curvature
    E := (p.PEX1 + p.PEX2 * dfz + p.PEX3 * dfz^2)
         * (1 - p.PEX4 * sign(SR_x))
         * p.LEX;

    // Magic Formula
    Fx := D * sin(C * atan(B * SR_x - E * (B * SR_x - atan(B * SR_x)))) + Sv;

  else
    Fx := 0;
  end if;

end FxPureEval;
