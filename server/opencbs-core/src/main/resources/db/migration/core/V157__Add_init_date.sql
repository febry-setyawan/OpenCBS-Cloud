INSERT INTO global_settings(name, type, value) 
SELECT 'start date', 'date', '2017-01-01'
WHERE NOT EXISTS (SELECT 1 FROM global_settings WHERE name = 'start date')