within BobDyn.Utilities.Math.Vector;

function angle_between
  import BobDyn.Utilities.Math.Vector.cross;
  import BobDyn.Utilities.Math.Vector.dot;

  input Real a[3];
  input Real b[3];
  input Real n[3]; // axis of rotation
  output Real theta;

protected
  Real num;
  Real den;
  Real eps = 1e-8;  // hard numerical floor

algorithm
  // Signed angle using atan2 formulation
  // theta = atan2( n · (a × b), a · b )
  //
  // This is:
  //  - continuous
  //  - signed
  //  - well-defined for all magnitudes
  //  - numerically stable near alignment
  //  - event-free

  num := dot(n, cross(a, b));
  den := dot(a, b);

  // Regularize only to avoid atan2(0,0)
  theta := atan2(num, den + eps);

end angle_between;
