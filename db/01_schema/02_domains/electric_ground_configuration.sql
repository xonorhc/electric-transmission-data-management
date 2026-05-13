-- TABLE: electric_ground_configuration
CREATE TABLE IF NOT EXISTS domains.electric_ground_configuration (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

