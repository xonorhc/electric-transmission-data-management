-- TABLE: structure_junction_subtype
CREATE TABLE IF NOT EXISTS domains.structure_junction_subtype (
    code smallint,
    name varchar(64) NOT NULL,
    details varchar(2000),
    PRIMARY KEY (code)
);
