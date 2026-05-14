INSERT INTO domains.validation_status (code, description)
VALUES
    (0, 'No calculation required, no validation required, no error'),
    (1, 'No calculation required, no validation required, has error(s)'),
    (2, 'No calculation required, validation required, no error'),
    (3, 'No calculation required, validation required, has error(s)'),
    (4, 'Calculation required, no validation required, no error'),
    (5, 'Calculation required, no validation required, has error(s)'),
    (6, 'Calculation required, validation required, no error'),
    (7, 'Calculation required, validation required, has error(s)');

