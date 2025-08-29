alter table loan_products
  drop column penalty_type;
ALTER TABLE loan_products ADD COLUMN IF NOT EXISTS loan_amount decimal,
  add column olb decimal,
  add column overdue_principal decimal,
  add column overdue_interest decimal;

ALTER TABLE loans ADD COLUMN IF NOT EXISTS loan_amount decimal,
  add column olb decimal,
  add column overdue_principal decimal,
  add column overdue_interest decimal;

ALTER TABLE loan_applications ADD COLUMN IF NOT EXISTS loan_amount decimal,
  add column olb decimal,
  add column overdue_principal decimal,
  add column overdue_interest decimal;

insert into global_settings(name, type, "value")
values ('PENALTY_ACCRUAL', 'TEXT', 'standardPenaltyCalculationService')