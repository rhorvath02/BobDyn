within BobLib.Vehicle.Chassis.Suspension.Templates;

model AxleDW
  // Modelica units
  import Modelica.SIunits;
  
  // Custom linalg
  import BobLib.Utilities.Math.Vector;
  import BobLib.Utilities.Math.Tensor;
  
  // Records
  import BobLib.Resources.VehicleRecord.Chassis.Suspension.Templates.SteeringRack.RackAndPinionRecord;
  
  // Load parameters
  parameter RackAndPinionRecord pRack;
  
  // Body template
  import BobLib.Resources.Records.TEMPLATES.BodyTemplate;
  
  // Geometry Parameters
  parameter BobLib.Resources.Records.TEMPLATES.AxleDWTemplate Axle annotation(
    Evaluate = false);
  
  // Mass Properties (Left)
  parameter BodyTemplate left_unsprung_mass "Left unsprung mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "Wheel Properties"));
  parameter BodyTemplate left_uca_mass "Left upper control arm mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "UCA Properties"));
  parameter BodyTemplate left_lca_mass "Left lower control arm mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "LCA Properties"));
  parameter BodyTemplate left_tie_mass "Left tie rod mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "Tie Properties"));
  
  // Mass Properties (Right – mirrored from left)
  parameter BodyTemplate right_unsprung_mass = BodyTemplate(m = left_unsprung_mass.m, r_cm = Vector.mirrorXZ(left_unsprung_mass.r_cm), I = Tensor.mirrorXZ(left_unsprung_mass.I)) "Right unsprung mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "Wheel Properties"));
  parameter BodyTemplate right_uca_mass = BodyTemplate(m = left_uca_mass.m, r_cm = Vector.mirrorXZ(left_uca_mass.r_cm), I = Tensor.mirrorXZ(left_uca_mass.I)) "Right upper control arm mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "UCA Properties"));
  parameter BodyTemplate right_lca_mass = BodyTemplate(m = left_lca_mass.m, r_cm = Vector.mirrorXZ(left_lca_mass.r_cm), I = Tensor.mirrorXZ(left_lca_mass.I)) "Right lower control arm mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "LCA Properties"));
  parameter BodyTemplate right_tie_mass = BodyTemplate(m = left_tie_mass.m, r_cm = Vector.mirrorXZ(left_tie_mass.r_cm), I = Tensor.mirrorXZ(left_tie_mass.I)) "Right tie rod mass" annotation(
    Evaluate = false,
    Dialog(tab = "Mass Properties", group = "Tie Properties"));
  
  // Visual parameters
  parameter SIunits.Length link_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));
  parameter SIunits.Length joint_diameter annotation(
    Dialog(tab = "Animation", group = "Sizing"));

  // Effective center for internal calculations
  final parameter SIunits.Position[3] effective_center = {Axle.wheel_center[1], 0, Axle.wheel_center[3]};

  // Interface frames
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a axle_frame annotation(
    Placement(transformation( extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {0, 50}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b left_cp annotation(
    Placement(transformation(origin = {-160, 0}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {-180, 0}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b right_cp annotation(
    Placement(transformation(origin = {160, 0}, extent = {{16, -16}, {-16, 16}}, rotation = -90), iconTransformation(origin = {180, 0}, extent = {{-16, -16}, {16, 16}})));
  
  // Tires
  replaceable BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire left_tire annotation(
    Placement(transformation(origin = {-160, 50}, extent = {{10, -10}, {-10, 10}})));
  replaceable BobLib.Vehicle.Chassis.Suspension.Templates.Tire.BaseTire right_tire annotation(
    Placement(transformation(origin = {160, 50}, extent = {{-10, -10}, {10, 10}})));
  
  // Wheel torque inputs
  Modelica.Mechanics.Rotational.Interfaces.Flange_b left_torque annotation(
    Placement(transformation(origin = {-180, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-180, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b right_torque annotation(
    Placement(transformation(origin = {180, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {180, 50}, extent = {{-10, -10}, {10, 10}})));
  DoubleWishbone.WishboneUprightLoop LeftWishboneUprightLoop(upper_fore_i = Axle.upper_fore_i, upper_aft_i = Axle.upper_aft_i, lower_fore_i = Axle.lower_fore_i, lower_aft_i = Axle.lower_aft_i, upper_o = Axle.upper_outboard, lower_o = Axle.lower_outboard, link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {-69, 50}, extent = {{29, -29}, {-29, 29}})));
  
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod LeftTieClosure(r_a = Axle.tie_inboard, r_b = Axle.tie_outboard, show_universal_axes = false, kinematic_constraint = true, link_diameter = link_diameter, joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {-60, 100}, extent = {{20, -20}, {-20, 20}})));
  DoubleWishbone.WishboneUprightLoop RightWishboneUprightLoop(upper_fore_i = Vector.mirrorXZ(Axle.upper_fore_i), upper_aft_i = Vector.mirrorXZ(Axle.upper_aft_i), lower_fore_i = Vector.mirrorXZ(Axle.lower_fore_i), lower_aft_i = Vector.mirrorXZ(Axle.lower_aft_i), upper_o = Vector.mirrorXZ(Axle.upper_outboard), lower_o = Vector.mirrorXZ(Axle.lower_outboard), link_diameter = link_diameter, joint_diameter = joint_diameter) annotation(
    Placement(transformation(origin = {69, 50}, extent = {{-29, -29}, {29, 29}})));
  
  BobLib.Vehicle.Chassis.Suspension.Linkages.Rod RightTieClosure(r_a = Vector.mirrorXZ(Axle.tie_inboard), r_b = Vector.mirrorXZ(Axle.tie_outboard), show_universal_axes = false, kinematic_constraint = true, link_diameter = link_diameter, joint_diameter = joint_diameter)  annotation(
    Placement(transformation(origin = {60, 100}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation left_tie_connection(r = Axle.lower_outboard - Axle.tie_outboard) annotation(
    Placement(transformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation right_tie_connection(r = Vector.mirrorXZ(Axle.lower_outboard - Axle.tie_outboard)) annotation(
    Placement(transformation(origin = {100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_rack(r = {Axle.tie_inboard[1], 0, Axle.tie_inboard[3]} - effective_center, animation = false) annotation(
    Placement(transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  SteeringRack.RackAndPinion RackAndPinion(pRack = pRack, link_diameter = link_diameter) annotation(
    Placement(transformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_wheel_center(r = Axle.wheel_center - Axle.lower_outboard) annotation(
    Placement(transformation(origin = {-120, 30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_wheel_center(r = Vector.mirrorXZ(Axle.wheel_center - Axle.lower_outboard)) annotation(
    Placement(transformation(origin = {120, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body left_uca_body(r_CM = left_uca_mass.r_cm - Axle.upper_outboard, m = left_uca_mass.m, sphereDiameter = joint_diameter, cylinderDiameter = link_diameter, I_11 = left_uca_mass.I[1, 1], I_22 = left_uca_mass.I[2, 2], I_33 = left_uca_mass.I[3, 3], I_21 = left_uca_mass.I[2, 1], I_31 = left_uca_mass.I[3, 1], I_32 = left_uca_mass.I[3, 2]) annotation(
    Placement(transformation(origin = {-119, 90}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body left_lca_body(r_CM = left_lca_mass.r_cm - Axle.lower_outboard, m = left_lca_mass.m, sphereDiameter = joint_diameter, cylinderDiameter = link_diameter, I_11 = left_lca_mass.I[1, 1], I_22 = left_lca_mass.I[2, 2], I_33 = left_lca_mass.I[3, 3], I_21 = left_lca_mass.I[2, 1], I_31 = left_lca_mass.I[3, 1], I_32 = left_lca_mass.I[3, 2]) annotation(
    Placement(transformation(origin = {-130, 12}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Body right_uca_body(r_CM = right_uca_mass.r_cm - {Axle.upper_outboard[1], -Axle.upper_outboard[2], Axle.upper_outboard[3]}, m = right_uca_mass.m, sphereDiameter = joint_diameter, cylinderDiameter = link_diameter, I_11 = right_uca_mass.I[1, 1], I_22 = right_uca_mass.I[2, 2], I_33 = right_uca_mass.I[3, 3], I_21 = right_uca_mass.I[2, 1], I_31 = right_uca_mass.I[3, 1], I_32 = right_uca_mass.I[3, 2]) annotation(
    Placement(transformation(origin = {120, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Modelica.Mechanics.MultiBody.Parts.Body right_lca_body(r_CM = right_lca_mass.r_cm - {Axle.lower_outboard[1], -Axle.lower_outboard[2], Axle.lower_outboard[3]}, m = right_lca_mass.m, sphereDiameter = joint_diameter, cylinderDiameter = link_diameter, I_11 = right_lca_mass.I[1, 1], I_22 = right_lca_mass.I[2, 2], I_33 = right_lca_mass.I[3, 3], I_21 = right_lca_mass.I[2, 1], I_31 = right_lca_mass.I[3, 1], I_32 = right_lca_mass.I[3, 2]) annotation(
    Placement(transformation(origin = {130, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body left_unsprung_body(r_CM = left_unsprung_mass.r_cm - Axle.wheel_center, m = left_unsprung_mass.m, I_11 = left_unsprung_mass.I[1, 1], I_22 = left_unsprung_mass.I[2, 2], I_33 = left_unsprung_mass.I[3, 3], I_21 = left_unsprung_mass.I[2, 1], I_31 = left_unsprung_mass.I[3, 1], I_32 = left_unsprung_mass.I[3, 2], sphereDiameter = joint_diameter, cylinderDiameter = link_diameter)  annotation(
    Placement(transformation(origin = {-170, 80}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body right_unsprung_body(r_CM = right_unsprung_mass.r_cm - {Axle.wheel_center[1], -Axle.wheel_center[2], Axle.wheel_center[3]}, m = right_unsprung_mass.m, I_11 = right_unsprung_mass.I[1, 1], I_22 = right_unsprung_mass.I[2, 2], I_33 = right_unsprung_mass.I[3, 3], I_21 = right_unsprung_mass.I[2, 1], I_31 = right_unsprung_mass.I[3, 1], I_32 = right_unsprung_mass.I[3, 2], sphereDiameter = joint_diameter, cylinderDiameter = link_diameter)  annotation(
    Placement(transformation(origin = {170, 80}, extent = {{-10, -10}, {10, 10}})));
protected
  // Fixed geometry from effective center to nodes
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_upper_i(r = (Axle.upper_fore_i + Axle.upper_aft_i)/2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, 70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_left_lower_i(r = (Axle.lower_fore_i + Axle.lower_aft_i)/2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_upper_i(r = ({Axle.upper_fore_i[1], -Axle.upper_fore_i[2], Axle.upper_fore_i[3]} + {Axle.upper_aft_i[1], -Axle.upper_aft_i[2], Axle.upper_aft_i[3]})/2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation to_right_lower_i(r = ({Axle.lower_fore_i[1], -Axle.lower_fore_i[2], Axle.lower_fore_i[3]} + {Axle.lower_aft_i[1], -Axle.lower_aft_i[2], Axle.lower_aft_i[3]})/2 - effective_center, animation = false) annotation(
    Placement(transformation(origin = {20, 30}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(left_cp, left_tire.cp_frame) annotation(
    Line(points = {{-160, 0}, {-160, 40}}));
  connect(right_cp, right_tire.cp_frame) annotation(
    Line(points = {{160, 0}, {160, 40}}));
  connect(left_torque, left_tire.hub_flange) annotation(
    Line(points = {{-180, 50}, {-170, 50}}));
  connect(right_torque, right_tire.hub_flange) annotation(
    Line(points = {{180, 50}, {170, 50}}));
  connect(axle_frame, to_left_lower_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 30}, {-10, 30}}));
  connect(axle_frame, to_right_lower_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 30}, {10, 30}}));
  connect(axle_frame, to_left_upper_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 70}, {-10, 70}}));
  connect(axle_frame, to_right_upper_i.frame_a) annotation(
    Line(points = {{0, 0}, {0, 70}, {10, 70}}));
  connect(to_left_lower_i.frame_b, LeftWishboneUprightLoop.lower_i_frame) annotation(
    Line(points = {{-30, 30}, {-40, 30}}, color = {95, 95, 95}));
  connect(to_left_upper_i.frame_b, LeftWishboneUprightLoop.upper_i_frame) annotation(
    Line(points = {{-30, 70}, {-40, 70}}, color = {95, 95, 95}));
  connect(to_right_lower_i.frame_b, RightWishboneUprightLoop.lower_i_frame) annotation(
    Line(points = {{30, 30}, {40, 30}}, color = {95, 95, 95}));
  connect(to_right_upper_i.frame_b, RightWishboneUprightLoop.upper_i_frame) annotation(
    Line(points = {{30, 70}, {40, 70}}, color = {95, 95, 95}));
  connect(axle_frame, to_rack.frame_a) annotation(
    Line(points = {{0, 0}, {0, 80}}));
  connect(to_rack.frame_b, RackAndPinion.mount_frame) annotation(
    Line(points = {{0, 100}, {0, 106}}, color = {95, 95, 95}));
  connect(RackAndPinion.left_frame, LeftTieClosure.frame_a) annotation(
    Line(points = {{-20, 110}, {-30, 110}, {-30, 100}, {-40, 100}}, color = {95, 95, 95}));
  connect(RackAndPinion.right_frame, RightTieClosure.frame_a) annotation(
    Line(points = {{20, 110}, {30, 110}, {30, 100}, {40, 100}}, color = {95, 95, 95}));
  connect(LeftTieClosure.frame_b, left_tie_connection.frame_a) annotation(
    Line(points = {{-80, 100}, {-100, 100}, {-100, 80}}, color = {95, 95, 95}));
  connect(RightTieClosure.frame_b, right_tie_connection.frame_a) annotation(
    Line(points = {{80, 100}, {100, 100}, {100, 80}}, color = {95, 95, 95}));
  connect(left_tie_connection.frame_b, LeftWishboneUprightLoop.steering_frame) annotation(
    Line(points = {{-100, 60}, {-100, 30}, {-98, 30}}, color = {95, 95, 95}));
  connect(right_tie_connection.frame_b, RightWishboneUprightLoop.steering_frame) annotation(
    Line(points = {{100, 60}, {100, 30}, {98, 30}}, color = {95, 95, 95}));
  connect(LeftWishboneUprightLoop.steering_frame, to_left_wheel_center.frame_a) annotation(
    Line(points = {{-98, 29.7}, {-110, 29.7}}, color = {95, 95, 95}));
  connect(RightWishboneUprightLoop.steering_frame, to_right_wheel_center.frame_a) annotation(
    Line(points = {{98, 29.7}, {110, 29.7}}, color = {95, 95, 95}));
  connect(left_tire.chassis_frame, to_left_wheel_center.frame_b) annotation(
    Line(points = {{-150, 50}, {-140, 50}, {-140, 30}, {-130, 30}}, color = {95, 95, 95}));
  connect(right_tire.chassis_frame, to_right_wheel_center.frame_b) annotation(
    Line(points = {{150, 50}, {140, 50}, {140, 30}, {130, 30}}, color = {95, 95, 95}));
  connect(left_uca_body.frame_a, LeftWishboneUprightLoop.upper_o_frame) annotation(
    Line(points = {{-109, 90}, {-68, 90}, {-68, 78}}, color = {95, 95, 95}));
  connect(left_lca_body.frame_a, LeftWishboneUprightLoop.lower_o_frame) annotation(
    Line(points = {{-120, 12}, {-68, 12}, {-68, 22}}, color = {95, 95, 95}));
  connect(right_uca_body.frame_a, RightWishboneUprightLoop.upper_o_frame) annotation(
    Line(points = {{110, 90}, {70, 90}, {70, 78}}, color = {95, 95, 95}));
  connect(right_lca_body.frame_a, RightWishboneUprightLoop.lower_o_frame) annotation(
    Line(points = {{120, 12}, {70, 12}, {70, 22}}, color = {95, 95, 95}));
  connect(left_unsprung_body.frame_a, left_tire.chassis_frame) annotation(
    Line(points = {{-160, 80}, {-140, 80}, {-140, 50}, {-150, 50}}, color = {95, 95, 95}));
  connect(right_unsprung_body.frame_a, right_tire.chassis_frame) annotation(
    Line(points = {{160, 80}, {140, 80}, {140, 50}, {152, 50}}, color = {95, 95, 95}));
  annotation(
    Diagram(coordinateSystem(extent = {{-180, -20}, {180, 140}}, preserveAspectRatio = true, grid = {4, 2})),
    Icon(coordinateSystem(extent = {{-180, -20}, {180, 140}}, preserveAspectRatio = true, grid = {4, 2}), graphics = {Line(origin = {-25, 35}, points = {{-35, -15}, {25, 15}}), Line(origin = {-30, 65}, points = {{-30, -9}, {30, -15}}), Line(origin = {-82, 24}, points = {{22, -4}, {-24, 4}}, thickness = 5), Line(origin = {-82, 60}, points = {{22, -4}, {-22, 6}}, thickness = 5), Ellipse(origin = {-60, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {-60, 56}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-30, 65}, points = {{90, -9}, {30, -15}}), Line(origin = {35, -5}, points = {{-35, 55}, {25, 25}}), Line(origin = {84, 16}, points = {{22, 12}, {-24, 4}}, thickness = 5, arrowSize = 2), Line(origin = {81, 61}, points = {{-21, -5}, {23, 5}}, thickness = 5), Ellipse(origin = {60, 56}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Ellipse(origin = {60, 20}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Line(origin = {-160, 4}, points = {{-20, -4}, {40, -4}, {40, 6}}), Line(origin = {160, 4}, points = {{20, -4}, {-40, -4}, {-40, 6}}), Line(origin = {-130, 50}, points = {{-10, 0}, {-50, 0}}, pattern = LinePattern.Dash, thickness = 1), Line(origin = {190, 50}, points = {{-10, 0}, {-50, 0}}, pattern = LinePattern.Dash, thickness = 1), Line(origin = {-80, 36}, points = {{20, -6}, {-22, 6}}, thickness = 5), Ellipse(origin = {-60, 30}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Rectangle(origin = {-120, 50}, fillColor = {71, 71, 71}, fillPattern = FillPattern.Solid, extent = {{-20, 40}, {20, -40}}, radius = 5), Line(origin = {40, 36}, points = {{20, -6}, {64, 6}}, thickness = 5), Ellipse(origin = {60, 30}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Rectangle(origin = {120, 50}, fillColor = {71, 71, 71}, fillPattern = FillPattern.Solid, extent = {{-20, 40}, {20, -40}}, radius = 5), Line(origin = {-25, 35}, points = {{-35, -15}, {25, 15}}), Line(origin = {35, -5}, points = {{-35, 55}, {25, 25}}), Line(origin = {-10, 30}, points = {{-36, 0}, {56, 0}}, thickness = 8), Line(origin = {-50, 30}, points = {{4, 0}, {-4, 0}}, color = {255, 0, 0}, thickness = 5), Line(origin = {50, 30}, points = {{4, 0}, {-4, 0}}, color = {255, 0, 0}, thickness = 5), Line(origin = {0, 46}, points = {{0, 4}, {0, -12}}), Line(origin = {0, 67}, points = {{0, -33}, {0, 33}}, thickness = 5), Ellipse(origin = {0, 100}, lineThickness = 5, extent = {{-26, 26}, {26, -26}}), Line(origin = {-10, 110}, points = {{10, -10}, {-14, -2}}, thickness = 5), Line(origin = {10, 110}, points = {{-10, -10}, {14, -2}}, thickness = 5), Ellipse(origin = {0, 100}, lineColor = {255, 255, 255}, lineThickness = 1, extent = {{-28, 28}, {28, -28}})}));
end AxleDW;
