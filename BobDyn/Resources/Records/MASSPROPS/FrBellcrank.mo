within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobDyn/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record FrBellcrank
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.1144;
  parameter SIunits.Position r_cm[3] = {-0.0295, 0.2941, 0.3814};
  parameter SIunits.Inertia I[3,3] = {{0.0002, 0, 0}, {0, 0.00005, 0}, {0, 0, 0.0002}};

end FrBellcrank;
