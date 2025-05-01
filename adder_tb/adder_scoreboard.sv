
`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )


class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)
    
    uvm_analysis_imp#(adder_transaction, adder_scoreboard) ap_driver;
    uvm_analysis_imp#(adder_transaction, adder_scoreboard) ap_monitor;

    uvm_tlm_fifo #(adder_transaction) expfifo;  // Expected Output FIFO
    uvm_tlm_fifo #(adder_transaction) outfifo;  // Actual Output FIFO

    int vec, pass, error;   // Counter for number of vectors, passes, and errors. 

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

    // Handling transaction... Expected Values
    function void write_drv(adder_transaction tr);
        `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
        if(tr.rst==1) 
            begin 
                t_out = 0;
            end
        else 
        begin
            t_a = tr.a;
            t_b = tr.b;
            t_cin = tr.cin;
            t_out = t_a + t_b + t_cin;
        end
        tr.out = t_out;
    void'(expfifo.try_put(tr));
    endfunction

    // Write outputs of monitor
    function void write_mon(adder_sequence_item tr);
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
            
            if (out_tr.out == exp_tr.out) begin
                PASS();
                `uvm_info ("PASS ",out_tr.convert2string() , UVM_MEDIUM)
            end
        
            else begin
                ERROR();
                `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
                `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
                `uvm_warning("ERROR",exp_tr.convert2string())
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