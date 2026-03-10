within BobLib.Resources.Records.MASSPROPS;

// ============================================================================
// AUTO-GENERATED FILE — DO NOT EDIT
// Source: /home/rober/shared/BobLib/BobLib/Resources/JSONs/MASSPROPS/mass_props.json
// Tool: convert_massprops_json_to_record.py
// ============================================================================

record Driver
  "Auto-generated rigid body mass properties"

  import Modelica.SIunits;

  parameter SIunits.Mass m = 65.7709122;
  parameter SIunits.Position r_cm[3] = {-0.5418375, 0.0000059, 0.3957818};
  parameter SIunits.Inertia I[3,3] = {{2.2419879, 0.0002837, -1.9759383}, {0.0002837, 7.6213869, -0.0000528}, {-1.9759383, -0.0000528, 6.7490423}};

end Driver;
