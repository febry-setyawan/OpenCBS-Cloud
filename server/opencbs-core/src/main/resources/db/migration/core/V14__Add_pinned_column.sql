-- noinspection SqlNoDataSourceInspectionForFile
ALTER TABLE profile_attachments ADD COLUMN IF NOT EXISTS pinned boolean not null default false
