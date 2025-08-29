CREATE TABLE IF NOT EXISTS events (
  id            BIGSERIAL PRIMARY KEY,
  event_type    VARCHAR(200) NOT NULL,
  created_at    TIMESTAMP    NOT NULL,
  created_by_id INTEGER      NOT NULL
);

-- Add constraint with DO block for PostgreSQL compatibility
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints 
                   WHERE constraint_name = 'events_created_by_id_fkey' 
                   AND table_name = 'events') THEN
        ALTER TABLE events ADD CONSTRAINT events_created_by_id_fkey 
        FOREIGN KEY (created_by_id) REFERENCES users (id) MATCH FULL;
    END IF;
END $$;

CREATE TABLE IF NOT EXISTS transactions (
  id               BIGSERIAL PRIMARY KEY,
  event_id         INTEGER      NOT NULL,
  transaction_type VARCHAR(200) NOT NULL,
  amount           DECIMAL(12, 4)
);

-- Add constraint with DO block for PostgreSQL compatibility  
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints 
                   WHERE constraint_name = 'transactions_event_id_fkey' 
                   AND table_name = 'transactions') THEN
        ALTER TABLE transactions ADD CONSTRAINT transactions_event_id_fkey 
        FOREIGN KEY (event_id) REFERENCES events (id) MATCH FULL;
    END IF;
END $$;
