# An ABI-Level Approach: Implementing a UEFI Bootloader and Kernel from First Principles

This repository holds the supplementary material for the paper "An ABI-Level Approach: Implementing a UEFI Bootloader and Kernel from First Principles" submitted to the ICAIT 2025 conference. The repository contains the source and binary files for a UEFI x64 bootloader and kernel written in FASM.

## Prerequisites

The implementation was tested in a Linux environment with the following dependencies:

Build dependencies:

* coreutils
* make
* flat assembler (fasm)

Optional tools for running the demo:

* mtools
* xorriso
* qemu

## Usage

1. Verify that prerequisites are installed
2. Execute 'make' in the root directory to automatically build and run the demo.
