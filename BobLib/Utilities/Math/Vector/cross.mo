within BobLib.Utilities.Math.Vector;

function cross
  input Real a[3];
  input Real b[3];
  output Real result[3];
algorithm
  result := {
    a[2]*b[3] - a[3]*b[2],
    a[3]*b[1] - a[1]*b[3],
    a[1]*b[2] - a[2]*b[1]
  };
end cross;
