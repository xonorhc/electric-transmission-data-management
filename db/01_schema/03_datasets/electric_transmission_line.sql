-- TABLE: electric_transmission_line
CREATE TABLE IF NOT EXISTS utility_network.electric_transmission_line (
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL, -- Index
    object_id integer, -- Index
    asset_id varchar(64),
    asset_group smallint DEFAULT 0 NOT NULL, -- Subtype
    asset_type smallint DEFAULT 0 NOT NULL,
    association_status smallint DEFAULT 0 NOT NULL,
    subnetwork_name varchar(2000) DEFAULT 'Unknown', -- Index
    supported_subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    supporting_subnetwork_name varchar(2000) DEFAULT 'Unknown', -- Index
    construction_status smallint DEFAULT 6 NOT NULL,
    validation_status smallint DEFAULT 6,
    lifecycle_status smallint DEFAULT 2 NOT NULL,
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    shape geometry(multilinestring, 4326) NOT NULL,
    shape_length numeric GENERATED ALWAYS AS (round(st_length (shape::geography)::numeric, 2)) STORED, -- Length
    is_connected smallint DEFAULT 2,
    from_device_terminal smallint DEFAULT 0,
    to_device_terminal smallint DEFAULT 0,
    flow_direction smallint DEFAULT 1,
    phases_normal smallint DEFAULT 0,
    maximum_voltage bigint DEFAULT 0,
    maximum_operating_voltage bigint DEFAULT 0,
    nominal_voltage_ll bigint,
    grounding smallint,
    measured_length numeric(8, 2),
    ohm_per_length domains.electric_ohms_per_km,
    section_id varchar(2000),
    transmission_line_name varchar(2000),
    PRIMARY KEY (object_id),
    FOREIGN KEY (asset_group) REFERENCES domains.electric_transmission_line_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (association_status) REFERENCES domains.network_6_associationstatus (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (construction_status) REFERENCES domains.construction_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (validation_status) REFERENCES domains.validation_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (lifecycle_status) REFERENCES domains.lifecycle_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (is_connected) REFERENCES domains.network_6_isconnected (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (from_device_terminal) REFERENCES domains.network_6_terminalnames (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (to_device_terminal) REFERENCES domains.network_6_terminalnames (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (flow_direction) REFERENCES domains.network_6_flowdirection (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (maximum_voltage) REFERENCES domains.electrictransmission_combined_maximum_voltage (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (maximum_operating_voltage) REFERENCES domains.electrictransmission_high_voltage_maximumm_operating_voltage_ll (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (nominal_voltage_ll) REFERENCES domains.electrictransmission_combined_nominal_voltage_ll (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (grounding) REFERENCES domains.electric_ground_configuration (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_line (validation_status);
CREATE INDEX ON utility_network.electric_transmission_line (subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_line (supported_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_line (supporting_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_line USING gist (shape);
CREATE INDEX ON utility_network.electric_transmission_line (shape_length);
