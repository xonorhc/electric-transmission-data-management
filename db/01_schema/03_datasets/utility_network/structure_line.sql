-- TABLE: structure_line
CREATE TABLE IF NOT EXISTS domains.structure_line_subtype (
    code smallint,
    description varchar(64),
    details varchar(2000),
    PRIMARY KEY (code)
);

INSERT INTO domains.structure_line_subtype (code, description, details)
    VALUES (0, 'Unknown', 'The Unknown asset group in the StructureLine feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.');

CREATE TABLE IF NOT EXISTS utility_network.structure_line (
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
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL,
    shape geometry(multilinestring, 4326) NOT NULL, -- Index
    shape_length numeric GENERATED ALWAYS AS (round(st_length (shape::geography)::numeric, 2)) STORED, -- Length
    flow_direction smallint DEFAULT 1,
    PRIMARY KEY (global_id),
    FOREIGN KEY (asset_group) REFERENCES domains.structure_line_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (association_status) REFERENCES domains.network_6_associationstatus (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (construction_status) REFERENCES domains.construction_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (validation_status) REFERENCES domains.validation_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (lifecycle_status) REFERENCES domains.lifecycle_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (flow_direction) REFERENCES domains.network_6_flowdirection (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE INDEX ON utility_network.structure_line (validation_status);

CREATE INDEX ON utility_network.structure_line (supported_subnetwork_name);

CREATE INDEX ON utility_network.structure_line USING gist (shape);

CREATE INDEX ON utility_network.structure_line (shape_length);

