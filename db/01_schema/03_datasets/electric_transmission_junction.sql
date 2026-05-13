-- TABLE: electric_transmission_junction_subtype
CREATE TABLE IF NOT EXISTS domains.electric_transmission_junction_subtype (
    code smallint,
    name varchar(64) NOT NULL,
    details varchar(2000),
    PRIMARY KEY (code)
);

INSERT INTO domains.electric_transmission_junction_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the ElectricTransmissionJunction feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'High Voltage Attachment', 'Points on High voltage lines where structures would attach.'),
    (2, 'High Voltage Connection Point', 'Points where electric cables connect, but no device exists, like a Tap.');

-- TABLE: electric_transmission_junction
CREATE TABLE IF NOT EXISTS utility_network.electric_transmission_junction (
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL, -- Index
    object_id integer, -- Index
    asset_id varchar(64),
    asset_group smallint DEFAULT 0 NOT NULL, -- Subtype
    asset_type smallint DEFAULT 0 NOT NULL,
    association_status smallint DEFAULT 0 NOT NULL,
    subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    supported_subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    supporting_subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    construction_status smallint DEFAULT 6 NOT NULL,
    validation_status smallint DEFAULT 6,
    lifecycle_status smallint DEFAULT 2 NOT NULL,
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    shape geometry(point, 4326) NOT NULL, -- Index
    symbol_rotation smallint DEFAULT 0 CHECK (symbol_rotation BETWEEN 0 AND 359),
    is_connected smallint DEFAULT 2 NOT NULL,
    phases_normal smallint DEFAULT 0 NOT NULL,
    is_riser boolean DEFAULT FALSE,
    section_id varchar(2000),
    PRIMARY KEY (object_id),
    FOREIGN KEY (asset_group) REFERENCES domains.electric_transmission_junction_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (association_status) REFERENCES domains.network_6_associationstatus (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (construction_status) REFERENCES domains.construction_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (validation_status) REFERENCES domains.validation_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (lifecycle_status) REFERENCES domains.lifecycle_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (is_connected) REFERENCES domains.network_6_isconnected(code) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- COMMENT:
COMMENT ON TABLE utility_network.electric_transmission_junction IS 'The Junction class represents locations where lines connect to lines or lines connect to devices. A key use for junction features is to allow devices or lines to connect to another line at an intermediate vertex. You can think of a junction as glue point at key places to connect all the features of a utility network. Junctions can be contained within assemblies.';
COMMENT ON COLUMN utility_network.electric_transmission_junction.global_id IS 'Globally unique Identifier across geodatabases';
COMMENT ON COLUMN utility_network.electric_transmission_junction.object_id IS 'A unique, not null integer field used to uniquely identify rows in tables in a geodatabase.';
COMMENT ON COLUMN utility_network.electric_transmission_junction.asset_id IS 'The Asset ID or Facilit ID of the equipment';
COMMENT ON COLUMN utility_network.electric_transmission_junction.asset_group IS 'The main classification of a utility element.';
COMMENT ON COLUMN utility_network.electric_transmission_junction.asset_type IS 'A class that refines a utility elements classification within an asset group.';
COMMENT ON COLUMN utility_network.electric_transmission_junction.association_status IS 'Indicates the type of association a feature or object participates in.';
COMMENT ON COLUMN utility_network.electric_transmission_junction.subnetwork_name IS 'a list of subnetwork names that the feature participates in';
COMMENT ON COLUMN utility_network.electric_transmission_junction.supported_subnetwork_name IS 'a list of subnetwork names that the feature either has an attachment to or contains elements from';
COMMENT ON COLUMN utility_network.electric_transmission_junction.supporting_subnetwork_name IS 'a list of subnetwork names that the feature is contained in';
COMMENT ON COLUMN utility_network.electric_transmission_junction.construction_status IS 'Used to indicate if the eqiupment is Gang Operable and/or Phase Operable';
COMMENT ON COLUMN utility_network.electric_transmission_junction.lifecycle_status IS 'The status of the feature in relation to tracing';
COMMENT ON COLUMN utility_network.electric_transmission_junction.created_user IS 'The portal or dbms user that created the feature or object, per editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_junction.created_date IS 'The date the object or feature was created per editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_junction.last_edited_user IS 'The last user to edit this feature according to editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_junction.last_edited_date IS 'The date this object or feature was last edited according to editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_junction.shape IS 'Geometry of the feature';
COMMENT ON COLUMN utility_network.electric_transmission_junction.symbol_rotation IS 'The angle the symbol should be rotated by';
COMMENT ON COLUMN utility_network.electric_transmission_junction.is_connected IS 'An indicator that an object is connected to a subnetwork in the utility network and can be used to identify isolated objects';
COMMENT ON COLUMN utility_network.electric_transmission_junction.supporting_subnetwork_name IS 'a list of subnetwork names that the feature is contained in';
COMMENT ON COLUMN utility_network.electric_transmission_junction.phases_normal IS 'The phases resulting from Normal switching states';
COMMENT ON COLUMN utility_network.electric_transmission_junction.is_riser IS 'Indicates that this equipment also acts as a riser or dip';
COMMENT ON COLUMN utility_network.electric_transmission_junction.section_id IS 'The Electrical Section this equipment is associated with';

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_junction (validation_status);
CREATE INDEX ON utility_network.electric_transmission_junction (subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_junction (supported_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_junction (supporting_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_junction USING gist (shape);

