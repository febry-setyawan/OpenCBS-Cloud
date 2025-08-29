-- Test data migration for opencbs-core testing
-- This migration adds essential test data required for tests to run

-- Insert default currency if it doesn't exist (or update existing one)
INSERT INTO currencies (id, name, code, is_main) 
VALUES (1, 'US Dollar', 'USD', true) 
ON CONFLICT (id) DO UPDATE SET name = 'US Dollar', code = 'USD';

-- Insert default global settings including default currency
INSERT INTO global_settings (name, type, value) 
VALUES ('DEFAULT_CURRENCY', 'LOOKUP', '1') 
ON CONFLICT (name) DO NOTHING;

-- Insert default branch
INSERT INTO branches (id, name) 
VALUES (1, 'DEFAULT BRANCH') 
ON CONFLICT (id) DO NOTHING;

-- Insert admin role 
INSERT INTO roles (id, name, status, is_system) 
VALUES (1, 'admin', 'ACTIVE', true) 
ON CONFLICT (id) DO UPDATE SET name = 'admin', status = 'ACTIVE', is_system = true;

-- Create admin user with correct BCrypt hash for password 'admin'
-- Use DO block to handle potential conflicts with existing users
DO $$
BEGIN
    -- First try to insert the admin user
    INSERT INTO users (id, username, password_hash, first_name, last_name, role_id, time_zone_name, status, is_system_user, first_login, password_expire_date, branch_id) 
    VALUES (3, 'admin', '$2a$10$SxkikAqaZvWGjvo8KAwbWeO0HJy.LGPist/yirI7mAZrWW6xTalY.', 'Test', 'Admin', 1, 'UTC', 'ACTIVE', false, false, '2099-12-31', 1);
EXCEPTION
    WHEN unique_violation THEN
        -- If user with id=3 exists, try to update existing Administrator user to be admin
        UPDATE users SET 
            username = 'admin',
            password_hash = '$2a$10$SxkikAqaZvWGjvo8KAwbWeO0HJy.LGPist/yirI7mAZrWW6xTalY.',
            first_name = 'Test',
            last_name = 'Admin',
            time_zone_name = 'UTC',
            status = 'ACTIVE',
            is_system_user = false,
            first_login = false,
            password_expire_date = '2099-12-31'
        WHERE username = 'Administrator' OR id = 2;
END $$;

-- Insert PersonCustomFieldSection for tests
INSERT INTO people_custom_fields_sections (id, caption, code, "order") 
VALUES (1, 'Personal Information', 'PERSONAL_INFO', 1) 
ON CONFLICT (id) DO NOTHING;

-- Insert CompanyCustomFieldSection for tests  
INSERT INTO companies_custom_fields_sections (id, caption, code, "order") 
VALUES (1, 'Company Information', 'COMPANY_INFO', 1) 
ON CONFLICT (id) DO NOTHING;