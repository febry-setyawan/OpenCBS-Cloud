ALTER TABLE roles ADD COLUMN IF NOT EXISTS status varchar(10) not null default 'ACTIVE';
ALTER TABLE audit.roles_history ADD COLUMN IF NOT EXISTS status varchar(10);

ALTER TABLE users ADD COLUMN IF NOT EXISTS status varchar(10) not null default 'ACTIVE';
ALTER TABLE audit.users_history ADD COLUMN IF NOT EXISTS status varchar(10);