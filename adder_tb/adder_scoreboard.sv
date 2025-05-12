`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

// Scoreboard
class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)
    
    uvm_analysis_imp_drv#(adder_transaction, adder_scoreboard) ap_driver;
    uvm_analysis_imp_mon#(adder_transaction, adder_scoreboard) ap_monitor;

    uvm_tlm_fifo #(adder_transaction) expfifo;  // Expected Output FIFO
    uvm_tlm_fifo #(adder_transaction) outfifo;  // Actual Output FIFO

    int vec, pass, error;   // Counter for number of vectors, passes, and errors

    reg [15:0]t_out;
    reg [15:0]t_a, t_b, t_cin;
    
    virtual intf vif;  // Virtual interface for clock access

    function new(string name="adder_scoreboard",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_driver = new("ap_driver", this);
        ap_monitor = new("ap_monitor", this);
        expfifo= new("expfifo",this);
        outfifo= new("outfifo",this);
        
        // Get interface handle
        if(!uvm_config_db#(virtual intf)::get(this, "*", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Failed to get virtual interface")
        end
    endfunction

    // Expected Values
    function void write_drv(adder_transaction tr);
        `uvm_info("write_drv STIM", tr.convert2string(), UVM_MEDIUM)
        // Process transaction
        t_a = tr.a;
        t_b = tr.b;
        t_cin = tr.cin;
        t_out = t_a + t_b + t_cin;
        // Calculate expected propagate and generate values
        tr.expected_propagate = t_a ^ t_b;
        tr.expected_generate = t_a & t_b;
        tr.out = t_out;
        void'(expfifo.try_put(tr));
    endfunction

    // Write outputs of monitor
    function void write_mon(adder_transaction tr);
        `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
        void'(outfifo.try_put(tr));
    endfunction

    task run_phase(uvm_phase phase);
        adder_transaction exp_tr, out_tr;

        forever begin
            `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
            expfifo.get(exp_tr);
            `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
            outfifo.get(out_tr);
            
            // Check if outputs are valid (when clkn_out is all 0s or clkp_out is all 1s)
            // We skip validation when the outputs are not valid
            if ((out_tr.clkn_out == 8'h00) || (out_tr.clkp_out == 8'hFF)) begin
                // Check output, propagate, and generate signals when valid
                @(posedge vif.clk); // before, the scoreboard would check the output when it transitions from invalid to a valid state
                // this led to false alarms!
                // added a 1 clock delay so that the scoreboard polls a valid output
                if ((out_tr.out == exp_tr.out) && 
                    (out_tr.propagate == exp_tr.expected_propagate) &&
                    (out_tr.generate_ == exp_tr.expected_generate))  begin
                    
                    PASS();
                    `uvm_info ("PASS ", $sformatf(
                        "Transaction PASSED:\n  Inputs: a=%h, b=%h, cin=%b\n  Outputs: out=%h, cout=%b\n  Propagate: actual=%h, expected=%h\n  Generate: actual=%h, expected=%h\n  Clock state: clkp_out=%h, clkn_out=%h", 
                        out_tr.a, out_tr.b, out_tr.cin,
                        out_tr.out, out_tr.cout,
                        out_tr.propagate, exp_tr.expected_propagate,
                        out_tr.generate_, exp_tr.expected_generate,
                        out_tr.clkp_out, out_tr.clkn_out), UVM_MEDIUM)
                end
                else begin
                    ERROR();
                    if (out_tr.out != exp_tr.out) begin
                        `uvm_error("OUTPUT_MISMATCH", $sformatf("Actual out: %h, Expected out: %h", 
                                                              out_tr.out, exp_tr.out))
                    end
                    if (out_tr.propagate != exp_tr.expected_propagate) begin
                        `uvm_error("PROPAGATE_MISMATCH", $sformatf("Actual propagate: %h, Expected propagate: %h", 
                                                                 out_tr.propagate, exp_tr.expected_propagate))
                    end
                    if (out_tr.generate_ != exp_tr.expected_generate) begin
                        `uvm_error("GENERATE_MISMATCH", $sformatf("Actual generate: %h, Expected generate: %h", 
                                                                out_tr.generate_, exp_tr.expected_generate))
                    end
                    `uvm_info("ERROR", $sformatf("Transaction with errors: a=%h, b=%h, cin=%b", 
                                               out_tr.a, out_tr.b, out_tr.cin), UVM_LOW)
                end
            end
            else begin
                // Skip validation when outputs are not valid
                `uvm_info("SKIPPED", $sformatf("Skipping validation: clkn_out=%h, clkp_out=%h - outputs not valid", 
                                              out_tr.clkn_out, out_tr.clkp_out), UVM_MEDIUM)
            end
        end
    endtask

    function void PASS();
        vec++;
        pass++;
    endfunction

    function void ERROR();
        vec++;
        error++;
    endfunction
endclass
