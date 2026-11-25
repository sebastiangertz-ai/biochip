## How it works

Der Frischwaechter zaehlt Temperaturmessungen. Bei jeder Messung (uio_in[0] = Messung fertig) wird der Wert an ui_in mit einem festen Grenzwert (8) verglichen. Der Chip zaehlt alle Messungen und die zu warmen Messungen. Ist eine Messung zu warm, geht der Alarm (uio_out[3]) an.

## How to test

Temperaturwert an ui_in anlegen und uio_in[0] kurz auf 1 setzen. Mit uio_in[1] (Anfrage) die Zaehlerstaende abfragen. Die Daten erscheinen an uo_out, uio_out[2] zeigt an, dass die Daten gueltig sind.

## External hardware

Temperatursensor mit 8-Bit-Ausgang, oder Schalter zum Testen.
