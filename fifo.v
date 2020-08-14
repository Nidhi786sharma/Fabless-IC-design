`define  FWIDTH     32           // Width of the FIFO.
`define  FDEPTH     4            // Depth of the FIFO.
`define  FCWIDTH    2            // Counter Width of the FIFO 2 to power 
                                 // FCWIDTH = FDEPTH.
module FIFO(  Clk,
              RstN,
              Data_In,
              FClrN,
              FInN,
              FOutN,

              F_Data,
              F_FullN,
              F_LastN,
              F_SLastN,
              F_FirstN,
              F_EmptyN
           );



input                       Clk;      // CLK Signal.
input                       RstN;     // Low Asserted Reset signal.
input [(`FWIDTH-1):0]       Data_In;  // Data Into FIFO.
input                       FInN;     // Write into FIFO Signal.
input                       FClrN;    // Clear Signal to FIFO.
input                       FOutN;    // Read From FIFO Signal.

output [(`FWIDTH-1):0]      F_Data;   // FIFO Data out.
output                      F_FullN;  // FIFO Full indicating signal.
output                      F_EmptyN; // FIFO Empty indicating signal.
output                      F_LastN;  // FIFO Last But One Signal.
output                      F_SLastN; // FIFO SLast But One Signal.
output                      F_FirstN; // Signal indicating only one word inFIFO.


reg                F_FullN;
reg                F_EmptyN;
reg                F_LastN;
reg                F_SLastN;
reg                F_FirstN;

reg    [`FCWIDTH:0]       fcounter;    // counter indicates num of data in FIFO
reg    [(`FCWIDTH-1):0]   rd_ptr;      // current read pointer.
reg    [(`FCWIDTH-1):0]   wr_ptr;      // current write pointer.
wire   [(`FWIDTH-1):0]    FIFODataOut; // Data Out from the FIFO MemBlk
wire   [(`FWIDTH-1):0]    FIFODataIn;  // Data into the FIFO MemBlk

wire   ReadN  = FOutN;
wire   WriteN = FInN;

assign F_Data     = FIFODataOut;  
assign FIFODataIn = Data_In;     


    FIFO_MEM_BLK memblk(.clk(Clk),          .writeN(WriteN),
                        .rd_addr(rd_ptr),
                        .wr_addr(wr_ptr),
                        .data_in(FIFODataIn),
                        .data_out(FIFODataOut)
                       ); 
 always @(posedge Clk or negedge RstN)
    begin

       if(!RstN) begin
           fcounter    <= 0;
           rd_ptr      <= 0;
           wr_ptr      <= 0;
       end
       else begin

           if(!FClrN ) begin
               fcounter    <= 0;
               rd_ptr      <= 0;
               wr_ptr      <= 0;
           end
           else begin

               if(!WriteN && F_FullN) 
                   wr_ptr <= wr_ptr + 1;

               if(!ReadN && F_EmptyN)
                   rd_ptr <= rd_ptr + 1;
 
               if(!WriteN && ReadN && F_FullN) 
                   fcounter <= fcounter + 1;
 else if(WriteN && !ReadN && F_EmptyN)
                   fcounter <= fcounter - 1;
          end
       end
    end
 always @(posedge Clk or negedge RstN)
    begin

       if(!RstN)
          F_EmptyN <= 1'b0;

       else begin
          if(FClrN==1'b1) begin

             if(F_EmptyN==1'b0 && WriteN==1'b0)

                 F_EmptyN <= 1'b1;
 
             else if(F_FirstN==1'b0 && ReadN==1'b0 && WriteN==1'b1)
 
                 F_EmptyN <= 1'b0;
          end
          else
             F_EmptyN <= 1'b0;
       end
end
 always @(posedge Clk or negedge RstN)
    begin
 
       if(!RstN)
 
          F_FirstN <= 1'b1;
 
       else begin
          if(FClrN==1'b1) begin
 
             if((F_EmptyN==1'b0 && WriteN==1'b0) ||
                (fcounter==2 && ReadN==1'b0 && WriteN==1'b1))
 
                 F_FirstN <= 1'b0;
  
             else if (F_FirstN==1'b0 && (WriteN ^ ReadN))
                 F_FirstN <= 1'b1;
          end
          else begin
 
             F_FirstN <= 1'b1;
          end
       end   
    end   
 always @(posedge Clk or negedge RstN)
    begin
 
       if(!RstN)
 
          F_SLastN <= 1'b1;
       
       else begin

          if(FClrN==1'b1) begin

             if( (F_LastN==1'b0 && ReadN==1'b0 && WriteN==1'b1) || 
                 (fcounter == (`FDEPTH-3) && WriteN==1'b0 && ReadN==1'b1))

                 F_SLastN <= 1'b0;
          

             else if(F_SLastN==1'b0 && (ReadN ^ WriteN) )
                 F_SLastN <= 1'b1;

          end
          else
             F_SLastN <= 1'b1;

       end
    end 
 always @(posedge Clk or negedge RstN)
    begin
 
       if(!RstN)
 
          F_LastN <= 1'b1;
 
       else begin
          if(FClrN==1'b1) begin
 
             if ((F_FullN==1'b0 && ReadN==1'b0)  ||
                 (fcounter == (`FDEPTH-2) && WriteN==1'b0 && ReadN==1'b1))
  
                 F_LastN <= 1'b0;
  
             else if(F_LastN==1'b0 && (ReadN ^ WriteN) )
                 F_LastN <= 1'b1;
          end
          else
             F_LastN <= 1'b1;
       end
    end
 always @(posedge Clk or negedge RstN)
    begin
 
       if(!RstN)
 
           F_FullN <= 1'b1;
 
       else begin
           if(FClrN==1'b1)  begin
 
               if (F_LastN==1'b0 && WriteN==1'b0 && ReadN==1'b1)
       
                    F_FullN <= 1'b0;
 
               else if(F_FullN==1'b0 && ReadN==1'b0)
    
                    F_FullN <= 1'b1;
           end
           else
               F_FullN <= 1'b1;
    
       end
    end
       
endmodule

module FIFO_MEM_BLK( clk,
                     writeN,
                     wr_addr,
                     rd_addr,
                     data_in,
                     data_out
                   );


input                    clk;       // input clk.
input                    writeN;    // Write Signal to put datainto fifo.
input  [(`FCWIDTH-1):0]  wr_addr;   // Write Address.
input  [(`FCWIDTH-1):0]  rd_addr;   // Read Address.
input  [(`FWIDTH-1):0]   data_in;   // DataIn in to Memory Block

output [(`FWIDTH-1):0]   data_out;  // Data Out from the Memory Block(FIFO)

wire   [(`FWIDTH-1):0] data_out;  

reg    [(`FWIDTH-1):0] FIFO[0:(`FDEPTH-1)];



assign data_out  = FIFO[rd_addr];

always @(posedge clk)
begin

   if(writeN==1'b0)
      FIFO[wr_addr] <= data_in;
end

endmodule

