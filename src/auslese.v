module auslese (
    input  wire       takt,
    input  wire       zuruecksetzen,
    input  wire       anfrage,
    input  wire [7:0] wert0,
    input  wire [7:0] wert1,
    input  wire [7:0] wert2,
    output reg  [7:0] daten,
    output reg        daten_gueltig
);
    reg [1:0] schritt;
    reg       aktiv;

    always @(posedge takt) begin
        if (zuruecksetzen) begin
            aktiv         <= 1'b0;
            schritt       <= 2'd0;
            daten         <= 8'd0;
            daten_gueltig <= 1'b0;
        end else if (!aktiv) begin
            daten_gueltig <= 1'b0;
            if (anfrage) begin
                aktiv   <= 1'b1;
                schritt <= 2'd0;
            end
        end else begin
            daten_gueltig <= 1'b1;
            case (schritt)
                2'd0:    daten <= wert0;
                2'd1:    daten <= wert1;
                default: daten <= wert2;
            endcase
            if (schritt == 2'd2)
                aktiv <= 1'b0;
            else
                schritt <= schritt + 2'd1;
        end
    end
endmodule