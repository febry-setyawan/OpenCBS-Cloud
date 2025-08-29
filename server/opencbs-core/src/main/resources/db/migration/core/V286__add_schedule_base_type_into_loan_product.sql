ALTER TABLE loan_products ADD COLUMN IF NOT EXISTS schedule_based_type varchar(50);
update loan_products set schedule_based_type = 'BY_INSTALLMENT';
alter table loan_products alter column schedule_based_type set not null;

ALTER TABLE audit.loan_products_history ADD COLUMN IF NOT EXISTS schedule_based_type varchar(50);

ALTER TABLE loan_applications ADD COLUMN IF NOT EXISTS maturity_date date;
ALTER TABLE loans ADD COLUMN IF NOT EXISTS maturity_date date;