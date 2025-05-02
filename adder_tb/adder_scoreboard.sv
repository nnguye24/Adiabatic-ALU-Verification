`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )
// tr is txn

class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)
    
    uvm_analysis_imp#(adder_transaction, adder_scoreboard) ap_driver;
    uvm_analysis_imp#(adder_transaction, adder_scoreboard) ap_monitor;

    uvm_tlm_fifo #(adder_transaction) expfifo;  // Expected Output FIFO
    uvm_tlm_fifo #(adder_transaction) outfifo;  // Actual Output FIFO

    int vec, pass, error;   // Counter for number of vectors, passes, and errors

    reg [15:0]t_out;
    reg [15:0]t_a, t_b, t_cin;

    function new(string name="adder_scoreboard",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_driver = new("ap_driver", this);
        ap_monitor = new("ap_monitor", this);
        expfifo= new("expfifo",this);
        outfifo= new("outfifo",this);

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
            
            // Check output, propagate, and generate signals
            if ((out_tr.out == exp_tr.out) && 
                (out_tr.propagate == exp_tr.expected_propagate) &&
                (out_tr.generate_ == exp_tr.expected_generate))  begin
                
                PASS();
                `uvm_info ("PASS ", $sformatf("Output: %h, Propagate: %h, Generate: %h", 
                                             out_tr.out, out_tr.propagate, out_tr.generate_), UVM_MEDIUM)
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
    endtask

    function void PASS();
        vec++;
        pass++;
    endfunction

    function void ERROR();
        vec++;
        error++;
    endfunction

endclass: adder_scoreboard