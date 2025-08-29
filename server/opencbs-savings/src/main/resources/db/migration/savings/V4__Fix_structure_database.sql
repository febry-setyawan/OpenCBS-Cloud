DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'saving_product_accounts' 
          AND column_name = 'saving_product_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE saving_product_accounts ALTER COLUMN saving_product_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'saving_product_accounts' 
          AND column_name = 'account_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE saving_product_accounts ALTER COLUMN account_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings_accounting_entries' 
          AND column_name = 'saving_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings_accounting_entries ALTER COLUMN saving_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings_accounting_entries' 
          AND column_name = 'accounting_entry_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings_accounting_entries ALTER COLUMN accounting_entry_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings_accounts' 
          AND column_name = 'saving_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings_accounts ALTER COLUMN saving_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings_accounts' 
          AND column_name = 'account_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings_accounts ALTER COLUMN account_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'created_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN created_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'opened_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN opened_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'closed_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN closed_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'reopened_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN reopened_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'deposited_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN deposited_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'withdrawed_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN withdrawed_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'saving_officer_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN saving_officer_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'saving_products' 
          AND column_name = 'currency_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE saving_products ALTER COLUMN currency_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'saving_product_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN saving_product_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'savings' 
          AND column_name = 'profile_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE savings ALTER COLUMN profile_id TYPE BIGINT;
    END IF;
END $$;
