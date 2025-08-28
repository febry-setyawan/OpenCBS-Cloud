-- Test schema and initial data for H2 database
-- This file is automatically loaded by Spring Boot for H2 test databases

-- Insert default branch (only id and name based on current Branch entity)
INSERT INTO branches (id, name) VALUES (1, 'DEFAULT BRANCH');

-- Insert basic permissions needed for testing
INSERT INTO permissions (id, name, description, module_type, permanent) VALUES 
(1, 'ALL', 'All permissions', 'CONFIGURATIONS', true);

-- Insert admin role (using correct column names)
INSERT INTO roles (id, name, status, is_system) VALUES (1, 'admin', 'ACTIVE', true);

-- Link admin role to all permissions (roles_permissions has id, permission_id, role_id)
INSERT INTO roles_permissions (id, permission_id, role_id) VALUES 
(1, 1, 1);

-- Insert admin user with password hash for 'admin'
-- Using a simple password hash that should definitely work: password 'admin'
-- Let's try a fresh BCrypt hash
INSERT INTO users (id, username, password_hash, first_name, last_name, role_id, branch_id, time_zone_name, status, is_system_user, first_login, password_expire_date) 
VALUES (1, 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAPXvQOr0k8rUZ.aJfiVgI/JqFfG', 'Test', 'Admin', 1, 1, 'UTC', 'ACTIVE', false, false, '2099-12-31');