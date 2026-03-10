# BobLib

Modelica-based templates and components for vehicle dynamics analysis.

This repository provides a modular, physically grounded vehicle modeling
library for suspension, tire, chassis, and full-vehicle simulation, with
an emphasis on correctness, reproducibility, and FMU export.

Documentation is published at BobLib.com and updated continuously.

---

## Overview

The `BobLib` package is a reusable Modelica library containing:

- Vehicle subsystems (chassis, suspension, tires, powertrain)
- Reusable mathematical and mechanical utilities
- Static parameter records for configuration and data management
- Test models for validation and experimentation

All simulation-relevant information is defined directly in Modelica source
files to ensure deterministic behavior and FMU portability.

---

## Repository Structure

```
.
├── LICENSE
├── makefile
├── out.txt
├── README.md
├── requirements.txt
├── Docs/
├── Tools/
└── BobLib/
    ├── package.mo
    ├── package.order
    ├── Resources/
    │   ├── JSONs/
    │   │   ├── SUS/
    │   │   └── TIRES/
    │   ├── Records/
    │   │   ├── SUS/
    │   │   └── TIRES/
    │   │       └── MF52_Tire.mo
    │   ├── package.mo
    │   └── package.order
    ├── Utilities/
    │   ├── FMI/
    │   ├── Math/
    │   └── Mechanics/
    ├── Vehicle/
    │   ├── Aero/
    │   ├── Chassis/
    │   │   ├── Body/
    │   │   ├── Suspension/
    │   │   └── Tires/
    │   └── Powertrain/
    ├── TestUtilities/
    ├── TestVehicle/
    └── package.mo
```

---

## Documentation

The VitePress documentation site lives in `Docs/` and is published at
BobLib.com. The website is the reference and will continue
to be updated.

---

## Tooling (Build-Time Only)

Python tooling under `Tools/` is used to convert external data formats
(e.g. PAC2002 `.tir`, JSON) into static Modelica records.

These tools are build-time only and are never required for simulation
or FMU execution.

Example:

```bash
python Tools/tires/convert_tir_to_mf52_record.py \
  BobLib/Resources/JSONs/TIRES/hoosier_r25b.tir
```

Generated records are written to:

```
BobLib/Resources/Records/TIRES/
```

Once generated, simulations and FMUs depend only on Modelica source files.

---

## Design Principles

- Static configuration: all parameters are defined as Modelica records.
- FMU-safe by construction: no runtime file I/O or host path dependencies.
- Separation of concerns: Python for preprocessing, Modelica for simulation.
- Deterministic builds: identical sources produce identical results.

---

## Requirements

- Modelica-compatible toolchain (e.g. OpenModelica)
- Python 3.10+ (tooling only)

Python dependencies are listed in `requirements.txt`.

---

## Status

This repository is under active development and is intended as a research
and engineering library rather than a packaged end-user application.

---

## License

See `LICENSE` for details.
