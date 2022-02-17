/* =====================================================================
 * Project:      Traffic generator
 * Title:        PWM_ctrl.sv
 * Description:  PWM controller for traffic generator. Some notes:
 *                  - PWM_PERIOD    ~ PWM signal period (T). Expressed in terms of clock cycles (Tck).
 *                  - PWM_PULSE     ~ PWM pulse duration (T*D)). Expressed in terms of clock cycles (Tck).
 *                  - PWM_SIZE      ~ PWM pulse value.
 *                  - PWM_ENABLE    ~ Enable to enable/disable PWM pulse creation.
 *                  - PWM_OUT       ~ Modulated signal. It drives streaming protocol signals (valid/ready).
 * 
 * $Date:        16.2.2022
 *
 * ===================================================================== */
/*
 * Copyright (C) 2022 University of Modena and Reggio Emilia.
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
 */

`include "timer.sv"

module PWM_ctrl #(
    parameter int unsigned WORD_WIDTH = 32
) (
    input logic CLK,
    input logic RSTN,
    input logic [WORD_WIDTH-1:0] PWM_PERIOD, 
    input logic [WORD_WIDTH-1:0] PWM_PULSE,
    input logic PWM_SIZE, 
    input logic PWM_ENABLE,
    output logic PWM_OUT
);

    // PWM ctrl states
    enum   {IDLE, HIGH, LOW} state, next_state;
    
    // Signals
    logic restart;
    logic [WORD_WIDTH-1:0] count;

    logic [WORD_WIDTH-1:0] T;
    logic [WORD_WIDTH-1:0] D;
    logic A;
    logic enable;
    assign T=PWM_PERIOD;
    assign D=PWM_PULSE;
    assign A=PWM_SIZE;
    assign enable=PWM_ENABLE;

    logic pwm;

    // Timer
    timer #(
        .WORD_WIDTH (32)
    ) timer (   
        .clk        (CLK),
        .rstn       (RSTN),
        .restart    (restart),
        .count      (count)
    );

    // FSM

    // additional signals (useful in sim)
    logic [WORD_WIDTH-1:0] comp;
    logic high2low;
    logic low2high;
    assign comp=count+1;
    assign high2low = (comp == D);
    assign low2high = (comp == T);

    always_ff @(posedge CLK, negedge RSTN) begin
        if(RSTN == 1'b0)
            state = IDLE;
        else
            state = next_state;
    end

    always_comb
    begin
    restart = 1'b0;
    case(state)

        // IDLE state --> no PWM signal
        IDLE: begin
            if(enable == 1'b1) begin
                next_state = HIGH;
                pwm = 1'b0;
                restart = 1'b1;
            end
            else begin
                next_state = IDLE;
                pwm = 1'b0;
                restart = 1'b0;
            end
        end

        // Pulse HIGH
        HIGH: begin
            pwm = A;
            if(enable == 1'b0)
                next_state = IDLE;
            else
                if (high2low)
                    next_state = LOW;
        end
        
        // Pulse LOW
        LOW: begin
            pwm = 1'b0;
            if(enable == 1'b0)
                next_state = IDLE;
            else
                if (low2high) begin
                    next_state = HIGH;
                    restart = 1'b1;
                end
        end

        default: begin
            pwm = 1'b0;
            next_state = IDLE;
        end
    endcase
    end

    assign PWM_OUT = pwm;
    
endmodule