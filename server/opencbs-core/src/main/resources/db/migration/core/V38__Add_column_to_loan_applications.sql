-- noinspection SqlNoDataSourceInspectionForFile
ALTER TABLE loan_applications ADD COLUMN IF NOT EXISTS interest_rate decimal(8, 4) not null;