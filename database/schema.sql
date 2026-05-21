-- OnTrack Database Schema
-- Target: PostgreSQL (Neon compatible)

-- Enable UUID extension if not already present (gen_random_uuid is standard in Pg 13+)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Finance Entries Table
CREATE TABLE IF NOT EXISTS finance_entries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    description VARCHAR(255) NOT NULL,
    amount NUMERIC(12, 2) NOT NULL,
    type VARCHAR(10) NOT NULL CHECK (type IN ('INCOME', 'EXPENSE')),
    category VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Hobbies Table
CREATE TABLE IF NOT EXISTS hobbies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    frequency_per_week INT NOT NULL DEFAULT 1 CHECK (frequency_per_week > 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 4. Hobby Logs Table (For tracking habit check-ins)
CREATE TABLE IF NOT EXISTS hobby_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    hobby_id UUID NOT NULL,
    date DATE NOT NULL,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (hobby_id) REFERENCES hobbies(id) ON DELETE CASCADE,
    UNIQUE (hobby_id, date) -- Prevents duplicate logs for the same hobby on the same day
);

-- 5. Journal Entries Table
CREATE TABLE IF NOT EXISTS journal_entries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    mood VARCHAR(50),
    date DATE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Indexes for performance optimization (frequent queries by user and date)
CREATE INDEX IF NOT EXISTS idx_finance_user_date ON finance_entries(user_id, date);
CREATE INDEX IF NOT EXISTS idx_hobbies_user ON hobbies(user_id);
CREATE INDEX IF NOT EXISTS idx_hobby_logs_hobby_date ON hobby_logs(hobby_id, date);
CREATE INDEX IF NOT EXISTS idx_journal_user_date ON journal_entries(user_id, date);
