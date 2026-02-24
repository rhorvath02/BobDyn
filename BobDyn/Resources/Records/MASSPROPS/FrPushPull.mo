within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record FrPushPull
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.1321334;
  parameter SIunits.Position r_cm[3] = {-0.00647691, 0.41524008, 0.28404398};
  parameter SIunits.Inertia I[3,3] = {{0.00146836, 0.00006195, -0.00008386}, {0.00006195, 0.00095939, -0.00069916}, {-0.00008386, -0.00069916, 0.0052775}};

end FrPushPull;
