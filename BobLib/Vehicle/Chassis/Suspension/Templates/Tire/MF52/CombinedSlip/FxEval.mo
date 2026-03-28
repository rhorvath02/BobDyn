within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip;
function FxEval
  import Modelica.SIunits;
  
  // Tire inputs
  input SIunits.Force Fz "Normal force acting on tire";
  input SIunits.Angle alpha "Slip angle";
  input SIunits.DimensionlessRatio kappa "Slip ratio";
  input SIunits.Angle gamma "Inclination angle";
  
  // Pure long coeffs
  input Real PCX1;
  input Real PDX1;
  input Real PDX2;
  input Real PDX3;
  input Real PEX1;
  input Real PEX2;
  input Real PEX3;
  input Real PEX4;
  input Real PKX1;
  input Real PKX2;
  input Real PKX3;
  input Real PHX1;
  input Real PHX2;
  input Real PVX1;
  input Real PVX2;
  
  // Combined long coeffs
  input Real RBX1;
  input Real RBX2;
  input Real RCX1;
  input Real REX1;
  input Real REX2;
  input Real RHX1;
  
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
  output SIunits.Force Fx;

protected
  // Shared quantities (pure and combined)
  Real IA_x;
  Real df_z;
  Real mu_x;
  Real C_x;
  Real D_x;
  Real K_x;
  Real B_x;
  Real S_Hx;
  Real S_Vx;
  Real SR_x;
  Real E_x;
  Real Fx_pure;
  
  // Combined loading quantities
  Real C_xSA;
  Real B_xSA;
  Real E_xSA;
  Real S_HxSA;
  Real SA_s;
  Real G_xSA;
  Real Fx_comb;
  Real mu_x_adj;

algorithm
  if Fz > 1e-3 then
    // Pure slip calculations
    IA_x := gamma * LGAX;
    df_z := (Fz - FNOMIN * LFZO) / (FNOMIN * LFZO);
    mu_x := (PDX1 + PDX2 * df_z) * (1 - PDX3 * IA_x^2) * LMUX;
  
    C_x := PCX1 * LCX;
    D_x := mu_x * Fz;
    K_x := Fz * (PKX1 + PKX2 * df_z) * exp(PKX3 * df_z) * LKX;
    B_x := K_x / (C_x * D_x);
  
    S_Hx := (PHX1 + PHX2 * df_z) * LHX;
    S_Vx := Fz * (PVX1 + PVX2 * df_z) * LVX * LMUX;
    SR_x := kappa + S_Hx;
  
    E_x := (PEX1 + PEX2 * df_z + PEX3 * df_z^2) * (1 - PEX4 * sign(SR_x)) * LEX;
  
    Fx_pure := D_x * sin(C_x * atan(B_x * SR_x - E_x * (B_x * SR_x - atan(B_x * SR_x)))) + S_Vx;
    
    // Combined slip calculations
    C_xSA := RCX1;
    B_xSA := RBX1 * cos(atan(RBX2 * kappa)) * LXAL;
    E_xSA := REX1 + REX2 * df_z;
    S_HxSA := RHX1;
  
    SA_s := alpha + S_HxSA;
  
    G_xSA := (cos(C_xSA * atan(B_xSA * SA_s - E_xSA * (B_xSA * SA_s - atan(B_xSA * SA_s))))) / (cos(C_xSA * atan(B_xSA * S_HxSA - E_xSA * (B_xSA * S_HxSA - atan(B_xSA * S_HxSA)))));
    
    Fx_comb := Fx_pure * G_xSA;
    mu_x_adj := mu_x * G_xSA;
    
    Fx := Fx_comb;
  else
    IA_x := 0;
    df_z := 0;
    mu_x := 0;
    C_x := 0;
    D_x := 0;
    K_x := 0;
    B_x := 0;
    S_Hx := 0;
    S_Vx := 0;
    SR_x := 0;
    E_x := 0;
    Fx_pure := 0;
    
    C_xSA := 0;
    B_xSA := 0;
    E_xSA := 0;
    S_HxSA := 0;
    SA_s := 0;
    G_xSA := 0;
    Fx_comb := 0;
    mu_x_adj := 0;
    
    Fx := 0;
  end if;
  
end FxEval;
