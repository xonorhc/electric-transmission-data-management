-- PERF: Create trigger created_user on all tables in water_system
DO $$
DECLARE
    mytables record;
BEGIN
    FOR mytables IN
    SELECT
        table_schema,
        table_name
    FROM
        information_schema.tables
    WHERE
        table_schema = 'utility_network'
        AND table_name NOT LIKE ('electric_transmission_line_transmission_conductor_details')
            LOOP
                EXECUTE format('ALTER TABLE %2$I.%1$I
                        ADD COLUMN IF NOT EXISTS created_date timestamptz,
                        ADD COLUMN IF NOT EXISTS created_user varchar(64);
                ', mytables.table_name, mytables.table_schema);

                EXECUTE format('CREATE OR REPLACE TRIGGER created_user
                        BEFORE INSERT ON %2$I.%1$I
                        FOR EACH ROW
                        EXECUTE FUNCTION created_user ();
                ', mytables.table_name, mytables.table_schema);
            END LOOP;
END
$$;

-- PERF: Create trigger last_edited_user on all tables in water_system
DO $$
DECLARE
    mytables record;
BEGIN
    FOR mytables IN
    SELECT
        table_schema,
        table_name
    FROM
        information_schema.tables
    WHERE
        table_schema = 'utility_network'
        AND table_name NOT LIKE ('electric_transmission_line_transmission_conductor_details')
            LOOP
                EXECUTE format('ALTER TABLE %2$I.%1$I
                        ADD COLUMN IF NOT EXISTS last_edited_date timestamptz,
                        ADD COLUMN IF NOT EXISTS last_edited_user varchar(20);
                ', mytables.table_name, mytables.table_schema);

                EXECUTE format('CREATE OR REPLACE TRIGGER last_edited_user
                        BEFORE UPDATE ON %2$I.%1$I
                        FOR EACH ROW
                        EXECUTE FUNCTION last_edited_user ();
                ', mytables.table_name, mytables.table_schema);
            END LOOP;
END
$$;
