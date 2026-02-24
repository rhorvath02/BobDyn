within BobDyn.Resources.Records.SUS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/SUS/tune.json
// Tool: convert_suspension_json_to_record.py
// ============================================================================

record RrAxleDW
  "Auto-generated suspension parameter record"

  import Modelica.SIunits;

  parameter SIunits.Position upper_fore_i[3] = {-1.279144, 0.2972308, 0.2482342};
  parameter SIunits.Position upper_aft_i[3] = {-1.4993874, 0.283845, 0.2434336};
  parameter SIunits.Position upper_outboard[3] = {-1.5540736, 0.5267706, 0.29464};
  parameter SIunits.Position lower_fore_i[3] = {-1.3142214, 0.283464, 0.086868};
  parameter SIunits.Position lower_aft_i[3] = {-1.4998192, 0.2835148, 0.0872236};
  parameter SIunits.Position lower_outboard[3] = {-1.55448, 0.57658, 0.116078};
  parameter SIunits.Position tie_inboard[3] = {-1.3763498, 0.2897124, 0.1700022};
  parameter SIunits.Position tie_outboard[3] = {-1.45796, 0.5823966, 0.2143506};
  parameter Real free_length = 0.27490478;
  parameter Real spring_table[2, 2] = [0, 0; 1, 43782];
  parameter Real damper_table[11, 2] = [0, 0; 0.002, 40; 0.005, 100; 0.01, 200; 0.02, 350; 0.05, 600; 0.1, 850; 0.2, 1100; 0.3, 1250; 0.5, 1450; 1, 1750];
  parameter SIunits.Position wheel_center[3] = {-1.5494, 0.60611077, 0.199898};
  parameter SIunits.Angle static_gamma = 0;
  parameter SIunits.Angle static_alpha = 0;
  parameter Real frame_height = 0.06731;
  parameter SIunits.Position frame_height_sensor[3] = {-1.5494, 0.2683979, 0.06731};

end RrAxleDW;
