ALTER TABLE borrowings ADD COLUMN IF NOT EXISTS branch_id bigint default 1 not null;

alter table borrowings
  add constraint borrowings_branch_id_fkey
foreign key (branch_id) references branches (id);