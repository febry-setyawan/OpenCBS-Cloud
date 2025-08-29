alter table groups_members
    add join_date timestamp not null default now();

alter table groups_members
    add left_date timestamp;

ALTER TABLE groups_members ADD COLUMN IF NOT EXISTS id bigserial primary key;