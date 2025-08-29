ALTER TABLE borrowing_events ADD COLUMN IF NOT EXISTS extra jsonb;

CREATE TABLE IF NOT EXISTS borrowing_events_accounting_entries (
  id                      bigserial primary key,
  borrowing_event_id integer not null references borrowing_events (id),
  accounting_entry_id     integer not null references accounting_entries (id),
  unique (borrowing_event_id, accounting_entry_id)
);