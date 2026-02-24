within BobDyn.Vehicle.Chassis.Tires.MF52;
function My_eval
  import Modelica.SIunits;
  
  // Tire inputs
  input SIunits.Force Fz "Normal force acting on tire";
  input SIunits.Angle alpha "Slip angle, in radians";
  input SIunits.DimensionlessRatio kappa "Slip ratio, unitless";
  input SIunits.Angle gamma "Inclination angle, in radians";
  
  // Pure rolling resistance coeffs
  input Real QSY1;
  input Real QSY2;
  input Real QSY3;
  input Real QSY4;

  // Pure long coeffs (needed for MF52 My calculation)
  input Real PKX1;
  input Real PKX2;
  input Real PKX3;
  input Real PHX1;
  input Real PHX2;
  input Real PVX1;
  input Real PVX2;
  
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
  output SIunits.Force My;

protected
  Real df_z;
  Real K_x;
  Real S_Hx;
  Real S_Vx;
  
algorithm
  if Fz > 1e-3 then
    df_z := (Fz - FNOMIN * LFZO) / (FNOMIN * LFZO);
  
    K_x := Fz * (PKX1 + PKX2 * df_z) * exp(PKX3 * df_z) * LKX;
  
    S_Hx := (PHX1 + PHX2 * df_z) * LHX;
    S_Vx := Fz * (PVX1 + PVX2 * df_z) * LVX * LMUX;
  
    My := R0 * (S_Vx + K_x * S_Hx);
  else
    df_z := 0;
    K_x := 0;
    S_Hx := 0;
    S_Vx := 0;
    
    My := 0;
  end if;
  
end My_eval;
