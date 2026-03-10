within BobLib.Resources.Records.TEMPLATES;

record AxleDWTemplate
  "Double wishbone axle template"

  import Modelica.SIunits;

  parameter SIunits.Position upper_fore_i[3];
  parameter SIunits.Position upper_aft_i[3];
  parameter SIunits.Position upper_outboard[3];
  parameter SIunits.Position lower_fore_i[3];
  parameter SIunits.Position lower_aft_i[3];
  parameter SIunits.Position lower_outboard[3];
  parameter SIunits.Position tie_inboard[3];
  parameter SIunits.Position tie_outboard[3];
  parameter Real free_length;
  parameter Real spring_table[:,2];
  parameter Real damper_table[:,2];
  parameter SIunits.Position wheel_center[3];
  parameter SIunits.Angle static_gamma;
  parameter SIunits.Angle static_alpha;
  parameter Real frame_height;
  parameter SIunits.Position frame_height_sensor[3];

end AxleDWTemplate;
