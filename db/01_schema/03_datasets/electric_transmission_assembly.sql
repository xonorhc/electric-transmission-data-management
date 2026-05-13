-- TABLE: electric_transmission_assembly_subtype
CREATE TABLE IF NOT EXISTS domains.electric_transmission_assembly_subtype (
    code smallint,
    name varchar(64) NOT NULL,
    details varchar(2000),
    PRIMARY KEY (code)
);

INSERT INTO domains.electric_transmission_assembly_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the ElectricTransmissionAssembly feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'High Voltage Bay', 'A collection of equipment used in High Voltage Bay');

-- TABLE: electric_transmission_assembly
CREATE TABLE IF NOT EXISTS utility_network.electric_transmission_assembly (
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL, -- Index
    object_id serial, -- Index
    asset_id varchar(64),
    asset_group smallint DEFAULT 0 NOT NULL, -- Subtype
    asset_type smallint DEFAULT 0 NOT NULL,
    association_status smallint DEFAULT 0 NOT NULL,
    supported_subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    construction_status smallint DEFAULT 6 NOT NULL,
    lifecycle_status smallint DEFAULT 2 NOT NULL,
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    shape geometry(point, 4326) NOT NULL, -- Index
    symbol_rotation smallint DEFAULT 0 CHECK (symbol_rotation BETWEEN 0 AND 359),
    PRIMARY KEY (object_id),
    FOREIGN KEY (asset_group) REFERENCES domains.electric_transmission_assembly_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (association_status) REFERENCES domains.network_6_associationstatus (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (construction_status) REFERENCES domains.construction_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (lifecycle_status) REFERENCES domains.lifecycle_status (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- COMMENT:
COMMENT ON TABLE utility_network.electric_transmission_assembly IS 'The Assembly feature class represents complex point features which contain other devices and lines. Like device features, assembly features are compact features but they differ in that assemblies contain other significant devices. Assemblies are useful to show a single symbol on the map yet model the internal features and their connections. Assemblies can contain devices, lines, and junctions. You can view the internal features of an assembly on the map or in the diagram view.';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.global_id IS 'Globally unique Identifier across geodatabases';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.object_id IS 'A unique, not null integer field used to uniquely identify rows in tables in a geodatabase.';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.asset_id IS 'The Asset ID or Facilit ID of the equipment';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.asset_group IS 'The main classification of a utility element.';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.asset_type IS 'A class that refines a utility elements classification within an asset group.';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.association_status IS 'Indicates the type of association a feature or object participates in.';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.construction_status IS 'Used to indicate if the eqiupment is Gang Operable and/or Phase Operable';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.lifecycle_status IS 'The status of the feature in relation to tracing';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.created_user IS 'The portal or dbms user that created the feature or object, per editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.created_date IS 'The date the object or feature was created per editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.last_edited_user IS 'The last user to edit this feature according to editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.last_edited_date IS 'The date this object or feature was last edited according to editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.shape IS 'Geometry of the feature';
COMMENT ON COLUMN utility_network.electric_transmission_assembly.symbol_rotation IS 'The angle the symbol should be rotated by';

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_assembly (supported_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_assembly USING gist (shape);

