insert into roles (name)
values ('Loan Officer');

ALTER TABLE loan_applications ADD COLUMN IF NOT EXISTS loan_officer_id int null;

update loan_applications
set loan_officer_id = 2;

alter table loan_applications
  alter column loan_officer_id set not null;

alter table loan_applications
  add constraint loan_applications_loan_officer_id_fkey foreign key (loan_officer_id) references users (id);

ALTER TABLE loans ADD COLUMN IF NOT EXISTS loan_officer_id int null;

update loans
set loan_officer_id = 2;

alter table loans
  alter column loan_officer_id set not null;

alter table loans
  add constraint loans_loan_officer_id_fkey foreign key (loan_officer_id) references users (id);
