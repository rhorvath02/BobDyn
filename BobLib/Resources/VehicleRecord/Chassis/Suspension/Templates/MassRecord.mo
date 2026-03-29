within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates;

record MassRecord
  import Modelica.SIunits;

  parameter SIunits.Mass m "Body mass";
  parameter SIunits.Position r_cm[3] "Vector to center of mass, resolved in chassis frame";
  parameter SIunits.Inertia I[3,3] "Inertia tensor, resolved about frame at r_cm";
  
end MassRecord;
