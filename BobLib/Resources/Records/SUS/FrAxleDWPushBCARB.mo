within BobLib.Resources.Records.SUS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/SUS/tune.json
// Tool: convert_suspension_json_to_record.py
// ============================================================================

record FrAxleDWPushBCARB
  "Auto-generated suspension parameter record"

  import Modelica.SIunits;

  parameter SIunits.Position bellcrank_pivot[3] = {-0.042144464098, 0.250754351932, 0.370010000136};
//  parameter SIunits.Position bellcrank_pivot_ref[3] = {-0.017822781728, 0.244001173922, 0.36717974316};
  parameter SIunits.Position bellcrank_pivot_axis[3] = {-0.017822781728, 0.244001173922, 0.36717974316} - bellcrank_pivot;
  parameter SIunits.Position bellcrank_pickup_1[3] = {-0.029010173628, 0.2971411507, 0.37219698865};
  parameter SIunits.Position bellcrank_pickup_2[3] = {-0.014493326106, 0.348410770284, 0.374614186762};
  parameter SIunits.Position bellcrank_pickup_3[3] = {-0.01102742905, 0.34553503283, 0.411259910778};
  parameter SIunits.Position left_bar_end[3] = {-0.10664664, 0.2667, 0.11811};
  parameter SIunits.Position left_arm_end[3] = {-0.03682914, 0.2667, 0.11597939};
  parameter SIunits.Angle bar_rate = 258 * 2.5;
  parameter SIunits.Position rod_mount[3] = {0.006762552642, 0.525610676234, 0.134465050856};
  parameter SIunits.Position shock_mount[3] = {-0.020673469702, 0.247847085458, 0.561456926868};

end FrAxleDWPushBCARB;
