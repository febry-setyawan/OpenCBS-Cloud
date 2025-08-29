-- noinspection SqlNoDataSourceInspectionForFile
ALTER TABLE tills ADD COLUMN IF NOT EXISTS "status" varchar(32) not null;

ALTER TABLE tills ADD COLUMN IF NOT EXISTS last_changed_by_id int not null;

ALTER TABLE tills ADD COLUMN IF NOT EXISTS opened_at timestamp;

ALTER TABLE tills ADD COLUMN IF NOT EXISTS closed_at timestamp;

alter table tills
  add constraint till_last_changed_by_id_fkey foreign key (last_changed_by_id) references users (id);