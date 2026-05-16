INSERT INTO domains.electric_transmission_junction_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the ElectricTransmissionJunction feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'High Voltage Attachment', 'Points on High voltage lines where structures would attach.'),
    (2, 'High Voltage Connection Point', 'Points where electric cables connect, but no device exists, like a Tap.');
