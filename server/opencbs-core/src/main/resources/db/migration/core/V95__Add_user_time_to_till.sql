ALTER TABLE tills ADD COLUMN IF NOT EXISTS changed_by_id INTEGER, ADD COLUMN IF NOT EXISTS open_date TIMESTAMP,
  ADD COLUMN IF NOT EXISTS close_date TIMESTAMP;

-- Add constraint with DO block for PostgreSQL compatibility
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints 
                   WHERE constraint_name = 'tills_created_by_id_fkey' 
                   AND table_name = 'tills') THEN
        ALTER TABLE tills ADD CONSTRAINT tills_created_by_id_fkey 
        FOREIGN KEY (changed_by_id) REFERENCES users (id) MATCH FULL;
    END IF;
END $$;