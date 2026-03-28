within BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip;

function MxCombinedEval
  import Modelica.SIunits;

  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MxPureRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.CombinedSlip.MxCombinedRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.SetupRecord;

  import BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52.PureSlip.MxPureEval;

  input SIunits.Force Fz;
  input SIunits.Force Fy;
  input SIunits.Angle gamma;

  input MxPureRecord pPure;
  input MxCombinedRecord pComb;
  input SetupRecord setup;

  output SIunits.Torque Mx;

algorithm
  if Fz > 1e-3 then
    Mx := MxPureEval(Fz, Fy, gamma, pPure, setup);
  else
    Mx := 0;
  end if;

end MxCombinedEval;
