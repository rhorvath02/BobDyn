within BobDyn.Resources.Records.PTN;

record BatteryParams
  import Modelica.SIunits;
  
  parameter Integer Ns(min=1) "Total number of cells in series";
  parameter Integer Np(min=1) "Number of parallel strings";

  parameter SIunits.Current I_discharge_max "Max discharge current";
  parameter SIunits.Current I_charge_max "Max regen current";

  parameter SIunits.Voltage V_max "Overvoltage threshold";
  parameter SIunits.Voltage V_min "Undervoltage threshold";
  
end BatteryParams;
