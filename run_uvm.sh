#!/bin/bash

# Set UVM path - adjust this to match your Xcelium installation
UVM_HOME=$XCELIUM_ROOT/tools/methodology/UVM/CDNS-1.2

# Run Xcelium with UVM configuration
xrun -access +r -gui \
    -uvm \
    +incdir+$UVM_HOME/sv \
    $UVM_HOME/sv/uvm_pkg.sv \
    adder_pkg.sv \
    adder/adder_b.sv \
    testbench.sv