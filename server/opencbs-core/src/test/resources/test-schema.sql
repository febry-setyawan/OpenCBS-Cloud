-- Minimal schema for testing PostgreSQL + Flyway integration
-- This creates the essential tables needed for basic tests to run

-- Create users table (referenced by other tables)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    username VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    enabled BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create branches table
CREATE TABLE IF NOT EXISTS branches (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(50),
    address VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create profiles table (core entity for the system)
CREATE TABLE IF NOT EXISTS profiles (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_id INTEGER REFERENCES users(id),
    branch_id INTEGER REFERENCES branches(id)
);

-- Create a simple permissions table
CREATE TABLE IF NOT EXISTS permissions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description VARCHAR(500)
);

-- Insert basic test data
INSERT INTO users (first_name, last_name, username, password_hash) 
VALUES ('Test', 'User', 'testuser', '$2a$10$test.hash.here') 
ON CONFLICT (username) DO NOTHING;

INSERT INTO branches (name, code, address)
VALUES ('Test Branch', 'TB001', 'Test Address')
ON CONFLICT DO NOTHING;

INSERT INTO permissions (name, description)
VALUES ('READ_PROFILE', 'Permission to read profiles')
ON CONFLICT (name) DO NOTHING;