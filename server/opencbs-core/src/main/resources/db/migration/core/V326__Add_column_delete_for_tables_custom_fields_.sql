ALTER TABLE people_custom_fields ADD COLUMN IF NOT EXISTS deleted boolean default false;
ALTER TABLE companies_custom_fields ADD COLUMN IF NOT EXISTS deleted boolean default false;
ALTER TABLE groups_custom_fields ADD COLUMN IF NOT EXISTS deleted boolean default false;
ALTER TABLE loan_application_custom_fields ADD COLUMN IF NOT EXISTS deleted boolean default false;
ALTER TABLE branch_custom_fields ADD COLUMN IF NOT EXISTS deleted boolean default false;
ALTER TABLE types_of_collateral_custom_fields ADD COLUMN IF NOT EXISTS deleted boolean default false;