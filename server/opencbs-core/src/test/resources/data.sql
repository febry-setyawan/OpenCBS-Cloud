-- Test schema and initial data for H2 database
-- This file is automatically loaded by Spring Boot for H2 test databases

-- Create audit schema for Hibernate Envers
CREATE SCHEMA IF NOT EXISTS audit;

-- Insert default currency
INSERT INTO currencies (id, name, code, digit_after_decimal) VALUES (1, 'US Dollar', 'USD', 2) ON CONFLICT (id) DO NOTHING;

-- Insert default global settings including default currency
INSERT INTO global_settings (id, name, type, value, description) VALUES 
    (1, 'DEFAULT_CURRENCY', 'LOOKUP', '1', 'Default system currency') ON CONFLICT (id) DO NOTHING;

-- Insert default branch (only id and name based on current Branch entity)  
INSERT INTO branches (id, name) VALUES (1, 'DEFAULT BRANCH') ON CONFLICT (id) DO NOTHING;

-- Insert admin role 
INSERT INTO roles (id, name, status, is_system) VALUES (1, 'admin', 'ACTIVE', true) ON CONFLICT (id) DO NOTHING;

-- Insert admin user with correct BCrypt hash for password 'admin' - generated using BCrypt.hashpw("admin", BCrypt.gensalt())
INSERT INTO users (id, username, password_hash, first_name, last_name, role_id, time_zone_name, status, is_system_user, first_login, password_expire_date, branch_id) 
VALUES (1, 'admin', '$2a$10$SxkikAqaZvWGjvo8KAwbWeO0HJy.LGPist/yirI7mAZrWW6xTalY.', 'Test', 'Admin', 1, 'UTC', 'ACTIVE', false, false, '2099-12-31', 1) ON CONFLICT (id) DO NOTHING;

-- Insert PersonCustomFieldSection for tests
INSERT INTO people_custom_fields_sections (id, caption, code, "order") VALUES (1, 'Personal Information', 'PERSONAL_INFO', 1) ON CONFLICT (id) DO NOTHING;

-- Insert CompanyCustomFieldSection for tests  
INSERT INTO companies_custom_fields_sections (id, caption, code, "order") VALUES (1, 'Company Information', 'COMPANY_INFO', 1) ON CONFLICT (id) DO NOTHING;