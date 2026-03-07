within BobDyn.Resources.Records.SUS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/SUS/tune.json
// Tool: convert_suspension_json_to_record.py
// ============================================================================

record RrAxleDWPullBCARB
  "Auto-generated suspension parameter record"

  import Modelica.SIunits;

  parameter SIunits.Position bellcrank_pivot[3] = {-1.39886851, 0.29230126, 0.1016};
  parameter SIunits.Position bellcrank_pivot_ref[3] = {-1.3847721, 0.29710676, 0.10709675};
  parameter SIunits.Position bellcrank_pickup_1[3] = {-1.41267566, 0.35197317, 0.08484064};
  parameter SIunits.Position bellcrank_pickup_2[3] = {-1.43801295, 0.36137285, 0.14160048};
  parameter SIunits.Position bellcrank_pickup_3[3] = {-1.41346984, 0.31057564, 0.12306883};
  parameter SIunits.Position left_bar_end[3] = {-1.3925183, 0.3032125, 0.41224196};
  parameter SIunits.Position left_arm_end[3] = {-1.43001283, 0.3032125, 0.4054766};
  parameter SIunits.Angle bar_rate = 535;
  parameter SIunits.Position rod_mount[3] = {-1.53509479, 0.50330883, 0.26648017};
  parameter SIunits.Position shock_mount[3] = {-1.50192144, 0.28884688, 0.36889916};

end RrAxleDWPullBCARB;
