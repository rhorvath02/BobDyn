within BobLib.Vehicle.Chassis.Suspension.Templates.Tire;

model MF5p2Tire
  import Modelica.SIunits;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire(realExpressionFx(y = Fx),
                                                                      realExpressionFy(y = Fy),
                                                                      realExpressionMx(y = Mx),
                                                                      realExpressionMy(y = My),
                                                                      realExpressionMz(y = Mz));

  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52;

  // Tire definition
  parameter BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.MF52Record tire;
  
  SIunits.Force Fx;
  SIunits.Force Fy;
  SIunits.Torque Mx;
  SIunits.Torque My;
  SIunits.Torque Mz;
  
  SIunits.Length t;
  SIunits.Length s;
  
equation
  // MF52 force and moment evaluation
  (Fx, Fy, Mx, My, Mz, t, s) =
    MF52.Eval(Fz, alpha, kappa, gamma, Vx, tire);

end MF5p2Tire;
