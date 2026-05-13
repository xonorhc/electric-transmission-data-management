-- TABLE: electric_operating_status
CREATE TABLE IF NOT EXISTS domains.electric_operating_status (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

