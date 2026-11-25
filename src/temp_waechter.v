module temp_waechter (
    input  wire       takt,
    input  wire       zuruecksetzen,
    input  wire [7:0] temperatur,
    input  wire [7:0] grenzwert,
    output reg        zu_warm,
    output reg        alarm_gemerkt
);
    always @(posedge takt) begin
        if (zuruecksetzen) begin
            zu_warm       <= 1'b0;
            alarm_gemerkt <= 1'b0;
        end else begin
            zu_warm <= (temperatur > grenzwert);
            if (temperatur > grenzwert)
                alarm_gemerkt <= 1'b1;
        end
    end
endmodule