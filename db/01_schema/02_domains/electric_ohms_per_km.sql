-- DOMAIN: electric_ohms_per_km
CREATE DOMAIN domains.electric_ohms_per_km AS integer CHECK (VALUE BETWEEN 0 AND 999999);

COMMENT ON DOMAIN domains.electric_ohms_per_km IS 'Range domain of valid values for Electric Cable resistance per KM';

