within BobLib.Resources.VehicleDefn;

record OrionRecord

  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.MassRecord;
  
  import TireModel = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.MF52;
  import Wheel = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire;
  import Rack = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.SteeringRack;
  import Stabar = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Stabar;
  import DW = BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.DoubleWishbone;
  import Axle = BobLib.Resources.VehicleRecord.Chassis.Suspension;
  
  parameter Rack.RackAndPinionRecord pRack(
    leftPickup = {0.05715, 0.2260092, 0.1137158},
    cFactor = 0.0889);
  
  parameter Stabar.StabarRecord pFrStabar(
    leftArmEnd = {-0.03682914, 0.2667, 0.11597939},
    leftBarEnd = {-0.10664664, 0.2667, 0.11811},
    barRate = 258);
  
  parameter DW.WishboneUprightLoopRecord pFrDW(
    upperFore_i = {0.1016, 0.237744, 0.2143252},
    upperAft_i = {-0.0680974, 0.2356358, 0.215138},
    lowerFore_i = {0.1016, 0.226314, 0.08001},
    lowerAft_i = {-0.0762, 0.226314, 0.08001},
    upper_o = {-0.0092964, 0.5420106, 0.2679954},
    lower_o = {0.0029972, 0.562991, 0.1139952},
    tie_o = {0.0569976, 0.546989, 0.1522222},
    wheelCenter = {0, 0.606110767456, 0.199898});
    
  parameter Axle.Templates.AxleMassRecord pFrAxleMass(
    unsprungMass = MassRecord(m = 7.8160579,
                              rCM = {-0.0061298, 0.60174377, 0.19797979},
                              inertia = {{0.10580066, 0.00038293, 0.00058877}, {0.00038293, 0.16064008, -0.00075416}, {0.00058877, -0.00075416, 0.10801766}}),
    ucaMass = MassRecord(m = 0.55776965,
                         rCM = {-0.00187916, 0.45854113, 0.25343195},
                         inertia = {{0.00700626, -0.00058434, -0.0001073}, {-0.00058434, 0.0011635, 0.00116272}, {-0.0001073, 0.00116272, 0.00762498}}),
    lcaMass = MassRecord(m = 0.5182905,
                         rCM = {0.00803455, 0.40581792, 0.09882118},
                         inertia = {{0.00649759, -0.00017572, -0.00001824}, {-0.00017572, 0.00145437, 0.00068888}, {-0.00001824, 0.00068888, 0.00776251}}),
    tieMass = MassRecord(m = 0.13459415,
                         rCM = {0.05709287, 0.34616483, 0.1281302},
                         inertia = {{0.00178949, -0.00000083, -0.0000001}, {-0.00000083, 0.00002994, 0.00021109}, {-0.0000001, 0.000211, 0.001764}}));
  
  parameter Axle.AxleDWRecord pFrAxleDW(
    bellcrankPivot = {-0.042144464098, 0.250754351932, 0.370010000136},
    bellcrankPivotAxis = {0.95754655, -0.26587315, -0.11142744},
    bellcrankPickup1 = {-0.029010173628, 0.2971411507, 0.37219698865},
    bellcrankPickup2 = {-0.014493326106, 0.348410770284, 0.374614186762},
    bellcrankPickup3 = {-0.01102742905, 0.34553503283, 0.411259910778},
    rodMount = {0.006762552642, 0.525610676234, 0.134465050856},
    shockMount = {-0.020673469702, 0.247847085458, 0.561456926868});
    
  parameter Wheel.Templates.PartialWheelRecord pFrTireSetup(
    R0 = 0.2045,
    rimR0 = 0.2045*0.625,
    rimWidth = 0.2045*0.625*1.4,
    staticAlpha = 0,
    staticGamma = 15);
  
  parameter Wheel.Wheel1DOF_YRecord pFrTireDOF(
    wheelJ = 0.02);
  
  parameter TireModel.MF52Record tireFL(
    // Setup
    setup = TireModel.SetupRecord(FNOMIN = 654.0, UNLOADED_RADIUS = pFrTireSetup.R0),

    // Fx - Pure
    fxPure = TireModel.PureSlip.FxPureRecord(
      LFZO = 1.0, LGAX = 1.0,
      PCX1 = 1.53041,
      PDX1 = 2.597991, PDX2 = -0.618826, PDX3 = 11.156379,
      PKX1 = 55.079922, PKX2 = -1.7e-05, PKX3 = -0.16185,
      PHX1 = -0.000126, PHX2 = 0.000467,
      PVX1 = 0.0, PVX2 = 0.0,
      PEX1 = 0.0, PEX2 = 0.141806, PEX3 = -1.93495, PEX4 = 0.044722,
      LCX  = 1.0, LMUX = 1.0, LKX  = 1.0, LHX  = 1.0, LVX  = 1.0, LEX  = 1.0, LXAL = 1.0),

    // Fx - Combined
    fxCombined = TireModel.CombinedSlip.FxCombinedRecord(
      RBX1 = 8.151136, RBX2 = 5.388063,
      RCX1 = 1.122399,
      REX1 = 0.052014, REX2 = -0.89845,
      RHX1 = 0.0,
      RVX1 = 0.0, RVX2 = 0.0),

    // Fy - Pure
    fyPure = TireModel.PureSlip.FyPureRecord(
      LFZO = 1.0, LGAY = 1.0,
      PCY1 = 1.53041,
      PDY1 = -2.40275, PDY2 = 0.343535, PDY3 = 3.89743,
      PKY1 = -53.2421, PKY2 = 2.38205, PKY3 = 1.36502,
      PHY1 = 0.0, PHY2 = 0.0, PHY3 = 0.0,
      PVY1 = 0.0, PVY2 = 0.0, PVY3 = 0.0, PVY4 = 0.0,
      PEY1 = 0.0, PEY2 = -0.280762, PEY3 = 0.70403, PEY4 = -0.478297,
      LCY  = 1.0, LMUY = 1.0, LEY  = 1.0, LKY  = 1.0, LHY  = 1.0, LVY  = 1.0,
      LYKA  = 1.0, LVYKA = 1.0
    ),

    // Fy - Combined
    fyCombined = TireModel.CombinedSlip.FyCombinedRecord(
      RBY1 = 14.628, RBY2 = 10.4, RBY3 = -0.00441045,
      RCY1 = 1.044,
      REY1 = 0.048, REY2 = 0.025,
      RHY1 = 0.009, RHY2 = 0.0023097,
      RVY1 = 4.78297e-06, RVY2 = 0.0127967, RVY3 = -0.498917, RVY4 = 18.2625, RVY5 = 2.72152, RVY6 = -10.5225),

    // Mx
    mxPure = TireModel.PureSlip.MxPureRecord(
      QSX1 = -0.0130807, QSX2 = 0.0, QSX3 = 0.0587803,
      LMX  = 1.0, LVMX = 1.0),

    mxCombined = TireModel.CombinedSlip.MxCombinedRecord(),

    // My - Pure
    myPure = TireModel.PureSlip.MyPureRecord(
      QSY1 = 0.0, QSY2 = 0.0, QSY3 = 0.0, QSY4 = 0.0,
      Vref = 11.176, LMY  = 1.0
    ),

    myCombined = TireModel.CombinedSlip.MyCombinedRecord(),

    // Mz - Pure
    mzPure = TireModel.PureSlip.MzPureRecord(
      QBZ1=8.22843, QBZ2=2.98676, QBZ3=-3.57739, QBZ4=-0.429117, QBZ5=0.433125,
      QCZ1=1.41359,
      QDZ1=0.152526, QDZ2=-0.0381101, QDZ3=0.387762, QDZ4=-3.95699,
      QEZ1=-0.239731, QEZ2=1.29253, QEZ3=-1.21298, QEZ4=0.197579, QEZ5=0.244,
      QHZ1=-0.00101749, QHZ2=0.000378319, QHZ3=-0.0405191, QHZ4=0.0185463,
      QBZ9=0.0, QBZ10=-1.72926,
      QDZ6=0.00604966, QDZ7=-0.000116241, QDZ8=-2.33359, QDZ9=-0.0379755,
      LTR=1.0, LRES=1.0, LKY=1.0, LMUY=1.0, LGAZ=1.0),

    // Mz - Combined
    mzCombined = TireModel.CombinedSlip.MzCombinedRecord(
      SSZ1=0.0, SSZ2=0.0, SSZ3=0.0, SSZ4=0.0,
      RVY1=4.78297e-06, RVY2=0.0127967, RVY3=-0.498917,
      RVY4=18.2625, RVY5=2.72152, RVY6=-10.5225,
      LS=1.0, LVYKA=1.0));

  // All corners
  TireModel.MF52Record tireFR = tireFL;
  TireModel.MF52Record tireRL = tireFL;
  TireModel.MF52Record tireRR = tireFL;

end OrionRecord;
