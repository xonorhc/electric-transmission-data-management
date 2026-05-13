-- TABLE: attribute_rule_type
CREATE TABLE IF NOT EXISTS domains.attribute_rule_type (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

