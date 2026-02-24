within BobDyn.Resources.Records.SUS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/SUS/tune.json
// Tool: convert_suspension_json_to_record.py
// ============================================================================

record FrAxleDW
  "Auto-generated suspension parameter record"

  import Modelica.SIunits;

  parameter SIunits.Position upper_fore_i[3] = {0.1016, 0.237744, 0.2143252};
  parameter SIunits.Position upper_aft_i[3] = {-0.0680974, 0.2356358, 0.215138};
  parameter SIunits.Position upper_outboard[3] = {-0.0092964, 0.5420106, 0.2679954};
  parameter SIunits.Position lower_fore_i[3] = {0.1016, 0.226314, 0.08001};
  parameter SIunits.Position lower_aft_i[3] = {-0.0762, 0.226314, 0.08001};
  parameter SIunits.Position lower_outboard[3] = {0.0029972, 0.562991, 0.1139952};
  parameter SIunits.Position tie_inboard[3] = {0.05715, 0.2260092, 0.1137158};
  parameter SIunits.Position tie_outboard[3] = {0.0569976, 0.546989, 0.1522222};
  parameter Real free_length = 0.20024806;
  parameter Real spring_table[2, 2] = [0, 0; 1, 26269];
  parameter Real damper_table[11, 2] = [0, 0; 0.002, 40; 0.005, 100; 0.01, 200; 0.02, 350; 0.05, 600; 0.1, 850; 0.2, 1100; 0.3, 1250; 0.5, 1450; 1, 1750];
  parameter SIunits.Position wheel_center[3] = {0, 0.606110767456, 0.199898};
  parameter SIunits.Angle static_gamma = 0;
  parameter SIunits.Angle static_alpha = 0;
  parameter Real frame_height = 0.06731;
  parameter SIunits.Position frame_height_sensor[3] = {0, 0.20955, 0.06731};

end FrAxleDW;
