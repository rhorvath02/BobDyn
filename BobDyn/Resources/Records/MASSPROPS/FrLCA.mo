within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record FrLCA
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.5182905;
  parameter SIunits.Position r_cm[3] = {0.00803455, 0.40581792, 0.09882118};
  parameter SIunits.Inertia I[3,3] = {{0.00649759, -0.00017572, -0.00001824}, {-0.00017572, 0.00145437, 0.00068888}, {-0.00001824, 0.00068888, 0.00776251}};

end FrLCA;
