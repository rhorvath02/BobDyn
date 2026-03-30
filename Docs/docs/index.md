---
layout: home

hero:
  name: BobDyn
  text: A framework for physics-based vehicle simulation
  tagline:
  image:
    src: /bob.png
    alt: BobDyn

features:
  - icon: "🧠"
    title: Multibody Dynamics Core (BobLib)
    details: Vehicles are modeled using acausal multibody dynamics in Modelica. Geometry, constraints, and force generation are defined directly from physical relationships, avoiding signal-based approximations and preserving consistency across operating conditions.

  - icon: "⚙️"
    title: Analysis & DOE Layer (BobSim)
    details: BobSim manages processing, simulation, and analysis workflows on top of the physical model. Batch simulations, design sweeps, and structured analysis are supported within a unified framework for vehicle characterization.

  - icon: "🔄"
    title: Unified Modeling Pipeline
    details: A single vehicle definition flows from configuration to insight. YAML-based inputs define the system, BobLib constructs the physical model, and BobSim executes simulation and analysis (scaling from basic tests to large design studies).

---

## Overview

BobDyn is built around a simple idea: define the physics once, and reuse it everywhere.

Traditional vehicle modeling workflows often rely on tightly coupled models, duplicated logic, and tool-specific abstractions. BobDyn separates concerns across a structured architecture:

- **Configuration** - vehicle definition in YAML
- **Physics** - multibody system modeling in Modelica (BobLib)
- **Execution** - processing, simulation, and analysis workflows (BobSim)

This separation maintains consistency, interpretability, and reuse across different analyses and stages of development.

---

## What This Enables

- Consistent vehicle behavior across all simulations  
- Direct traceability from system response to physical structure  
- Rapid iteration across large design spaces  
- Reuse of models across multiple tools and workflows  
- A scalable path from simple tests to full vehicle analysis  

---

## Open and Accessible

Tools with similar capabilities exist in industry but are often closed and cost-prohibitive. BobDyn is designed to be:

- **Open-source** - accessible to students, researchers, and teams  
- **Extensible** - adaptable to different vehicle architectures and workflows  
- **Transparent** - models remain readable, debuggable, and grounded in physics  

This enables deeper system understanding without reliance on black-box tools.

---

## Start Here

- Learn how vehicles are modeled → [BobLib](./boblib/)  
- Explore simulation and analysis workflows → [BobSim](./bobsim/)  
- Dive into methods and references → [Reference](./reference/)