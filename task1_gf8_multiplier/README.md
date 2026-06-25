# Task 1 — RTL Synthesis of GF(2⁸) Multiplier

> **Tool:** Synopsys Design Compiler V-2023.12-SP4  
> **Technology:** SAED 14nm Standard Cell Library (RVT)  
> **Verification:** Synopsys VCS + Verdi  

---

## Objective

Synthesize a GF(2⁸) multiplier using Synopsys Design Compiler and evaluate area, timing, and power under five different configurations: single RVT library, multi-VT, PVT corners, delay-priority optimization, and leakage/dynamic power optimization.

---

## Design — `gf8_mul`

Multiplies two 8-bit elements in GF(2⁸) using the AES irreducible polynomial `x⁸ + x⁴ + x³ + x + 1` (0x11B). Fully combinational shift-and-XOR product with modular reduction, followed by a 1-cycle registered output.

```verilog
module gf8_mul (
    input  wire       clk,   // synchronous clock
    input  wire       rst,   // synchronous active-high reset
    input  wire [7:0] a,     // multiplicand
    input  wire [7:0] b,     // multiplier
    output reg  [7:0] y      // GF(2⁸) product — 1-cycle latency
);
```

---

## Functional Verification — VCS/Verdi

![VCS Simulation Output and Waveform](images/fig01_vcs_simulation_output.png)
*Fig. 1: VCS simulation terminal output and Verdi waveform*

| Test Vector | a | b | Expected y | Result |
|-------------|---|---|-----------|--------|
| AES FIPS 197 | 0x57 | 0x83 | 0xC1 | ✅ PASS |
| Simple field | 0x02 | 0x03 | 0x06 | ✅ PASS |
| High-value | 0xFF | 0x13 | 0xE5 | ✅ PASS |

Simulation end time: **145,000 ps**. All assertions passed.

---

## DC Synthesis Script

![TCL Script](images/fig02_tcl_script_pt1.png)
*Fig. 2: DC synthesis TCL script*

Key constraints:
| Parameter | Value |
|-----------|-------|
| Clock period | 5.00 ns |
| Clock latency | 1.50 ns |
| Clock uncertainty | 0.30 ns |
| Input delay | 1.00 ns |
| Max transition | 0.50 ns |
| Wire load model | 8000 (top) |

---

## Script 1 — Single RVT Library (Baseline)

![Area Report — Script 1](images/fig03_area_report_1_gf8_mul.png)
*Fig. 3: Area report — 1_gf8_mul.tcl*

![Power Report — Script 1](images/fig04_power_report_1_gf8_mul.png)
*Fig. 4: Power report — 1_gf8_mul.tcl*

![Timing Report — Script 1](images/fig05_timing_report_1_gf8_mul.png)
*Fig. 5: Timing report — 1_gf8_mul.tcl*

| Metric | Value |
|--------|-------|
| Total Area | 113.769 µm² |
| Total Power | 25.27 µW |
| Slack (MET) | **+3.16 ns** ✅ |

---

## Script 2 — Multi-VT (RVT + HVT + LVT)

![Timing Report — Script 2](images/fig06_timing_report_2_gf8_mul.png)
*Fig. 6: Timing report — 2_gf8_mul.tcl*

![Area Report — Script 2](images/fig07_area_report_2_gf8_mul.png)
*Fig. 7: Area report — 2_gf8_mul.tcl*

![Power Report — Script 2](images/fig08_power_report_2_gf8_mul.png)
*Fig. 8: Power report — 2_gf8_mul.tcl*

| Metric | Value |
|--------|-------|
| Total Area | 114.167 µm² |
| Total Power | 42.25 µW |
| Slack (MET) | **+3.31 ns** ✅ |

---

## Script 3 — RVT with Multiple PVT Corners

![Area Report — Script 3](images/fig09_area_report_3_gf8_mul.png)
*Fig. 9: Area report — 3_gf8_mul.tcl (ss0p585v125c corner)*

![Power Report — Script 3](images/fig10_power_report_3_gf8_mul.png)
*Fig. 10: Power report — 3_gf8_mul.tcl*

![Timing Report — Script 3](images/fig11_timing_report_3_gf8_mul.png)
*Fig. 11: Timing report — 3_gf8_mul.tcl*

| Metric | Value |
|--------|-------|
| Total Area | 113.769 µm² |
| Total Power | 21.02 µW |
| Slack (MET) | **+3.16 ns** ✅ |

---

## Script 4 — Delay-Priority Optimization

![Area Report — Script 4](images/fig12_area_report_4_gf8_mul.png)
*Fig. 12: Area report — 4_gf8_mul.tcl (`set_cost_priority -delay`)*

![Power Report — Script 4](images/fig13_power_report_4_gf8_mul.png)
*Fig. 13: Power report — 4_gf8_mul.tcl*

![Timing Report — Script 4](images/fig14_timing_report_4_gf8_mul.png)
*Fig. 14: Timing report — 4_gf8_mul.tcl*

| Metric | Value |
|--------|-------|
| Total Area | 113.769 µm² |
| Total Power | 21.02 µW |
| Slack (MET) | **+3.16 ns** ✅ |

---

## Script 5 — Leakage & Dynamic Power Optimization

![Area Report — Script 5](images/fig15_area_report_5_gf8_mul.png)
*Fig. 15: Area report — 5_gf8_mul.tcl (`set_leakage_optimization + set_dynamic_optimization`)*

![Power Report — Script 5](images/fig16_power_report_5_gf8_mul.png)
*Fig. 16: Power report — 5_gf8_mul.tcl*

![Timing Report — Script 5](images/fig17_timing_report_5_gf8_mul.png)
*Fig. 17: Timing report — 5_gf8_mul.tcl*

| Metric | Value |
|--------|-------|
| Total Area | 115.472 µm² |
| Total Power | 22.34 µW |
| Slack (MET) | **+2.84 ns** ✅ |

---

## Observations & Summary

| Script | Configuration | Area (µm²) | Power (µW) | Slack (ns) |
|--------|--------------|-----------|-----------|-----------|
| `1_gf8_mul.tcl` | Single RVT — baseline | 113.769 | 25.27 | 3.16 |
| `2_gf8_mul.tcl` | Multi-VT (RVT+HVT+LVT) | 114.167 | 42.25 | 3.31 |
| `3_gf8_mul.tcl` | RVT + PVT corners | 113.769 | 21.02 | 3.16 |
| `4_gf8_mul.tcl` | RVT + delay priority | 113.769 | 21.02 | 3.16 |
| `5_gf8_mul.tcl` | RVT + power opt | 115.472 | 22.34 | 2.84 |

![Manual Verification](images/fig21_manual_verification.png)
*Fig. 21: Manual verification of results*

---

## Appendix — RTL & Testbench

![RTL Code](images/fig18_rtl_code.png)
*Fig. 18: `gf8_mul.v` RTL source*

![Testbench Code](images/fig19_testbench_code.png)
*Fig. 19: `tb_gf8_mul.v` testbench*

![RTL Schematic](images/fig20_rtl_schematic.png)
*Fig. 20: RTL schematic from Design Vision*

---

## Conclusion

LVT configurations suit performance-critical paths; HVT/multi-VT suit low-power applications. All five synthesis runs met the 5 ns clock constraint with positive slack.
