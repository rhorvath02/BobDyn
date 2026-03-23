within BobLib.Vehicle.Chassis.Suspension.Linkages;

model Pushrod
  import Modelica.SIunits;
  
  extends BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.TieClosure(tie_rod(n1_a=pivot_axis, showUniversalAxes = false, kinematicConstraint = false));
  
  parameter SIunits.Position pivot_axis[3] "Pivot rotational axis" annotation(
    Dialog(group = "Geometry"));
  
equation

end Pushrod;
