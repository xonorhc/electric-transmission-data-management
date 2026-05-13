-- TABLE: asset_type_conductor_details_busbar
CREATE TABLE IF NOT EXISTS domains.asset_type_conductor_details_busbar (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

