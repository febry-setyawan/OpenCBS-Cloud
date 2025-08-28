-- Test schema and initial data for H2 database
-- This file is automatically loaded by Spring Boot for H2 test databases

-- Create audit schema for Hibernate Envers
CREATE SCHEMA IF NOT EXISTS audit;

-- Insert default branch (only id and name based on current Branch entity)  
INSERT INTO branches (id, name) VALUES (1, 'DEFAULT BRANCH');

-- Insert admin role 
INSERT INTO roles (id, name, status, is_system) VALUES (1, 'admin', 'ACTIVE', true);

-- Insert admin user with correct BCrypt hash for password 'admin' - generated using BCrypt.hashpw("admin", BCrypt.gensalt())
INSERT INTO users (id, username, password_hash, first_name, last_name, role_id, time_zone_name, status, is_system_user, first_login, password_expire_date) 
VALUES (1, 'admin', '$2a$10$SxkikAqaZvWGjvo8KAwbWeO0HJy.LGPist/yirI7mAZrWW6xTalY.', 'Test', 'Admin', 1, 'UTC', 'ACTIVE', false, false, '2099-12-31');

-- Insert PersonCustomFieldSection for tests
INSERT INTO people_custom_fields_sections (id, caption, code, "order") VALUES (1, 'Personal Information', 'PERSONAL_INFO', 1);

-- Insert CompanyCustomFieldSection for tests  
INSERT INTO companies_custom_fields_sections (id, caption, code, "order") VALUES (1, 'Company Information', 'COMPANY_INFO', 1);