within BobLib.Resources.VehicleDefn;

record OrionRecord

  import Tire = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52;

  parameter Tire.MF52Record tireFL(

    // Setup
    setup = Tire.SetupRecord(
      Fnomin = 654.0,
      R0     = 0.2045
    ),

    // Fx - Pure
    fxPure = Tire.PureSlip.FxPureRecord(
      LFZO = 1.0,
      LGAX = 1.0,

      PCX1 = 1.53041,

      PDX1 = 2.597991,
      PDX2 = -0.618826,
      PDX3 = 11.156379,

      PKX1 = 55.079922,
      PKX2 = -1.7e-05,
      PKX3 = -0.16185,

      PHX1 = -0.000126,
      PHX2 = 0.000467,

      PVX1 = 0.0,
      PVX2 = 0.0,

      PEX1 = 0.0,
      PEX2 = 0.141806,
      PEX3 = -1.93495,
      PEX4 = 0.044722,

      LCX  = 1.0,
      LMUX = 1.0,
      LKX  = 1.0,
      LHX  = 1.0,
      LVX  = 1.0,
      LEX  = 1.0,
      LXAL = 1.0
    ),

    // Fx - Combined
    fxCombined = Tire.CombinedSlip.FxCombinedRecord(
      RBX1 = 8.151136,
      RBX2 = 5.388063,
      RCX1 = 1.122399,
      REX1 = 0.052014,
      REX2 = -0.89845,

      RHX1 = 0.0,

      RVX1 = 0.0,
      RVX2 = 0.0
    ),

    // Fy - Pure
    fyPure = Tire.PureSlip.FyPureRecord(
      LFZO = 1.0,
      LGAY = 1.0,

      PCY1 = 1.53041,

      PDY1 = -2.40275,
      PDY2 = 0.343535,
      PDY3 = 3.89743,

      PKY1 = -53.2421,
      PKY2 = 2.38205,
      PKY3 = 1.36502,

      PHY1 = 0.0,
      PHY2 = 0.0,
      PHY3 = 0.0,

      PVY1 = 0.0,
      PVY2 = 0.0,
      PVY3 = 0.0,
      PVY4 = 0.0,

      PEY1 = 0.0,
      PEY2 = -0.280762,
      PEY3 = 0.70403,
      PEY4 = -0.478297,

      LCY  = 1.0,
      LMUY = 1.0,
      LEY  = 1.0,
      LKY  = 1.0,
      LHY  = 1.0,
      LVY  = 1.0,

      LYKA  = 1.0,
      LVYKA = 1.0
    ),

    // Fy - Combined
    fyCombined = Tire.CombinedSlip.FyCombinedRecord(
      RBY1 = 14.628,
      RBY2 = 10.4,
      RBY3 = -0.00441045,
      RCY1 = 1.044,
      REY1 = 0.048,
      REY2 = 0.025,

      RHY1 = 0.009,
      RHY2 = 0.0023097,

      RVY1 = 4.78297e-06,
      RVY2 = 0.0127967,
      RVY3 = -0.498917,
      RVY4 = 18.2625,
      RVY5 = 2.72152,
      RVY6 = -10.5225
    ),

    // Mx
    mxPure = Tire.PureSlip.MxPureRecord(
      QSX1 = -0.0130807,
      QSX2 = 0.0,
      QSX3 = 0.0587803,

      LMX  = 1.0,
      LVMX = 1.0
    ),

    mxCombined = Tire.CombinedSlip.MxCombinedRecord(),

    // My (FULL MF5.2)
    myPure = Tire.PureSlip.MyPureRecord(
      QSY1 = 0.0,
      QSY2 = 0.0,
      QSY3 = 0.0,
      QSY4 = 0.0,

      Vref = 11.176,
      LMY  = 1.0
    ),

    myCombined = Tire.CombinedSlip.MyCombinedRecord(),

    // Mz - Pure
    mzPure = Tire.PureSlip.MzPureRecord(
      QBZ1=8.22843, QBZ2=2.98676, QBZ3=-3.57739, QBZ4=-0.429117, QBZ5=0.433125,
      QCZ1=1.41359,
      QDZ1=0.152526, QDZ2=-0.0381101, QDZ3=0.387762, QDZ4=-3.95699,
      QEZ1=-0.239731, QEZ2=1.29253, QEZ3=-1.21298, QEZ4=0.197579, QEZ5=0.244,
      QHZ1=-0.00101749, QHZ2=0.000378319, QHZ3=-0.0405191, QHZ4=0.0185463,

      QBZ9=0.0, QBZ10=-1.72926,
      QDZ6=0.00604966, QDZ7=-0.000116241, QDZ8=-2.33359, QDZ9=-0.0379755,

      LTR=1.0,
      LRES=1.0,
      LKY=1.0,
      LMUY=1.0,
      LGAZ=1.0
    ),

    // Mz - Combined
    mzCombined = Tire.CombinedSlip.MzCombinedRecord(
      SSZ1=0.0, SSZ2=0.0, SSZ3=0.0, SSZ4=0.0,

      RVY1=4.78297e-06, RVY2=0.0127967, RVY3=-0.498917,
      RVY4=18.2625, RVY5=2.72152, RVY6=-10.5225,

      LS=1.0,
      LVYKA=1.0
    )
  );

  // All corners
  Tire.MF52Record tireFR = tireFL;
  Tire.MF52Record tireRL = tireFL;
  Tire.MF52Record tireRR = tireFL;

end OrionRecord;
