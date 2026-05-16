INSERT INTO domains.electric_transmission_line_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the ElectricTransmissionLine feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'High Voltage Overhead Conductor', 'Overhead High Voltage lines represent Transmission and Sub transmission voltage cables and are typically polyphase lines that represent multiple lines per phase. Lines can be Alternating (AC) or Direct Current (DC).'),
    (2, 'High Voltage Underground Conductor', 'Underground High Voltage lines represent Transmission and Sub transmission voltage cables and are typically polyphase lines that represent multiple lines per phase. Lines can be Alternating (AC) or Direct Current (DC).'),
    (3, 'High Voltage Submersible Conductor', 'Submarine High Voltage lines represent Transmission and Sub transmission voltage cables and are typically polyphase lines that represent multiple lines per phase. Lines can be Alternating (AC) or Direct Current (DC).'),
    (4, 'High Voltage Busbar', 'Busbar is solid conductor used in substations on the high voltage side of equipment.'),
    (5, 'High Voltage Connector', 'A line used to connect equipment, but would not be considered trackable cable.'),
    (6, 'High Voltage Service', 'A High Voltage line to provide electric service');
