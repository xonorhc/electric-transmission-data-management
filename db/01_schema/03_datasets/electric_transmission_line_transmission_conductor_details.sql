-- TABLE: electric_transmission_line_transmission_conductor_details
CREATE TABLE IF NOT EXISTS utility_network.electric_transmission_line_transmission_conductor_details (
    rule_id smallint,
    origin_subtype varchar(64) NOT NULL,
    origin_min_cardinality smallint DEFAULT 0,
    origin_max_cardinality smallint DEFAULT 10,
    destination_subtype varchar(64) NOT NULL,
    destination_min_cardinality smallint DEFAULT 0,
    destination_max_cardinality smallint DEFAULT 10,
    PRIMARY KEY (rule_id)
);

INSERT INTO utility_network.electric_transmission_line_transmission_conductor_details (rule_id, origin_subtype, origin_min_cardinality, origin_max_cardinality, destination_subtype, destination_min_cardinality, destination_max_cardinality)
VALUES
    (1, 'High Voltage Busbar', 0, 10, 'Busbar', 0, 10),
    (2, 'High Voltage Overhead Conductor', 0, 10, 'Aerial Bare', 0, 10),
    (3, 'High Voltage Overhead Conductor', 0, 10, 'Aerial Covered', 0, 10),
    (4, 'High Voltage Service', 0, 10, 'Aerial Bare', 0, 10),
    (5, 'High Voltage Service', 0, 10, 'Aerial Covered', 0, 10),
    (6, 'High Voltage Service', 0, 10, 'Submarine', 0, 10),
    (7, 'High Voltage Service', 0, 10, 'Underground', 0, 10),
    (8, 'High Voltage Submersible Conductor', 0, 10, 'Submarine', 0, 10),
    (9, 'High Voltage Underground Conductor', 0, 10, 'Underground', 0, 10);
