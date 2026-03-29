within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates;

record AxleMassRecord
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.MassRecord;

  parameter MassRecord unsprungMass "Left unsprung mass record" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties"));
  parameter MassRecord ucaMass "Left upper control arm mass record" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties"));
  parameter MassRecord lcaMass "Left lower control arm mass record" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties"));
  parameter MassRecord tieMass "Left tie rod mass record" annotation( 
    Evaluate = false,
    Dialog(tab = "Mass Properties"));
  
end AxleMassRecord;
