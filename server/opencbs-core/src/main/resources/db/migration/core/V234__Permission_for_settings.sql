insert into permissions(name, description, module_type, permanent)
  select 'SETTING', '', 'CONFIGURATIONS', true 
  where not exists (select 1 from permissions where name = 'SETTING' and module_type = 'CONFIGURATIONS');
