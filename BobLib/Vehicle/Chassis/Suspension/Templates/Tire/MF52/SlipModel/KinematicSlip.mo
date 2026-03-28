within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.SlipModel;

model KinematicSlip
  extends BaseSlipModel;

  parameter Real V_min = 0.5 "Low-speed regularization velocity";
  parameter Real kappa_max = 2.0 "Clamp for longitudinal slip";
  parameter Real alpha_max = 1.2 "Clamp for slip angle [rad]";

protected
  Real V_ref "Composite reference speed";
  Real V_planar "Planar contact speed";
  Real Vsx "Longitudinal slip velocity";
  Real alpha_raw;
  Real kappa_raw;
  Real blend;

equation
  V_planar = sqrt(Vx^2 + Vy^2);
  V_ref = sqrt(Vx^2 + (R0*omega)^2 + V_min^2);

  blend = V_planar / (V_planar + V_min);

  alpha_raw = blend * atan2(-Vy, sqrt(Vx^2 + V_min^2));

  Vsx = Vx - R0*omega;
  kappa_raw = -Vsx / V_ref;

  alpha = max(min(alpha_raw, alpha_max), -alpha_max);
  kappa = max(min(kappa_raw, kappa_max), -kappa_max);

end KinematicSlip;
