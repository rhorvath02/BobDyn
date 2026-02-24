within BobDyn.Vehicle.Chassis.Tires.MF52;
function Mx_eval
  import Modelica.SIunits;
  
  // Tire inputs
  input SIunits.Force Fz "Normal force acting on tire";
  input SIunits.Force Fy "Lateral force acting on tire";
  input SIunits.Angle alpha "Slip angle, in radians";
  input SIunits.DimensionlessRatio kappa "Slip ratio, unitless";
  input SIunits.Angle gamma "Inclination angle, in radians";
  
  // Pure overturning coeffs
  input Real QSX1;
  input Real QSX2;
  input Real QSX3;
  
  // Scaling coeffs
  input Real LFZO;
  input Real LCX;
  input Real LMUX;
  input Real LEX;
  input Real LKX;
  input Real LHX;
  input Real LVX;
  input Real LXAL;
  input Real LGAX;
  input Real LCY;
  input Real LMUY;
  input Real LEY;
  input Real LKY;
  input Real LHY;
  input Real LVY;
  input Real LGAY;
  input Real LKYG;
  input Real LTR;
  input Real LRES;
  input Real LCZ;
  input Real LGAZ;
  input Real LYKA;
  input Real LVYKA;
  input Real LS;
  input Real LSGKP;
  input Real LSGAL;
  input Real LGYR;
  input Real LMX;
  input Real LVMX;
  input Real LMY;
  input Real LIP;
  
  // Vertical coeffs
  input Real FNOMIN;
  
  // Dimension coeffs
  input Real R0;

  // Outputs
  output SIunits.Force Mx;

algorithm
  if Fz > 1e-3 then
    Mx := R0 * Fz * (QSX1 * LVMX + (-1 * QSX2 * gamma + QSX3 * Fy / FNOMIN) * LMX);
  else
    Mx := 0;
  end if;
  
end Mx_eval;
