ALTER TABLE collaterals_custom_fields_values ADD COLUMN IF NOT EXISTS created_by_id int, ADD COLUMN IF NOT EXISTS created_at timestamp without time zone not null default now(),
  add column verified_by_id int,
  add column verified_at timestamp without time zone,
  add column status varchar(250);
alter table collaterals_custom_fields_values
  add constraint collaterals_custom_fields_values_created_at_id_fkey foreign key (created_by_id) references users (id);
alter table collaterals_custom_fields_values
  add constraint collaterals_custom_fields_values_verified_at_id_fkey foreign key (verified_by_id) references users (id);

