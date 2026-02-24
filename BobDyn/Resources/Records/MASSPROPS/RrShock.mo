within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record RrShock
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.39967795;
  parameter SIunits.Position r_cm[3] = {-1.47256593, 0.30651588, 0.27889458};
  parameter SIunits.Inertia I[3,3] = {{0.00225533, 0.00013562, -0.00045208}, {0.00013562, 0.00199361, -0.00070199}, {-0.00045208, -0.00070199, 0.0006078}};

end RrShock;
