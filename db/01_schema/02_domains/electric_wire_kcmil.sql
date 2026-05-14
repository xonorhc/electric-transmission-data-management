-- DOMAIN: electric_wire_kcmil
CREATE DOMAIN domains.electric_wire_kcmil AS INTEGER CHECK (VALUE BETWEEN 250 AND 4000);

COMMENT ON DOMAIN domains.electric_wire_kcmil IS 'Wire kcmil sizes';

