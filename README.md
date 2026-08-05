# 🚀 32-bit Single-Cycle RV32I RISC-V Processor

> RTL implemented in **Verilog HDL** | Functionally Verified in **QuestaSim** | Synthesized & Implemented in **Xilinx Vivado**

---

## 📖 Overview

This repository contains the complete RTL implementation of a **32-bit Single-Cycle RV32I RISC-V Processor**, designed completely from scratch using **Verilog HDL**.

The processor follows a **Single-Cycle Architecture**, where every instruction completes execution in a single clock cycle. The design fully supports the **RV32I Base Integer Instruction Set (ISA)** consisting of **37 instructions**, and has been functionally verified using comprehensive testbenches in **QuestaSim** before being synthesized and implemented using **Xilinx Vivado**.

This project was developed during my internship at **CoreIC Technologies** as part of my learning in Digital Design, Computer Architecture, FPGA Design, and Verilog HDL.

---

# ✨ Features

- ✅ Complete RV32I Base Integer ISA (37 Instructions)
- ✅ 32-bit Single-Cycle Processor
- ✅ Modular RTL Design
- ✅ Fetch, Decode, Execute, Memory & Writeback Stages
- ✅ Byte-Addressable Data Memory
- ✅ Instruction Memory
- ✅ Immediate Generator
- ✅ ALU with Arithmetic & Logical Operations
- ✅ Branch Comparator
- ✅ Functional Verification in QuestaSim
- ✅ FPGA Synthesis & Implementation in Xilinx Vivado

---

# 🏗 Processor Architecture

The processor is divided into five major stages:

1. **Instruction Fetch (IF)**
2. **Instruction Decode (ID)**
3. **Execute (EX)**
4. **Memory Access (MEM)**
5. **Write Back (WB)**



---

# 📂 Repository Structure

```
RV32I-Single-Cycle-RISC-V-Processor/
│
├── RTL/                 # All Verilog RTL modules
│
├── TB/                  # Testbenches
│
├── Programs/            # .mem program files
│
├── Simulation/          # QuestaSim outputs (optional)
│
├── Documentation/       # Report & Presentation
│
├── Synthesis/           # Vivado synthesis reports
│
├── Implementation/      # Vivado implementation reports
│
├── Images/              # README images
│
├── LICENSE
├── README.md
└── .gitignore
```

---

# ⚙ Supported RV32I Instructions

### Arithmetic & Logical

- ADD
- SUB
- SLL
- SLT
- SLTU
- XOR
- SRL
- SRA
- OR
- AND

### Immediate Instructions

- ADDI
- SLTI
- SLTIU
- XORI
- ORI
- ANDI
- SLLI
- SRLI
- SRAI

### Load Instructions

- LB
- LH
- LW
- LBU
- LHU

### Store Instructions

- SB
- SH
- SW

### Branch Instructions

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

### Jump Instructions

- JAL
- JALR

### Upper Immediate Instructions

- LUI
- AUIPC

---

# 🧩 Major RTL Modules

| Module | Description |
|---------|-------------|
| Program Counter | Generates instruction address |
| Instruction Memory | Stores instruction program |
| Register File | 32 × 32-bit General Purpose Registers |
| Immediate Generator | Generates Immediate Values |
| Control Unit | Generates Control Signals |
| ALU | Performs Arithmetic & Logical Operations |
| Comparator | Branch Comparison Logic |
| Data Memory | Byte Addressable Data Memory |
| Result Multiplexer | Selects Writeback Data |

---

# ✅ Functional Verification

The processor was verified using **QuestaSim** through both module-level and complete processor verification.

Verification includes:

- Arithmetic Instructions
- Logical Instructions
- Immediate Instructions
- Load Instructions
- Store Instructions
- Branch Instructions
- Jump Instructions
- Upper Immediate Instructions

All **37 RV32I Instructions** successfully passed functional verification.

<p align="center">
<img src="Images/all37_pass.png" width="900">
</p>

---

# 🖥 FPGA Synthesis & Implementation

The RTL design was synthesized and implemented using **Xilinx Vivado**.

### Synthesis Summary

- Tool: Xilinx Vivado
- Language: Verilog HDL
- Target Device: *(Update according to your FPGA)*

During synthesis, the processor was successfully mapped onto FPGA resources and implemented without functional errors.

<p align="center">
<img src="Images/implementation.png" width="850">
</p>

---

# 🛠 Tools Used

- Verilog HDL
- QuestaSim
- Xilinx Vivado
- Git
- GitHub

---

# 📚 Documentation

A detailed design report is included containing:

- Processor Architecture
- RTL Design
- Control Unit Design
- Verification Methodology
- Functional Verification Results
- FPGA Synthesis
- FPGA Implementation
- Limitations
- Future Work

---

# 🚀 Future Improvements

- Five Stage Pipeline
- Hazard Detection Unit
- Data Forwarding
- Branch Prediction
- Block RAM Based Memory
- CSR Instructions
- RV32M Extension
- Cache Memory

---

# 👨‍💻 Author

**Shourya Pathak**

B.Tech Electronics & Computer Engineering

---

# 📜 License

This project is released under the **MIT License**.

---

⭐ If you found this project interesting, consider giving the repository a **Star**.
