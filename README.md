# ASIC Implementations — MAVLD505

> **Student:** Syed Faheem · Reg. No. 25MVD0030  
> **Course:** MAVLD505 — ASIC Design Lab · Winter Semester 2025–26  
> **Submitted to:** Dr. Ragunath G, Department of Micro and Nanoelectronics, SENSE, VIT University  
> **Technology:** SAED 14nm Standard Cell Library  

---

## Overview

Complete **RTL-to-GDS ASIC flow** across five lab tasks using the Synopsys EDA tool chain. Two designs are implemented — a GF(2⁸) multiplier and a RISC-V decoder — across Tasks 1–4, and a third design (8-bit restoring divider) is taken through a full standalone flow in Task 5.

| Task | Design | Stage | Tools |
|------|--------|-------|-------|
| [Task 1](task1_gf8_multiplier/) | GF(2⁸) Multiplier | RTL Synthesis — 5-script comparison | Design Compiler, VCS/Verdi |
| [Task 2](task2_primetime_lec/) | RISC-V Decoder | Static Timing Analysis + LEC | PrimeTime, Formality |
| [Task 3](task3_physical_design/) | RISC-V Decoder | Physical Design (Floorplan → Route) | IC Compiler II |
| [Task 4](task4_signoff/) | RISC-V Decoder | Signoff DRC / LVS / Output Generation | ICC2 + ICV |
| [Task 5](task5_restoring_divider/) | 8-bit Restoring Divider | Full RTL-to-GDS Flow | DC, PT, Formality, ICC2 |

---

## Tool Chain

```
RTL (Verilog)
     │
     ├─► Synopsys VCS + Verdi        ── Functional Simulation & Waveform Debug
     │
     ├─► Synopsys Design Compiler    ── Logic Synthesis → Gate-Level Netlist + SDC
     │
     ├─► Synopsys PrimeTime          ── Static Timing Analysis (setup/hold) + ECO
     │
     ├─► Synopsys Formality          ── Logical Equivalence Checking (RTL vs Netlist)
     │
     ├─► Synopsys IC Compiler II     ── Floorplan, Power Plan, Placement, CTS, Routing
     │
     └─► Synopsys ICV / IC Validator ── Signoff DRC / LVS
```

---

## Repository Structure

```
asic-implementations/
│
├── README.md
│
├── task1_gf8_multiplier/
│   ├── README.md                    Synthesis analysis — 5 scripts, full report data
│   ├── images/                      29 figures extracted from lab report
│   ├── rtl/
│   │   ├── gf8_mul.v                GF(2⁸) multiplier RTL
│   │   └── tb_gf8_mul.v             Testbench — AES known-vector checks
│   ├── reports/
│   │   ├── pri_enc8_area.rpt        Area report
│   │   ├── pri_enc8_power.rpt       Power report
│   │   ├── pri_enc8_timing.rpt      Timing report
│   │   ├── pri_enc8_qor.rpt         QoR report
│   │   └── pri_enc8_netlist.v       Gate-level netlist
│   └── constraints/
│       └── pri_enc8_constraints.sdc SDC constraints
│
├── task2_primetime_lec/
│   ├── README.md                    PrimeTime STA + Formality LEC
│   └── images/                      6 figures
│
├── task3_physical_design/
│   ├── README.md                    ICC2 physical flow
│   └── images/                      9 figures
│
├── task4_signoff/
│   ├── README.md                    DRC/LVS/output files/density analysis
│   └── images/                      16 figures
│
└── task5_restoring_divider/
    ├── README.md                    Full RTL-to-GDS flow
    └── images/                      50 figures
```

> **Note on Task 1 reports:** The uploaded `.rpt` files are labelled `pri_enc8` — an 8-to-3 priority encoder synthesized in the same lab session using the SAED14nm LVT library. The GF(2⁸) multiplier (`gf8_mul`) five-script results are documented in the Task 1 README from the lab PDF.

---

## Key Results

### Task 1 — GF(2⁸) Multiplier Synthesis

| Script | Configuration | Area (µm²) | Power (µW) | Slack (ns) |
|--------|--------------|-----------|-----------|-----------|
| `1_gf8_mul.tcl` | Single RVT — baseline | 113.769 | 25.27 | 3.16 |
| `2_gf8_mul.tcl` | Multi-VT (RVT+HVT+LVT) | 114.167 | 42.25 | 3.31 |
| `3_gf8_mul.tcl` | RVT + PVT corners | 113.769 | 21.02 | 3.16 |
| `4_gf8_mul.tcl` | RVT + delay priority | 113.769 | 21.02 | 3.16 |
| `5_gf8_mul.tcl` | RVT + power opt | 115.472 | 22.34 | 2.84 |

### Task 2 — RISC-V Decoder STA & LEC

| Check | Initial | After ECO Fix |
|-------|---------|--------------|
| Setup WNS | 0.00 ns ✅ | 0.00 ns ✅ |
| Hold WNS | −0.144 ns ❌ | 0.00 ns ✅ |
| Formality | — | 1,120/1,120 PASS ✅ |

### Task 3 — RISC-V Decoder Physical Design

All stages complete — floorplan (40% util), power mesh (M8/M9), placement, CTS (50 ps latency), routing. Post-route: 0 setup / 0 hold violations ✅

### Task 4 — RISC-V Decoder Signoff

| Check | Result |
|-------|--------|
| DRC (205 rules) | 22,681 violations (PDK-inherent, non-modifiable) |
| LVS (13,627 nets) | 0 shorts / 0 opens / 0 floating ✅ |
| Output files | GDS + SDF + SPEF×2 + SDC + netlists×2 ✅ |
| Formality (physical vs RTL) | SUCCEEDED ✅ |

### Task 5 — 8-bit Restoring Divider Full Flow

| Stage | Result |
|-------|--------|
| Synthesis — Total area | 165.987 µm² |
| Synthesis — Total power | 45.169 µW |
| Formality | 17/17 PASS ✅ |
| Pre-layout STA (post-ECO) | 0.00 ns setup / 0.00 ns hold ✅ |
| Physical Design | All stages complete ✅ |

---

## References

- SAED 14nm EDK Standard Cell Library Documentation
- Synopsys Design Compiler User Guide V-2023.12-SP4
- Synopsys PrimeTime User Guide
- Synopsys IC Compiler II User Guide
- Synopsys Formality User Guide
- AES Standard — FIPS PUB 197

---

*VIT University · School of Electronics Engineering · Department of Micro and Nanoelectronics · MAVLD505*
