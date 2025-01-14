module state_machine_race_tb;
reg clk, reset, insere;
reg[3:0] numero;
wire led;
wire[6:0] display;

state_machine_race uut
(
    .clk(clk),
    .reset(reset),
    .numero(numero),
    .insere(insere),
    .led(led),
    .display(display)
);

always begin 
    #5;
    clk=~clk;
end 

initial begin
    $dumpfile("state_machine_race.vcd");
    $dumpvars(0, state_machine_race_tb);

    reset = 0; insere = 0; clk = 0;
    numero = 4'b0101; #10; insere = 1; #10; insere = 0; 
    numero = 4'b0011; #10; insere = 1; #10; insere = 0;
    numero = 4'b0111; #10; insere = 1; #10; insere = 0;
    numero = 4'b1001; #10; insere = 1; #10; insere = 0;
    numero = 4'b1100; #10; insere = 1; #10; insere = 0;
    numero = 4'b0101; #10; insere = 1; #10; insere = 0;
    numero = 4'b1001; #10; insere = 1; #10; insere = 0; #10;
    reset = 1; #10 ; reset = 0; #10;
    numero = 4'b0101; #10; insere = 1; #10; insere = 0;
    numero = 4'b0011; #10; insere = 1; #10; insere = 0;
    numero = 4'b0111; #10; insere = 1; #10; insere = 0;
    numero = 4'b1001; #10; insere = 1; #10; insere = 0;
    numero = 4'b0101; #10; insere = 1; #10; insere = 0;
    numero = 4'b0010; #10; insere = 1; #10; insere = 0;
    numero = 4'b1001; #10; insere = 1; #10; insere = 0; #10;
    reset = 1; #10 ; reset = 0; #10;
    numero = 4'b0101; #10; insere = 1; #10; insere = 0;
    numero = 4'b0011; #10; insere = 1; #10; insere = 0;
    numero = 4'b0010; #10; insere = 1; #10; insere = 0;
    numero = 4'b0001; #10; insere = 1; #10; insere = 0; #10;

    $finish;
end

endmodule