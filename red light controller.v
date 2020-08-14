/*Consider a controller for traffic light at the intersection of four roads. Consider P1, P2, P3 and P4 as four roads and PL as Pedestrian. The road has the following stages.
            Green=10011,
           Yellow=01000,
           Red=00100.
The pedestrian has following two states
           Green=0000
           Red=1111
First the road P1 is green and all other roads P2, P3 ,P4 and PL  are red .After a some delay P1 is turn to yellow and then red the traffic signal on P2 is green. After a delay P2 is turn to yellow and then red the signal on  P3 is green.Then P3 is changed to yellow and then red. Similarly P4 is turned green then yellow & then red. Pedestrian Light PL is green after a delay. Again P1 is turned to green & the routine will continue.
PROGRAM:*/
 module traffic (clk, reset,p1,p2,p3,p4,PL);
  input  clk;
 input  reset;
 output reg[4:0] p1;
 output reg[4:0] p2;
 output reg[4:0] p3;
 output reg[4:0] p4;
 output reg[3:0]PL;
 reg[4:0]sig;

 always @ (posedge clk or negedge reset)
begin
  if(reset==1'b0)begin
  p1=5'b00100;
  p2=5'b00100;
  p3=5'b00100;
  p4=5'b00100;
  PL=4'b01111;
  sig<=6'b000000;
  end
 else begin
 sig<=sig+1;
 case(sig[4:0])
 6'b00000:begin
               p1=5'b10011; // path 1 is green
               p2=5'b00100; // all other paths are red
               p3=5'b00100;
               p4=5'b00100;
               PL=4'b1111;
               end
  6'b00100:begin
                 p1=5'b01000;   //path 1 is yellow
               p2=5'b00100; // all other paths are red
                 p3=5'b00100;
                 p4=5'b00100;
                        PL<=4'b1111;
                 end
   6'b01000:begin
                 p1=5'b00100; // path1 is red
                 p2=5'b10011; //path2 is green
                  p3=5'b00100; // all other paths are red
                 p4=5'b00100;
                  PL=4'b1111;
                  end
    6'b01100:begin
                  p1=5'b00100;
                  p2=5'b01000; //path2 is yellow
                     p3=5'b00100; // all other paths are red
                     p4=5'b00100;
                     PL=4'b1111;
                                    end
     6'b10000:begin
                        p1=5'b00100;
                        p2=5'b00100;
                        p3=5'b10011; //path3 is green
                     p4=5'b00100; // all other paths are red
                        PL=4'b1111;
                                               end
       6'b10100:begin
                        p1=5'b00100;
                        p2=5'b00100;
                        p3=5'b01000; //path3 is yellow
                     p4=5'b00100;// all other paths are red
                        PL=4'b1111;
                       end
      6'b11000:begin
                        p1=5'b00100;
                        p2=5'b00100;
                       p3=5'b00100;// all other paths are red
                        p4=5'b10011;//path4 is yellow
                          PL=4'b1111;
                        end
 6'b10000:begin
p1=5'b00100; // all other paths are red
p2=5'b00100;
p3=5'b00100;
p4=5'b00100;
PL=4'b0000; // pedestrian green	
end	
  default:sig<=5'b00000
endcase
end
end
endmodule
					 