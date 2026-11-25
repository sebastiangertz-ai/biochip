module biochip_zaehler (
    input  wire       takt,
    input  wire       zuruecksetzen,
    input  wire       messung_fertig,
    output reg  [7:0] anzahl
);
    always @(posedge takt) begin
        if (zuruecksetzen)
            anzahl <= 8'd0;
        else if (messung_fertig)
            anzahl <= anzahl + 8'd1;
    end
endmodule