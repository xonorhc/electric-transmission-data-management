-- TABLE: lifecycle_combined
CREATE TABLE IF NOT EXISTS domains.lifecycle_combined (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

