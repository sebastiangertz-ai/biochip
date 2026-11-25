`default_nettype none
module tt_um_biochip_gertz (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
    wire zuruecksetzen = ~rst_n;
    wire [7:0] gesamt, zu_warm_anzahl;
    wire alarm;
    wire [7:0] daten;
    wire daten_gueltig;

    biochip_kern kern (
        .takt(clk), .zuruecksetzen(zuruecksetzen),
        .messung_fertig(uio_in[0]),
        .temperatur(ui_in), .grenzwert(8'd8),
        .anzahl_messungen(gesamt), .anzahl_zu_warm(zu_warm_anzahl),
        .alarm_gemerkt(alarm)
    );

    auslese nfc (
        .takt(clk), .zuruecksetzen(zuruecksetzen), .anfrage(uio_in[1]),
        .wert0(gesamt), .wert1(zu_warm_anzahl), .wert2({7'b0, alarm}),
        .daten(daten), .daten_gueltig(daten_gueltig)
    );

    assign uo_out  = daten;
    assign uio_out = {4'b0000, alarm, daten_gueltig, 2'b00};
    assign uio_oe  = 8'b0000_1100;

    wire _unused = &{ena, uio_in[7:2], 1'b0};
endmodule
`default_nettype wire