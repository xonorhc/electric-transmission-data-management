-- DOMAIN: wire_attachment_height
CREATE DOMAIN domains.wire_attachment_height AS integer CHECK (VALUE BETWEEN 0 AND 100);

COMMENT ON DOMAIN domains.wire_attachment_height IS 'Height of attachment';

