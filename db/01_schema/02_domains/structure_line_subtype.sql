-- TABLE: structure_line_subtype
CREATE TABLE IF NOT EXISTS domains.structure_line_subtype (
    code smallint,
    name varchar(64),
    details varchar(2000),
    PRIMARY KEY (code)
);
