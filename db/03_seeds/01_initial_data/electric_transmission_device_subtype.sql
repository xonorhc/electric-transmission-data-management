INSERT INTO domains.electric_transmission_device_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the ElectricTransmissionDevice feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'High Voltage Generation', 'A generation facility, such as a group or a single turbine, used in the generation of high volume watts.'),
    (2, 'High Voltage Service', 'A service location or load point used in the delivery of high voltage power, frequently thought of as a meter location.'),
    (3, 'High Voltage Switch', 'A switch used to control the flow of energy.'),
    (4, 'Power Transformer', 'Transformer devices represent a single electrical transformer. These devices can be by phase or polyphase.'),
    (5, 'High Voltage Section Head', NULL);
