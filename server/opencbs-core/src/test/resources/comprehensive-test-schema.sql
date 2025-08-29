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
    position VARCHAR(255),
    password_expire_date DATE,
    first_login BOOLEAN DEFAULT true,
    is_system_user BOOLEAN DEFAULT false,
    last_entry_time TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'ACTIVE',
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
    description VARCHAR(500),
    status VARCHAR(50) NOT NULL DEFAULT 'ACTIVE',
    is_system BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
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
    status VARCHAR(50) NOT NULL DEFAULT 'LIVE',
    version INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    branch_id BIGINT,
    CONSTRAINT fk_profiles_branch FOREIGN KEY (branch_id) REFERENCES branches(id),
    CONSTRAINT fk_profiles_created_by FOREIGN KEY (created_by_id) REFERENCES users(id)
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
    "order" INTEGER DEFAULT 0,
    code TEXT NOT NULL DEFAULT ''
);

-- Create people_custom_fields table
CREATE TABLE IF NOT EXISTS people_custom_fields (
  id bigserial primary key,
  section_id bigint not null,
  name varchar(255) not null,
  field_type varchar(31) not null,
  caption varchar(255) not null,
  description varchar(255) not null default '',
  is_unique boolean not null default false,
  is_required boolean not null default false,
  "order" int not null default(0),
  extra text null,
  deleted boolean not null default false
);

alter table people_custom_fields
add constraint people_custom_fields_section_id_fkey
foreign key (section_id)
references people_custom_fields_sections(id);

CREATE TABLE IF NOT EXISTS people_custom_fields_values (
  id bigserial primary key,
  owner_id bigint not null,
  field_id bigint not null,
  value text null
);

alter table people_custom_fields_values
add constraint people_custom_fields_values_owner_id_fkey
foreign key (owner_id)
references profiles(id);

alter table people_custom_fields_values
add constraint people_custom_fields_values_field_id_fkey
foreign key (field_id)
references people_custom_fields(id);

-- Create companies_custom_fields_sections table
CREATE TABLE IF NOT EXISTS companies_custom_fields_sections (
  id bigserial primary key,
  caption varchar(255) not null,
  "order" int not null default(0),
  code text not null default('')
);

CREATE TABLE IF NOT EXISTS companies_custom_fields (
  id bigserial primary key,
  section_id bigint not null,
  name varchar(255) not null,
  field_type varchar(31) not null,
  caption varchar(255) not null,
  description varchar(255) not null default '',
  is_unique boolean not null default false,
  is_required boolean not null default false,
  "order" int not null default(0),
  extra text null,
  deleted boolean not null default false
);

alter table companies_custom_fields
add constraint companies_custom_fields_section_id_fkey
foreign key (section_id)
references companies_custom_fields_sections(id);

CREATE TABLE IF NOT EXISTS companies_custom_fields_values (
  id bigserial primary key,
  owner_id bigint not null,
  field_id bigint not null,
  value text null
);

alter table companies_custom_fields_values
add constraint companies_custom_fields_values_owner_id_fkey
foreign key (owner_id)
references profiles(id);

alter table companies_custom_fields_values
add constraint companies_custom_fields_values_field_id_fkey
foreign key (field_id)
references companies_custom_fields(id);

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

INSERT INTO roles (name, description, status, is_system)
VALUES 
    ('ADMIN', 'System Administrator', 'ACTIVE', false),
    ('USER', 'Regular User', 'ACTIVE', false),
    ('TELLER', 'Bank Teller', 'ACTIVE', false)
ON CONFLICT (name) DO NOTHING;

INSERT INTO permissions (name, description, module_type, permanent)
VALUES 
    ('READ_PROFILE', 'Permission to read profiles', 'PROFILES', false),
    ('CREATE_PROFILE', 'Permission to create profiles', 'PROFILES', false),
    ('UPDATE_PROFILE', 'Permission to update profiles', 'PROFILES', false),
    ('DELETE_PROFILE', 'Permission to delete profiles', 'PROFILES', false)
ON CONFLICT (name) DO NOTHING;

-- Insert admin user
INSERT INTO users (first_name, last_name, username, password_hash, role_id, branch_id, address, enabled, password_expire_date) 
SELECT 'Admin', 'User', 'admin', '$2b$12$IN4J2IrYtdH3Qd18u5ogOu1cO.FBK5HvtiFxm8IhwfFL5Ung4D81q', r.id, b.id, 'Admin Address', true, CURRENT_DATE + INTERVAL '1 year'
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
INSERT INTO people_custom_fields_sections (name, caption, "order", code)
VALUES 
    ('Personal Information', 'Personal Info', 1, 'personal'),
    ('Contact Information', 'Contact Info', 2, 'contact')
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

-- Branch Custom Fields (from V309)
CREATE TABLE IF NOT EXISTS branch_custom_fields_sections (
  id bigserial primary key,
  caption varchar(255) not null,
  "order" int not null default(0),
  code text not null default('')
);

CREATE TABLE IF NOT EXISTS branch_custom_fields (
  id bigserial primary key,
  section_id bigint not null,
  name varchar(255) not null,
  field_type varchar(31) not null,
  caption varchar(255) not null,
  description varchar(255) not null default '',
  is_unique boolean not null default false,
  is_required boolean not null default false,
  "order" int not null default(0),
  extra text null,
  deleted boolean not null default false
);

alter table branch_custom_fields
add constraint branch_custom_fields_sections_id_fkey
foreign key (section_id)
references branch_custom_fields_sections(id);

CREATE TABLE IF NOT EXISTS branch_custom_fields_values (
  id bigserial primary key,
  owner_id bigint not null,
  field_id bigint not null,
  value text null,
  created_by_id  bigint not null,
  created_at timestamp not null,
  verified_by_id bigint not null,
  verified_at timestamp not null,
  status varchar(255)
);

alter table branch_custom_fields_values
add constraint branch_custom_fields_values_owner_id_fkey
foreign key (owner_id)
references branches(id);

alter table branch_custom_fields_values
add constraint branch_custom_fields_values_field_id_fkey
foreign key (field_id)
references branch_custom_fields(id);

alter table branch_custom_fields_values
add constraint branch_custom_fields_values_created_by_id_fkey
foreign key (created_by_id)
references users(id);

alter table branch_custom_fields_values
add constraint branch_custom_fields_values_verified_by_id_fkey
foreign key (verified_by_id)
references users(id);

-- Create audit schema for Hibernate Envers
CREATE SCHEMA IF NOT EXISTS audit;

CREATE SEQUENCE IF NOT EXISTS audit.hibernate_sequence START 1;

CREATE TABLE IF NOT EXISTS audit.revinfo (
    rev INTEGER NOT NULL PRIMARY KEY,
    revtstmp BIGINT,
    username VARCHAR(255) NOT NULL
);

-- Create audit history tables for custom fields
CREATE TABLE IF NOT EXISTS audit.people_custom_fields_history (
    id BIGINT NOT NULL,
    rev INTEGER NOT NULL,
    revtype SMALLINT,
    section_id BIGINT,
    name VARCHAR(255),
    field_type VARCHAR(31),
    caption VARCHAR(255),
    description VARCHAR(255),
    is_unique BOOLEAN,
    is_required BOOLEAN,
    "order" INTEGER,
    extra TEXT,
    deleted BOOLEAN,
    CONSTRAINT people_custom_fields_history_pkey PRIMARY KEY (id, rev),
    CONSTRAINT fk_people_custom_fields_rev FOREIGN KEY (rev) REFERENCES audit.revinfo(rev)
);

CREATE TABLE IF NOT EXISTS audit.people_custom_fields_values_history (
    id BIGINT NOT NULL,
    rev INTEGER NOT NULL,
    revtype SMALLINT,
    owner_id BIGINT,
    field_id BIGINT,
    value TEXT,
    CONSTRAINT people_custom_fields_values_history_pkey PRIMARY KEY (id, rev),
    CONSTRAINT fk_people_custom_fields_values_rev FOREIGN KEY (rev) REFERENCES audit.revinfo(rev)
);

-- Additional core tables needed for tests

-- Business Sectors table (tree-like structure)
CREATE TABLE IF NOT EXISTS business_sectors (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    parent_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_business_sectors_parent FOREIGN KEY (parent_id) REFERENCES business_sectors(id)
);

-- Locations table (tree-like structure)
CREATE TABLE IF NOT EXISTS locations (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    parent_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_locations_parent FOREIGN KEY (parent_id) REFERENCES locations(id)
);

-- Holidays table
CREATE TABLE IF NOT EXISTS holidays (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    annual BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Global Settings table
CREATE TABLE IF NOT EXISTS global_settings (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    type VARCHAR(50) NOT NULL,
    value TEXT,
    description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- User Sessions table
CREATE TABLE IF NOT EXISTS user_sessions (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    session_id VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    active BOOLEAN DEFAULT true,
    ip_address VARCHAR(45),
    user_agent TEXT,
    CONSTRAINT fk_user_sessions_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Payment Methods table
CREATE TABLE IF NOT EXISTS payment_methods (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    parent_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_payment_methods_parent FOREIGN KEY (parent_id) REFERENCES payment_methods(id)
);

-- Relationships table
CREATE TABLE IF NOT EXISTS relationships (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Accounting entries table
CREATE TABLE IF NOT EXISTS accounting_entries (
    id BIGSERIAL PRIMARY KEY,
    number BIGINT UNIQUE NOT NULL,
    amount DECIMAL(19,2) NOT NULL,
    description VARCHAR(500),
    created_date DATE NOT NULL,
    effective_date DATE NOT NULL,
    created_by_id BIGINT NOT NULL,
    branch_id BIGINT,
    deleted BOOLEAN DEFAULT false,
    CONSTRAINT fk_accounting_entries_user FOREIGN KEY (created_by_id) REFERENCES users(id),
    CONSTRAINT fk_accounting_entries_branch FOREIGN KEY (branch_id) REFERENCES branches(id)
);

-- Account balances table
CREATE TABLE IF NOT EXISTS account_balances (
    id BIGSERIAL PRIMARY KEY,
    account_id BIGINT NOT NULL,
    date DATE NOT NULL,
    balance DECIMAL(19,2) NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_account_balances_account FOREIGN KEY (account_id) REFERENCES accounts(id),
    UNIQUE(account_id, date)
);

-- Till/vault related tables
CREATE TABLE IF NOT EXISTS vaults (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    branch_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_vaults_branch FOREIGN KEY (branch_id) REFERENCES branches(id)
);

CREATE TABLE IF NOT EXISTS tills (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    vault_id BIGINT,
    branch_id BIGINT,
    user_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_tills_vault FOREIGN KEY (vault_id) REFERENCES vaults(id),
    CONSTRAINT fk_tills_branch FOREIGN KEY (branch_id) REFERENCES branches(id),
    CONSTRAINT fk_tills_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Till events table
CREATE TABLE IF NOT EXISTS till_events (
    id BIGSERIAL PRIMARY KEY,
    till_id BIGINT NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    amount DECIMAL(19,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_till_events_till FOREIGN KEY (till_id) REFERENCES tills(id)
);

-- System settings table
CREATE TABLE IF NOT EXISTS system_settings (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    value TEXT,
    description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Other fees table
CREATE TABLE IF NOT EXISTS other_fees (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    percentage DECIMAL(5,2),
    min_value DECIMAL(19,2),
    max_value DECIMAL(19,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Entry fees table
CREATE TABLE IF NOT EXISTS entry_fees (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    amount DECIMAL(19,2),
    percentage DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Penalties table
CREATE TABLE IF NOT EXISTS penalties (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    penalty_type VARCHAR(50),
    amount DECIMAL(19,2),
    percentage DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Exchange rates table
CREATE TABLE IF NOT EXISTS exchange_rates (
    id BIGSERIAL PRIMARY KEY,
    currency_id BIGINT NOT NULL,
    buy_rate DECIMAL(10,4),
    sell_rate DECIMAL(10,4),
    date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_exchange_rates_currency FOREIGN KEY (currency_id) REFERENCES currencies(id)
);

-- Day closures table
CREATE TABLE IF NOT EXISTS day_closures (
    id BIGSERIAL PRIMARY KEY,
    date DATE UNIQUE NOT NULL,
    closed BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Task events table
CREATE TABLE IF NOT EXISTS task_events (
    id BIGSERIAL PRIMARY KEY,
    event_type VARCHAR(100) NOT NULL,
    description TEXT,
    installment_datetime TIMESTAMP,
    grouped BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Task events participants table  
CREATE TABLE IF NOT EXISTS task_events_participants (
    id BIGSERIAL PRIMARY KEY,
    task_event_id BIGINT NOT NULL,
    user_id BIGINT,
    type VARCHAR(50),
    CONSTRAINT fk_task_events_participants_task FOREIGN KEY (task_event_id) REFERENCES task_events(id),
    CONSTRAINT fk_task_events_participants_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Messages table
CREATE TABLE IF NOT EXISTS messages (
    id BIGSERIAL PRIMARY KEY,
    subject VARCHAR(255),
    content TEXT,
    sender_id BIGINT,
    recipient_id BIGINT,
    read BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_messages_sender FOREIGN KEY (sender_id) REFERENCES users(id),
    CONSTRAINT fk_messages_recipient FOREIGN KEY (recipient_id) REFERENCES users(id)
);

-- Profiles accounts mapping table
CREATE TABLE IF NOT EXISTS profiles_accounts (
    profile_id BIGINT NOT NULL,
    account_id BIGINT NOT NULL,
    PRIMARY KEY (profile_id, account_id),
    CONSTRAINT fk_profiles_accounts_profile FOREIGN KEY (profile_id) REFERENCES profiles(id),
    CONSTRAINT fk_profiles_accounts_account FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Transaction templates table
CREATE TABLE IF NOT EXISTS transaction_template (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

-- Transaction template accounts table
CREATE TABLE IF NOT EXISTS transaction_template_accounts (
    id BIGSERIAL PRIMARY KEY,
    template_id BIGINT NOT NULL,
    account_id BIGINT NOT NULL,
    is_debit BOOLEAN NOT NULL,
    CONSTRAINT fk_template_accounts_template FOREIGN KEY (template_id) REFERENCES transaction_template(id),
    CONSTRAINT fk_template_accounts_account FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Checker request table (for approval workflows)
CREATE TABLE IF NOT EXISTS checker_request (
    id BIGSERIAL PRIMARY KEY,
    action VARCHAR(100) NOT NULL,
    content TEXT,
    status VARCHAR(50) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    reviewed_at TIMESTAMP,
    reviewed_by_id BIGINT,
    CONSTRAINT fk_checker_request_creator FOREIGN KEY (created_by_id) REFERENCES users(id),
    CONSTRAINT fk_checker_request_reviewer FOREIGN KEY (reviewed_by_id) REFERENCES users(id)
);

-- Request table (general requests)
CREATE TABLE IF NOT EXISTS request (
    id BIGSERIAL PRIMARY KEY,
    type VARCHAR(100) NOT NULL,
    content TEXT,
    status VARCHAR(50) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_request_creator FOREIGN KEY (created_by_id) REFERENCES users(id)
);

-- Searchable profiles table
CREATE TABLE IF NOT EXISTS searchable_profiles (
    id BIGSERIAL PRIMARY KEY,
    profile_id BIGINT NOT NULL,
    search_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_searchable_profiles_profile FOREIGN KEY (profile_id) REFERENCES profiles(id)
);

-- Company/Group member tables  
CREATE TABLE IF NOT EXISTS companies_members (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL,
    person_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_companies_members_company FOREIGN KEY (company_id) REFERENCES profiles(id),
    CONSTRAINT fk_companies_members_person FOREIGN KEY (person_id) REFERENCES profiles(id)
);

CREATE TABLE IF NOT EXISTS groups_members (
    id BIGSERIAL PRIMARY KEY,
    group_id BIGINT NOT NULL,
    person_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_groups_members_group FOREIGN KEY (group_id) REFERENCES profiles(id),
    CONSTRAINT fk_groups_members_person FOREIGN KEY (person_id) REFERENCES profiles(id)
);

-- Attachment tables
CREATE TABLE IF NOT EXISTS people_attachments (
    id BIGSERIAL PRIMARY KEY,
    owner_id BIGINT NOT NULL,
    filename VARCHAR(255) NOT NULL,
    content_type VARCHAR(100),
    file_size BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_people_attachments_owner FOREIGN KEY (owner_id) REFERENCES profiles(id)
);

CREATE TABLE IF NOT EXISTS companies_attachments (
    id BIGSERIAL PRIMARY KEY,
    owner_id BIGINT NOT NULL,
    filename VARCHAR(255) NOT NULL,
    content_type VARCHAR(100),
    file_size BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_companies_attachments_owner FOREIGN KEY (owner_id) REFERENCES profiles(id)
);

CREATE TABLE IF NOT EXISTS groups_attachments (
    id BIGSERIAL PRIMARY KEY,
    owner_id BIGINT NOT NULL,
    filename VARCHAR(255) NOT NULL,
    content_type VARCHAR(100),
    file_size BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_groups_attachments_owner FOREIGN KEY (owner_id) REFERENCES profiles(id)
);

-- Group custom fields (similar to people and companies)
CREATE TABLE IF NOT EXISTS groups_custom_fields_sections (
    id BIGSERIAL PRIMARY KEY,
    caption VARCHAR(255) NOT NULL,
    "order" INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT
);

CREATE TABLE IF NOT EXISTS groups_custom_fields (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    caption VARCHAR(255) NOT NULL,
    field_type VARCHAR(50) NOT NULL,
    section_id BIGINT,
    "order" INTEGER,
    required BOOLEAN DEFAULT false,
    unique_constraint BOOLEAN DEFAULT false,
    extra TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id BIGINT,
    CONSTRAINT fk_groups_custom_fields_section FOREIGN KEY (section_id) REFERENCES groups_custom_fields_sections(id)
);

CREATE TABLE IF NOT EXISTS groups_custom_fields_values (
    id BIGSERIAL PRIMARY KEY,
    owner_id BIGINT NOT NULL,
    field_id BIGINT NOT NULL,
    value TEXT,
    CONSTRAINT fk_groups_custom_fields_values_owner FOREIGN KEY (owner_id) REFERENCES profiles(id),
    CONSTRAINT fk_groups_custom_fields_values_field FOREIGN KEY (field_id) REFERENCES groups_custom_fields(id)
);

-- Views for compatibility
CREATE OR REPLACE VIEW view_operation AS
SELECT 
    id,
    'TILL' as type,
    amount,
    created_at as datetime,
    created_by_id as user_id
FROM till_events;

CREATE OR REPLACE VIEW view_task_event_participants AS
SELECT 
    tep.id,
    tep.task_event_id,
    tep.user_id,
    tep.type,
    u.username,
    u.first_name,
    u.last_name
FROM task_events_participants tep
LEFT JOIN users u ON u.id = tep.user_id
);