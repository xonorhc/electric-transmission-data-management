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
    FOREIGN KEY (is_connected) REFERENCES domains.network_6_isconnected (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_junction (validation_status);
CREATE INDEX ON utility_network.electric_transmission_junction (subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_junction (supported_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_junction (supporting_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_junction USING gist (shape);
