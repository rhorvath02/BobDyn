within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

function MyPureEval
  import Modelica.SIunits;

  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MyPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;

  // Inputs
  input SIunits.Force Fz "Normal force";
  input SIunits.Force Fx "Longitudinal force";
  input SIunits.Velocity Vx "Longitudinal velocity";

  input MyPureRecord p;
  input SetupRecord setup;

  // Output
  output SIunits.Torque My;

protected
  Real Vx_n;

algorithm
  if Fz > 1e-3 then

    // Normalized velocity
    Vx_n := Vx / p.Vref;

    My :=
      setup.UNLOADED_RADIUS * Fz *
      (
        p.QSY1
        + p.QSY2 * (Fx / setup.FNOMIN)
        + p.QSY3 * Vx_n
        + p.QSY4 * Vx_n^4
      )
      * p.LMY;

  else
    My := 0;
  end if;

end MyPureEval;
