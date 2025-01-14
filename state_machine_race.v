module state_machine_race (
    input clk,
    input reset,
    input wire[3:0] numero,
    input insere,
    output reg led,
    output reg[6:0] display
);


    //define os estado
    localparam sig0 = 3'b000;
    localparam sig1 = 3'b001;
    localparam sig2 = 3'b010;
    localparam sig3 = 3'b011;
    localparam sig4 = 3'b100;
    localparam sig5 = 3'b101;
    localparam sig6 = 3'b110;
    localparam sigfalha = 3'b111;
    

    //variaveis que guardam o proximo estado e o estado atual
    reg [2:0] present_state, next_state;


    reg start_led_e_next_state = 0;
    reg start_display = 0;
    reg start_present_state = 0;

    //logica de proximo estado que roda sempre que alguem insere um numero
    always @(posedge clk) begin
        if(start_led_e_next_state == 1)begin
            if(insere) begin
                if(numero < 4'b1010) begin
                    case (present_state)
                        sigfalha:
                            next_state = present_state;
                        sig6:
                            next_state = present_state;
                        sig5:
                            if (numero == 4'b1001)
                                next_state = sig6;
                            else
                                if(led == 1)
                                    led = 0;
                                else
                                    next_state = sigfalha;
                            
                        sig4:
                            if (numero == 4'b0101)
                                next_state = sig5;
                            else
                                if(led == 1)
                                    led = 0;
                                else
                                    next_state = sigfalha;
                        sig3:
                            if (numero == 4'b1001)
                                next_state = sig4;
                            else
                                if(led == 1)
                                    led = 0;
                                else
                                    next_state = sigfalha;
                        sig2:
                            if (numero == 4'b0111)
                                next_state = sig3;
                            else
                                if(led == 1)
                                    led = 0;
                                else
                                    next_state = sigfalha;
                        sig1:
                            if (numero == 4'b0011)
                                next_state = sig2;
                            else
                                if(led == 1)
                                    led = 0;
                                else
                                    next_state = sigfalha;
                        sig0:
                            if (numero == 4'b0101)
                                next_state = sig1;
                            else
                                if(led == 1)
                                    led = 0;
                                else
                                    next_state = sigfalha; 
                        default:
                            next_state = sig0;
                    endcase 
                end else begin
                    next_state = present_state;
                end
            end
            if(reset) begin
                next_state = sig0;
                led = 1;
            end
        end else begin
            led = 1;
            next_state = 3'b000;
            start_led_e_next_state = 1;
        end 
    end

    //logica de saida para os estados
    always @(posedge clk) begin

        if(start_display == 1) begin
            if(present_state == sig0 && reset == 1'b1)
                display = 7'b0000001;
            else
                if(present_state == sigfalha)
                    display = 7'b0111000;
                else if(present_state == sig6)
                    if(led == 1)
                        display = 7'b0100100;
                    else
                        display = 7'b0011000;
                else 
                    if (numero == 4'b1001)
                        display = 7'b0000100;
                    else if (numero == 4'b1000)
                        display = 7'b0000000;
                    else if (numero == 4'b0111)
                        display = 7'b0001111;
                    else if (numero == 4'b0110)
                        display = 7'b0100000;
                    else if (numero == 4'b0101)
                        display = 7'b0100100;
                    else if (numero == 4'b0100)
                        display = 7'b1001100;
                    else if (numero == 4'b0011)
                        display = 7'b0000110;
                    else if (numero == 4'b0010)
                        display = 7'b0010010;
                    else if (numero == 4'b0001)
                        display = 7'b1001111;
                    else if (numero == 4'b0000)
                        display = 7'b0000001;  
                    else
                        display = 7'b1111110;  
        end else begin
            display = 7'b0000001;
            start_display = 1;

        end
    end

    //logica de troca de estados
    always @(negedge clk) begin
        if(start_present_state == 1'b1)
            if (reset == 1'b1) begin 
                present_state = sig0;
            end else begin
                present_state = next_state;
            end
        else 
            present_state = 3'b000;
            start_present_state = 1'b1;
        

    end

endmodule