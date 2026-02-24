#!/usr/bin/env python3
"""
convert_massprops_json_to_record.py

Build-time tool for converting rigid-body mass properties
(JSON) into typed Modelica records.

- FMU-safe
- Deterministic
- center_of_mass REQUIRED
- Front + Rear symmetry
"""

from __future__ import annotations

from pathlib import Path
import json
from decimal import Decimal, getcontext

getcontext().prec = 28


# =============================================================================
# FORMATTERS
# =============================================================================

def fmt(x) -> str:
    d = Decimal(str(x)).normalize()
    s = format(d, "f") if d.as_tuple().exponent > -12 else format(d, "g")
    return s.rstrip("0").rstrip(".") if "." in s else s


def fmt_vec(v):
    if len(v) != 3:
        raise ValueError(f"Expected 3-vector, got {len(v)}")
    return "{" + ", ".join(fmt(x) for x in v) + "}"


def fmt_mat(m):
    if len(m) != 3 or any(len(row) != 3 for row in m):
        raise ValueError("Expected 3x3 inertia matrix")
    rows = [fmt_vec(row) for row in m]
    return "{" + ", ".join(rows) + "}"


# =============================================================================
# VALIDATION
# =============================================================================

def validate_block(name: str, block: dict):
    required = ["mass", "center_of_mass", "inertia"]
    for key in required:
        if key not in block:
            raise KeyError(f"{name}: missing required key '{key}'")

    if not isinstance(block["center_of_mass"], list):
        raise TypeError(f"{name}: center_of_mass must be a list")

    if not isinstance(block["inertia"], list):
        raise TypeError(f"{name}: inertia must be a 3x3 list")


# =============================================================================
# MODELICA EMISSION
# =============================================================================

def emit_mass_record(
    name: str,
    data: dict,
    out_path: Path,
    src: Path,
):
    validate_block(name, data)

    lines = [
        "within BobDyn.Resources.Records.MASSPROPS;",
        "",
        "// ============================================================================",
        "// AUTO-GENERATED FILE — DO NOT EDIT",
        f"// Source: {src}",
        "// Tool: convert_massprops_json_to_record.py",
        "// ============================================================================",
        "",
        f"record {name}",
        '  "Auto-generated rigid body mass properties"',
        "",
        "  import Modelica.SIunits;",
        "",
        f"  parameter SIunits.Mass m = {fmt(data['mass'])};",
        f"  parameter SIunits.Position r_cm[3] = {fmt_vec(data['center_of_mass'])};",
        f"  parameter SIunits.Inertia I[3,3] = {fmt_mat(data['inertia'])};",
        "",
        f"end {name};",
        "",
    ]

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines))

    # Maintain package.order
    pkg_order = out_path.parent / "package.order"
    if pkg_order.exists():
        entries = pkg_order.read_text().splitlines()
        if name not in entries:
            entries.append(name)
            pkg_order.write_text("\n".join(entries) + "\n")


# =============================================================================
# DRIVER
# =============================================================================

def main():
    import sys

    if len(sys.argv) != 2:
        print("Usage: convert_massprops_json_to_record.py <file.json>")
        sys.exit(1)

    src = Path(sys.argv[1]).resolve()
    data = json.loads(src.read_text())

    out_dir = Path("BobDyn/Resources/Records/MASSPROPS")

    for name, block in data.items():
        emit_mass_record(
            name=name,
            data=block,
            out_path=out_dir / f"{name}.mo",
            src=src,
        )

    print("Generated mass property records:")
    for name in data:
        print(f"  - {out_dir / (name + '.mo')}")


if __name__ == "__main__":
    main()
