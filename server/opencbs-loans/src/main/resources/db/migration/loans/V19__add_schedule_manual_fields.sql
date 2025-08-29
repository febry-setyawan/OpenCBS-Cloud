ALTER TABLE loans
    ADD COLUMN IF NOT EXISTS schedule_manual_edited BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS schedule_manual_edited_at TIMESTAMP WITHOUT TIME ZONE,
    ADD COLUMN IF NOT EXISTS schedule_manual_edited_by_id BIGINT;

-- Add constraint with DO block for PostgreSQL compatibility
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints 
                   WHERE constraint_name = 'schedule_manual_edited_by_id_fkey' 
                   AND table_name = 'loans') THEN
        ALTER TABLE loans ADD CONSTRAINT schedule_manual_edited_by_id_fkey
        FOREIGN KEY (schedule_manual_edited_by_id) REFERENCES users(id);
    END IF;
END $$;
