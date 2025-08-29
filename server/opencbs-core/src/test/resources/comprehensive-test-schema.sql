-- Comprehensive PostgreSQL test schema for OpenCBS
-- This schema includes the essential tables and columns needed for tests to run
-- Based on JPA entity definitions and avoiding complex legacy migration issues

-- Create users table with all required columns
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    time_zone_name VARCHAR(255) DEFAULT 'Asia/Bishkek',
    branch_id BIGINT,
    role_id BIGINT NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(255),
    id_number VARCHAR(255),
    address VARCHAR(255),
    enabled BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Create branches table
CREATE TABLE IF NOT EXISTS branches (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(50),
    address VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Create roles table
CREATE TABLE IF NOT EXISTS roles (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description VARCHAR(500)
);

-- Create permissions table
CREATE TABLE IF NOT EXISTS permissions (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description VARCHAR(500) NOT NULL,
    module_type VARCHAR(255) NOT NULL,
    permanent BOOLEAN NOT NULL DEFAULT false
);

-- Create roles_permissions junction table
CREATE TABLE IF NOT EXISTS roles_permissions (
    id BIGSERIAL PRIMARY KEY,
    role_id BIGINT NOT NULL,
    permission_id BIGINT NOT NULL,
    UNIQUE(role_id, permission_id)
);

-- Create profiles table (core entity for the system)
CREATE TABLE IF NOT EXISTS profiles (
    id BIGSERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    branch_id BIGINT
);

-- Create accounts table (for financial operations)
CREATE TABLE IF NOT EXISTS accounts (
    id BIGSERIAL PRIMARY KEY,
    number VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    parent_id BIGINT,
    is_debit_balance BOOLEAN DEFAULT false,
    type_id BIGINT,
    currency_id BIGINT DEFAULT 1,
    branch_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Create currencies table
CREATE TABLE IF NOT EXISTS currencies (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    digit_after_decimal INTEGER DEFAULT 2
);

-- Create account_types table
CREATE TABLE IF NOT EXISTS account_types (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(50) UNIQUE NOT NULL
);

-- Create events table
CREATE TABLE IF NOT EXISTS events (
    id BIGSERIAL PRIMARY KEY,
    event_type VARCHAR(200) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    created_by_id BIGINT NOT NULL
);

-- Create transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id BIGSERIAL PRIMARY KEY,
    event_id BIGINT NOT NULL,
    transaction_type VARCHAR(200) NOT NULL,
    amount DECIMAL(12, 4)
);

-- Create payees table
CREATE TABLE IF NOT EXISTS payees (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(500),
    account_id BIGINT
);

-- Create professions table
CREATE TABLE IF NOT EXISTS professions (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(50) UNIQUE
);

-- Create account_tags table
CREATE TABLE IF NOT EXISTS account_tags (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create people_custom_fields_sections table
CREATE TABLE IF NOT EXISTS people_custom_fields_sections (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    caption VARCHAR(255),
    order_number INTEGER DEFAULT 0
);

-- Add foreign key constraints with proper naming
ALTER TABLE users 
ADD CONSTRAINT IF NOT EXISTS fk_users_branch 
FOREIGN KEY (branch_id) REFERENCES branches (id);

ALTER TABLE users 
ADD CONSTRAINT IF NOT EXISTS fk_users_role 
FOREIGN KEY (role_id) REFERENCES roles (id);

ALTER TABLE users 
ADD CONSTRAINT IF NOT EXISTS fk_users_created_by 
FOREIGN KEY (created_by_id) REFERENCES users (id);

ALTER TABLE roles_permissions 
ADD CONSTRAINT IF NOT EXISTS fk_roles_permissions_role 
FOREIGN KEY (role_id) REFERENCES roles (id);

ALTER TABLE roles_permissions 
ADD CONSTRAINT IF NOT EXISTS fk_roles_permissions_permission 
FOREIGN KEY (permission_id) REFERENCES permissions (id);

ALTER TABLE profiles 
ADD CONSTRAINT IF NOT EXISTS fk_profiles_created_by 
FOREIGN KEY (created_by_id) REFERENCES users (id);

ALTER TABLE profiles 
ADD CONSTRAINT IF NOT EXISTS fk_profiles_branch 
FOREIGN KEY (branch_id) REFERENCES branches (id);

ALTER TABLE accounts 
ADD CONSTRAINT IF NOT EXISTS fk_accounts_parent 
FOREIGN KEY (parent_id) REFERENCES accounts (id);

ALTER TABLE accounts 
ADD CONSTRAINT IF NOT EXISTS fk_accounts_type 
FOREIGN KEY (type_id) REFERENCES account_types (id);

ALTER TABLE accounts 
ADD CONSTRAINT IF NOT EXISTS fk_accounts_currency 
FOREIGN KEY (currency_id) REFERENCES currencies (id);

ALTER TABLE accounts 
ADD CONSTRAINT IF NOT EXISTS fk_accounts_branch 
FOREIGN KEY (branch_id) REFERENCES branches (id);

ALTER TABLE accounts 
ADD CONSTRAINT IF NOT EXISTS fk_accounts_created_by 
FOREIGN KEY (created_by_id) REFERENCES users (id);

ALTER TABLE events 
ADD CONSTRAINT IF NOT EXISTS fk_events_created_by 
FOREIGN KEY (created_by_id) REFERENCES users (id);

ALTER TABLE transactions 
ADD CONSTRAINT IF NOT EXISTS fk_transactions_event 
FOREIGN KEY (event_id) REFERENCES events (id);

ALTER TABLE payees 
ADD CONSTRAINT IF NOT EXISTS fk_payees_account 
FOREIGN KEY (account_id) REFERENCES accounts (id);

-- Insert basic test data
INSERT INTO currencies (name, code, digit_after_decimal) 
VALUES ('Kyrgyz Som', 'KGS', 2) 
ON CONFLICT (code) DO NOTHING;

INSERT INTO account_types (name, code)
VALUES 
    ('Asset', 'ASSET'),
    ('Liability', 'LIABILITY'),
    ('Equity', 'EQUITY'),
    ('Income', 'INCOME'),
    ('Expense', 'EXPENSE')
ON CONFLICT (code) DO NOTHING;

INSERT INTO branches (name, code, address)
VALUES ('Main Branch', 'MAIN', 'Test Address 123')
ON CONFLICT DO NOTHING;

INSERT INTO roles (name, description)
VALUES 
    ('ADMIN', 'System Administrator'),
    ('USER', 'Regular User'),
    ('TELLER', 'Bank Teller')
ON CONFLICT (name) DO NOTHING;

INSERT INTO permissions (name, description, module_type, permanent)
VALUES 
    ('READ_PROFILE', 'Permission to read profiles', 'PROFILES', false),
    ('CREATE_PROFILE', 'Permission to create profiles', 'PROFILES', false),
    ('UPDATE_PROFILE', 'Permission to update profiles', 'PROFILES', false),
    ('DELETE_PROFILE', 'Permission to delete profiles', 'PROFILES', false)
ON CONFLICT (name) DO NOTHING;

-- Insert admin user
INSERT INTO users (first_name, last_name, username, password_hash, role_id, branch_id, address, enabled) 
SELECT 'Admin', 'User', 'admin', '$2a$10$XmtWixcSIQVNuX.j3SY7ZegiojYcKp.yE1MtqgF7VAy6e1GclZITm', r.id, b.id, 'Admin Address', true
FROM roles r, branches b 
WHERE r.name = 'ADMIN' AND b.code = 'MAIN'
ON CONFLICT (username) DO NOTHING;

-- Insert test user  
INSERT INTO users (first_name, last_name, username, password_hash, role_id, branch_id, address, enabled) 
SELECT 'Test', 'User', 'testuser', '$2a$10$test.hash.here', r.id, b.id, 'Test Address', true
FROM roles r, branches b 
WHERE r.name = 'USER' AND b.code = 'MAIN'
ON CONFLICT (username) DO NOTHING;

-- Add permissions to admin role
INSERT INTO roles_permissions (role_id, permission_id)
SELECT r.id, p.id 
FROM roles r, permissions p 
WHERE r.name = 'ADMIN'
ON CONFLICT (role_id, permission_id) DO NOTHING;

-- Insert basic accounts for financial operations
INSERT INTO accounts (number, name, is_debit_balance, type_id, currency_id, branch_id)
SELECT '1000', 'Cash', true, at.id, c.id, b.id
FROM account_types at, currencies c, branches b
WHERE at.code = 'ASSET' AND c.code = 'KGS' AND b.code = 'MAIN'
ON CONFLICT (number) DO NOTHING;

INSERT INTO accounts (number, name, is_debit_balance, type_id, currency_id, branch_id) 
SELECT '2000', 'Customer Deposits', false, at.id, c.id, b.id
FROM account_types at, currencies c, branches b
WHERE at.code = 'LIABILITY' AND c.code = 'KGS' AND b.code = 'MAIN'
ON CONFLICT (number) DO NOTHING;

-- Insert test professions
INSERT INTO professions (name, code)
VALUES 
    ('Engineer', 'ENG'),
    ('Teacher', 'TCH'),
    ('Doctor', 'DOC')
ON CONFLICT (code) DO NOTHING;

-- Insert test payees
INSERT INTO payees (name, description)
VALUES 
    ('Test Payee 1', 'Test payee for testing'),
    ('Test Payee 2', 'Another test payee')
ON CONFLICT DO NOTHING;

-- Insert test custom field sections
INSERT INTO people_custom_fields_sections (name, caption, order_number)
VALUES 
    ('Personal Information', 'Personal Info', 1),
    ('Contact Information', 'Contact Info', 2)
ON CONFLICT DO NOTHING;

-- Insert account tags (matching the AccountTagType enum exactly with correct IDs)
INSERT INTO account_tags (id, name)
VALUES 
    (1, 'ASSET'),
    (2, 'LIABILITIES'),
    (3, 'EQUITY'),
    (5, 'REVENUES'),
    (6, 'EXPENSES'),
    (7, 'OFF_BALANCE'),
    (8, 'TELLER'),
    (9, 'CURRENT_ACCOUNT'),
    (10, 'GAIN_ACCOUNT'),
    (11, 'LOSS_ACCOUNT'),
    (12, 'BANK_ACCOUNT')
ON CONFLICT (id) DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_branch_id ON users(branch_id);
CREATE INDEX IF NOT EXISTS idx_accounts_number ON accounts(number);
CREATE INDEX IF NOT EXISTS idx_profiles_type ON profiles(type);
CREATE INDEX IF NOT EXISTS idx_events_created_at ON events(created_at);
CREATE INDEX IF NOT EXISTS idx_transactions_event_id ON transactions(event_id);