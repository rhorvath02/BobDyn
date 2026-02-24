within BobDyn.Utilities.Math.Vector;

function dot
  input Real[:] a;
  input Real[:] b;
  output Real result;
algorithm
  result := sum(a[i] * b[i] for i in 1:size(a,1));
end dot;
