-- noinspection SqlNoDataSourceInspectionForFile
ALTER TABLE loan_applications_installments ADD COLUMN IF NOT EXISTS last_accrual_date date;