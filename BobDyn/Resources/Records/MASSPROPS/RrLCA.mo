within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record RrLCA
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.46311564;
  parameter SIunits.Position r_cm[3] = {-1.47625848, 0.4301135, 0.10156115};
  parameter SIunits.Inertia I[3,3] = {{0.00434917, -0.00226155, -0.0002268}, {-0.00226155, 0.00268231, 0.00042397}, {-0.0002268, 0.00042397, 0.0069183}};

end RrLCA;
