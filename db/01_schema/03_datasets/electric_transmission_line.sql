-- TABLE: electric_transmission_line_subtype
CREATE TABLE IF NOT EXISTS domains.electric_transmission_line_subtype (
    code smallint,
    name varchar(64) NOT NULL,
    details varchar(2000),
    PRIMARY KEY (code)
);

INSERT INTO domains.electric_transmission_line_subtype (code, name, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the ElectricTransmissionLine feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'High Voltage Overhead Conductor', 'Overhead High Voltage lines represent Transmission and Sub transmission voltage cables and are typically polyphase lines that represent multiple lines per phase. Lines can be Alternating (AC) or Direct Current (DC).'),
    (2, 'High Voltage Underground Conductor', 'Underground High Voltage lines represent Transmission and Sub transmission voltage cables and are typically polyphase lines that represent multiple lines per phase. Lines can be Alternating (AC) or Direct Current (DC).'),
    (3, 'High Voltage Submersible Conductor', 'Submarine High Voltage lines represent Transmission and Sub transmission voltage cables and are typically polyphase lines that represent multiple lines per phase. Lines can be Alternating (AC) or Direct Current (DC).'),
    (4, 'High Voltage Busbar', 'Busbar is solid conductor used in substations on the high voltage side of equipment.'),
    (5, 'High Voltage Connector', 'A line used to connect equipment, but would not be considered trackable cable.'),
    (6, 'High Voltage Service', 'A High Voltage line to provide electric service');

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

-- COMMENT:
COMMENT ON TABLE utility_network.electric_transmission_line IS 'The Line feature class represents linear features. These are the lines which deliver your utility resource. Lines can be connected to other lines, junctions, and devices. Lines can be contained within assemblies.';
COMMENT ON COLUMN utility_network.electric_transmission_line.global_id IS 'Globally unique Identifier across geodatabases';
COMMENT ON COLUMN utility_network.electric_transmission_line.object_id IS 'A unique, not null integer field used to uniquely identify rows in tables in a geodatabase.';
COMMENT ON COLUMN utility_network.electric_transmission_line.asset_id IS 'The Asset ID or Facilit ID of the equipment';
COMMENT ON COLUMN utility_network.electric_transmission_line.asset_group IS 'The main classification of a utility element.';
COMMENT ON COLUMN utility_network.electric_transmission_line.asset_type IS 'A class that refines a utility elements classification within an asset group.';
COMMENT ON COLUMN utility_network.electric_transmission_line.association_status IS 'Indicates the type of association a feature or object participates in.';
COMMENT ON COLUMN utility_network.electric_transmission_line.subnetwork_name IS 'a list of subnetwork names that the feature participates in';
COMMENT ON COLUMN utility_network.electric_transmission_line.supported_subnetwork_name IS 'a list of subnetwork names that the feature either has an attachment to or contains elements from';
COMMENT ON COLUMN utility_network.electric_transmission_line.supporting_subnetwork_name IS 'a list of subnetwork names that the feature is contained in';
COMMENT ON COLUMN utility_network.electric_transmission_line.construction_status IS 'Used to indicate if the eqiupment is Gang Operable and/or Phase Operable';
COMMENT ON COLUMN utility_network.electric_transmission_line.lifecycle_status IS 'The status of the feature in relation to tracing';
COMMENT ON COLUMN utility_network.electric_transmission_line.created_user IS 'The portal or dbms user that created the feature or object, per editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_line.created_date IS 'The date the object or feature was created per editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_line.last_edited_user IS 'The last user to edit this feature according to editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_line.last_edited_date IS 'The date this object or feature was last edited according to editor tracking';
COMMENT ON COLUMN utility_network.electric_transmission_line.shape IS 'Geometry of the feature';
COMMENT ON COLUMN utility_network.electric_transmission_line.phases_normal IS 'The phases resulting from Normal switching states';
COMMENT ON COLUMN utility_network.electric_transmission_line.maximum_voltage IS 'The maximum voltage the equipment can sustain';
COMMENT ON COLUMN utility_network.electric_transmission_line.maximum_operating_voltage IS 'The maximum voltage the equipment can be reliable operated at';
COMMENT ON COLUMN utility_network.electric_transmission_line.nominal_voltage_ll IS 'The named line to line voltage measured in Volts';
COMMENT ON COLUMN utility_network.electric_transmission_line.grounding IS 'Attribute to define the AC system grounding type of Delta or Wye';
COMMENT ON COLUMN utility_network.electric_transmission_line.measured_length IS 'The actual length of the cable, duct, conduit, trench';
COMMENT ON COLUMN utility_network.electric_transmission_line.ohm_per_length IS 'The electrical resistance measured in ohms of the cable';
COMMENT ON COLUMN utility_network.electric_transmission_line.section_id IS 'The Electrical Section this equipment is associated with';

-- INDEX:
CREATE INDEX ON utility_network.electric_transmission_line (validation_status);
CREATE INDEX ON utility_network.electric_transmission_line (subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_line (supported_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_line (supporting_subnetwork_name);
CREATE INDEX ON utility_network.electric_transmission_line USING gist (shape);
CREATE INDEX ON utility_network.electric_transmission_line (shape_length);
