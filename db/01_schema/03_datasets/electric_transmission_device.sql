-- TABLE: utility_network.electric_transmission_device_subtype
CREATE TABLE IF NOT EXISTS domains.electric_transmission_device_subtype (
    code smallint,
    name varchar(64) NOT NULL,
    details varchar(2000),
    PRIMARY KEY (code)
);

INSERT INTO domains.electric_transmission_device_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the ElectricTransmissionDevice feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'High Voltage Generation', 'A generation facility, such as a group or a single turbine, used in the generation of high volume watts.'),
    (2, 'High Voltage Service', 'A service location or load point used in the delivery of high voltage power, frequently thought of as a meter location.'),
    (3, 'High Voltage Switch', 'A switch used to control the flow of energy.'),
    (4, 'Power Transformer', 'Transformer devices represent a single electrical transformer. These devices can be by phase or polyphase.'),
    (5, 'High Voltage Section Head', NULL);

-- TABLE: utility_network.electric_transmission_device
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

-- COMMENT:
COMMENT ON TABLE utility_network.electric_transmission_device IS 'The Device feature class represents features through which your utility resource flows and devices can affect your resource in several ways. Devices can optionally have terminals when there are distinct entry points to the device. Devices can be connected to other devices, junctions, and lines. Devices can be contained within assemblies.';
COMMENT ON COLUMN utility_network.electric_transmission_device.global_id IS 'Globally unique Identifier across geodatabases';
COMMENT ON COLUMN utility_network.electric_transmission_device.object_id IS 'A unique, not null integer field used to uniquely identify rows in tables in a geodatabase.';
COMMENT ON COLUMN utility_network.electric_transmission_device.asset_id IS 'The Asset ID or Facilit ID of the equipment';
COMMENT ON COLUMN utility_network.electric_transmission_device.asset_group IS 'The main classification of a utility element.';
COMMENT ON COLUMN utility_network.electric_transmission_device.asset_type IS 'A class that refines a utility elements classification within an asset group.';
COMMENT ON COLUMN utility_network.electric_transmission_device.association_status IS 'Indicates the type of association a feature or object participates in.';
COMMENT ON COLUMN utility_network.electric_transmission_device.supported_subnetwork_name IS 'a list of subnetwork names that the feature either has an attachment to or contains elements from';
COMMENT ON COLUMN utility_network.electric_transmission_device.construction_status IS 'Used to indicate if the eqiupment is Gang Operable and/or Phase Operable';
COMMENT ON COLUMN utility_network.electric_transmission_device.lifecycle_status IS 'The status of the feature in relation to tracing';
COMMENT ON COLUMN utility_network.electric_transmission_device.created_user IS 'The portal or dbms user that created the feature or object, per editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_device.created_date IS 'The date the object or feature was created per editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_device.last_edited_user IS 'The last user to edit this feature according to editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_device.last_edited_date IS 'The date this object or feature was last edited according to editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_device.shape IS 'Geometry of the feature';
COMMENT ON COLUMN utility_network.electric_transmission_device.symbol_rotation IS 'The angle the symbol should be rotated by';
COMMENT ON COLUMN utility_network.electric_transmission_device.is_connected IS 'An indicator that an object is connected to a subnetwork in the utility network and can be used to identify isolated objects';
COMMENT ON COLUMN utility_network.electric_transmission_device.is_subnetwork_controller IS 'An indicator that an object is a subnetwork controller in the utility network';
COMMENT ON COLUMN utility_network.electric_transmission_device.subnetwork_controller_name IS 'The unique name of the subnetwork controller in the tier';
COMMENT ON COLUMN utility_network.electric_transmission_device.tier_name IS 'The name of the tier to which the subnetwork belongs';
COMMENT ON COLUMN utility_network.electric_transmission_device.tier_rank IS 'The rank number assigned to the tier to which the subnetwork belongs';
COMMENT ON COLUMN utility_network.electric_transmission_device.terminal_path IS 'terminal configuration used which defines the terminals and the paths between them';
COMMENT ON COLUMN utility_network.electric_transmission_device.subnetwork_name IS 'a list of subnetwork names that the feature participates in';
COMMENT ON COLUMN utility_network.electric_transmission_device.supporting_subnetwork_name IS 'a list of subnetwork names that the feature is contained in';
COMMENT ON COLUMN utility_network.electric_transmission_device.normal_status IS 'The normal state for a swtichable device';
COMMENT ON COLUMN utility_network.electric_transmission_device.phases_normal IS 'The phases resulting from Normal switching states';
COMMENT ON COLUMN utility_network.electric_transmission_device.primary_nominal_voltage_ll IS 'The named line to line voltage measured in Volts';
COMMENT ON COLUMN utility_network.electric_transmission_device.secondary_voltage_line_to_line IS 'The named Secondary line to line voltage measured in Volts';
COMMENT ON COLUMN utility_network.electric_transmission_device.secondary_voltage_line_to_ground IS 'The named Secondary line to neutral or ground measured in Voltage';
COMMENT ON COLUMN utility_network.electric_transmission_device.secondary_winding_grounding IS 'Attribute to define the AC system grounding type of Delta or Wye on the Secondary Winding';
COMMENT ON COLUMN utility_network.electric_transmission_device.tertiary_voltage_line_to_line IS 'The named Tertiary line to line voltage measured in Volts';
COMMENT ON COLUMN utility_network.electric_transmission_device.tertiary_voltage_line_to_ground IS 'The named Tertiary line to neutral or ground measured in Voltage';
COMMENT ON COLUMN utility_network.electric_transmission_device.tertiary_winding_grounding IS 'Attribute to define the AC system grounding type of Delta or Wye on the Tertiary winding';
COMMENT ON COLUMN utility_network.electric_transmission_device.maximum_voltage IS 'The maximum voltage the equipment can sustain';
COMMENT ON COLUMN utility_network.electric_transmission_device.maximum_operating_voltage IS 'The maximum voltage the equipment can be reliable operated at';
COMMENT ON COLUMN utility_network.electric_transmission_device.peak_load IS 'The maximum sustained load experienced by a power consumer';
COMMENT ON COLUMN utility_network.electric_transmission_device.rated_power IS 'The Rated Power for the equipment';
COMMENT ON COLUMN utility_network.electric_transmission_device.primary_to_secondary_winding_vector_group IS 'The IEC category used to describe the winding configurations and phase angle differences between the Primary and Secondary windings of a three phase transformer';
COMMENT ON COLUMN utility_network.electric_transmission_device.primary_to_tertiary_winding_vector_group IS 'The IEC category used to describe the winding configurations and phase angle differences between the Primary and Tertiary windings of a three phase transformer';
COMMENT ON COLUMN utility_network.electric_transmission_device.section_id IS 'The Electrical Section this equipment is associated with';
COMMENT ON COLUMN utility_network.electric_transmission_device.section_terminal IS 'The UN terminal used for this section';
COMMENT ON COLUMN utility_network.electric_transmission_device.is_riser IS 'Indicates that this equipment also acts as a riser or dip';
COMMENT ON COLUMN utility_network.electric_transmission_device.section_start_or_end_indicator IS 'Indicates that this equipment is the start of a section';

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_device (validation_status);
CREATE INDEX ON utility_network.electric_transmission_device (subnetwork_controller_name);
CREATE INDEX ON utility_network.electric_transmission_device (subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_device (supported_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_device (supporting_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_device USING gist (shape);

