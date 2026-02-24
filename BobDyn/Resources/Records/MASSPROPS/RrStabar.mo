within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record RrStabar
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 0.7072127;
  parameter SIunits.Position r_cm[3] = {-1.3997744, 0, 0.39073492};
  parameter SIunits.Inertia I[3,3] = {{0.04079278, 0.00000162, 0.00025813}, {0.00000162, 0.00304082, -0.00000075}, {0.00025813, -0.0000075, 0.03813774}};

end RrStabar;
