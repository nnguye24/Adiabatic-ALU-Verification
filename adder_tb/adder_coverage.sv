
class adder_coverage extends uvm_subscriber #(adder_sequence_item);
  `uvm_component_utils(adder_coverage)

  function new(string name="",uvm_component parent);
    super.new(name,parent);
    dut_cov=new();
  endfunction
  

  
  adder_sequence_item txn;
  real cov;
  

  covergroup dut_cov;
    option.per_instance=1;
    A:coverpoint txn.a { 
      bins name1_1[]={[0:3]};
      bins name2_1[]={[4:7]};
      bins name3_1[]={[8:11]};
      bins name4_1[]={[11:15]};
    }
    B:coverpoint txn.b { 
      bins name1_2[]={[0:3]};
      bins name2_2[]={[4:7]};
      bins name3_2[]={[8:11]};
      bins name4_2[]={[11:15]};
    }
  endgroup:dut_cov

  function void write(adder_transactiont);
    txn=t;
    dut_cov.sample();
  endfunction
  

  
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=dut_cov.get_coverage();
  endfunction
  


  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM)
  endfunction
  
  
endclass:adder_coverage
