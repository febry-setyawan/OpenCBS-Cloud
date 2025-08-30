-- Test schema and initial data for H2 database
-- This file is automatically loaded by Spring Boot for H2 test databases

-- Insert default currency
INSERT INTO currencies (name, code, is_main) VALUES ('US Dollar', 'USD', true);

-- Insert default branch (only id and name based on current Branch entity)  
INSERT INTO branches (name) VALUES ('DEFAULT BRANCH');

-- Insert admin role 
INSERT INTO roles (name, status, is_system) VALUES ('admin', 'ACTIVE', true);

-- Insert admin user with correct BCrypt hash for password 'admin' - generated using BCrypt.hashpw("admin", BCrypt.gensalt())
INSERT INTO users (username, password_hash, first_name, last_name, role_id, time_zone_name, status, is_system_user, first_login, password_expire_date, branch_id) 
VALUES ('admin', '$2a$10$SxkikAqaZvWGjvo8KAwbWeO0HJy.LGPist/yirI7mAZrWW6xTalY.', 'Test', 'Admin', 1, 'UTC', 'ACTIVE', false, false, '2099-12-31', 1);