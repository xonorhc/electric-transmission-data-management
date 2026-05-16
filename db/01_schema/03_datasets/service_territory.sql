-- TABLE: service_territory
CREATE TABLE IF NOT EXISTS utility_network.service_territory (
    global_id uuid DEFAULT gen_random_uuid () UNIQUE NOT NULL, -- Index
    object_id integer, -- Index
    created_user varchar(64), -- Creator
    created_date timestamptz, -- Created
    last_edited_user varchar(64), -- Editor
    last_edited_date timestamptz, -- Edited
    shape geometry(polygon, 4326) NOT NULL, -- Index
    shape_area numeric GENERATED ALWAYS AS (round(st_area (shape::geography)::numeric, 2)) STORED,
    shape_perimeter numeric GENERATED ALWAYS AS (round(st_perimeter (shape::geography)::numeric, 2)) STORED,
    company_name varchar(64),
    district_name varchar(64),
    PRIMARY KEY (object_id)
);

-- INDEX:
CREATE INDEX ON utility_network.service_territory USING gist (shape);
