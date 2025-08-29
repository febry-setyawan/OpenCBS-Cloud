ALTER TABLE currencies ADD COLUMN IF NOT EXISTS is_main boolean default false not null;

update currencies
set is_main = true
where id =
      (
          select cast(global_settings.value as bigint)
          from global_settings
          where global_settings.name ilike 'PIVOT_CURRENCY_ID'
      );