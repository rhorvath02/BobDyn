within BobLib.Vehicle.Chassis.Tires.MF52;
function Fy_eval
  import Modelica.SIunits;
  
  // Tire inputs
  input SIunits.Force Fz "Normal force acting on tire";
  input SIunits.Angle alpha "Slip angle, in radians";
  input SIunits.DimensionlessRatio kappa "Slip ratio, unitless";
  input SIunits.Angle gamma "Inclination angle, in radians";
  
  // Pure lat coeffs
  input Real PCY1;
  input Real PDY1;
  input Real PDY2;
  input Real PDY3;
  input Real PEY1;
  input Real PEY2;
  input Real PEY3;
  input Real PEY4;
  input Real PKY1;
  input Real PKY2;
  input Real PKY3;
  input Real PHY1;
  input Real PHY2;
  input Real PHY3;
  input Real PVY1;
  input Real PVY2;
  input Real PVY3;
  input Real PVY4;
  
  // Combined lat coeffs
  input Real RBY1;
  input Real RBY2;
  input Real RBY3;
  input Real RCY1;
  input Real REY1;
  input Real REY2;
  input Real RHY1;
  input Real RHY2;
  input Real RVY1;
  input Real RVY2;
  input Real RVY3;
  input Real RVY4;
  input Real RVY5;
  input Real RVY6;
  
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
  output SIunits.Force Fy;

protected
  // Shared quantities (pure and combined)
  Real IA_y;
  Real df_z;
  Real mu_y;
  Real C_y;
  Real D_y;
  Real K_y;
  Real B_y;
  Real S_Hy;
  Real S_Vy;
  Real SA_y;
  Real E_y;
  Real Fy_pure;
  
  // Combined loading quantities
  Real C_ySR;
  Real B_ySR;
  Real E_ySR;
  Real S_HySR;
  Real D_VySR;
  Real S_VySR;
  Real SR_s;
  Real G_ySR;
  Real Fy_comb;
  Real mu_y_adj;

algorithm
  if Fz > 1e-3 then
    IA_y := gamma * LGAY;
    df_z := (Fz - FNOMIN * LFZO) / (FNOMIN * LFZO);
    mu_y := (PDY1 + PDY2 * df_z) * (1 - PDY3 * IA_y^2) * LMUY;
  
    C_y := PCY1 * LCY;
    D_y := mu_y * Fz;
    K_y := PKY1 * FNOMIN * sin(2 * atan(Fz / (PKY2 * FNOMIN * LFZO))) * (1 - PKY3 * abs(IA_y)) * LFZO * LKY;
    B_y := K_y / (C_y * D_y) * sign(PDY1);
  
    S_Hy := (PHY1 + PHY2 * df_z) * LHY + PHY3 * IA_y;
    S_Vy := Fz * ((PVY1 + PVY2 * df_z) * LVY + (PVY3 + PVY4 * df_z) * IA_y) * LMUY;
    SA_y := alpha + S_Hy;
  
    E_y := (PEY1 + PEY2 * df_z) * (1 - (PEY3 + PEY4 * IA_y) * sign(SA_y)) * LEY;
  
    Fy_pure := D_y * sin(C_y * atan(B_y * SA_y - E_y * (B_y * SA_y - atan(B_y * SA_y)))) + S_Vy;
      
    C_ySR := RCY1;
    B_ySR := RBY1 * cos(atan(RBY2 * (alpha - RBY3))) * LYKA;
    E_ySR := REY1 + REY2 * df_z;
    S_HySR := RHY1 + RHY2 * df_z;
  
    D_VySR := mu_y * Fz * (RVY1 + RVY2 * df_z + RVY3 * gamma) * cos(atan(RVY4 * alpha));
    S_VySR := D_VySR * sin(RVY5 * atan(RVY6 * kappa)) * LVYKA;
  
    SR_s := kappa + S_HySR;
  
    G_ySR := (cos(C_ySR * atan(B_ySR * SR_s - E_ySR * (B_ySR * SR_s - atan(B_ySR * SR_s))))) / (cos(C_ySR * atan(B_ySR * S_HySR - E_ySR * (B_ySR * S_HySR - atan(B_ySR * S_HySR)))));
  
    Fy_comb := Fy_pure * G_ySR + S_VySR;
    mu_y_adj := mu_y * G_ySR;
    
    Fy := Fy_comb;
  
  else
    IA_y := 0;
    df_z := 0;
    mu_y := 0;
    C_y := 0;
    D_y := 0;
    K_y := 0;
    B_y := 0;
    S_Hy := 0;
    S_Vy := 0;
    SA_y := 0;
    E_y := 0;
    Fy_pure := 0;
    
    C_ySR := 0;
    B_ySR := 0;
    E_ySR := 0;
    S_HySR := 0;
    D_VySR := 0;
    S_VySR := 0;
    SR_s := 0;
    G_ySR := 0;
    Fy_comb := 0;
    mu_y_adj := 0;
    
    Fy := 0;
  end if;
  
end Fy_eval;
