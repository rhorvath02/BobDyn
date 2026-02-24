within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/VehicleDynamics/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record RrUnsprung
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 7.35802418;
  parameter SIunits.Position r_cm[3] = {-1.54948701, 0.60559861, 0.20104023};
  parameter SIunits.Inertia I[3,3] = {{0.10429603, 0.00008706, 0.00004516}, {0.00008706, 0.15655532, -0.00147057}, {0.00004516, -0.00147057, 0.10327132}};

end RrUnsprung;
