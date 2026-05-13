-- TABLE: yes_no
CREATE TABLE IF NOT EXISTS domains.yes_no (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

