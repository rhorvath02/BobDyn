---
layout: home

hero:
  name: BobDyn
  text: Vehicle Dynamics Analysis
  tagline: A first-principles solver for Formula SAE vehicle characterization. Define your vehicle. Run the solver. Understand the response.
  image:
    src: /bob.png
    alt: BobDyn

features:
  - icon: "📦"
    title: Multibody Dynamics Core
    details: Build vehicles using multibody dynamics in Modelica. This layer captures geometry, constraints, and force generation directly from physical equations. It replaces simplified kinematic abstractions with transparent, acausal models that maintain integrity across all maneuvers.

  - icon: "🖥️"
    title: Orchestration Layer
    details: Manage the execution and analysis of BobLib models. This layer wraps the physics to run batch simulations, perform design studies, and generate reports. It provides the framework needed to explore vehicle behavior and sensitivities across the design space.

  - icon: "🔀"
    title: End-to-End Pipeline
    details: Bridge deep vehicle dynamics with practical engineering tasks. Define the physics once and deploy the model across the entire lifecycle, scaling from basic K&C testing and standard maneuvers to large-scale optimization and DOE studies within a single, reproducible ecosystem.
---
