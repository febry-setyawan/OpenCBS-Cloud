ALTER TABLE users ADD COLUMN IF NOT EXISTS branch_id integer;
alter table users
    add constraint users_branch_id_fkey foreign key (branch_id) references branches (id);