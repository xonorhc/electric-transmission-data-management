INSERT INTO domains.structure_boundary_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the Structure Boundary feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'Electric Substation Boundary', 'Electric Substation Boundary features are polygon features that outline of a Substation.'),
    (2, 'Electric Zone', 'An electrical area that can be used for managing switching or saftey');
