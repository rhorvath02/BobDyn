within BobLib.Resources.Records.SUS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/SUS/tune.json
// Tool: convert_suspension_json_to_record.py
// ============================================================================

record RrAxleDW
  "Auto-generated suspension parameter record"

  import Modelica.SIunits;

  parameter SIunits.Position upper_fore_i[3] = {-1.27914400, 0.29723080, 0.24823420} annotation(Evaluate = false);
  parameter SIunits.Position upper_aft_i[3] = {-1.49938740, 0.28384500, 0.24343360} annotation(Evaluate = false);
  parameter SIunits.Position upper_outboard[3] = {-1.55407360, 0.52677060, 0.29464000} annotation(Evaluate = false);
  parameter SIunits.Position lower_fore_i[3] = {-1.31422140, 0.28346400, 0.08686800} annotation(Evaluate = false);
  parameter SIunits.Position lower_aft_i[3] = {-1.49981920, 0.28351480, 0.08722360} annotation(Evaluate = false);
  parameter SIunits.Position lower_outboard[3] = {-1.55448000, 0.57658000, 0.11607800} annotation(Evaluate = false);
  parameter SIunits.Position tie_inboard[3] = {-1.37634980, 0.28971240, 0.17000220} annotation(Evaluate = false);
  parameter SIunits.Position tie_outboard[3] = {-1.45796000, 0.58239660, 0.21435060} annotation(Evaluate = false);
  parameter Real free_length = 0.27490478 annotation(Evaluate = false);
  parameter Real spring_table[2, 2] = [0, 0; 1, 43782] annotation(Evaluate = false);
  parameter Real damper_table[11, 2] = [0, 0; 0.002, 40; 0.005, 100; 0.01, 200; 0.02, 350; 0.05, 600; 0.1, 850; 0.2, 1100; 0.3, 1250; 0.5, 1450; 1, 1750] annotation(Evaluate = false);
  parameter SIunits.Position wheel_center[3] = {-1.5494, 0.60611077, 0.199898} annotation(Evaluate = false);
  parameter SIunits.Angle static_gamma = 0 annotation(Evaluate = false);
  parameter SIunits.Angle static_alpha = 0 annotation(Evaluate = false);
  parameter Real frame_height = 0.06731 annotation(Evaluate = false);
  parameter SIunits.Position frame_height_sensor[3] = {-1.5494, 0.2683979, 0.06731} annotation(Evaluate = false);

annotation(Evaluate=false);
end RrAxleDW;
