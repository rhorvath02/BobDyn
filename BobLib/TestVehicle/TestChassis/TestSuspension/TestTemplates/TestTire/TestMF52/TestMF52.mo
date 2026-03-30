within BobLib.TestVehicle.TestChassis.TestSuspension.TestTemplates.TestTire.TestMF52;

model TestMF52
  import Modelica.SIunits;

  import Tire = BobLib.Vehicle.Chassis.Suspension.Templates.Tire.MF52;
  import Vehicle = BobLib.Resources.VehicleDefn;

// ============================================================
  // Vehicle Definition
  // ============================================================
  parameter Vehicle.OrionRecord car;

// ============================================================
  // Operating Conditions
  // ============================================================
  parameter SIunits.Force Fz = 654;
  parameter SIunits.Angle gamma = 0;
  parameter SIunits.Velocity Vx = 10;

// ============================================================
  // Sweep Definition
  // ============================================================
  parameter Integer nAlpha = 41;
  parameter Integer nKappa = 41;

  parameter SIunits.Angle alphaMin = -0.25;
  parameter SIunits.Angle alphaMax =  0.25;

  parameter Real kappaMin = -0.25;
  parameter Real kappaMax =  0.25;

// ============================================================
  // Grids
  // ============================================================
  SIunits.Angle alphaGrid[nAlpha];
  Real kappaGrid[nKappa];

// ============================================================
  // Outputs (FULL GRID)
  // ============================================================
  discrete SIunits.Force Fx[nAlpha, nKappa];
  discrete SIunits.Force Fy[nAlpha, nKappa];

  discrete SIunits.Torque Mx[nAlpha, nKappa];
  discrete SIunits.Torque My[nAlpha, nKappa];
  discrete SIunits.Torque Mz[nAlpha, nKappa];

  discrete SIunits.Length t[nAlpha, nKappa];
  discrete SIunits.Length s[nAlpha, nKappa];

// ============================================================
  // Useful slices (PURE SLIP)
  // ============================================================
  discrete SIunits.Force Fy_alpha[nAlpha];
  discrete SIunits.Torque Mz_alpha[nAlpha];
  discrete SIunits.Length t_alpha[nAlpha];
  discrete SIunits.Length s_alpha[nAlpha];

  discrete SIunits.Force Fx_kappa[nKappa];
  discrete SIunits.Length t_kappa[nKappa];

// ============================================================
  // Validation (VERY IMPORTANT)
  // ============================================================
  discrete Real Mz_reconstructed[nAlpha, nKappa];

protected
  Integer midAlpha;
  Integer midKappa;

algorithm
  when initial() then
// ------------------------------------------------------------
// Mid indices
// ------------------------------------------------------------
    midAlpha := integer((nAlpha + 1) / 2);
    midKappa := integer((nKappa + 1) / 2);
// ------------------------------------------------------------
// Build grids
// ------------------------------------------------------------
    for i in 1:nAlpha loop
      alphaGrid[i] :=
        alphaMin + (alphaMax - alphaMin) * (i - 1) / (nAlpha - 1);
    end for;

    for j in 1:nKappa loop
      kappaGrid[j] :=
        kappaMin + (kappaMax - kappaMin) * (j - 1) / (nKappa - 1);
    end for;

    alphaGrid[midAlpha] := 0;
    kappaGrid[midKappa] := 0;


    // ------------------------------------------------------------
    // Sweep evaluation
    // ------------------------------------------------------------
    for i in 1:nAlpha loop
      for j in 1:nKappa loop

        (Fx[i,j], Fy[i,j], Mx[i,j], My[i,j], Mz[i,j], t[i,j], s[i,j]) :=
          Tire.Eval(
            Fz,
            alphaGrid[i],
            kappaGrid[j],
            gamma,
            Vx,
            car.tireFL
          );
// Reconstruction check
        Mz_reconstructed[i,j] := -t[i,j] * Fy[i,j] + s[i,j] * Fx[i,j];

      end for;
    end for;
// ------------------------------------------------------------
// PURE SLIP SLICES (κ = 0)
// ------------------------------------------------------------
    for i in 1:nAlpha loop
      Fy_alpha[i] := Fy[i, midKappa];
      Mz_alpha[i] := Mz[i, midKappa];
      t_alpha[i]  := t[i, midKappa];
      s_alpha[i]  := s[i, midKappa];
    end for;
// ------------------------------------------------------------
// PURE LONGITUDINAL (α = 0)
// ------------------------------------------------------------
    for j in 1:nKappa loop
      Fx_kappa[j] := Fx[midAlpha, j];
      t_kappa[j]  := t[midAlpha, j]; // should collapse
    end for;
  end when;

annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 1));
end TestMF52;
