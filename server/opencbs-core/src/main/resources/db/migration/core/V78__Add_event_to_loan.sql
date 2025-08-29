ALTER TABLE events ADD COLUMN IF NOT EXISTS loan_id integer not null;
alter table events
  add constraint events_loan_id_fkey foreign key (loan_id) references loans (id) match full;