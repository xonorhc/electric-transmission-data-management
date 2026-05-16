-- TABLE: structure_boundary_subtype
CREATE TABLE IF NOT EXISTS domains.structure_boundary_subtype (
    code smallint,
    name varchar(64) NOT NULL,
    details varchar(2000),
    PRIMARY KEY (code)
);
