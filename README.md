# Fast Fourier Transform (FFT) Implementation  

## 📖 Overview  
This project documents the **end-to-end implementation** of an FFT core (advnaced SDC architecture) — starting from **algorithmic modeling in MATLAB**, all the way to **synthesizable RTL, verification, synthesis, and ASIC physical design (PnR) using Cadence tools**.  

The FFT is a fundamental block in **signal processing**, widely used in communication systems, image processing, and spectrum analysis. Implementing it in hardware requires careful consideration of **architecture, resource usage, timing, and scalability**.  

---

## 🚀 Project Flow  

### 1. Algorithmic Modeling (MATLAB)  
- Implemented FFT algorithm in **MATLAB** for initial validation.  
- Verified correctness using floating-point models.  
- Fixed-point analysis to match hardware constraints.  
- Explored trade-offs between:  
  - Iterative vs. pipelined architectures.  
  - Wordlength scaling vs. accuracy.  

---

### 2. Hardware Architecture Design  
- **Chosen Architecture:** **Advanced SDC (Single-path Delay Commutator)**  
  - Provides **higher throughput** compared to SDF.  
  - Optimized pipeline for **maximum operating frequency**.  
  - Efficient memory access and reduced hardware overhead.  
- Defined FFT size, throughput, and latency.  
- Designed:  
  - Butterfly unit  
  - Twiddle-factor ROM (or CORDIC-based generation)  
  - Control FSM for iterative scheduling  
- Inserted pipeline registers for higher performance.  

---

### 3. RTL Implementation (Verilog/SystemVerilog)  
- RTL modules implemented for:  
  - Butterfly computation  
  - Twiddle factor multiplication  
  - Data reordering (bit-reversal / stride-based addressing)  
- Control logic integrated with datapath.  
- Configurable FFT size for flexibility.  

---

### 4. Verification  
- **Testbench in SystemVerilog** with golden reference from MATLAB.  
- Checked correctness for:  
  - Impulse input  
  - Sinusoidal input  
  - All-zero and max-value vectors  
- Automated waveform comparison with MATLAB outputs.  
- Assertions + coverage metrics included.  

---

### 5. Logic Synthesis (Cadence Genus)  
- Constraints applied:  
  - Target clock frequency  
  - I/O delays for integration  
- Reports generated:  
  - **Area** utilization  
  - **Timing** slack (setup/hold)  
  - **Power** estimates  

---

### 6. Place & Route (Cadence Innovus)  
- Floorplanning: separated datapath (butterflies) and control logic.  
- Placement and routing optimized for minimal congestion.  
- Clock Tree Synthesis (CTS) tuned for low skew.  
- **Static Timing Analysis (STA)** performed using Cadence Tempus.  
- **Power analysis** (dynamic + leakage) with Cadence Voltus.  
- Final GDSII prepared for tapeout.  

---

## 📊 Design Flow Diagram  

```mermaid
flowchart TD
    A[Modeling in MATLAB] --> B[Architecture Design (Advanced SDC)]
    B --> C[RTL Implementation (Verilog)]
    C --> D[Verification (SystemVerilog + MATLAB reference)]
    D --> E[Synthesis - Cadence Genus]
    E --> F[Place & Route - Cadence Innovus]


    F --> G[STA - Tempus & Power - Voltus]
    G --> H[Final GDSII for ASIC]
