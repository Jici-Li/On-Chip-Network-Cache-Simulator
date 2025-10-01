[readme.md](https://github.com/user-attachments/files/22635300/readme.md)
# On Chip Network And hierarchy Performance Analysis

A beginner friendly project mainly focus on how time and heat of communication and access memory can differ from ways of processors connect.

## What I built

### Network topology comparison

#### Simulating two way s processor can connect:

* **Mesh:** Simple grid layout
* **Dragonfly:** Complex design with shortcut connections

### NUCA memory latency

A simple model, displaying accessing memory from far is slower than nearby. The module shows it can differ from 10 to 50ns depends on distance.

### Hardware module

Wrote a simple address mapping module which change local address to remote. (State machine)

## How to run

### Network Simulation
```bash
python dragonfly.py
```
*Simulates dragonfly network topology and performance.*

### Memory Latency Visualization
```bash
python hot.py
```
*Visualizes memory access patterns and latency hotspots.*

### Hardware Simulation 
```bash
# Compile and simulate
iverilog -g2012 -o sim design.sv testbench.sv
vvp sim

# Or in one line:
iverilog -g2012 -o sim design.sv testbench.sv && vvp sim
```
*Runs hardware simulation using SystemVerilog.*



## Results

| Topology  | Averge path length | Diameter | Max degree | Edge count |
|-----------|--------------------|----------|------------|------------|
| Dragonfly | 2.183              | 3.000    | 5.000      | 30.00      |
| Mesh      | 2.667              | 6.000    | 4.000      | 24.00      |

## What I learnt

* **Using NetworkX in python** 
* **Writing basic testing system verilog modules**
* **Basic Noc topology**

## Tools used

* **Python(NetworkX, Matplotlib, NumPy)** 
* **System verilog(basic)**




