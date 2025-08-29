ALTER TABLE loan_applications ADD COLUMN IF NOT EXISTS branch_id bigint default 1 not null;

alter table loan_applications
    add constraint loan_applications_branch_id_fkey
foreign key (branch_id) references branches (id);

ALTER TABLE loans ADD COLUMN IF NOT EXISTS branch_id bigint default 1 not null;

alter table loans
  add constraint loans_branch_id_fkey
foreign key (branch_id) references branches (id);

ALTER TABLE day_closures ADD COLUMN IF NOT EXISTS branch_id bigint default 1 not null;

alter table day_closures
  add constraint day_closures_branch_id_fkey
foreign key (branch_id) references branches (id);

ALTER TABLE day_closure_contracts ADD COLUMN IF NOT EXISTS branch_id bigint default 1 not null;

alter table day_closure_contracts
  add constraint day_closure_contracts_branch_id_fkey
foreign key (branch_id) references branches (id);