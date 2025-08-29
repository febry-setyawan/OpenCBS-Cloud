DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_accounts' 
          AND column_name = 'account_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_accounts ALTER COLUMN account_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_accounts' 
          AND column_name = 'borrowing_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_accounts ALTER COLUMN borrowing_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_events' 
          AND column_name = 'created_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_events ALTER COLUMN created_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_events' 
          AND column_name = 'borrowing_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_events ALTER COLUMN borrowing_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_events' 
          AND column_name = 'rolled_back_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_events ALTER COLUMN rolled_back_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_events_accounting_entries' 
          AND column_name = 'borrowing_event_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_events_accounting_entries ALTER COLUMN borrowing_event_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_events_accounting_entries' 
          AND column_name = 'accounting_entry_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_events_accounting_entries ALTER COLUMN accounting_entry_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_products' 
          AND column_name = 'currency_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_products ALTER COLUMN currency_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_products_accounts' 
          AND column_name = 'account_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_products_accounts ALTER COLUMN account_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowing_products_accounts' 
          AND column_name = 'borrowing_product_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowing_products_accounts ALTER COLUMN borrowing_product_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowings' 
          AND column_name = 'borrowing_product_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowings ALTER COLUMN borrowing_product_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowings' 
          AND column_name = 'created_by_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowings ALTER COLUMN created_by_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowings' 
          AND column_name = 'loan_officer_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowings ALTER COLUMN loan_officer_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowings' 
          AND column_name = 'profile_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowings ALTER COLUMN profile_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowings' 
          AND column_name = 'correspondence_account_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowings ALTER COLUMN correspondence_account_id TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowings_installments' 
          AND column_name = 'event_group_key'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowings_installments ALTER COLUMN event_group_key TYPE BIGINT;
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'borrowings_installments' 
          AND column_name = 'borrowing_id'
          AND data_type != 'bigint'
    ) THEN
        ALTER TABLE borrowings_installments ALTER COLUMN borrowing_id TYPE BIGINT;
    END IF;
END $$;