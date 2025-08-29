ALTER TABLE credit_committee_amount_range ADD COLUMN IF NOT EXISTS created_at timestamp not null default now();

ALTER TABLE credit_committee_amount_range ADD COLUMN IF NOT EXISTS created_by_id integer;

update credit_committee_amount_range
set created_by_id = 1;

alter table credit_committee_amount_range
  add constraint credit_committee_amount_range_created_by_id_fkey foreign key (created_by_id) references users(id);

insert into global_settings (name, type, "value")
values ('CREDIT_COMMITTEE_MODE', 'TEXT', 'defaultCreditCommitteeService');

insert into permissions (name, "group")
values ('PRIMARY_CREDIT_COMMITTEE_MEMBER', 'Credit Committee');