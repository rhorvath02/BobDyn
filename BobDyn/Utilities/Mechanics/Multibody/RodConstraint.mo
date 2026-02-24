within BobDyn.Utilities.Mechanics.Multibody;

model RodConstraint
  extends Modelica.Mechanics.MultiBody.Interfaces.LineForceBase;

  parameter Modelica.Units.SI.Length L0;
  parameter Real k;
  parameter Real d;

protected
  Real L;
  Real f;

equation
  L = length;
  f = k*(L - L0) + d*der(L);

  frame_a.f =  f * e_a;
  frame_b.f = -f * e_a;
end RodConstraint;
