within BobLib.Resources.Records.TEMPLATES;

record BodyTemplate
  "Rigid body mass properties (body-fixed frame)"

  import Modelica.SIunits;

  parameter SIunits.Mass m
    "Body mass";

  parameter SIunits.Position r_cm[3]
    "Center of mass position in body-fixed frame";

  parameter SIunits.Inertia I[3,3]
    "Inertia tensor about center of mass, resolved in body-fixed frame";

end BodyTemplate;
