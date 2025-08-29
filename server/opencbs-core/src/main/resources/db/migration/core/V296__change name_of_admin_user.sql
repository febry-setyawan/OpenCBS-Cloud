update users set first_name = 'Administrator', last_name = '', username = 'Administrator' where id = 2;
ALTER TABLE roles ADD COLUMN IF NOT EXISTS is_system boolean default false;
update roles set name = 'Administrator', is_system = true where id = 1;