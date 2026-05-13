-- TABLE: structure_line_subtype
CREATE TABLE IF NOT EXISTS domains.structure_line_subtype (
    code smallint,
    name varchar(64),
    details varchar(2000),
    PRIMARY KEY (code)
);

INSERT INTO domains.structure_line_subtype (code, name, details)
    VALUES (0, 'Unknown', 'The Unknown asset group in the StructureLine feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.');

-- TABLE: structure_line
CREATE TABLE IF NOT EXISTS utility_network.structure_line (
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL, -- Index
    object_id integer, -- Index
    asset_id varchar(64),
    asset_group smallint DEFAULT 0 NOT NULL, -- Subtype
    asset_type smallint DEFAULT 0 NOT NULL,
    association_status smallint DEFAULT 0 NOT NULL,
    supported_subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    construction_status smallint DEFAULT 6 NOT NULL,
    validation_status smallint DEFAULT 6, -- index
    lifecycle_status smallint DEFAULT 2 NOT NULL,
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    shape geometry(multilinestring, 4326) NOT NULL, -- Index
    shape_length numeric GENERATED ALWAYS AS (round(st_length (shape::geography)::numeric, 2)) STORED, -- Length
    flow_direction smallint DEFAULT 1,
    PRIMARY KEY (object_id),
    FOREIGN KEY (asset_group) REFERENCES domains.structure_line_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (association_status) REFERENCES domains.network_6_associationstatus (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (construction_status) REFERENCES domains.construction_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (validation_status) REFERENCES domains.validation_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (lifecycle_status) REFERENCES domains.lifecycle_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (flow_direction) REFERENCES domains.network_6_flowdirection (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- COMMENT:
COMMENT ON TABLE utility_network.structure_line IS 'The Structure Line contain lines which carry a resource. Structure lines participating as containers can contain other structure lines.';
COMMENT ON COLUMN utility_network.structure_line.global_id IS 'Globally unique Identifier across geodatabases';
COMMENT ON COLUMN utility_network.structure_line.object_id IS 'A unique, not null integer field used to uniquely identify rows in tables in a geodatabase.';
COMMENT ON COLUMN utility_network.structure_line.asset_id IS 'The Asset ID or Facilit ID of the equipment';
COMMENT ON COLUMN utility_network.structure_line.asset_group IS 'The main classification of a utility element.';
COMMENT ON COLUMN utility_network.structure_line.asset_type IS 'A class that refines a utility elements classification within an asset group.';
COMMENT ON COLUMN utility_network.structure_line.association_status IS 'Indicates the type of association a feature or object participates in.';
COMMENT ON COLUMN utility_network.structure_line.supported_subnetwork_name IS 'a list of subnetwork names that the feature either has an attachment to or contains elements from';
COMMENT ON COLUMN utility_network.structure_line.construction_status IS 'Used to indicate if the eqiupment is Gang Operable and/or Phase Operable';
COMMENT ON COLUMN utility_network.structure_line.lifecycle_status IS 'The status of the feature in relation to tracing';
COMMENT ON COLUMN utility_network.structure_line.created_user IS 'The portal or dbms user that created the feature or object, per editor tracking';
COMMENT ON COLUMN utility_network.structure_line.created_date IS 'The date the object or feature was created per editor tracking';
COMMENT ON COLUMN utility_network.structure_line.last_edited_user IS 'The last user to edit this feature according to editor tracking';
COMMENT ON COLUMN utility_network.structure_line.last_edited_date IS 'The date this object or feature was last edited according to editor tracking';
COMMENT ON COLUMN utility_network.structure_line.shape IS 'Geometry of the feature';

-- INDEX:
CREATE INDEX ON utility_network.structure_line (validation_status);
CREATE INDEX ON utility_network.structure_line (supported_subnetwork_name);
CREATE INDEX ON utility_network.structure_line USING gist (shape);
