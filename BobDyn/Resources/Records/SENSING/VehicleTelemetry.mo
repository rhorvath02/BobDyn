within BobDyn.Resources.Records.SENSING;

record VehicleTelemetry
  BobDyn.Resources.Records.SENSING.SYSTEMS.InputsTelemetry input_sigs;
  
  BobDyn.Resources.Records.SENSING.SYSTEMS.AeroTelemetry aero_sigs;
  
  BobDyn.Resources.Records.SENSING.SYSTEMS.KinematicsTelemetry kin_sigs;
  BobDyn.Resources.Records.SENSING.SYSTEMS.DynamicsTelemetry dyn_sigs;
  
  BobDyn.Resources.Records.SENSING.SYSTEMS.PowertrainTelemetry powertrain_sigs;
  BobDyn.Resources.Records.SENSING.SYSTEMS.SuspensionTelemetry sus_sigs[4];
  BobDyn.Resources.Records.SENSING.SYSTEMS.WheelTelemetry wheel_sigs[4];

end VehicleTelemetry;
