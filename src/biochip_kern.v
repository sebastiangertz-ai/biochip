module biochip_kern (
    input  wire       takt,
    input  wire       zuruecksetzen,
    input  wire       messung_fertig,
    input  wire [7:0] temperatur,
    input  wire [7:0] grenzwert,
    output wire [7:0] anzahl_messungen,
    output reg  [7:0] anzahl_zu_warm,
    output wire       alarm_gemerkt
);
    wire zu_warm;

    biochip_zaehler zaehler (
        .takt(takt),
        .zuruecksetzen(zuruecksetzen),
        .messung_fertig(messung_fertig),
        .anzahl(anzahl_messungen)
    );

    temp_waechter waechter (
        .takt(takt),
        .zuruecksetzen(zuruecksetzen),
        .temperatur(temperatur),
        .grenzwert(grenzwert),
        .zu_warm(zu_warm),
        .alarm_gemerkt(alarm_gemerkt)
    );

    always @(posedge takt) begin
        if (zuruecksetzen)
            anzahl_zu_warm <= 8'd0;
        else if (messung_fertig && (temperatur > grenzwert))
            anzahl_zu_warm <= anzahl_zu_warm + 8'd1;
    end
endmodule