ALTER TABLE guarantors ADD COLUMN IF NOT EXISTS created_at timestamp without time zone null;

ALTER TABLE guarantors ADD COLUMN IF NOT EXISTS created_by_id bigint not null default 1;

alter table guarantors
  add constraint guarantors_created_by_id_fkey foreign key (created_by_id) references users (id);

ALTER TABLE guarantors ADD COLUMN IF NOT EXISTS closed_at timestamp without time zone null;

ALTER TABLE guarantors ADD COLUMN IF NOT EXISTS closed_by_id bigint null default 1;

alter table guarantors
  add constraint guarantors_closed_by_id_fkey foreign key (closed_by_id) references users (id);

--------------------------------------------------------------

ALTER TABLE collaterals ADD COLUMN IF NOT EXISTS created_at timestamp without time zone null;

ALTER TABLE collaterals ADD COLUMN IF NOT EXISTS closed_at timestamp without time zone null;

ALTER TABLE collaterals ADD COLUMN IF NOT EXISTS closed_by_id bigint null default 1;

alter table collaterals
  add constraint collaterals_closed_by_id_fkey foreign key (closed_by_id) references users (id);