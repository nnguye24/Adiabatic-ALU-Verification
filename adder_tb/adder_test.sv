
class adder_test extends uvm_test;
    `uvm_component_utils(adder_test)
    
    function new(string name="",uvm_component parent);
	    super.new(name,parent);
    endfunction
    

    adder_env env;
    int file;

    // Base sequence
    adder_sequence seq;
    
    // Sequences with specific constraints
    adder_add_zero_a seq1_1;
    adder_add_zero_a seq1_2;
    adder_add_zero_b seq2_1;
    adder_add_zero_b seq2_2;
    adder_cin_1 seq3_1;
    adder_cin_1 seq3_2;
    adder_boundary seq4_1;
    adder_all_bits seq5_1;
    
    // Add specific sequences for propagate, generate, and ripple carry verification
    adder_propagate_test seq_prop;
    adder_generate_test seq_gen;
    adder_ripple_carry_test seq_ripple;
  
    reset rst;

    
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = adder_env::type_id::create("env",this);

      seq = adder_sequence::type_id::create("seq");
      seq1_1 = adder_add_zero_a::type_id::create("seq1_1");
      seq1_2 = adder_add_zero_a::type_id::create("seq1_2");
      seq2_1 = adder_add_zero_b::type_id::create("seq2_1");
      seq2_2 = adder_add_zero_b::type_id::create("seq2_2");
      seq3_1 = adder_cin_1::type_id::create("seq3_1");
      seq3_2 = adder_cin_1::type_id::create("seq3_2");
      seq4_1 = adder_boundary::type_id::create("seq4_1");
      seq5_1 = adder_all_bits::type_id::create("seq5_1");
      seq_prop = adder_propagate_test::type_id::create("seq_prop");
      seq_gen = adder_generate_test::type_id::create("seq_gen");
      seq_ripple = adder_ripple_carry_test::type_id::create("seq_ripple");
    endfunction
    

    
    function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      //factory.print();
      $display("End of elaboration phase in agent");
    endfunction
    

    
    function void start_of_simulation_phase(uvm_phase phase);
      super.start_of_simulation_phase(phase);
      $display("start_of_simulation_phase");
      file=$fopen("LOG_FILE.log","w");
      set_report_default_file(file);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      env.set_report_verbosity_level_hier(UVM_MEDIUM);
      seq.loop_count=100;
    endfunction
    

    
    task run_phase(uvm_phase phase);
	      phase.raise_objection(this);
            
            // Start with reset sequence
            rst.start(env.agent.sequencer);
            
            // Run base random sequence
            seq.start(env.agent.sequencer);
            
            // Run constrained sequences
            seq1_1.start(env.agent.sequencer); // a=0
            seq2_1.start(env.agent.sequencer); // b=0
            seq3_1.start(env.agent.sequencer); // cin=1
            seq4_1.start(env.agent.sequencer); // Boundary values
            seq5_1.start(env.agent.sequencer); // All bits
            
            // Run propagate pattern specific tests
            seq_prop.start(env.agent.sequencer); // Special propagate patterns
            
            // Run generate pattern specific tests
            seq_gen.start(env.agent.sequencer); // Special generate patterns
            
            // Run ripple carry specific tests 
            seq_ripple.start(env.agent.sequencer); // Ripple carry patterns
            
            #10;
	      phase.drop_objection(this);
    endtask
    

endclass:adder_test
