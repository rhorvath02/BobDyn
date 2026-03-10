within BobLib.Resources.Records.SENSING;

record VehicleTelemetry
  BobLib.Resources.Records.SENSING.SYSTEMS.InputsTelemetry input_sigs;
  
  BobLib.Resources.Records.SENSING.SYSTEMS.AeroTelemetry aero_sigs;
  
  BobLib.Resources.Records.SENSING.SYSTEMS.KinematicsTelemetry kin_sigs;
  BobLib.Resources.Records.SENSING.SYSTEMS.DynamicsTelemetry dyn_sigs;
  
  BobLib.Resources.Records.SENSING.SYSTEMS.PowertrainTelemetry powertrain_sigs;
  BobLib.Resources.Records.SENSING.SYSTEMS.SuspensionTelemetry sus_sigs[4];
  BobLib.Resources.Records.SENSING.SYSTEMS.WheelTelemetry wheel_sigs[4];

end VehicleTelemetry;
