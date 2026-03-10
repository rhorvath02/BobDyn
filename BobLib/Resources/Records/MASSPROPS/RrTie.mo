within BobLib.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record RrTie
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.13293714;
  parameter SIunits.Position r_cm[3] = {-1.40704567, 0.39979876, 0.18668273};
  parameter SIunits.Inertia I[3,3] = {{0.00146339, -0.00039766, -0.00006025}, {-0.00039766, 0.00014812, 0.0002161}, {-0.00006025, 0.0002161, 0.00154153}};

end RrTie;
