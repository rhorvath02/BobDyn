within BobLib.Vehicle.Chassis.Suspension;

partial model AxleDWBase
  // Modelica units
  import Modelica.SIunits;
  
  // Custom linalg
  import BobLib.Utilities.Math.Vector;
  import BobLib.Utilities.Math.Tensor;
  
  // Records
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.SteeringRack.RackAndPinionRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoopRecord;
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.AxleMassRecord;
  
  // Load parameters
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
                                                       r_cm = Vector.mirrorXZ(pLeftAxleMass.unsprungMass.r_cm),
                                                       I = Tensor.mirrorXZ(pLeftAxleMass.unsprungMass.I)),
                                          ucaMass(m = pLeftAxleMass.ucaMass.m,
                                                  r_cm = Vector.mirrorXZ(pLeftAxleMass.ucaMass.r_cm),
                                                  I = Tensor.mirrorXZ(pLeftAxleMass.ucaMass.I)),
                                          lcaMass(m = pLeftAxleMass.lcaMass.m,
                                                  r_cm = Vector.mirrorXZ(pLeftAxleMass.lcaMass.r_cm),
                                                  I = Tensor.mirrorXZ(pLeftAxleMass.lcaMass.I)),
                                          tieMass(m = pLeftAxleMass.tieMass.m,
                                                  r_cm = Vector.mirrorXZ(pLeftAxleMass.tieMass.r_cm),
                                                  I = Tensor.mirrorXZ(pLeftAxleMass.tieMass.I)));
  
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  parameter SIunits.Length joint_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  
  // Effective center for internal calculations
  final parameter SIunits.Position[3] effective_center = {pLeftDW.wheelCenter[1], 0, pLeftDW.wheelCenter[3]};

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
  
  // Tires
  replaceable BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire leftTire annotation(
    Placement(transformation(origin = {-160, 50}, extent = {{10, -10}, {-10, 10}})));
  replaceable BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire rightTire annotation(
    Placement(transformation(origin = {160, 50}, extent = {{-10, -10}, {10, 10}})));
  
  // Wheel torque inputs
  Modelica.Mechanics.Rotational.Interfaces.Flange_b leftTorque annotation(
    Placement(transformation(origin = {-180, 50}, extent = {{-10, -10}, {10, 10}}), 
    iconTransformation(origin = {-180, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b rightTorque annotation(
    Placement(transformation(origin = {180, 50}, extent = {{-10, -10}, {10, 10}}), 
    iconTransformation(origin = {180, 50}, extent = {{-10, -10}, {10, 10}})));
  
  BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoop leftWishboneUprightLoop(pDW = pLeftDW, link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-69, 50}, extent = {{29, -29}, {-29, 29}})));
  BobLib.Vehicle.Chassis.Suspension.Templates.DoubleWishbone.WishboneUprightLoop rightWishboneUprightLoop(pDW = pRightDW, link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {69, 50}, extent = {{-29, -29}, {29, 29}})));
  
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod leftTieClosure(r_a = pRack.leftPickup,
                                                                r_b = pLeftDW.tie_o,
                                                                show_universal_axes = false,
                                                                kinematic_constraint = true,
                                                                link_diameter = link_diameter,
                                                                joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {-60, 100}, extent = {{20, -20}, {-20, 20}})));
  
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod rightTieClosure(r_a = Vector.mirrorXZ(pRack.leftPickup),
                                                                 r_b = pRightDW.tie_o,
                                                                 show_universal_axes = false,
                                                                 kinematic_constraint = true,
                                                                 link_diameter = link_diameter,
                                                                 joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {60, 100}, extent = {{-20, -20}, {20, 20}})));

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation leftTieConnection(r = pLeftDW.lower_o - pLeftDW.tie_o) annotation(
    Placement(transformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rightTieConnection(r = pRightDW.lower_o - pRightDW.tie_o) annotation(
    Placement(transformation(origin = {100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRack(r = {pRack.leftPickup[1], 0, pRack.leftPickup[3]} - effective_center, animation = false) annotation(
    Placement(transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  BobLib.Vehicle.Chassis.Suspension.Templates.SteeringRack.RackAndPinion RackAndPinion(pRack = pRack, link_diameter = link_diameter) annotation(
    Placement(transformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftWheelCenter(r = pLeftDW.wheelCenter - pLeftDW.lower_o) annotation(
    Placement(transformation(origin = {-120, 30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightWheelCenter(r = pRightDW.wheelCenter - pRightDW.lower_o) annotation(
    Placement(transformation(origin = {120, 30}, extent = {{-10, -10}, {10, 10}})));
  
  // Left-half bodies
  Modelica.Mechanics.MultiBody.Parts.Body leftUCABody(m = pLeftAxleMass.ucaMass.m,
                                                      r_CM = pLeftAxleMass.ucaMass.r_cm - pLeftDW.upper_o,
                                                      I_11 = pLeftAxleMass.ucaMass.I[1, 1],
                                                      I_22 = pLeftAxleMass.ucaMass.I[2, 2],
                                                      I_33 = pLeftAxleMass.ucaMass.I[3, 3],
                                                      I_21 = pLeftAxleMass.ucaMass.I[2, 1],
                                                      I_31 = pLeftAxleMass.ucaMass.I[3, 1],
                                                      I_32 = pLeftAxleMass.ucaMass.I[3, 2],
                                                      sphereDiameter = joint_diameter,
                                                      cylinderDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-119, 90}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body leftLCABody(m = pLeftAxleMass.lcaMass.m,
                                                      r_CM = pLeftAxleMass.lcaMass.r_cm - pLeftDW.lower_o,
                                                      I_11 = pLeftAxleMass.lcaMass.I[1, 1],
                                                      I_22 = pLeftAxleMass.lcaMass.I[2, 2],
                                                      I_33 = pLeftAxleMass.lcaMass.I[3, 3],
                                                      I_21 = pLeftAxleMass.lcaMass.I[2, 1],
                                                      I_31 = pLeftAxleMass.lcaMass.I[3, 1],
                                                      I_32 = pLeftAxleMass.lcaMass.I[3, 2],
                                                      sphereDiameter = joint_diameter,
                                                      cylinderDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-130, 12}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Body leftUnsprungBody(m = pLeftAxleMass.unsprungMass.m,
                                                           r_CM = pLeftAxleMass.unsprungMass.r_cm - pLeftDW.wheelCenter,
                                                           I_11 = pLeftAxleMass.unsprungMass.I[1, 1],
                                                           I_22 = pLeftAxleMass.unsprungMass.I[2, 2],
                                                           I_33 = pLeftAxleMass.unsprungMass.I[3, 3],
                                                           I_21 = pLeftAxleMass.unsprungMass.I[2, 1],
                                                           I_31 = pLeftAxleMass.unsprungMass.I[3, 1],
                                                           I_32 = pLeftAxleMass.unsprungMass.I[3, 2],
                                                           sphereDiameter = joint_diameter,
                                                           cylinderDiameter = link_diameter) annotation(
    Placement(transformation(origin = {-170, 80}, extent = {{10, -10}, {-10, 10}})));
  
  // Right-half bodies
  Modelica.Mechanics.MultiBody.Parts.Body rightUCABody(m = pRightAxleMass.ucaMass.m,
                                                       r_CM = pRightAxleMass.ucaMass.r_cm - pRightDW.upper_o,
                                                       I_11 = pRightAxleMass.ucaMass.I[1, 1],
                                                       I_22 = pRightAxleMass.ucaMass.I[2, 2],
                                                       I_33 = pRightAxleMass.ucaMass.I[3, 3],
                                                       I_21 = pRightAxleMass.ucaMass.I[2, 1],
                                                       I_31 = pRightAxleMass.ucaMass.I[3, 1],
                                                       I_32 = pRightAxleMass.ucaMass.I[3, 2],
                                                       sphereDiameter = joint_diameter,
                                                       cylinderDiameter = link_diameter) annotation(
    Placement(transformation(origin = {120, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Body rightLCABody(m = pRightAxleMass.lcaMass.m,
                                                       r_CM = pRightAxleMass.lcaMass.r_cm - pRightDW.lower_o,
                                                       I_11 = pRightAxleMass.lcaMass.I[1, 1],
                                                       I_22 = pRightAxleMass.lcaMass.I[2, 2],
                                                       I_33 = pRightAxleMass.lcaMass.I[3, 3],
                                                       I_21 = pRightAxleMass.lcaMass.I[2, 1],
                                                       I_31 = pRightAxleMass.lcaMass.I[3, 1],
                                                       I_32 = pRightAxleMass.lcaMass.I[3, 2],
                                                       sphereDiameter = joint_diameter,
                                                       cylinderDiameter = link_diameter) annotation(
    Placement(transformation(origin = {130, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body rightUnsprungBody(m = pRightAxleMass.unsprungMass.m,
                                                            r_CM = pRightAxleMass.unsprungMass.r_cm - pRightDW.wheelCenter,
                                                            I_11 = pRightAxleMass.unsprungMass.I[1, 1],
                                                            I_22 = pRightAxleMass.unsprungMass.I[2, 2],
                                                            I_33 = pRightAxleMass.unsprungMass.I[3, 3],
                                                            I_21 = pRightAxleMass.unsprungMass.I[2, 1],
                                                            I_31 = pRightAxleMass.unsprungMass.I[3, 1],
                                                            I_32 = pRightAxleMass.unsprungMass.I[3, 2],
                                                            sphereDiameter = joint_diameter,
                                                            cylinderDiameter = link_diameter)  annotation(
    Placement(transformation(origin = {170, 80}, extent = {{-10, -10}, {10, 10}})));

protected
  // Fixed geometry from effective center to nodes
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftUpper_i(r = (pLeftDW.upperFore_i + pLeftDW.upperAft_i)/2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, 70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toLeftLower_i(r = (pLeftDW.lowerFore_i + pLeftDW.lowerAft_i)/2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{10, -10}, {-10, 10}})));
    
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightUpper_i(r = (pRightDW.upperFore_i + pRightDW.upperAft_i)/2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation toRightLower_i(r = (pRightDW.lowerFore_i + pRightDW.lowerAft_i)/2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, 30}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(leftCP, leftTire.cp_frame) annotation(
    Line(points = {{-160, 0}, {-160, 40}}));
  connect(rightCP, rightTire.cp_frame) annotation(
    Line(points = {{160, 0}, {160, 40}}));
  connect(leftTorque, leftTire.hub_flange) annotation(
    Line(points = {{-180, 50}, {-170, 50}}));
  connect(rightTorque, rightTire.hub_flange) annotation(
    Line(points = {{180, 50}, {170, 50}}));
  connect(axleFrame, toLeftLower_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 30}, {-10, 30}}));
  connect(axleFrame, toRightLower_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 30}, {10, 30}}));
  connect(axleFrame, toLeftUpper_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 70}, {-10, 70}}));
  connect(axleFrame, toRightUpper_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 70}, {10, 70}}));
  connect(toLeftLower_i.frame_b, leftWishboneUprightLoop.lower_i_frame) annotation(
    Line(points = {{-30, 30}, {-40, 30}}, color = {95, 95, 95}));
  connect(toLeftUpper_i.frame_b, leftWishboneUprightLoop.upper_i_frame) annotation(
    Line(points = {{-30, 70}, {-40, 70}}, color = {95, 95, 95}));
  connect(toRightLower_i.frame_b, rightWishboneUprightLoop.lower_i_frame) annotation(
    Line(points = {{30, 30}, {40, 30}}, color = {95, 95, 95}));
  connect(toRightUpper_i.frame_b, rightWishboneUprightLoop.upper_i_frame) annotation(
    Line(points = {{30, 70}, {40, 70}}, color = {95, 95, 95}));
  connect(axleFrame, toRack.frame_a) annotation(
    Line(points = {{0, 0}, {0, 80}}));
  connect(toRack.frame_b, RackAndPinion.mountFrame) annotation(
    Line(points = {{0, 100}, {0, 106}}, color = {95, 95, 95}));
  connect(RackAndPinion.leftFrame, leftTieClosure.frame_a) annotation(
    Line(points = {{-20, 110}, {-30, 110}, {-30, 100}, {-40, 100}}, color = {95, 95, 95}));
  connect(RackAndPinion.rightFrame, rightTieClosure.frame_a) annotation(
    Line(points = {{20, 110}, {30, 110}, {30, 100}, {40, 100}}, color = {95, 95, 95}));
  connect(leftTieClosure.frame_b, leftTieConnection.frame_a) annotation(
    Line(points = {{-80, 100}, {-100, 100}, {-100, 80}}, color = {95, 95, 95}));
  connect(rightTieClosure.frame_b, rightTieConnection.frame_a) annotation(
    Line(points = {{80, 100}, {100, 100}, {100, 80}}, color = {95, 95, 95}));
  connect(leftTieConnection.frame_b, leftWishboneUprightLoop.steering_frame) annotation(
    Line(points = {{-100, 60}, {-100, 30}, {-98, 30}}, color = {95, 95, 95}));
  connect(rightTieConnection.frame_b, rightWishboneUprightLoop.steering_frame) annotation(
    Line(points = {{100, 60}, {100, 30}, {98, 30}}, color = {95, 95, 95}));
  connect(leftWishboneUprightLoop.steering_frame, toLeftWheelCenter.frame_a) annotation(
    Line(points = {{-98, 29.7}, {-110, 29.7}}, color = {95, 95, 95}));
  connect(rightWishboneUprightLoop.steering_frame, toRightWheelCenter.frame_a) annotation(
    Line(points = {{98, 29.7}, {110, 29.7}}, color = {95, 95, 95}));
  connect(leftTire.chassis_frame, toLeftWheelCenter.frame_b) annotation(
    Line(points = {{-150, 50}, {-140, 50}, {-140, 30}, {-130, 30}}, color = {95, 95, 95}));
  connect(rightTire.chassis_frame, toRightWheelCenter.frame_b) annotation(
    Line(points = {{150, 50}, {140, 50}, {140, 30}, {130, 30}}, color = {95, 95, 95}));
  connect(leftUCABody.frame_a, leftWishboneUprightLoop.upper_o_frame) annotation(
    Line(points = {{-109, 90}, {-68, 90}, {-68, 78}}, color = {95, 95, 95}));
  connect(leftLCABody.frame_a, leftWishboneUprightLoop.lower_o_frame) annotation(
    Line(points = {{-120, 12}, {-68, 12}, {-68, 22}}, color = {95, 95, 95}));
  connect(rightUCABody.frame_a, rightWishboneUprightLoop.upper_o_frame) annotation(
    Line(points = {{110, 90}, {70, 90}, {70, 78}}, color = {95, 95, 95}));
  connect(rightLCABody.frame_a, rightWishboneUprightLoop.lower_o_frame) annotation(
    Line(points = {{120, 12}, {70, 12}, {70, 22}}, color = {95, 95, 95}));
  connect(leftUnsprungBody.frame_a, leftTire.chassis_frame) annotation(
    Line(points = {{-160, 80}, {-140, 80}, {-140, 50}, {-150, 50}}, color = {95, 95, 95}));
  connect(rightUnsprungBody.frame_a, rightTire.chassis_frame) annotation(
    Line(points = {{160, 80}, {140, 80}, {140, 50}, {152, 50}}, color = {95, 95, 95}));
  annotation(
    Diagram(coordinateSystem(extent = {{-180, -20}, {180, 140}}, preserveAspectRatio = true, grid = {4, 2})),
    Icon(coordinateSystem(extent = {{-180, -20}, {180, 140}}, preserveAspectRatio = true, grid = {4, 2}), graphics = {Line(origin = {-25, 35}, points = {{-35, -15}, {25, 15}}), Line(origin = {-30, 65}, points = {{-30, -9}, {30, -15}}), Line(origin = {-82, 24}, points = {{22, -4}, {-24, 4}}, thickness = 5), Line(origin = {-82, 60}, points = {{22, -4}, {-22, 6}}, thickness = 5), Ellipse(origin = {-60, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {-60, 56}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-30, 65}, points = {{90, -9}, {30, -15}}), Line(origin = {35, -5}, points = {{-35, 55}, {25, 25}}), Line(origin = {84, 16}, points = {{22, 12}, {-24, 4}}, thickness = 5, arrowSize = 2), Line(origin = {81, 61}, points = {{-21, -5}, {23, 5}}, thickness = 5), Ellipse(origin = {60, 56}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {60, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-160, 4}, points = {{-20, -4}, {40, -4}, {40, 6}}), Line(origin = {160, 4}, points = {{20, -4}, {-40, -4}, {-40, 6}}), Line(origin = {-130, 50}, points = {{-10, 0}, {-50, 0}}, pattern = LinePattern.Dash, thickness = 1), Line(origin = {190, 50}, points = {{-10, 0}, {-50, 0}}, pattern = LinePattern.Dash, thickness = 1), Line(origin = {-80, 36}, points = {{20, -6}, {-22, 6}}, thickness = 5), Ellipse(origin = {-60, 30}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Rectangle(origin = {-120, 50}, fillColor = {71, 71, 71}, fillPattern = FillPattern.Solid, extent = {{-20, 40}, {20, -40}}, radius = 5), Line(origin = {40, 36}, points = {{20, -6}, {64, 6}}, thickness = 5), Ellipse(origin = {60, 30}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Rectangle(origin = {120, 50}, fillColor = {71, 71, 71}, fillPattern = FillPattern.Solid, extent = {{-20, 40}, {20, -40}}, radius = 5), Line(origin = {-25, 35}, points = {{-35, -15}, {25, 15}}), Line(origin = {35, -5}, points = {{-35, 55}, {25, 25}}), Line(origin = {-10, 30}, points = {{-36, 0}, {56, 0}}, thickness = 8), Line(origin = {-50, 30}, points = {{4, 0}, {-4, 0}}, color = {255, 0, 0}, thickness = 5), Line(origin = {50, 30}, points = {{4, 0}, {-4, 0}}, color = {255, 0, 0}, thickness = 5), Line(origin = {0, 46}, points = {{0, 4}, {0, -12}}), Line(origin = {0, 67}, points = {{0, -33}, {0, 33}}, thickness = 5), Ellipse(origin = {0, 100}, lineThickness = 5, extent = {{-26, 26}, {26, -26}}), Line(origin = {-10, 110}, points = {{10, -10}, {-14, -2}}, thickness = 5), Line(origin = {10, 110}, points = {{-10, -10}, {14, -2}}, thickness = 5), Ellipse(origin = {0, 100}, lineColor = {255, 255, 255}, lineThickness = 1, extent = {{-28, 28}, {28, -28}})}));
end AxleDWBase;
