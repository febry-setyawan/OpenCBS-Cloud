-- noinspection SqlNoDataSourceInspectionForFile
ALTER TABLE users ADD COLUMN IF NOT EXISTS time_zone_name varchar(31) not null default 'Asia/Bishkek';
