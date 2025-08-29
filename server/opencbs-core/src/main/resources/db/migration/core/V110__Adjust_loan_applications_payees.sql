alter table loan_applications_payees rename disbursement_date to planned_disbursement_date;
ALTER TABLE loan_applications_payees ADD COLUMN IF NOT EXISTS disbursement_date date,
  add column status varchar(40);