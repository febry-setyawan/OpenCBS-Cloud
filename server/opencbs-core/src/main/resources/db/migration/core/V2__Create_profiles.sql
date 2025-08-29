-- noinspection SqlNoDataSourceInspectionForFile
create table if not exists profiles (
  id bigserial primary key,
  type varchar(20) not null,
  first_name varchar(255) null,
  last_name varchar(255) null,
  birth_date date null
);
