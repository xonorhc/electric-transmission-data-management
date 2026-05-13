-- TABLE: validation_error_exception
CREATE TABLE IF NOT EXISTS domains.validation_error_exception (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

