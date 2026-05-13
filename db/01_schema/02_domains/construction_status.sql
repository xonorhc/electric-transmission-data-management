-- TABLE: construction_status
CREATE TABLE IF NOT EXISTS domains.construction_status (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

