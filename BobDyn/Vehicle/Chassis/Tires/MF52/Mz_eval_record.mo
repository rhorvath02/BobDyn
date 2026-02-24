within BobDyn.Vehicle.Chassis.Tires.MF52;

function Mz_eval_record
  import BobDyn.Vehicle.Chassis.Tires.MF52.Records.Mz_record;
  import Modelica.SIunits;
  
  // Tire inputs
  input SIunits.Force Fz "Normal force acting on tire";
  input SIunits.Force Fx "Longitudinal force acting on tire";
  input SIunits.Force Fy "Lateral force acting on tire";
  input SIunits.Angle alpha "Slip angle, in radians";
  input SIunits.DimensionlessRatio kappa "Slip ratio, unitless";
  input SIunits.Angle gamma "Inclination angle, in radians";
  
  // Pure aligning coeffs
  input Real QBZ1;
  input Real QBZ2;
  input Real QBZ3;
  input Real QBZ4;
  input Real QBZ5;
  input Real QBZ9;
  input Real QBZ10;
  input Real QCZ1;
  input Real QDZ1;
  input Real QDZ2;
  input Real QDZ3;
  input Real QDZ4;
  input Real QDZ6;
  input Real QDZ7;
  input Real QDZ8;
  input Real QDZ9;
  input Real QEZ1;
  input Real QEZ2;
  input Real QEZ3;
  input Real QEZ4;
  input Real QEZ5;
  input Real QHZ1;
  input Real QHZ2;
  input Real QHZ3;
  input Real QHZ4;

  // Combined aligning coeffs
  input Real SSZ1;
  input Real SSZ2;
  input Real SSZ3;
  input Real SSZ4;

  // Pure lat coeffs
  input Real PCY1;
  input Real PDY1;
  input Real PDY2;
  input Real PDY3;
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
  input Real RVY1;
  input Real RVY2;
  input Real RVY3;
  input Real RVY4;
  input Real RVY5;
  input Real RVY6;

  // Pure long coeffs
  input Real PKX1;
  input Real PKX2;
  input Real PKX3;

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
  output Mz_record Mz_out;
  
protected
  Real df_z;
  Real IA_z;
  
  // Lateral
  Real IA_y;
  Real mu_y;
  Real S_Hy;
  Real S_Vy;
  Real K_y;
  Real C_y;
  Real D_y;
  Real B_y;
  
  // Longitudinal
  Real K_x;
  
  // Aligning
  Real D_t;
  Real C_t;
  Real B_t;
  Real D_VySR;
  Real S_VySR;
  Real S_Ht;
  Real SA_t;
  Real E_t;
  Real S_Hf;
  Real SA_r;
  Real SA_t_eq;
  Real SA_r_eq;
  Real t_adj;
  Real F_y_IA_adj;
  Real D_r;
  Real B_r;
  Real M_zr;
  Real s;
  
algorithm
  if Fz > 1e-3 then
    df_z := (Fz - FNOMIN * LFZO) / (FNOMIN * LFZO);
    IA_z := gamma * LGAZ;
  
    // Lateral Dependencies
    IA_y := gamma * LGAY;
    mu_y := (PDY1 + PDY2 * df_z) * (1 - PDY3 * IA_y^2) * LMUY;
    S_Hy := (PHY1 + PHY2 * df_z) * LHY + PHY3 * IA_y;
    S_Vy := Fz * ((PVY1 + PVY2 * df_z) * LVY + (PVY3 + PVY4 * df_z) * IA_y) * LMUY;
  
    K_y := PKY1 * FNOMIN * sin(2 * atan(Fz / (PKY2 * FNOMIN * LFZO))) * (1 - PKY3 * abs(IA_y)) * LFZO * LKY;
    C_y := PCY1 * LCY;
    D_y := mu_y * Fz;
    B_y := K_y / (C_y * D_y);
  
    // Longitudinal
    K_x := Fz * (PKX1 + PKX2 * df_z) * exp(PKX3 * df_z) * LKX;
    
    // Aligning
    D_t := Fz * (QDZ1 + QDZ2 * df_z) * (1 + QDZ3 * IA_z + QDZ4 * IA_z^2) * (R0 / FNOMIN) * LTR;
    C_t := QCZ1;
    B_t := (QBZ1 + QBZ2 * df_z + QBZ3 * df_z^2) * (1 + QBZ4 * IA_z + QBZ5 * abs(IA_z)) * LKY / LMUY;
    
    D_VySR := mu_y * Fz * (RVY1 + RVY2 * df_z + RVY3 * gamma) * cos(atan(RVY4 * alpha));
    S_VySR := D_VySR * sin(RVY5 * atan(RVY6 * kappa)) * LVYKA;
  
    S_Ht := QHZ1 + QHZ2 * df_z + (QHZ3 + QHZ4 * df_z) * IA_z;
    SA_t := alpha + S_Ht;
  
    E_t := (QEZ1 + QEZ2 * df_z + QEZ3 * df_z^2) * (1 + (QEZ4 + QEZ5 * IA_z) * (2 / Modelica.Constants.pi) * atan(B_t * C_t * SA_t));
  
    S_Hf := S_Hy + S_Vy / K_y;
    SA_r := alpha + S_Hf;
  
    // Adjusted SA values
    SA_t_eq := atan(sqrt((tan(SA_t))^2 + (K_x / K_y)^2 * kappa^2)) * sign(SA_t);
    SA_r_eq := atan(sqrt((tan(SA_r))^2 + (K_x / K_y)^2 * kappa^2)) * sign(SA_r);
  
    // Pneumatic trail
    t_adj := D_t * cos(C_t * atan(B_t * SA_t_eq - E_t * (B_t * SA_t_eq - atan(B_t * SA_t_eq)))) * cos(alpha);
  
    // Aligning moment calculation
    F_y_IA_adj := Fy - S_VySR;
  
    D_r := Fz * ((QDZ6 + QDZ7 * df_z) * LRES + (QDZ8 + QDZ9 * df_z) * IA_z) * R0 * LMUY;
    B_r := QBZ9 * LKY / LMUY + QBZ10 * B_y * C_y;
  
    M_zr := D_r * cos(atan(B_r * SA_r_eq)) * cos(alpha);
  
    s := (SSZ1 + SSZ2 * (Fy / FNOMIN) + (SSZ3 + SSZ4 * df_z) * gamma) * R0 * LS;
    
    Mz_out.pneu_trail := t_adj;
    Mz_out.pneu_scrub := s;
    
    Mz_out.Mz := -t_adj * F_y_IA_adj + M_zr + s * Fx;
  else
    df_z := 0;
    IA_z := 0;
    
    IA_y := 0;
    mu_y := 0;
    S_Hy := 0;
    S_Vy := 0;
    K_y := 0;
    C_y := 0;
    D_y := 0;
    B_y := 0;
    
    K_x := 0;
    
    D_t := 0;
    C_t := 0;
    B_t := 0;
    D_VySR := 0;
    S_VySR := 0;
    S_Ht := 0;
    SA_t := 0;
    E_t := 0;
    S_Hf := 0;
    SA_r := 0;
    SA_t_eq := 0;
    SA_r_eq := 0;
    t_adj := 0;
    F_y_IA_adj := 0;
    D_r := 0;
    B_r := 0;
    M_zr := 0;
    s := 0;
    
    Mz_out.pneu_trail := 0;
    Mz_out.pneu_scrub := 0;
    
    Mz_out.Mz := 0;
  end if;
  
end Mz_eval_record;
