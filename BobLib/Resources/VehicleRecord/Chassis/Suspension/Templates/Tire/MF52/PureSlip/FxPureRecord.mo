within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

record FxPureRecord
  // Scaling
  Real LGAX "Camber influence scaling for longitudinal force [-]";
  Real LFZO "Scaling of nominal load Fz0 [-]";

  // Shape (C)
  Real PCX1 "Shape factor C [-]";

  // Peak (D)
  Real PDX1 "Base friction coefficient [-]";
  Real PDX2 "Load sensitivity of friction [-]";
  Real PDX3 "Camber influence on friction [-]";

  // Stiffness (B via Kx)
  Real PKX1 "Longitudinal stiffness factor [-]";
  Real PKX2 "Load-dependent stiffness factor [-]";
  Real PKX3 "Exponential stiffness variation [-]";

  // Shift (Shx)
  Real PHX1 "Horizontal shift base [-]";
  Real PHX2 "Horizontal shift load dependency [-]";

  // Shift (Svx)
  Real PVX1 "Vertical shift base [-]";
  Real PVX2 "Vertical shift load dependency [-]";

  // Curvature (E)
  Real PEX1 "Curvature factor base [-]";
  Real PEX2 "Curvature load dependency [-]";
  Real PEX3 "Quadratic curvature load term [-]";
  Real PEX4 "Curvature asymmetry factor [-]";

  // Lambda scaling
  Real LCX "Shape factor scaling [-]";
  Real LMUX "Friction scaling [-]";
  Real LKX "Stiffness scaling [-]";
  Real LHX "Horizontal shift scaling [-]";
  Real LVX "Vertical shift scaling [-]";
  Real LEX "Curvature scaling [-]";
  Real LXAL "Combined slip interaction scaling [-]";

end FxPureRecord;
