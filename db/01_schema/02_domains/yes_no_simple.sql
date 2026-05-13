-- TABLE: yes_no_simple
CREATE TABLE IF NOT EXISTS domains.yes_no_simple (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

