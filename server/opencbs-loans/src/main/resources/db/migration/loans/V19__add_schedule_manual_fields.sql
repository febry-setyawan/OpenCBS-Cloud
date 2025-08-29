ALTER TABLE loans
    ADD COLUMN IF NOT EXISTS schedule_manual_edited BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS schedule_manual_edited_at TIMESTAMP WITHOUT TIME ZONE,
    ADD COLUMN IF NOT EXISTS schedule_manual_edited_by_id BIGINT;


ALTER TABLE loans
    ADD CONSTRAINT IF NOT EXISTS schedule_manual_edited_by_id_fkey
        FOREIGN KEY (schedule_manual_edited_by_id) REFERENCES users(id);
