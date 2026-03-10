within BobLib.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record FrUnsprung
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 7.8160579;
  parameter SIunits.Position r_cm[3] = {-0.0061298, 0.60174377, 0.19797979};
  parameter SIunits.Inertia I[3,3] = {{0.10580066, 0.00038293, 0.00058877}, {0.00038293, 0.16064008, -0.00075416}, {0.00058877, -0.00075416, 0.10801766}};

end FrUnsprung;
