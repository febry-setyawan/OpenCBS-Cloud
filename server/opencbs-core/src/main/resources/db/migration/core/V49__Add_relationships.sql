CREATE TABLE IF NOT EXISTS relationships (
  id bigserial primary key,
  name varchar(200) not null unique
);

insert into relationships (name) values ('Mother');