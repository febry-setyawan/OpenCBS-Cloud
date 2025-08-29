ALTER TABLE loan_applications_payees ADD COLUMN IF NOT EXISTS closed_at timestamp null;

ALTER TABLE loan_applications_payees ADD COLUMN IF NOT EXISTS closed_by_id bigint null;