ALTER TABLE credit_committee_votes ADD COLUMN IF NOT EXISTS notes varchar(255);
ALTER TABLE credit_committee_votes ADD COLUMN IF NOT EXISTS created_at timestamp;