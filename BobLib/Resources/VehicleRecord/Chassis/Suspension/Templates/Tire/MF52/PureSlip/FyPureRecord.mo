within BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52.PureSlip;

record FyPureRecord
  // Scaling
  Real LFZO "Nominal load scaling [-]";
  Real LGAY "Camber influence scaling [-]";

  // Shape (C)
  Real PCY1 "Shape factor C [-]";

  // Peak (D)
  Real PDY1 "Base friction coefficient [-]";
  Real PDY2 "Load sensitivity of friction [-]";
  Real PDY3 "Camber influence on friction [-]";

  // Stiffness (cornering stiffness Ky)
  Real PKY1 "Cornering stiffness factor [-]";
  Real PKY2 "Load scaling for stiffness [-]";
  Real PKY3 "Camber reduction of stiffness [-]";

  // Shift (Shy)
  Real PHY1 "Horizontal shift base [-]";
  Real PHY2 "Horizontal shift load dependency [-]";
  Real PHY3 "Camber-induced horizontal shift [-]";

  // Shift (Svy)
  Real PVY1 "Vertical shift base [-]";
  Real PVY2 "Vertical shift load dependency [-]";
  Real PVY3 "Camber-induced vertical shift [-]";
  Real PVY4 "Load-camber coupling in vertical shift [-]";

  // Curvature (E)
  Real PEY1 "Curvature base [-]";
  Real PEY2 "Curvature load dependency [-]";
  Real PEY3 "Curvature asymmetry factor [-]";
  Real PEY4 "Camber influence on curvature [-]";

  // Lambda scaling
  Real LCY "Shape scaling [-]";
  Real LMUY "Friction scaling [-]";
  Real LEY "Curvature scaling [-]";
  Real LKY "Stiffness scaling [-]";
  Real LHY "Horizontal shift scaling [-]";
  Real LVY "Vertical shift scaling [-]";

  // Combined slip interaction
  Real LYKA "Combined slip interaction scaling [-]";
  Real LVYKA "Combined slip vertical shift scaling [-]";

end FyPureRecord;
