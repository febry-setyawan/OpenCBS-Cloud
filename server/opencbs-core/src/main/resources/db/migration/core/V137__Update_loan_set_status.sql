ALTER TABLE loans ADD COLUMN IF NOT EXISTS status varchar(100);

update loans
set status = 'ACTIVE';

alter table loans
  alter column status set not null;