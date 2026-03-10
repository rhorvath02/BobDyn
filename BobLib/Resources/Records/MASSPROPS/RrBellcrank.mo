within BobLib.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record RrBellcrank
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.07803865;
  parameter SIunits.Position r_cm[3] = {-1.41222715, 0.3211961, 0.10888523};
  parameter SIunits.Inertia I[3,3] = {{0.00008564, -0.00002211, -0.00001137}, {-0.00002211, 0.00004914, 0.00001422}, {-0.00001137, 0.00001422, 0.00007959}};

end RrBellcrank;
