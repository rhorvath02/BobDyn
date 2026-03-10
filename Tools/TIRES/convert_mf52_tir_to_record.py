"""
convert_tir_to_mf52_record.py

Build-time tool for converting PAC2002 '.tir' files into
static Modelica MF5.2 parameter records.

- No runtime file I/O in Modelica
- Fully typed MF5.2 schema
- Code generation
"""

from __future__ import annotations

from dataclasses import dataclass, fields
from pathlib import Path
from typing import Dict
import sys
import re
import difflib
from decimal import Decimal, getcontext

# high precision, but we control
getcontext().prec = 28


# =============================================================================
# FORMATTERS
# =============================================================================

def fmt_float(x: float) -> str:
    """
    Stable, human-friendly float formatter.
    Avoids artifacts like 0.008999999999999999.
    """
    d = Decimal(str(x)).normalize()
    s = format(d, "f") if d.as_tuple().exponent > -12 else format(d, "g")
    return s.rstrip("0").rstrip(".") if "." in s else s


# =============================================================================
# MODELICA TYPE MAP (minimal but meaningful)
# =============================================================================

TYPEMAP: dict[str, str] = {
    "UNLOADED_RADIUS": "SIunits.Length",
    "RIM_RADIUS": "SIunits.Length",
    "RIM_WIDTH": "SIunits.Length",
    "FNOMIN": "SIunits.Force",
    "INERTIA": "SIunits.MomentOfInertia",
    "VERTICAL_STIFFNESS": "SIunits.TranslationalSpringConstant",
    "VERTICAL_DAMPING": "SIunits.TranslationalDampingConstant",
}


# =============================================================================
# MF5.2 TIRE SCHEMA (PAC2002)
# =============================================================================

@dataclass(frozen=True, slots=True)
class MF52Tire:
    # DIMENSIONS / WHEEL
    RIM_RADIUS: float
    RIM_WIDTH: float
    INERTIA: float

    # DIMENSIONS / VERTICAL
    UNLOADED_RADIUS: float
    FNOMIN: float
    VERTICAL_STIFFNESS: float
    VERTICAL_DAMPING: float

    # SCALING COEFFICIENTS
    LFZO: float
    LCX: float
    LMUX: float
    LEX: float
    LKX: float
    LHX: float
    LVX: float
    LXAL: float
    LGAX: float
    LCY: float
    LMUY: float
    LEY: float
    LKY: float
    LHY: float
    LVY: float
    LGAY: float
    LKYG: float
    LTR: float
    LRES: float
    LCZ: float
    LGAZ: float
    LYKA: float
    LVYKA: float
    LS: float
    LSGKP: float
    LSGAL: float
    LGYR: float
    LMX: float
    LVMX: float
    LMY: float
    LIP: float

    # LONGITUDINAL FORCE
    PCX1: float
    PDX1: float
    PDX2: float
    PDX3: float
    PEX1: float
    PEX2: float
    PEX3: float
    PEX4: float
    PKX1: float
    PKX2: float
    PKX3: float
    PHX1: float
    PHX2: float
    PVX1: float
    PVX2: float
    RBX1: float
    RBX2: float
    RCX1: float
    REX1: float
    REX2: float
    RHX1: float

    # LATERAL FORCE
    PCY1: float
    PDY1: float
    PDY2: float
    PDY3: float
    PEY1: float
    PEY2: float
    PEY3: float
    PEY4: float
    PKY1: float
    PKY2: float
    PKY3: float
    PHY1: float
    PHY2: float
    PHY3: float
    PVY1: float
    PVY2: float
    PVY3: float
    PVY4: float
    RBY1: float
    RBY2: float
    RBY3: float
    RCY1: float
    REY1: float
    REY2: float
    RHY1: float
    RHY2: float
    RVY1: float
    RVY2: float
    RVY3: float
    RVY4: float
    RVY5: float
    RVY6: float

    # OVERTURNING MOMENT
    QSX1: float
    QSX2: float
    QSX3: float

    # ROLLING RESISTANCE
    QSY1: float
    QSY2: float
    QSY3: float
    QSY4: float

    # ALIGNING TORQUE
    QBZ1: float
    QBZ2: float
    QBZ3: float
    QBZ4: float
    QBZ5: float
    QBZ9: float
    QBZ10: float
    QCZ1: float
    QDZ1: float
    QDZ2: float
    QDZ3: float
    QDZ4: float
    QDZ6: float
    QDZ7: float
    QDZ8: float
    QDZ9: float
    QEZ1: float
    QEZ2: float
    QEZ3: float
    QEZ4: float
    QEZ5: float
    QHZ1: float
    QHZ2: float
    QHZ3: float
    QHZ4: float
    SSZ1: float
    SSZ2: float
    SSZ3: float
    SSZ4: float


# =============================================================================
# TIR PARSER
# =============================================================================

_TIR_LINE_RE = re.compile(
    r"^\s*(?P<key>[A-Za-z0-9_]+)\s*=\s*(?P<value>[-+0-9.eE]+)"
)


def read_tir(path: Path) -> Dict[str, float]:
    data: Dict[str, float] = {}

    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("$") or line.startswith("!") or line.startswith("["):
            continue

        m = _TIR_LINE_RE.match(line)
        if not m:
            continue

        data[m.group("key").upper()] = float(m.group("value"))

    return data


# =============================================================================
# SCHEMA MAPPING
# =============================================================================

def build_mf52_tire(data: Dict[str, float]) -> MF52Tire:
    schema_keys = {f.name for f in fields(MF52Tire)}

    missing = sorted(schema_keys - data.keys())
    extra   = sorted(data.keys() - schema_keys)

    if missing:
        msg = ["Missing required TIR keys:"]
        for k in missing:
            close = difflib.get_close_matches(k, data.keys(), n=3)
            hint = f" (did you mean {close}?)" if close else ""
            msg.append(f"  {k}{hint}")
        raise KeyError("\n".join(msg))

    if extra:
        print("Warning: unused TIR keys detected:")
        for k in extra:
            print(f"  {k}")

    return MF52Tire(**{k: data[k] for k in schema_keys})


# =============================================================================
# MODELICA CODEGEN
# =============================================================================

def emit_modelica_record(
    tire: MF52Tire,
    record_name: str,
    out_path: Path,
    source_tir: Path,
) -> None:

    lines: list[str] = []

    lines.extend([
        "// ============================================================================",
        "// AUTO-GENERATED FILE — DO NOT EDIT",
        f"// Source: {source_tir}",
        "// Tool: Tools/tires/convert_tir_to_mf52_record.py",
        "// ============================================================================",
        "",
        "within BobLib.Resources.Records.TIRES;",
        "",
        f"record {record_name}",
        '  "Auto-generated MF5p2 tire record (PAC2002)"',
        "",
        "  import Modelica.SIunits;",
        "",
    ])

    for f in fields(tire):
        val = getattr(tire, f.name)
        mtype = TYPEMAP.get(f.name, "Real")
        lines.append(
            f"  parameter {mtype} {f.name} = {fmt_float(val)};"
        )

    lines.extend([
        "",
        f"end {record_name};",
        "",
    ])

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines))

    # update package.order if present
    pkg_order = out_path.parent / "package.order"
    if pkg_order.exists():
        entries = pkg_order.read_text().splitlines()
        if record_name not in entries:
            entries.append(record_name)
            pkg_order.write_text("\n".join(entries) + "\n")


# =============================================================================
# CLI
# =============================================================================

def main() -> None:
    if len(sys.argv) != 2:
        print("Usage: convert_tir_to_mf52_record.py <file.tir>")
        sys.exit(1)

    tir_path = Path(sys.argv[1]).resolve()
    if not tir_path.exists():
        raise FileNotFoundError(tir_path)

    data = read_tir(tir_path)
    tire = build_mf52_tire(data)

    record_name = tir_path.stem.replace("-", "_")
    out_dir = Path("./BobLib/Resources/Records/TIRES")
    out_path = out_dir / f"{record_name}.mo"

    emit_modelica_record(tire, record_name, out_path, tir_path)

    print(f"Generated: {out_path}")


if __name__ == "__main__":
    main()
