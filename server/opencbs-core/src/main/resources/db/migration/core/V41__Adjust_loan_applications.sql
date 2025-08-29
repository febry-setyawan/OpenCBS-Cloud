-- noinspection SqlNoDataSourceInspectionForFile
ALTER TABLE loan_applications ADD COLUMN IF NOT EXISTS disbursement_date date not null;
ALTER TABLE loan_applications ADD COLUMN IF NOT EXISTS preferred_repayment_date date not null;