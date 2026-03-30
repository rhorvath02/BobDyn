---
layout: doc
title: BobSim
---

# BobSim

BobSim executes and analyzes vehicle models built in BobLib. It provides the tools needed to explore system behavior, quantify sensitivities, and evaluate design decisions across the full parameter space.

---

## What It Does

- Runs simulations across large design spaces  
- Evaluates how changes in inputs affect vehicle response  
- Generates structured data for analysis and comparison  
- Transforms models into actionable engineering insight  

---

## Design of Experiments

BobSim exposes a Design of Experiments (DOE) workflow for systematic simulation sweeps and sensitivity analysis.

A set of input parameters is defined along with ranges and step sizes. BobSim evaluates the model across the full parameter space, producing a map of how each parameter influences each output metric.

---

## What This Reveals

- Which parameters dominate system behavior  
- How design variables interact with one another  
- Where trade-offs exist between competing objectives  
- How sensitive the system is to small changes  

Instead of evaluating a single configuration, the entire design space can be explored and understood.

---

## From Simulation to Insight

Traditional workflows often rely on isolated simulations and manual iteration.

BobSim enables:

- **Structured exploration** - consistent evaluation across all parameter combinations  
- **Sensitivity analysis** - direct measurement of parameter influence  
- **Gradient awareness** - understanding how and why the system responds  
- **Data-driven decisions** - prioritizing effort based on quantified impact  

---

## Why It Matters

- Enables rapid iteration across the design space  
- Reduces reliance on trial-and-error development  
- Identifies high-impact design changes early  
- Supports informed, data-driven engineering decisions  

---

## Explore the Workflow

[Design of Experiments →](/bobsim/doe)