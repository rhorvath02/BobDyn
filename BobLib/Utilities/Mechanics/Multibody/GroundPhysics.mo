within BobLib.Utilities.Mechanics.Multibody;

model GroundPhysics
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
    
  parameter Real c = 100000 "Stiffness";
  parameter Real d = 750 "Damping";
  
  Real pen "Smooth penetration";
  constant Real eps = 1e-6;

protected
  Real r_rel_z "Relative z-displacement";
  Real v_rel_z "Relative z-velocity";
  Real f_z "Normal force";

initial equation
  r_rel_z = 0;
//  v_rel_z = 0;
  
equation
  r_rel_z = frame_b.r_0[3] - frame_a.r_0[3];
  v_rel_z = der(r_rel_z);
  
  // Only apply force when compressed (r_rel[3] < 0)
  //  f_z = if r_rel_z < 0 then -c * r_rel_z - d * v_rel_z else 0;
  
  // Smooth unilateral ground contact (C continuous)
  pen = 0.5 * (sqrt(r_rel_z*r_rel_z + eps*eps) - r_rel_z);
  f_z = c * pen + d * der(pen);
  
  frame_a.f = {0, 0, f_z};
  frame_b.f = -frame_a.f;
  
  frame_a.t = {0, 0, 0};
  frame_b.t = {0, 0, 0};

annotation(
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics = {
        Text(
          extent={{-120,-160},{120,-120}},
          textString="%name",
          fontSize=14,
          horizontalAlignment=TextAlignment.Center
        ),
        
        Text(
          extent={{-230,-60},{-90,-20}},
          textString="Fixed",
          fontSize=12,
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Center
        ),
        
        Text(
          extent={{20,100},{230,140}},
          textString="Interface",
          fontSize=12,
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Center
        ),
        
        // --- Dirt (bottom 62.5%) ---
        Rectangle(
          extent={{-100,-100},{100,25}},
          fillPattern=FillPattern.Solid,
          fillColor={150,100,50},
          lineThickness=2
        ),

        // --- Grass top (top 37.5%) ---
        Rectangle(
          extent={{-100,25},{100,100}},
          fillPattern=FillPattern.Solid,
          fillColor={95,200,70},
          lineThickness=2
        ),

        // --- Grass fringe pixels ---
        Rectangle(extent={{-95,25},{-80,10}}, fillPattern=FillPattern.Solid, fillColor={115,220,85}),
        Rectangle(extent={{-60,25},{-45,5}},  fillPattern=FillPattern.Solid, fillColor={115,220,85}),
        Rectangle(extent={{-25,25},{-15,15}}, fillPattern=FillPattern.Solid, fillColor={115,220,85}),
        Rectangle(extent={{10,25},{25,8}},    fillPattern=FillPattern.Solid, fillColor={115,220,85}),
        Rectangle(extent={{45,25},{60,12}},   fillPattern=FillPattern.Solid, fillColor={115,220,85}),
        Rectangle(extent={{75,25},{90,7}},    fillPattern=FillPattern.Solid, fillColor={115,220,85}),

        // --- Dirt speckles ---
        Rectangle(extent={{-80,-20},{-70,-30}}, fillPattern=FillPattern.Solid, fillColor={120,80,40}),
        Rectangle(extent={{-50,-60},{-40,-70}}, fillPattern=FillPattern.Solid, fillColor={120,80,40}),
        Rectangle(extent={{-20,-10},{-10,-20}}, fillPattern=FillPattern.Solid, fillColor={120,80,40}),
        Rectangle(extent={{5,-80},{15,-90}},    fillPattern=FillPattern.Solid, fillColor={120,80,40}),
        Rectangle(extent={{30,-45},{40,-55}},   fillPattern=FillPattern.Solid, fillColor={120,80,40}),
        Rectangle(extent={{60,-70},{70,-80}},   fillPattern=FillPattern.Solid, fillColor={120,80,40}),
        Rectangle(extent={{20,-25},{30,-35}},   fillPattern=FillPattern.Solid, fillColor={120,80,40})

      }
    )
  );
end GroundPhysics;
