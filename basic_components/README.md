# Basic Components

This folder contains descriptions of basic components in VHDL. Each component is accompanies by a simple testbench with which you can simulate the single component.

Each component comes with its HDL description and a package you can use to configure the generics of the block itself. There is also a testbench you can use to check the block functionality and how to interact with it.

The blocks are simulated through GHDL, so there is a small makefiles which issues all the GHDL commands. There is also a GHDL wave files to show the right signals when representing them with GTKwave.

## Dependencies

In order to run the simulation and have a look at the results, there are just very few things you need to install: GHDL and GTKwave. In this section, we are explaining how to install such dependencies.

### Linux

We are considering Ubuntu as base platform. In order to install ghdl, issue the following command:

```bash
sudo apt-get install ghdl
```

In order to install `GTKwave` issue the command:

```bash
sudo apt-get install gtkwave
```

That's it!

## Usage

Move to the directory of the component you want to test, let's say `register`:

```bash
cd basic_components/register
```

Run the simulation:

```bash
make
```

Show the results in form of waveforms:

```bash
make wave
```

Enjoy!

## Components

`memory_cell`: memory block of configurable parallelism.

PARAMETERS:

* `n`: generic. Parallelism of the memory. Default 1 bits
* `delay`: generic. Delay after which output changes when input changes and memory is in transparency (load asserted)

INPUT:

* `clock`: bit. System clock
* `async_reset_n`: bit, 0-active asynchronous reset
* `load`: bit, 1-active synchronous load
* `I`: vector, *n* bit, data to store

OUTPUT:

* `O`: vector, *n* bit, stored data

## Contacts

Antonio Riccio <antonio.riccio.27@gmail.com>
