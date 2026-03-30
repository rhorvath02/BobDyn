within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates;

record MassRecord
  import Modelica.SIunits;

  parameter SIunits.Mass m "Body mass";
  parameter SIunits.Position rCM[3] "Vector to center of mass, resolved in chassis frame";
  parameter SIunits.Inertia inertia[3,3] "Inertia tensor, resolved about frame at rCM";
  
end MassRecord;
