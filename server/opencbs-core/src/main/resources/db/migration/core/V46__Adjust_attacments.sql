-- noinspection SqlNoDataSourceInspectionForFile
alter table companies_attachments
  rename company_id to owner_id;
ALTER TABLE companies_attachments ADD COLUMN IF NOT EXISTS original_name varchar(255);

alter table loan_applications_attachments
  rename loan_application_id to owner_id;
ALTER TABLE loan_applications_attachments ADD COLUMN IF NOT EXISTS original_name varchar(255);

alter table people_attachments
  rename person_id to owner_id;
ALTER TABLE people_attachments ADD COLUMN IF NOT EXISTS original_name varchar(255);