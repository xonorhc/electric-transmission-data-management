-- TABLE: electric_marker_type
CREATE TABLE IF NOT EXISTS domains.electric_marker_type (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

