within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record RrUCA
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.34927896;
  parameter SIunits.Position r_cm[3] = {-1.47556121, 0.42263392, 0.27196898};
  parameter SIunits.Inertia I[3,3] = {{0.00248293, -0.00169357, -0.00031129}, {-0.00169357, 0.00276385, 0.00045612}, {-0.00031129, 0.00045612, 0.00504556}};

end RrUCA;
