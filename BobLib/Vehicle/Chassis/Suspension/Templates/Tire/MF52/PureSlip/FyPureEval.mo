within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

function FyPureEval
  import Modelica.SIunits;
  
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.FyPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;

  input SIunits.Force Fz;
  input SIunits.Angle alpha;
  input SIunits.Angle gamma;

  input FyPureRecord p;
  input SetupRecord setup;

  output SIunits.Force Fy;

protected
  Real IA_y;
  Real dfz;
  Real mu_y;

  Real C;
  Real D;
  Real K;
  Real B;
  Real Sh;
  Real Sv;
  Real SA;
  Real E;

algorithm
  if Fz > 1e-3 then
    IA_y := gamma * p.LGAY;

    dfz := (Fz - setup.Fnomin * p.LFZO) / (setup.Fnomin * p.LFZO);

    mu_y := (p.PDY1 + p.PDY2 * dfz) * (1 - p.PDY3 * IA_y^2) * p.LMUY;

    C := p.PCY1 * p.LCY;
    D := mu_y * Fz;

    K := p.PKY1 * setup.Fnomin *
         sin(2 * atan(Fz / (p.PKY2 * setup.Fnomin * p.LFZO))) *
         (1 - p.PKY3 * abs(IA_y)) *
         p.LFZO * p.LKY;

    B := K / (C * D + 1e-8);

    Sh := (p.PHY1 + p.PHY2 * dfz) * p.LHY + p.PHY3 * IA_y;
    Sv := Fz * ((p.PVY1 + p.PVY2 * dfz) * p.LVY +
                (p.PVY3 + p.PVY4 * dfz) * IA_y) * p.LMUY;

    SA := alpha + Sh;

    E := (p.PEY1 + p.PEY2 * dfz) *
         (1 - (p.PEY3 + p.PEY4 * IA_y) * sign(SA)) *
         p.LEY;

    Fy := D * sin(C * atan(B * SA - E * (B * SA - atan(B * SA)))) + Sv;

  else
    Fy := 0;
  end if;

end FyPureEval;
