within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip;

function MyCombinedEval
  import Modelica.SIunits;

  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MyPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip.MyCombinedRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;

  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MyPureEval;

  input SIunits.Force Fz;
  input SIunits.Force Fx;
  input SIunits.Velocity Vx;

  input MyPureRecord pPure;
  input MyCombinedRecord pComb;
  input SetupRecord setup;

  output SIunits.Torque My;

algorithm
  if Fz > 1e-3 then
    My := MyPureEval(Fz, Fx, Vx, pPure, setup);
  else
    My := 0;
  end if;

end MyCombinedEval;
