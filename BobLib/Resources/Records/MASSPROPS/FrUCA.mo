within BobLib.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record FrUCA
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.55776965;
  parameter SIunits.Position r_cm[3] = {-0.00187916, 0.45854113, 0.25343195};
  parameter SIunits.Inertia I[3,3] = {{0.00700626, -0.00058434, -0.0001073}, {-0.00058434, 0.0011635, 0.00116272}, {-0.0001073, 0.00116272, 0.00762498}};

end FrUCA;
