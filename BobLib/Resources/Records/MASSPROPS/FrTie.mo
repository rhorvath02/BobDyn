within BobLib.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record FrTie
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.13459415;
  parameter SIunits.Position r_cm[3] = {0.05709287, 0.34616483, 0.1281302};
  parameter SIunits.Inertia I[3,3] = {{0.00178949, -0.00000083, -0.0000001}, {-0.00000083, 0.00002994, 0.00021109}, {-0.0000001, 0.000211, 0.001764}};

end FrTie;
