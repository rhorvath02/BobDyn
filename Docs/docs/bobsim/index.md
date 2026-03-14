---
layout: doc
title: BobSim
---

# BobSim

BobSim supports two analysis workflows. Both operate on the same underlying vehicle model and physics layer; they differ in how inputs are specified and what the outputs represent.

## Characterization

A single, fixed vehicle configuration is provided as input. The solver runs once and returns a complete set of performance metrics describing how that vehicle behaves physically.

Use this workflow to:

- Evaluate a specific vehicle setup
- Establish a performance baseline before making changes
- Compute metric values to compare against a previous configuration

[Go to Characterization →](/bobsim/characterization)

## Design of Experiments

A set of parameters is provided along with defined ranges and step sizes. The solver runs across the full parameter space and returns sensitivity data: how much each input parameter influences each output metric, and in what direction.

Use this workflow to:

- Identify which parameters have the most influence on a target metric
- Quantify trade-offs between competing objectives
- Prioritize development effort based on partial derivatives

[Go to Design of Experiments →](/bobsim/doe)

---

## How They Relate

Characterization answers: *what does this vehicle do?*

DOE answers: *what happens if I change this parameter?*

A typical session runs characterization first to establish the current state, then uses DOE to understand the sensitivity of the design space around that state.
