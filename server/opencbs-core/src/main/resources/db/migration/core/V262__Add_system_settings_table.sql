CREATE TABLE IF NOT EXISTS system_settings (
  id    BIGSERIAL PRIMARY KEY,
  name  VARCHAR(255) NOT NULL,
  type  VARCHAR(255) NOT NULL,
  value VARCHAR(255) NOT NULL
);

insert into system_settings (name, type, value)
  values ('PASSWORD_LENGTH', 'INTEGER', '3'),
         ('UPPER_CASE', 'BOOLEAN', 'FALSE'),
         ('NUMBERS', 'BOOLEAN', 'FALSE'),
         ('FIRST_LOG_IN', 'BOOLEAN', 'FALSE'),
         ('EXPIRE_PERIOD', 'LIST', 'NEVER');

ALTER TABLE users ADD COLUMN IF NOT EXISTS password_expire_date date default (now() + interval '1 week'),
  add column first_login boolean default true;