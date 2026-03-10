within BobLib.Resources.Records.PTN;

record CellParams
  parameter Modelica.SIunits.Charge Q_C = 10800 "Cell capacity";
  parameter Modelica.SIunits.Resistance R0 = 0.01539 "Cell DC internal resistance";
  parameter Real OCV_table[:,2] = [0.00, 3.0;
                                   0.10, 3.4;
                                   0.20, 3.6;
                                   0.50, 3.7;
                                   0.80, 3.9;
                                   1.00, 4.2] "SOC vs OCV lookup table (SOC in [0,1])";

end CellParams;
