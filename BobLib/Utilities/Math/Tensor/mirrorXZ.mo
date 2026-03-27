within BobLib.Utilities.Math.Tensor;

function mirrorXZ
  input Real T[3,3];
  output Real T_m[3,3];

protected
  constant Real R[3,3] = [1, 0, 0;
                          0,-1, 0;
                          0, 0, 1];

algorithm
  T_m := R * T * transpose(R);
  
end mirrorXZ;
