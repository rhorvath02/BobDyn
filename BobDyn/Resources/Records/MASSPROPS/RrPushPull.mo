within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobDyn/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record RrPushPull
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.12876397;
  parameter SIunits.Position r_cm[3] = {-1.45952523, 0.40988917, 0.15435368};
  parameter SIunits.Inertia I[3,3] = {{0.00086923, -0.00028677, -0.00034408}, {-0.00028677, 0.00074649, 0.00042518}, {-0.00034408, 0.00042518, 0.005933}};

end RrPushPull;
