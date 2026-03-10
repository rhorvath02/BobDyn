within BobLib.Resources.Records.SUS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/SUS/tune.json
// Tool: convert_suspension_json_to_record.py
// ============================================================================

record FrAxleDW
  "Auto-generated suspension parameter record"

  import Modelica.SIunits;
  
  extends BobLib.Resources.Records.TEMPLATES.AxleDWTemplate(upper_fore_i = {0.1016, 0.237744, 0.2143252},
                                                            upper_aft_i = {-0.0680974, 0.2356358, 0.215138},
                                                            upper_outboard = {-0.0092964, 0.5420106, 0.2679954},
                                                            lower_fore_i = {0.1016, 0.226314, 0.08001},
                                                            lower_aft_i = {-0.0762, 0.226314, 0.08001},
                                                            lower_outboard = {0.0029972, 0.562991, 0.1139952},
                                                            tie_inboard = {0.05715, 0.2260092, 0.1137158},
                                                            tie_outboard = {0.0569976, 0.546989, 0.1522222},
                                                            free_length = 0.20024806,
                                                            spring_table = [0, 0; 1, 26269],
                                                            damper_table = [0, 0; 0.002, 40; 0.005, 100; 0.01, 200; 0.02, 350; 0.05, 600; 0.1, 850; 0.2, 1100; 0.3, 1250; 0.5, 1450; 1, 1750],
                                                            wheel_center = {0, 0.606110767456, 0.199898},
                                                            static_gamma = 0,
                                                            static_alpha = 0,
                                                            frame_height = 0.06731,
                                                            frame_height_sensor = {0, 0.20955, 0.06731});

end FrAxleDW;
