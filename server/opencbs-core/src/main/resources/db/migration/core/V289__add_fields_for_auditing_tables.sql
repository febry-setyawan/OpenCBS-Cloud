ALTER TABLE audit.groups_attachments_history ADD COLUMN IF NOT EXISTS owner_id bigint;
ALTER TABLE audit.people_attachments_history ADD COLUMN IF NOT EXISTS owner_id bigint;

ALTER TABLE audit.people_custom_fields_values_history ADD COLUMN IF NOT EXISTS status varchar(255),
  add column value varchar(255),
  add column verified_at timestamp,
  add column field_id bigint,
  add column verified_by_id bigint;

ALTER TABLE audit.groups_custom_fields_values_history ADD COLUMN IF NOT EXISTS status varchar(255),
  add column value varchar(255),
  add column verified_at timestamp,
  add column field_id bigint,
  add column verified_by_id bigint;

ALTER TABLE audit.companies_custom_fields_values_history ADD COLUMN IF NOT EXISTS status varchar(255),
  add column value varchar(255),
  add column verified_at timestamp,
  add column field_id bigint,
  add column verified_by_id bigint;

CREATE TABLE IF NOT EXISTS audit.groups_custom_fields_history
(
  id bigint not null,
  rev integer not null references audit.revinfo,
  revtype smallint,
  constraint groups_custom_fields_history_pkey
  primary key (id, rev)
);

CREATE TABLE IF NOT EXISTS audit.people_custom_fields_history
(
  id bigint not null,
  rev integer not null references audit.revinfo,
  revtype smallint,
  constraint people_custom_fields_history_pkey
  primary key (id, rev)
);

CREATE TABLE IF NOT EXISTS audit.companies_custom_fields_history
(
  id bigint not null,
  rev integer not null references audit.revinfo,
  revtype smallint,
  constraint companies_custom_fields_history_pkey
  primary key (id, rev)
);

ALTER TABLE audit.users_history ADD COLUMN IF NOT EXISTS role_id bigint;
