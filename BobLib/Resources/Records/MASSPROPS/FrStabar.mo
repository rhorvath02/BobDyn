within BobLib.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record FrStabar
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.80054682;
  parameter SIunits.Position r_cm[3] = {-0.08281405, 0, 0.13334037};
  parameter SIunits.Inertia I[3,3] = {{0.03682686, -0.00000003, 0.00067104}, {-0.00000003, 0.00394358, 0}, {0.00067104, 0, 0.03481172}};

end FrStabar;
