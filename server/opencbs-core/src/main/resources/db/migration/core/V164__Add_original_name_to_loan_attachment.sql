alter table loan_attachments
  rename loan_id to owner_id;
ALTER TABLE loan_attachments ADD COLUMN IF NOT EXISTS original_filename varchar(255);