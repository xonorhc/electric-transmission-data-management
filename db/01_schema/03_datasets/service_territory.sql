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

-- COMMENT:
COMMENT ON TABLE utility_network.service_territory IS 'The networks service territory that represents the operational area of the utility.';
COMMENT ON COLUMN utility_network.service_territory.global_id IS 'Globally unique Identifier across geodatabases';
COMMENT ON COLUMN utility_network.service_territory.object_id IS 'A unique, not null integer field used to uniquely identify rows in tables in a geodatabase.';
COMMENT ON COLUMN utility_network.service_territory.created_user IS 'The portal or dbms user that created the feature or object, per editor tracking';
COMMENT ON COLUMN utility_network.service_territory.created_date IS 'The date the object or feature was created per editor tracking';
COMMENT ON COLUMN utility_network.service_territory.last_edited_user IS 'The last user to edit this feature according to editor tracking';
COMMENT ON COLUMN utility_network.service_territory.last_edited_date IS 'The date this object or feature was last edited according to editor tracking';
COMMENT ON COLUMN utility_network.service_territory.shape IS 'Geometry of the feature';
COMMENT ON COLUMN utility_network.service_territory.company_name IS 'The company name of this service area polygon';
COMMENT ON COLUMN utility_network.service_territory.district_name IS 'The name of the district ';

-- INDEX:
CREATE INDEX ON utility_network.service_territory USING gist (shape);

