-- TABLE: electric_transmission_conductor_details_subtype
CREATE TABLE IF NOT EXISTS domains.electric_transmission_conductor_details_subtype (
    code smallint,
    name varchar(64) NOT NULL,
    details varchar(2000),
    PRIMARY KEY (code)
);
