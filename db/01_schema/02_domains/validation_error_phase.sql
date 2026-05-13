-- TABLE: validation_error_phase
CREATE TABLE IF NOT EXISTS domains.validation_error_phase (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

