`timescale 1ns / 1ps

/*
Step 1) Build a DMA that copies memory 
 * source_addr
 * dest_addr
 * length
 * start

System Flow: CPU configures registers --> DMA reads memory
--> DMA writes memory --> DMA raises DONE flag
*/

module axi_dma #(

    // AXI Data bus width
    parameter AXI_DATA_WIDTH = 32,

    // AXI Address bus width
    parameter AXI_ADDR_WIDTH = 16

)(
    input  logic clk,    // clock signal
    input  logic rst,    // reset signal
    input  logic start,  // start DMA transfer
    output logic done    // transfer complete
);

    // Internal registers
    logic [AXI_ADDR_WIDTH-1:0] src_addr; // source memory address
    logic [AXI_ADDR_WIDTH-1:0] dst_addr; // destination memory address
    logic [15:0] length; // number of transfers

    logic [15:0] count; // transfers completed


    // DMA State Machine
    typedef enum logic [2:0] {

        IDLE,   // waiting for start signal
        READ,   // read memory
        WRITE,  // write memory
        DONE    // transfer finished

    } dma_state_t;

    dma_state_t state;

endmodule : axi_dma