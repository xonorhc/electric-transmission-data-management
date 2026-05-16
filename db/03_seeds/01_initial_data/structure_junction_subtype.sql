INSERT INTO domains.structure_junction_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the StructureJunction feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'Electric Station', 'A fence or gate surrounding critical facilities to maintain safety and security.'),
    (2, 'Electric High Voltage Pole', 'Electric High Voltage Poles are vertical support structures used to support High Voltage or Transmission lines. Medium Voltage and Low Voltage equipment can be associated this feature type.'),
    (3, 'Marker', 'Markers are types of structures used to warn of the location of power lines. These are frequently used for high voltage power lines or where medium voltage or higher voltage lines cross water bodies where boat booms could potentially come in contact with power lines.');
