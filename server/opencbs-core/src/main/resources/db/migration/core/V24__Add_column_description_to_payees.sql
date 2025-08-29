-- noinspection SqlNoDataSourceInspectionForFile
ALTER TABLE payees ADD COLUMN IF NOT EXISTS description varchar(255) not null;