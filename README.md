# Digital Systems

## Introduction

This repo contains all concerns digital circuits design projects I have done during the university. You can find arithmetic machines, flip-flops and various exercises. This project is intended for learning purposes.

The projects file are intended for the **Digilent Nexys2-1200 board**.

Tested onto Xubuntu-1804.

## Prerequisites

In order to properly use this repo, you need to install *Xilinx ISE* and *Digilent Adept* software. I installed all this required software onto a *VirtualBox* VM but you are free to use whatever comes to your mind (e.g. docker containers ;)).

### Installing Xilinx ISE

I used Xilinx **ISE webpack edition**. It is free of charge and freely available from the Xilinx website.

Please follow [this](https://github.com/casper-astro/mlib_devel/wiki/How-to-install-Xilinx-ISE) procedure.

### Installing Digilent Adept

1. download the Adept *runtime* and *utilities* .deb files from [here](https://reference.digilentinc.com/reference/software/adept/start?redirect=1#software_downloads) (you need to register first)

2. assuming you downloaded the .deb packages into `~/Downloads`, install them by typing:

```bash
    sudo apt install ~/Downloads/digilent.adept.runtime_2.19.2-amd64.deb
    sudo apt install ~/Downloads/digilent.adept.utilities_2.2.1-amd64.deb
```

Note: calling `apt install` installs also the dependencies of the .deb files.

### Installing C compiler

In order to execute the simulations with the *ISim* tool, it is necessary to install the C compiler. To do so, type:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential
```

## Usage

`git clone https://github.com/artic92/digital_systems.git`

## Example

Import the project. From the ISE GUI:

```text
File -> Open project
```

Select the project description file:

```text
project0.xise
```

Generate the bitstream. To do so, select from the ISE GUI:

```text
Generate Programming File
```

Once the bitstream is ready, open a terminal and change directory to this repository home directory. Assuming this repo is into ~, type:

```bash
cd ~/digital_systems
```

Use the provided `on_board.sh` script to flash the bitstream to the Nexys2 board. Plug the USB cable connected to the Nexys2 onto this PC. Then type:

```bash
./on_board.sh init
./on_board.sh prog project0/project0_demo.bit
```

Answer Y when it prompted.

Here it is! You should see a spectacular light blinking on the board.

Source: [here](https://reference.digilentinc.com/learn/programmable-logic/tutorials/getting-started-with-fpga/start)

## Folders

`arithmetic_machines`

Contains adders, subtractors, multipliers, dividers. Each type of machine has been implemented applying different alghorithms (e.g. divider with restoring and non-restoring alghoritms).

`clocks`

This folder contains exercises regarding the generation of periodic signals (a.k.a. *clocks*).

## Projects

Notes:

* entities named as *`*_on_board.vhd`* connect the logic circuit to a 7-segments display, available on the *Nexys2* board
* entities named as *`tb_*.vhd`* describe tests on the behavioural component

### Adders

`carry_ripple`: configurable ripple carry adder.

PARAMETERS:

* `n`: generic. Parallelism of *A* and *B*. Default 4 bit

INPUT:

* `A`: vector. *n* bit
* `B`: vector. *n* bit
* `c_in`: bit. Input carry

OUTPUT:

* `S`: vector. *A* + *B*
* `c_out`: bit. Carry flag
* `ovfl`: bit. Overflow flag

`carry_lookahead`: configurable *carry lookahead* adder.

PARAMETERS:

* `n`: generic. Parallelism of *A* and *B*. Default 8 bit

INPUT:

* `A`: vector. *n* bit
* `B`: vector. *n* bit
* `c_in`: bit. Input carry

OUTPUT:

* `S`: vector. *A* + *B*
* `ovfl`: bit. Overflow flag

`carry_select`: configurable *carry select* adder.

PARAMETERS:

* `n`: generic. Parallelism of *A* and *B*. Default 8 bit

INPUT:

* `A`: vector. *n* bit
* `B`: vector. *n* bit
* `c_in`: bit. Input carry

OUTPUT:

* `S`: vector. *A* + *B*
* `ovfl`: bit. Overflow flag

`carry_save`: configurable *carry save* adder.

PARAMETERS:

* `n`: generic. Parallelism of *A* and *B*. Default 8 bit

INPUT:

* `A`: vector. *n* bit
* `B`: vector. *n* bit
* `C`: vector. *n* bit

OUTPUT:

* `S`: vector. *A* + *B* + *C*

---

### Multipliers

`mac_mutiplier`: configurable MAC multiplier

PARAMETERS

* `n` parallelism of *A*. Default 8 bit
* `m` parallelism of *B*. Default 8 bit

INPUT

* `A` vector. *n* bit
* `B` vector. *m* bit

OUTPUT

* `P` vector. *A* * *B*

`combinatorial_mutiplier`: configurable combinatorial multiplier

PARAMETERS

* `n` parallelism of *A*. Default 2 bit
* `m` parallelism of *B*. Default 2 bit

INPUT

* `A` vector. *n* bit
* `B` vector. *m* bit

OUTPUT

* `P` vector. *A* * *B*

`robertson`: configurable Robertson multiplier

PARAMETERS

* `n` parallelism of *A*. Default 4 bit
* `m` parallelism of *B*. Default 4 bit

INPUT

* `A` vector. *n* bit
* `B` vector. *m* bit
* `reset_n` bit. Reset signal. 0-active
* `enable` bit. Enable signal. 1-active
* `clock` bit. Clock signal

OUTPUT

* `P` vector. *A* * *B*
* `done` bit. Termination flag

`booth`: configurable Booth multiplier

PARAMETERS

* `n` parallelism of *A*. Default 4 bit
* `m` parallelism of *B*. Default 4 bit

INPUT

* `A` vector. *n* bit
* `B` vector. *m* bit
* `reset_n` bit. Reset signal. 0-active
* `enable` bit. Enable signal. 1-active
* `clock` bit. Clock signal

OUTPUT

* `P` vector. *A* * *B*
* `done` bit. Termination flag

---

### Dividers

`non_restoring`: configurable non-restoring divider

PARAMETERS

* `n` parallelism of *V*. Default 4 bit

INPUT

* `D` dividend, vector. *(2\*n)-1* bit
* `V` divisor, vector. *n* bit
* `enable` bit. 1-active. Starts the computation if `reset_n` is 1.
* `reset_n` bit. 0-active. Reset signal
* `clock` bit. Clock signal

OUTPUT

* `done` bit. End-of-computation flag
* `div_per_zero` bit. Division-per-zero flag
* `Q` quotient *D/V*, vector. *n* bit
* `R` remainder, vector. *n* bit

`restoring`: configurable restoring divider

PARAMETERS

* `n` parallelism of *V*. Default 4 bit

INPUT

* `D` dividend, vector. *(2\*n)-1* bit
* `V` divisor, vector. *n* bit
* `enable` bit. 1-active. Starts the computation if `reset_n` is 1.
* `reset_n` bit. 0-active. Reset signal
* `clock` bit. Clock signal

OUTPUT

* `done` bit. End-of-computation flag
* `div_per_zero` bit. Division-per-zero flag
* `Q` quotient *D/V*, vector. *n* bit
* `R` remainder, vector. *n* bit

### Clocks

---

`exercise1`

The goal of this excercise is to generate a periodic signal employing the `after` clause and follwing the pattern:

| ti    | t0 | t1 | t2 | t3 | t4 | t5  | t6  | t7  | t8  | t9  | t10 | t11 |
|-------|----|----|----|----|----|-----|-----|-----|-----|-----|-----|-----|
| value | 0  | 1  | 0  | 1  | 0  | 1   | 0   | 1   | 9   | 1   |  0  |  0  |
| ns    | 0  | 25 | 35 | 50 | 75 | 105 | 110 | 155 | 175 | 195 | 235 | 280 |

`exercise2`

This exercise is similar to the previous one except the signal is generated using an `inverter chain`.

`exercise3`

The goal of this exercise is to generate, from a base clock of 100 MHz and 50% duty cycle, a periodic signal with the following pattern:


| Singnal shape    | time                   | value |
| ---------------- | ---------------------- | ------|
| initial state    | 0                      |   0   |
| 15 rising edge   | after 15 rising edges  |   1   |
| 15 falling edge  | after 15 falling edges |   0   |
| 15 falling edge  | after 15 falling edges |   1   |
| 10 rising edge   | after 10 rising edges  |   0   |

Then, phase-shift this signal of 90,180,270,360 degrees respectively.

`exercise4`

The goal of this exercise is to design a clock generator capable of delay a base clock of 100 MHz and 50% duty cycle. This component has to generate 4 signals, each one is the base signal but with phase displaced of 90, 180, 270, 360 degrees. The component is described in both `behavioural` and `structural` flavours.

`exercise6`

The goal of this exercise is to generate the following periodic signals starting from a time-base signal of 100 MHz and 50% duty cycle:

1) 25 MHz and 50% duty cycle
2) 78 MHz and 50% duty cycle
3) 25 MHz and 70% duty cycle
4) 78 MHz and 70% duty cycle

This component should be implemented in two variants. The former should use only counters, while the latter should use the builtin **Xilinx DCM** component.

## Contacts

Antonio Riccio <antonio.riccio.27@gmail.com>
