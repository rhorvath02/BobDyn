within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

function MxPureEval
  import Modelica.SIunits;

  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MxPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;

  // Tire inputs
  input SIunits.Force Fz "Normal force acting on tire";
  input SIunits.Force Fy "Lateral force acting on tire";
  input SIunits.Angle gamma "Inclination angle (camber), radians";

  input MxPureRecord p;
  input SetupRecord setup;

  // Output
  output SIunits.Torque Mx;

algorithm
  if Fz > 1e-3 then

    Mx :=
      setup.UNLOADED_RADIUS * Fz *
      (
        p.QSX1 * p.LVMX
        +
        (-p.QSX2 * gamma + p.QSX3 * Fy / setup.FNOMIN) * p.LMX
      );

  else
    Mx := 0;
  end if;

end MxPureEval;
