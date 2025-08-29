ALTER TABLE day_closures ADD COLUMN IF NOT EXISTS day date not null default to_timestamp(0);

