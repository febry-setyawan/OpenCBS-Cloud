-- Fix test data for admin user
-- This migration ensures admin user exists for testing

-- Create admin user with correct BCrypt hash for password 'admin'
-- Use DO block to handle potential conflicts with existing users
DO $$
BEGIN
    -- Check if admin user exists
    IF NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin') THEN
        -- If no admin user exists, try to update existing Administrator user to be admin
        IF EXISTS (SELECT 1 FROM users WHERE username = 'Administrator' OR username = 'administrator') THEN
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
            WHERE username = 'Administrator' OR username = 'administrator';
        ELSE
            -- Create new admin user
            INSERT INTO users (username, password_hash, first_name, last_name, role_id, time_zone_name, status, is_system_user, first_login, password_expire_date, branch_id) 
            VALUES ('admin', '$2a$10$SxkikAqaZvWGjvo8KAwbWeO0HJy.LGPist/yirI7mAZrWW6xTalY.', 'Test', 'Admin', 1, 'UTC', 'ACTIVE', false, false, '2099-12-31', 1);
        END IF;
    END IF;
END $$;