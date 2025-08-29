DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'guarantors' 
          AND column_name = 'amount' 
          AND is_nullable = 'NO'
    ) THEN
        ALTER TABLE guarantors ALTER COLUMN amount DROP NOT NULL;
    END IF;
END $$;