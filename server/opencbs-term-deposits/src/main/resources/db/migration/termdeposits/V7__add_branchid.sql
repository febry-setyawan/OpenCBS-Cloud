ALTER TABLE term_deposits ADD COLUMN IF NOT EXISTS branch_id bigint default 1 not null;

alter table term_deposits
  add constraint term_deposits_branch_id_fkey
foreign key (branch_id) references branches (id);