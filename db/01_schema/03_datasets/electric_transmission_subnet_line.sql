-- TABLE: electric_transmission_subnet_line
CREATE TABLE IF NOT EXISTS utility_network.electric_transmission_subnet_line (
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL, -- Index
    object_id serial,
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    shape geometry(multilinestring, 4326) NOT NULL, -- Index
    shape_length numeric GENERATED ALWAYS AS (round(st_length (shape::geography)::numeric, 2)) STORED, -- Length
    subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL,
    is_dirty smallint NOT NULL,
    tier_name smallint NOT NULL DEFAULT 0, -- Subtype
    subnetwork_controller_names varchar(2000) DEFAULT 'Unknown' NOT NULL,
    last_update_subnetwork date,
    last_ack_export_subnetwork date,
    PRIMARY KEY (object_id),
    FOREIGN KEY (is_dirty) REFERENCES domains.network_6_isdirty (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (tier_name) REFERENCES domains.electric_transmission_subnet_line_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_subnet_line USING gist (shape);
CREATE INDEX ON utility_network.electric_transmission_subnet_line (shape_length);
