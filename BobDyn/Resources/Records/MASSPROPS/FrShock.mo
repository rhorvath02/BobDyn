within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobDyn/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record FrShock
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.3227;
  parameter SIunits.Position r_cm[3] = {-0.0211, 0.2984, 0.5078};
  parameter SIunits.Inertia I[3,3] = {{0.0007, 0, 0}, {0, 0.0006, -0.0002}, {0, -0.0002, 0.0004}};

end FrShock;
