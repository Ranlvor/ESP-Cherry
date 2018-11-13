# ESP-Cherry
Little board that connects 4 Cherry Switches and 4 LEDs to a Wemos D1 Mini Board

# Folder Structure:
* ESP-Cerry: KiCad Project of the Board
* gehaeuse: OpenSCAD Project for a 3D printed casing

# Parts
* U1: Wemos D1 Mini
* Switches SW1, SW2, SW3, SW4: CHERRY MX-Switches, choose to your liking
* Resistors R1, R2: Pull-Up-Resistors for SW3 and SW4, 1kΩ - 100kΩ should be fine
* LEDs D1, D2, D3, D4: LEDs to iluminate the Keykaps, choose to your liking.  Use LEDs which fit your switches. The switches I used fit 3mm LED's but some do not
* Resistors R3, R4, R5, R6: protective resistors for LEDs D1, D2, D3, D4: choose whatever fits your LEDs.

## Optional Parts:
* Add R7 = 4.7kΩ and U3 = DS18B20 for temperature mesurement

# Other
* Power the Wemos D1 via USB, it powers the rest of the board (or solder 3.3V or 5V directly to the Wemos)
* Mounting Holes fit M3 screws
* Mounting Holes Positions in mm from the lower left corner of the board:
  * 5.08, 20.32
  * 5.08, 40.64
  * 5.08, 58.42
  * 5.08, 78.74
  * 52.07, 7.62
  * 52.07, 78.74
