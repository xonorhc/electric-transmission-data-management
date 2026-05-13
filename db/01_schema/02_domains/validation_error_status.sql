-- TABLE: validation_error_status
CREATE TABLE IF NOT EXISTS domains.validation_error_status (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

