-- TABLE: electric_transmission_phase_attribution_all
CREATE TABLE IF NOT EXISTS domains.electric_transmission_phase_attribution_all (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

