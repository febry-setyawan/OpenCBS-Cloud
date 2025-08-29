-- DELETE ALL ENTRY FEES --
-- Made safer: Only delete if Service Fees account exists and has child accounts

DELETE FROM accounts
WHERE parent_id = (SELECT id
                   FROM accounts
                   WHERE name = 'Service Fees')
  AND EXISTS (SELECT 1 FROM accounts WHERE name = 'Service Fees');