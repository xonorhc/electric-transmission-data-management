-- TABLE: electric_transmission_device
CREATE TABLE IF NOT EXISTS utility_network.electric_transmission_device (
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL, -- Index
    object_id integer, -- Index
    asset_id varchar(64),
    asset_group smallint DEFAULT 0 NOT NULL, -- Subtype
    asset_type smallint DEFAULT 0 NOT NULL,
    association_status smallint DEFAULT 0 NOT NULL,
    supported_subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    construction_status smallint DEFAULT 6 NOT NULL,
    validation_status smallint DEFAULT 6, -- Index
    lifecycle_status smallint DEFAULT 2 NOT NULL,
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    shape geometry(point, 4326) NOT NULL, -- Index
    symbol_rotation smallint DEFAULT 0 CHECK (symbol_rotation BETWEEN 0 AND 259),
    is_subnetwork_controller boolean DEFAULT false NOT NULL,
    is_connected smallint DEFAULT 2 NOT NULL,
    subnetwork_controller_name varchar(2000) DEFAULT 'Unknown' NOT NULL, -- Index
    tier_name smallint DEFAULT 0 NOT NULL,
    tier_rank bigint DEFAULT 0 NOT NULL,
    terminal_path varchar(128) DEFAULT 'Default' NOT NULL,
    subnetwork_name varchar(2000) DEFAULT 'Unknown' NOT NULL, -- Index
    supporting_subnetwork_name varchar(2000) DEFAULT 'Unknown' NOT NULL, -- Index
    normal_status smallint,
    phases_normal smallint DEFAULT 0 NOT NULL,
    primary_nominal_voltage_ll bigint,
    secondary_voltage_line_to_line bigint,
    secondary_voltage_line_to_ground bigint,
    secondary_winding_grounding smallint,
    tertiary_voltage_line_to_line bigint,
    tertiary_voltage_line_to_ground bigint,
    tertiary_winding_grounding smallint,
    maximum_voltage bigint DEFAULT 0,
    maximum_operating_voltage bigint DEFAULT 0,
    peak_load bigint,
    rated_power bigint,
    primary_to_secondary_winding_vector_group smallint,
    primary_to_tertiary_winding_vector_group smallint,
    section_id varchar(2000),
    section_terminal smallint,
    is_riser boolean DEFAULT FALSE,
    section_start_or_end_indicator smallint,
    istap boolean DEFAULT FALSE,
    PRIMARY KEY (object_id),
    FOREIGN KEY (asset_group) REFERENCES domains.electric_transmission_device_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (association_status) REFERENCES domains.network_6_associationstatus (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (construction_status) REFERENCES domains.construction_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (validation_status) REFERENCES domains.validation_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (lifecycle_status) REFERENCES domains.lifecycle_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (is_connected) REFERENCES domains.network_6_isconnected (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (tier_name) REFERENCES domains.network_6_tiername (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (normal_status) REFERENCES domains.electric_operating_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (primary_nominal_voltage_ll) REFERENCES domains.electrictransmission_combined_nominal_voltage_ll (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (secondary_voltage_line_to_line) REFERENCES domains.electrictransmission_combined_nominal_voltage_ll (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (secondary_voltage_line_to_ground) REFERENCES domains.electrictransmission_combined_nominal_voltage_lg (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (secondary_winding_grounding) REFERENCES domains.electric_ground_configuration_transformer_regulator (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (tertiary_voltage_line_to_line) REFERENCES domains.electrictransmission_combined_nominal_voltage_ll (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (tertiary_voltage_line_to_ground) REFERENCES domains.electrictransmission_combined_nominal_voltage_lg (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (tertiary_winding_grounding) REFERENCES domains.electric_ground_configuration_transformer_regulator (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (maximum_voltage) REFERENCES domains.electrictransmission_combined_maximum_voltage (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (maximum_operating_voltage) REFERENCES domains.electrictransmission_combined_maximumm_operating_voltage_ll (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (rated_power) REFERENCES domains.electric_combined_bank_power_units (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (section_start_or_end_indicator) REFERENCES domains.electrictransmission_section_indicator (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_device (validation_status);
CREATE INDEX ON utility_network.electric_transmission_device (subnetwork_controller_name);
CREATE INDEX ON utility_network.electric_transmission_device (subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_device (supported_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_device (supporting_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_device USING gist (shape);
