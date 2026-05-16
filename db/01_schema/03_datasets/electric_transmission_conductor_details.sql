-- TABLE: electric_transmission_conductor_details
CREATE TABLE IF NOT EXISTS utility_network.electric_transmission_conductor_details (
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL, -- Index
    object_id integer, -- Index
    asset_id varchar(64),
    asset_group smallint DEFAULT 0 NOT NULL, -- Subtype
    asset_type smallint DEFAULT 0 NOT NULL,
    association_status smallint DEFAULT 0 NOT NULL,
    subnetwork_name varchar(2000) DEFAULT 'Unknown' NOT NULL, -- Index
    supported_subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    supporting_subnetwork_name varchar(2000) DEFAULT 'Unknown' NOT NULL, -- Index
    construction_status smallint DEFAULT 6 NOT NULL,
    validation_status smallint DEFAULT 6, -- Index
    lifecycle_status smallint DEFAULT 2 NOT NULL,
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    phases_normal smallint DEFAULT 0 NOT NULL,
    measured_length numeric(8, 2),
    insulation_type smallint,
    Wire_type smallint,
    insulation_maximum_voltage bigint,
    impedance numeric,
    wire_number smallint,
    kcmil numeric,
    nominal_voltage_ll bigint,
    maximum_voltage bigint,
    maximum_operating_voltage bigint,
    cable_group_number smallint,
    conductor_material smallint,
    conductor_insulation_material smallint,
    conductor_diameter numeric,
    conductor_full_diameter numeric,
    conductor_insulation_thickness numeric,
    conductor_sheath_thickness numeric,
    electric_line_global_id uuid, -- Index
    PRIMARY KEY (object_id),
    FOREIGN KEY (asset_group) REFERENCES domains.electric_transmission_device_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (association_status) REFERENCES domains.network_6_associationstatus (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (construction_status) REFERENCES domains.construction_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (validation_status) REFERENCES domains.validation_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (lifecycle_status) REFERENCES domains.lifecycle_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (insulation_type) REFERENCES domains.electric_wire_insulation_type (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (kcmil) REFERENCES domains.electric_wire_diameter_in (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (nominal_voltage_ll) REFERENCES domains.electrictransmission_combined_nominal_voltage_ll (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (maximum_voltage) REFERENCES domains.electrictransmission_combined_maximum_voltage (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (maximum_operating_voltage) REFERENCES domains.electrictransmission_combined_maximumm_operating_voltage_ll (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (conductor_material) REFERENCES domains.electrictransmission_connector_material (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (conductor_diameter) REFERENCES domains.electric_wire_diameter_in (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (asset_type) REFERENCES domains.electric_transmission_conductor_details_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_line_transmission_conductor_details (electric_line_global_id);
CREATE INDEX ON utility_network.electric_transmission_line_transmission_conductor_details (global_id);
