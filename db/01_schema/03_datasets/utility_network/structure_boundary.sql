-- TABLE: structure_boundary
CREATE TABLE IF NOT EXISTS domains.structure_boundary_subtype (
    code smallint,
    description varchar(64) NOT NULL,
    details varchar(2000),
    PRIMARY KEY (code)
);

INSERT INTO domains.structure_boundary_subtype (code, description, details)
VALUES
    (0, 'Unknown', 'The Unknown asset group in the Structure Boundary feature class is used for data migration and is not intended to store known assets. It does not have any rules and network properties applied to it.'),
    (1, 'Electric Substation Boundary', 'Electric Substation Boundary features are polygon features that outline of a Substation.'),
    (2, 'Electric Zone', 'An electrical area that can be used for managing switching or saftey');

CREATE TABLE IF NOT EXISTS utility_network.structure_boundary (
    object_id integer, -- Index
    asset_id varchar(64),
    asset_group smallint DEFAULT 0 NOT NULL, -- Subtype
    asset_type smallint DEFAULT 0 NOT NULL,
    association_status smallint DEFAULT 0 NOT NULL,
    supported_subnetwork_name varchar(64) DEFAULT 'Unknown' NOT NULL, -- Index
    construction_status smallint DEFAULT 6 NOT NULL,
    validation_status smallint DEFAULT 6,
    lifecycle_status smallint DEFAULT 2 NOT NULL,
    nickname varchar(64),
    maximum_kw bigint,
    contained_count smallint,
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL,
    shape geometry(polygon, 4326) NOT NULL,
    shape_area numeric GENERATED ALWAYS AS (round(st_area (shape::geography)::numeric, 2)) STORED,
    shape_perimeter numeric GENERATED ALWAYS AS (round(st_perimeter (shape::geography)::numeric, 2)) STORED,
    PRIMARY KEY (object_id),
    FOREIGN KEY (asset_group) REFERENCES domains.structure_boundary_subtype (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (association_status) REFERENCES domains.network_6_associationstatus (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (construction_status) REFERENCES domains.construction_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (validation_status) REFERENCES domains.validation_status (code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (lifecycle_status) REFERENCES domains.lifecycle_status (code) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE INDEX ON utility_network.structure_boundary (validation_status);

CREATE INDEX ON utility_network.structure_boundary (supported_subnetwork_name);

CREATE INDEX ON utility_network.structure_boundary USING gist (shape);

CREATE INDEX ON utility_network.structure_boundary (shape_area);

CREATE INDEX ON utility_network.structure_boundary (shape_perimeter);

