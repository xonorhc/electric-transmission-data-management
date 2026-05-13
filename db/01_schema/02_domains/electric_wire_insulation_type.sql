-- TABLE: electric_wire_insulation_type
CREATE TABLE IF NOT EXISTS domains.electric_wire_insulation_type (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

