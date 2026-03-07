within BobDyn.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobDyn/BobDyn/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record Sprung
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 158.2801053;
  parameter SIunits.Position r_cm[3] = {-0.98223949, -0.00353588, 0.21533036};
  parameter SIunits.Inertia I[3,3] = {{16.30759334, 0.08792256, -0.12611578}, {0.08792256, 7.84280233, 0.38206387}, {-0.12611578, 0.38206387, 18.2914811}};

end Sprung;
