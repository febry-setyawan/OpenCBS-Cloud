CREATE TABLE IF NOT EXISTS group_loan_applications (
  id                  bigserial      primary key,
  group_id            bigint         not null references profiles,
  member_id           bigint         not null references profiles,
  loan_application_id bigint         not null references loan_applications,
  amount              numeric(12, 2) not null,

  unique (member_id, loan_application_id)
);

ALTER TABLE loans ADD COLUMN IF NOT EXISTS profile_id bigint references profiles;