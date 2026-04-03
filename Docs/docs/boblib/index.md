---
layout: doc
title: Overview
---

# BobLib

BobLib defines vehicle systems using acausal multibody physics. It serves as the foundation of the BobDyn framework, translating vehicle definitions into structured, high-fidelity physical models.

---

## What It Does

- Builds full vehicle systems from modular components- Represents geometry, constraints, and force generation directly- Captures load paths and interactions through physical relationships- Produces models that remain consistent across all operating conditions
---

## Modeling Approach

Traditional vehicle models often rely on simplified formulas or signal-based representations. BobLib instead constructs the system from first principles:

- **Acausal multibody modeling** - components interact through physical laws, not prescribed signal flow- **Explicit geometry** - suspension linkages, pickup points, etc. are directly defined- **Constraint-based systems** - motion is governed by joints and connections rather than approximations (DAEs)
This allows simulations to reproduce behavior naturally and efficiently, without relying on empirical shortcuts.

---

## Structure

BobLib is organized around reusable system definitions:

- **Vehicle** - full system assembly- **Suspension** - architecture-specific templates (e.g., double wishbone)- **Linkages & Joints** - physical connections and constraints- **Tires** - force and moment generation- **Powertrain** - energy and drivetrain systems
Each layer is modular, allowing components to be reused and extended across different vehicle designs.

---

## Why It Matters

- Models are interpretable and physically grounded- Behavior can be traced directly to system structure- Components can be reused across projects and configurations- The same model supports multiple types of analysis