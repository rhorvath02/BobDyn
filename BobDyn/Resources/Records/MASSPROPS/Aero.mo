within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record Aero
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 17.5221607;
  parameter SIunits.Position r_cm[3] = {-1.0591486, 0, 0.4690962};
  parameter SIunits.Inertia I[3,3] = {{5.7927214, 0, -2.707829}, {0, 10.8282253, 0}, {-2.707829, 0, 12.8409194}};

end Aero;
