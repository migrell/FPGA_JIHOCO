module simple_fnd_controller (
    input clk, //륶아 연애좀해 ㅋ
    input reset,
    input [7:0] data_in,
    // input rx_done,
    output [7:0] fnd_font,
    output [3:0] fnd_comm
);
    // // 마지막 자리만 활성화 (active low)
    // assign fnd_comm = 4'b1110;

    wire[3:0] w_bcd;//TEST
    reg [3:0] value_hex;

    always @(*) begin
        if (data_in >= 8'h30 && data_in <= 8'h39)  // ASCII '0'-'9'
            value_hex = data_in - 8'h30;
        else if (data_in >= 8'h41 && data_in <= 8'h46)  // ASCII 'A'-'F'
            value_hex = data_in - 8'h41 + 4'hA;
        else if (data_in >= 8'h61 && data_in <= 8'h66)  // ASCII 'a'-'f'
            value_hex = data_in - 8'h61 + 4'hA;
        else 
            value_hex = 4'h0;  // 기본값
    end
    
    assign w_bcd = value_hex;

    bcdtoseg U_BCDTOSEG(
        .bcd(w_bcd),
        .seg(fnd_font)


    );

    assign fnd_comm = 4'b1110;

    endmodule
    
    // // 수신 데이터 저장 레지스터
    // // reg [7:0] display_data_reg;
    
    // // 수신 완료 시 데이터 업데이트
    // always @(posedge clk or posedge reset) begin
    //     if (reset) begin
    //         display_data_reg <= 8'h30; // 기본값 '0'
    //     end else if (rx_done) begin
    //         display_data_reg <= rx_data; // 수신 데이터 저장 
    //     end
    // end
    // // single clock 처리 -> 현재상태가지고 처리함 
        

    // // 표시할 BCD 데이터 변환
    // reg [3:0] display_bcd;
   


   module bcdtoseg (
    input [3:0] bcd,
    output reg [7:0] seg
);
    always @(bcd) begin
        case (bcd)
            4'h0: seg = 8'hC0;
            4'h1: seg = 8'hF9;
            4'h2: seg = 8'hA4;
            4'h3: seg = 8'hB0;
            4'h4: seg = 8'h99;
            4'h5: seg = 8'h92;
            4'h6: seg = 8'h82;
            4'h7: seg = 8'hF8;
            4'h8: seg = 8'h80;
            4'h9: seg = 8'h90;
            4'hA: seg = 8'h88;  // A
            4'hB: seg = 8'h83;  // B
            4'hC: seg = 8'hC6;  // C
            4'hD: seg = 8'hA1;  // D
            4'hE: seg = 8'h86;  // E
            4'hF: seg = 8'h8E;  // F
            default: seg = 8'hFF;  // 예외 처리
        endcase
    end
endmodule
