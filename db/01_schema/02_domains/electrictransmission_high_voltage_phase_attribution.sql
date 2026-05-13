-- TABLE: electrictransmission_high_voltage_phase_attribution
CREATE TABLE IF NOT EXISTS domains.electrictransmission_high_voltage_phase_attribution (
    code smallint PRIMARY KEY,
    description varchar(64),
    details varchar(2000)
);

