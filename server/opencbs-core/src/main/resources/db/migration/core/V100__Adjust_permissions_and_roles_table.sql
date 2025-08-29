-- noinspection SqlNoDataSourceInspectionForFile
drop table if exists roles_permissions;

CREATE TABLE IF NOT EXISTS roles_permissions (
  role_id       int not null,
  permission_id int not null
);

alter table roles_permissions
  add constraint roles_permissions_roles_id_fkey foreign key (role_id) references roles (id);

alter table roles_permissions
  add constraint roles_permissions_permission_id_fkey foreign key (permission_id) references permissions (id);

alter table roles_permissions
  add constraint roles_permissions_role_id_permission_id_key unique (role_id, permission_id);

INSERT INTO roles_permissions (role_id, permission_id)
SELECT 1, 1 WHERE NOT EXISTS (SELECT 1 FROM roles_permissions WHERE role_id = 1 AND permission_id = 1)
UNION ALL
SELECT 1, 2 WHERE NOT EXISTS (SELECT 1 FROM roles_permissions WHERE role_id = 1 AND permission_id = 2)
UNION ALL
SELECT 1, 3 WHERE NOT EXISTS (SELECT 1 FROM roles_permissions WHERE role_id = 1 AND permission_id = 3)
UNION ALL
SELECT 1, 4 WHERE NOT EXISTS (SELECT 1 FROM roles_permissions WHERE role_id = 1 AND permission_id = 4);