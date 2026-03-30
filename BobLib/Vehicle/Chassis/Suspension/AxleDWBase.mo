within BobLib.Vehicle.Chassis.Suspension;

partial model AxleDWBase
  import Modelica.SIunits;
  
  import BobLib.Utilities.Math.Vector;
  import BobLib.Utilities.Math.Tensor;
  
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.Tire.Templates.PartialWheelRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.SteeringRack.RackAndPinionRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoopRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.AxleMassRecord;
  
  // Record parameters
  parameter PartialWheelRecord pLeftPartialWheel;
  parameter PartialWheelRecord pRightPartialWheel(R0 = pLeftPartialWheel.R0,
                                                  rimR0 = pLeftPartialWheel.rimR0,
                                                  rimWidth = pLeftPartialWheel.rimWidth,
                                                  staticAlpha = -pLeftPartialWheel.staticAlpha,
                                                  staticGamma = -pLeftPartialWheel.staticGamma);
  parameter RackAndPinionRecord pRack;
  parameter WishboneUprightLoopRecord pLeftDW;
  parameter WishboneUprightLoopRecord pRightDW(upperFore_i = Vector.mirrorXZ(pLeftDW.upperFore_i),
                                               upperAft_i = Vector.mirrorXZ(pLeftDW.upperAft_i),
                                               lowerFore_i = Vector.mirrorXZ(pLeftDW.lowerFore_i),
                                               lowerAft_i = Vector.mirrorXZ(pLeftDW.lowerAft_i),
                                               upper_o = Vector.mirrorXZ(pLeftDW.upper_o),
                                               lower_o = Vector.mirrorXZ(pLeftDW.lower_o),
                                               tie_o = Vector.mirrorXZ(pLeftDW.tie_o),
                                               wheelCenter = Vector.mirrorXZ(pLeftDW.wheelCenter));
  parameter AxleMassRecord pLeftAxleMass;
  parameter AxleMassRecord pRightAxleMass(unsprungMass(m = pLeftAxleMass.unsprungMass.m,
                                                       rCM = Vector.mirrorXZ(pLeftAxleMass.unsprungMass.rCM),
                                                       inertia = Tensor.mirrorXZ(pLeftAxleMass.unsprungMass.inertia)),
                                          ucaMass(m = pLeftAxleMass.ucaMass.m,
                                                  rCM = Vector.mirrorXZ(pLeftAxleMass.ucaMass.rCM),
                                                  inertia = Tensor.mirrorXZ(pLeftAxleMass.ucaMass.inertia)),
                                          lcaMass(m = pLeftAxleMass.lcaMass.m,
                                                  rCM = Vector.mirrorXZ(pLeftAxleMass.lcaMass.rCM),
                                                  inertia = Tensor.mirrorXZ(pLeftAxleMass.lcaMass.inertia)),
                                          tieMass(m = pLeftAxleMass.tieMass.m,
                                                  rCM = Vector.mirrorXZ(pLeftAxleMass.tieMass.rCM),
                                                  inertia = Tensor.mirrorXZ(pLeftAxleMass.tieMass.inertia)));
  
  // Visual parameters
  outer parameter SIunits.Length linkDiameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  outer parameter SIunits.Length jointDiameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  
  // Effective center for internal calculations
  final parameter SIunits.Position[3] effectiveCenter = {pLeftDW.wheelCenter[1], 0, pLeftDW.wheelCenter[3]};

  // Interface frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a axleFrame annotation(
    Placement(transformation( extent = {{16, -16}, {-16, 16}}, rotation = -90), 
    iconTransformation(origin = {0, 50}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b leftCP annotation(
    Placement(transformation(origin = {-160, 0}, extent = {{16, -16}, {-16, 16}}, rotation = -90), 
    iconTransformation(origin = {-180, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b rightCP annotation(
    Placement(transformation(origin = {160, 0}, extent = {{16, -16}, {-16, 16}}, rotation = -90), 
    iconTransformation(origin = {180, 0}, extent = {{-16, -16}, {16, 16}})));
  
   // Wheel torque inputs
  Modelica.Mechanics.Rotational.Interfaces.Flange_b leftTorque annotation(
    Placement(transformation(origin = {-180, 50}, extent = {{-10, -10}, {10, 10}}), 
    iconTransformation(origin = {-180, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b rightTorque annotation(
    Placement(transformation(origin = {180, 50}, extent = {{-10, -10}, {10, 10}}), 
    iconTransformation(origin = {180, 50}, extent = {{-10, -10}, {10, 10}})));
  
  // Tires
  replaceable BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire leftTire(pPartialWheel = pLeftPartialWheel) annotation(
    Placement(transformation(origin = {-160, 50}, extent = {{10, -10}, {-10, 10}})));
  replaceable BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire rightTire(pPartialWheel = pRightPartialWheel) annotation(
    Placement(transformation(origin = {160, 50}, extent = {{-10, -10}, {10, 10}})));
  
  // Double wishbones
  BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoop leftWishboneUprightLoop(pDW = pLeftDW, final linkDiameter = linkDiameter, final jointDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {-69, 50}, extent = {{29, -29}, {-29, 29}})));
  BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoop rightWishboneUprightLoop(pDW = pRightDW, final linkDiameter = linkDiameter, final jointDiameter = jointDiameter) annotation(
    Placement(transformation(origin = {69, 50}, extent = {{-29, -29}, {29, 29}})));
  
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod leftTieRod(r_a = pRack.leftPickup,
                                                            r_b = pLeftDW.tie_o,
                                                            show_universal_axes = false,
                                                            kinematicConstraint = true,
                                                            final linkDiameter = linkDiameter,
                                                            final jointDiameter = jointDiameter)  annotation(
    Placement(transformation(origin = {-60, 100}, extent = {{20, -20}, {-20, 20}})));
  
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod rightTieRod(r_a = Vector.mirrorXZ(pRack.leftPickup),
                                                             r_b = pRightDW.tie_o,
                                                             show_universal_axes = false,
                                                             kinematicConstraint = true,
                                                             final linkDiameter = linkDiameter,
                                                             final jointDiameter = jointDiameter)  annotation(
    Placement(transformation(origin = {60, 100}, extent = {{-20, -20}, {20, 20}})));

  BobLib.Vehicle.Chassis.Suspension.Templates.SteeringRack.RackAndPinion rackAndPinion(pRack = pRack, final linkDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}})));
  
protected
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRack(r = {pRack.leftPickup[1], 0, pRack.leftPickup[3]} - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation leftTieConnection(r = pLeftDW.lower_o - pLeftDW.tie_o) annotation(
    Placement(transformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rightTieConnection(r = pRightDW.lower_o - pRightDW.tie_o) annotation(
    Placement(transformation(origin = {100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftWheelCenter(r = pLeftDW.wheelCenter - pLeftDW.lower_o) annotation(
    Placement(transformation(origin = {-120, 30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightWheelCenter(r = pRightDW.wheelCenter - pRightDW.lower_o) annotation(
    Placement(transformation(origin = {120, 30}, extent = {{-10, -10}, {10, 10}})));
    
  // Fixed geometry from effective center to nodes
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftUpper_i(r = (pLeftDW.upperFore_i + pLeftDW.upperAft_i)/2 - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {-20, 70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftLower_i(r = (pLeftDW.lowerFore_i + pLeftDW.lowerAft_i)/2 - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{10, -10}, {-10, 10}})));
    
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightUpper_i(r = (pRightDW.upperFore_i + pRightDW.upperAft_i)/2 - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {20, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightLower_i(r = (pRightDW.lowerFore_i + pRightDW.lowerAft_i)/2 - effectiveCenter, animation = false) annotation(
    Placement(transformation(origin = {20, 30}, extent = {{-10, -10}, {10, 10}})));
  
  // Left-half bodies
  Modelica.Mechanics.MultiBody.Parts.Body leftUCABody(m = pLeftAxleMass.ucaMass.m,
                                                      r_CM = pLeftAxleMass.ucaMass.rCM - pLeftDW.upper_o,
                                                      I_11 = pLeftAxleMass.ucaMass.inertia[1, 1],
                                                      I_22 = pLeftAxleMass.ucaMass.inertia[2, 2],
                                                      I_33 = pLeftAxleMass.ucaMass.inertia[3, 3],
                                                      I_21 = pLeftAxleMass.ucaMass.inertia[2, 1],
                                                      I_31 = pLeftAxleMass.ucaMass.inertia[3, 1],
                                                      I_32 = pLeftAxleMass.ucaMass.inertia[3, 2],
                                                      sphereDiameter = jointDiameter,
                                                      cylinderDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {-119, 90}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body leftLCABody(m = pLeftAxleMass.lcaMass.m,
                                                      r_CM = pLeftAxleMass.lcaMass.rCM - pLeftDW.lower_o,
                                                      I_11 = pLeftAxleMass.lcaMass.inertia[1, 1],
                                                      I_22 = pLeftAxleMass.lcaMass.inertia[2, 2],
                                                      I_33 = pLeftAxleMass.lcaMass.inertia[3, 3],
                                                      I_21 = pLeftAxleMass.lcaMass.inertia[2, 1],
                                                      I_31 = pLeftAxleMass.lcaMass.inertia[3, 1],
                                                      I_32 = pLeftAxleMass.lcaMass.inertia[3, 2],
                                                      sphereDiameter = jointDiameter,
                                                      cylinderDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {-130, 12}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Body leftUnsprungBody(m = pLeftAxleMass.unsprungMass.m,
                                                           r_CM = pLeftAxleMass.unsprungMass.rCM - pLeftDW.wheelCenter,
                                                           I_11 = pLeftAxleMass.unsprungMass.inertia[1, 1],
                                                           I_22 = pLeftAxleMass.unsprungMass.inertia[2, 2],
                                                           I_33 = pLeftAxleMass.unsprungMass.inertia[3, 3],
                                                           I_21 = pLeftAxleMass.unsprungMass.inertia[2, 1],
                                                           I_31 = pLeftAxleMass.unsprungMass.inertia[3, 1],
                                                           I_32 = pLeftAxleMass.unsprungMass.inertia[3, 2],
                                                           sphereDiameter = jointDiameter,
                                                           cylinderDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {-170, 80}, extent = {{10, -10}, {-10, 10}})));
  
  // Right-half bodies
  Modelica.Mechanics.MultiBody.Parts.Body rightUCABody(m = pRightAxleMass.ucaMass.m,
                                                       r_CM = pRightAxleMass.ucaMass.rCM - pRightDW.upper_o,
                                                       I_11 = pRightAxleMass.ucaMass.inertia[1, 1],
                                                       I_22 = pRightAxleMass.ucaMass.inertia[2, 2],
                                                       I_33 = pRightAxleMass.ucaMass.inertia[3, 3],
                                                       I_21 = pRightAxleMass.ucaMass.inertia[2, 1],
                                                       I_31 = pRightAxleMass.ucaMass.inertia[3, 1],
                                                       I_32 = pRightAxleMass.ucaMass.inertia[3, 2],
                                                       sphereDiameter = jointDiameter,
                                                       cylinderDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {120, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Body rightLCABody(m = pRightAxleMass.lcaMass.m,
                                                       r_CM = pRightAxleMass.lcaMass.rCM - pRightDW.lower_o,
                                                       I_11 = pRightAxleMass.lcaMass.inertia[1, 1],
                                                       I_22 = pRightAxleMass.lcaMass.inertia[2, 2],
                                                       I_33 = pRightAxleMass.lcaMass.inertia[3, 3],
                                                       I_21 = pRightAxleMass.lcaMass.inertia[2, 1],
                                                       I_31 = pRightAxleMass.lcaMass.inertia[3, 1],
                                                       I_32 = pRightAxleMass.lcaMass.inertia[3, 2],
                                                       sphereDiameter = jointDiameter,
                                                       cylinderDiameter = linkDiameter) annotation(
    Placement(transformation(origin = {130, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body rightUnsprungBody(m = pRightAxleMass.unsprungMass.m,
                                                            r_CM = pRightAxleMass.unsprungMass.rCM - pRightDW.wheelCenter,
                                                            I_11 = pRightAxleMass.unsprungMass.inertia[1, 1],
                                                            I_22 = pRightAxleMass.unsprungMass.inertia[2, 2],
                                                            I_33 = pRightAxleMass.unsprungMass.inertia[3, 3],
                                                            I_21 = pRightAxleMass.unsprungMass.inertia[2, 1],
                                                            I_31 = pRightAxleMass.unsprungMass.inertia[3, 1],
                                                            I_32 = pRightAxleMass.unsprungMass.inertia[3, 2],
                                                            sphereDiameter = jointDiameter,
                                                            cylinderDiameter = linkDiameter)  annotation(
    Placement(transformation(origin = {170, 80}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(leftCP, leftTire.cpFrame) annotation(
    Line(points = {{-160, 0}, {-160, 40}}));
  connect(rightCP, rightTire.cpFrame) annotation(
    Line(points = {{160, 0}, {160, 40}}));
  connect(leftTorque, leftTire.hubFlange) annotation(
    Line(points = {{-180, 50}, {-170, 50}}));
  connect(rightTorque, rightTire.hubFlange) annotation(
    Line(points = {{180, 50}, {170, 50}}));
  connect(axleFrame, toLeftLower_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 30}, {-10, 30}}));
  connect(axleFrame, toRightLower_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 30}, {10, 30}}));
  connect(axleFrame, toLeftUpper_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 70}, {-10, 70}}));
  connect(axleFrame, toRightUpper_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 70}, {10, 70}}));
  connect(toLeftLower_i.frame_b, leftWishboneUprightLoop.lowerFrame_i) annotation(
    Line(points = {{-30, 30}, {-40, 30}}, color = {95, 95, 95}));
  connect(toLeftUpper_i.frame_b, leftWishboneUprightLoop.upperFrame_i) annotation(
    Line(points = {{-30, 70}, {-40, 70}}, color = {95, 95, 95}));
  connect(toRightLower_i.frame_b, rightWishboneUprightLoop.lowerFrame_i) annotation(
    Line(points = {{30, 30}, {40, 30}}, color = {95, 95, 95}));
  connect(toRightUpper_i.frame_b, rightWishboneUprightLoop.upperFrame_i) annotation(
    Line(points = {{30, 70}, {40, 70}}, color = {95, 95, 95}));
  connect(axleFrame, toRack.frame_a) annotation(
    Line(points = {{0, 0}, {0, 80}}));
  connect(toRack.frame_b, rackAndPinion.mountFrame) annotation(
    Line(points = {{0, 100}, {0, 106}}, color = {95, 95, 95}));
  connect(rackAndPinion.leftFrame, leftTieRod.frame_a) annotation(
    Line(points = {{-20, 110}, {-30, 110}, {-30, 100}, {-40, 100}}, color = {95, 95, 95}));
  connect(rackAndPinion.rightFrame, rightTieRod.frame_a) annotation(
    Line(points = {{20, 110}, {30, 110}, {30, 100}, {40, 100}}, color = {95, 95, 95}));
  connect(leftTieRod.frame_b, leftTieConnection.frame_a) annotation(
    Line(points = {{-80, 100}, {-100, 100}, {-100, 80}}, color = {95, 95, 95}));
  connect(rightTieRod.frame_b, rightTieConnection.frame_a) annotation(
    Line(points = {{80, 100}, {100, 100}, {100, 80}}, color = {95, 95, 95}));
  connect(leftTieConnection.frame_b, leftWishboneUprightLoop.steeringFrame) annotation(
    Line(points = {{-100, 60}, {-100, 30}, {-98, 30}}, color = {95, 95, 95}));
  connect(rightTieConnection.frame_b, rightWishboneUprightLoop.steeringFrame) annotation(
    Line(points = {{100, 60}, {100, 30}, {98, 30}}, color = {95, 95, 95}));
  connect(leftWishboneUprightLoop.steeringFrame, toLeftWheelCenter.frame_a) annotation(
    Line(points = {{-98, 29.7}, {-110, 29.7}}, color = {95, 95, 95}));
  connect(rightWishboneUprightLoop.steeringFrame, toRightWheelCenter.frame_a) annotation(
    Line(points = {{98, 29.7}, {110, 29.7}}, color = {95, 95, 95}));
  connect(leftTire.chassisFrame, toLeftWheelCenter.frame_b) annotation(
    Line(points = {{-150, 50}, {-140, 50}, {-140, 30}, {-130, 30}}, color = {95, 95, 95}));
  connect(rightTire.chassisFrame, toRightWheelCenter.frame_b) annotation(
    Line(points = {{150, 50}, {140, 50}, {140, 30}, {130, 30}}, color = {95, 95, 95}));
  connect(leftUCABody.frame_a, leftWishboneUprightLoop.upperFrame_o) annotation(
    Line(points = {{-109, 90}, {-68, 90}, {-68, 78}}, color = {95, 95, 95}));
  connect(leftLCABody.frame_a, leftWishboneUprightLoop.lowerFrame_o) annotation(
    Line(points = {{-120, 12}, {-68, 12}, {-68, 22}}, color = {95, 95, 95}));
  connect(rightUCABody.frame_a, rightWishboneUprightLoop.upperFrame_o) annotation(
    Line(points = {{110, 90}, {70, 90}, {70, 78}}, color = {95, 95, 95}));
  connect(rightLCABody.frame_a, rightWishboneUprightLoop.lowerFrame_o) annotation(
    Line(points = {{120, 12}, {70, 12}, {70, 22}}, color = {95, 95, 95}));
  connect(leftUnsprungBody.frame_a, leftTire.chassisFrame) annotation(
    Line(points = {{-160, 80}, {-140, 80}, {-140, 50}, {-150, 50}}, color = {95, 95, 95}));
  connect(rightUnsprungBody.frame_a, rightTire.chassisFrame) annotation(
    Line(points = {{160, 80}, {140, 80}, {140, 50}, {152, 50}}, color = {95, 95, 95}));
  
  annotation(
    Diagram(coordinateSystem(extent = {{-180, -20}, {180, 140}}, preserveAspectRatio = true, grid = {4, 2})),
    Icon(coordinateSystem(extent = {{-180, -20}, {180, 140}}, preserveAspectRatio = true, grid = {4, 2}), graphics = {Line(origin = {-25, 35}, points = {{-35, -15}, {25, 15}}), Line(origin = {-30, 65}, points = {{-30, -9}, {30, -15}}), Line(origin = {-82, 24}, points = {{22, -4}, {-24, 4}}, thickness = 5), Line(origin = {-82, 60}, points = {{22, -4}, {-22, 6}}, thickness = 5), Ellipse(origin = {-60, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {-60, 56}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-30, 65}, points = {{90, -9}, {30, -15}}), Line(origin = {35, -5}, points = {{-35, 55}, {25, 25}}), Line(origin = {84, 16}, points = {{22, 12}, {-24, 4}}, thickness = 5, arrowSize = 2), Line(origin = {81, 61}, points = {{-21, -5}, {23, 5}}, thickness = 5), Ellipse(origin = {60, 56}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {60, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-160, 4}, points = {{-20, -4}, {40, -4}, {40, 6}}), Line(origin = {160, 4}, points = {{20, -4}, {-40, -4}, {-40, 6}}), Line(origin = {-130, 50}, points = {{-10, 0}, {-50, 0}}, pattern = LinePattern.Dash, thickness = 1), Line(origin = {190, 50}, points = {{-10, 0}, {-50, 0}}, pattern = LinePattern.Dash, thickness = 1), Line(origin = {-80, 36}, points = {{20, -6}, {-22, 6}}, thickness = 5), Ellipse(origin = {-60, 30}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Rectangle(origin = {-120, 50}, fillColor = {71, 71, 71}, fillPattern = FillPattern.Solid, extent = {{-20, 40}, {20, -40}}, radius = 5), Line(origin = {40, 36}, points = {{20, -6}, {64, 6}}, thickness = 5), Ellipse(origin = {60, 30}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Rectangle(origin = {120, 50}, fillColor = {71, 71, 71}, fillPattern = FillPattern.Solid, extent = {{-20, 40}, {20, -40}}, radius = 5), Line(origin = {-25, 35}, points = {{-35, -15}, {25, 15}}), Line(origin = {35, -5}, points = {{-35, 55}, {25, 25}}), Line(origin = {-10, 30}, points = {{-36, 0}, {56, 0}}, thickness = 8), Line(origin = {-50, 30}, points = {{4, 0}, {-4, 0}}, color = {255, 0, 0}, thickness = 5), Line(origin = {50, 30}, points = {{4, 0}, {-4, 0}}, color = {255, 0, 0}, thickness = 5), Line(origin = {0, 46}, points = {{0, 4}, {0, -12}})}));
end AxleDWBase;
