module arbiter( input clk,
                input rst,
                input req3, //REQUEST SIGNALS
                input req2,
                input req1,
                input req0,
                output gnt3, //GRANT SIGNALS
                output gnt2,
                output gnt1,
                output gnt0
);
    wire beginblock;
    wire[1:0] lgnt; // 2-bit vector that represents an encoded form of the grant
    wire lcomreq;
    reg lgnt0; //These are registers (i.e., reg type) that store the latched grant signals for each request line
    reg lgnt1;
    reg lgnt2;
    reg lgnt3;
    reg mask_enable;
    reg lmask0;
    reg lmask1;
    always@ (posedge clk)
    begin
        if (rst)
        begin
            lgnt0<=0;
            lgnt1<=0;
            lgnt2<=0;
            lgnt3<=0;
        end
        else
        begin
        /// lgnt0 gets priority only if:
        // - No one else is using the bus (lcomreq == 0)
        // - lmask defines the current starting priority
        // - Higher-priority requests (req3, req2, req1) are not asserted 
              
        lgnt0 <=(~lcomreq & ~lmask1 & ~lmask0 & ~req3 & ~req2 & ~req1 & req0)
        | (~lcomreq & ~lmask1 &  lmask0 & ~req3 & ~req2 &  req0)
        | (~lcomreq &  lmask1 & ~lmask0 & ~req3 &  req0)
        | (~lcomreq &  lmask1 &  lmask0 & req0  )
        | ( lcomreq & lgnt0 );

        lgnt1 <=(~lcomreq & ~lmask1 & ~lmask0 &  req1)
        | (~lcomreq & ~lmask1 &  lmask0 & ~req3 & ~req2 &  req1 & ~req0)
        | (~lcomreq &  lmask1 & ~lmask0 & ~req3 &  req1 & ~req0)
        | (~lcomreq &  lmask1 &  lmask0 &  req1 & ~req0)
        | ( lcomreq &  lgnt1);
      
        lgnt2 <=(~lcomreq & ~lmask1 & ~lmask0 &  req2  & ~req1)
        | (~lcomreq & ~lmask1 &  lmask0 &  req2)
        | (~lcomreq &  lmask1 & ~lmask0 & ~req3 &  req2  & ~req1 & ~req0)
        | (~lcomreq &  lmask1 &  lmask0 &  req2 & ~req1 & ~req0)
        | ( lcomreq &  lgnt2);
      
        lgnt3 <=(~lcomreq & ~lmask1 & ~lmask0 & req3  & ~req2 & ~req1)
        | (~lcomreq & ~lmask1 &  lmask0 & req3  & ~req2)
        | (~lcomreq &  lmask1 & ~lmask0 & req3)
        | (~lcomreq &  lmask1 &  lmask0 & req3  & ~req2 & ~req1 & ~req0)
        | ( lcomreq & lgnt3);
        end
    end

    //encoder logic
    assign  lgnt =  {(lgnt3 | lgnt2),(lgnt3 | lgnt1)};

    assign lcomreq = ( req3 & lgnt3 )
                | ( req2 & lgnt2 )
                | ( req1 & lgnt1 )
                | ( req0 & lgnt0 );

    assign beginblock = (req3 | req2 | req1 | req0) & ~lcomreq;
    assign mask_enable = beginblock;

    always @ (posedge clk )
    begin
        if( rst ) 
        begin
            lmask1 <= 0;
            lmask0 <= 0;
        end 
        else if(mask_enable) 
        begin
            lmask1 <= lgnt[1];
            lmask0 <= lgnt[0];
        end 
        else 
        begin
                lmask1 <= lmask1;
                lmask0 <= lmask0;
        end 
    end

// Drive the outputs

assign gnt3   = lgnt3;
assign gnt2   = lgnt2;
assign gnt1   = lgnt1;
assign gnt0   = lgnt0;



endmodule