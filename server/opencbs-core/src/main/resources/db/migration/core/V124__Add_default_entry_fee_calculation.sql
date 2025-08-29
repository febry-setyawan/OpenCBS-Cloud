INSERT INTO global_settings(name, type, "value")
SELECT 'ENTRY_FEE_CALCULATION', 'TEXT', 'fundAccessEntryFeeCalculationService'
WHERE NOT EXISTS (SELECT 1 FROM global_settings WHERE name = 'ENTRY_FEE_CALCULATION')