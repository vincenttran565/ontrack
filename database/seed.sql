-- OnTrack Mock Seed Data
-- For local development and testing
-- BCrypt password hash for 'password123': $2a$10$8.Kclm2G42E.p5x0NpxSxej/Y/.eS69u93PqN0lJ9o/V.Jz8k2q1G

-- Clear existing data (in order of dependencies)
TRUNCATE TABLE hobby_logs CASCADE;
TRUNCATE TABLE hobbies CASCADE;
TRUNCATE TABLE finance_entries CASCADE;
TRUNCATE TABLE journal_entries CASCADE;
TRUNCATE TABLE users CASCADE;

-- 1. Seed Users
-- We define specific UUIDs so we can reference them in child tables
INSERT INTO users (id, username, email, password_hash, created_at)
VALUES 
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'alex_tracker', 'alex@example.com', '$2a$10$8.Kclm2G42E.p5x0NpxSxej/Y/.eS69u93PqN0lJ9o/V.Jz8k2q1G', NOW() - INTERVAL '30 days'),
  ('f6e5d4c3-b2a1-0f9e-8d7c-6b5a4f3e2d1c', 'maria_reflects', 'maria@example.com', '$2a$10$8.Kclm2G42E.p5x0NpxSxej/Y/.eS69u93PqN0lJ9o/V.Jz8k2q1G', NOW() - INTERVAL '15 days');

-- 2. Seed Finance Entries (Alex)
INSERT INTO finance_entries (user_id, description, amount, type, category, date)
VALUES
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Bi-weekly Salary', 2500.00, 'INCOME', 'Salary', CURRENT_DATE - INTERVAL '14 days'),
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Whole Foods Groceries', 124.50, 'EXPENSE', 'Groceries', CURRENT_DATE - INTERVAL '12 days'),
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Monthly Rent Payment', 1200.00, 'EXPENSE', 'Rent', CURRENT_DATE - INTERVAL '10 days'),
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Electric Utility Bill', 85.20, 'EXPENSE', 'Utilities', CURRENT_DATE - INTERVAL '8 days'),
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Freelance Web Design', 450.00, 'INCOME', 'Freelance', CURRENT_DATE - INTERVAL '5 days'),
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Local Coffee Shop', 6.75, 'EXPENSE', 'Dining Out', CURRENT_DATE - INTERVAL '2 days'),
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Netflix Subscription', 15.49, 'EXPENSE', 'Subscriptions', CURRENT_DATE);

-- 3. Seed Hobbies (Alex & Maria)
INSERT INTO hobbies (id, user_id, name, description, frequency_per_week)
VALUES
  ('11111111-2222-3333-4444-555555555555', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Running', 'Goal: Train for a half marathon and log progress weekly.', 3),
  ('22222222-3333-4444-5555-666666666666', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Reading', 'Read 20 pages of standard fiction/non-fiction daily.', 7),
  ('33333333-4444-5555-6666-777777777777', 'f6e5d4c3-b2a1-0f9e-8d7c-6b5a4f3e2d1c', 'Watercolor Painting', 'Paint miniature landscapes and explore colors.', 2);

-- 4. Seed Hobby Logs (Alex's Running & Reading logs)
INSERT INTO hobby_logs (hobby_id, date, notes)
VALUES
  ('11111111-2222-3333-4444-555555555555', CURRENT_DATE - INTERVAL '5 days', 'Did an easy 5k. Felt light on my feet.'),
  ('11111111-2222-3333-4444-555555555555', CURRENT_DATE - INTERVAL '3 days', 'Tempo run: 8k at 5:10/km pace. Hard but satisfying.'),
  ('11111111-2222-3333-4444-555555555555', CURRENT_DATE - INTERVAL '1 day', 'Long slow run: 12k. Knees felt a bit sore near the end.'),
  ('22222222-3333-4444-5555-666666666666', CURRENT_DATE - INTERVAL '2 days', 'Finished chapter 4 of Atomic Habits. Great points on environment design.'),
  ('22222222-3333-4444-5555-666666666666', CURRENT_DATE - INTERVAL '1 day', 'Read chapter 5. Started setting up daily implementation intentions.'),
  ('33333333-4444-5555-6666-777777777777', CURRENT_DATE - INTERVAL '4 days', 'Completed a small sunset sketch. Practiced wet-on-wet technique.');

-- 5. Seed Journal Entries (Maria)
INSERT INTO journal_entries (user_id, title, content, mood, date)
VALUES
  ('f6e5d4c3-b2a1-0f9e-8d7c-6b5a4f3e2d1c', 'A Fresh Start', 'Today I decided to finally set up a routine and focus on self-improvement. Spent some time cleaning my desk and setting up my goals. Feeling excited about what is to come.', 'Motivated', CURRENT_DATE - INTERVAL '4 days'),
  ('f6e5d4c3-b2a1-0f9e-8d7c-6b5a4f3e2d1c', 'Mid-week Slump', 'Felt a bit overwhelmed today with work tasks piling up. Took a short walk in the afternoon to clear my head which helped a bit. Need to prioritize sleep tonight.', 'Tired', CURRENT_DATE - INTERVAL '2 days'),
  ('f6e5d4c3-b2a1-0f9e-8d7c-6b5a4f3e2d1c', 'Breakthrough in Painting', 'Had a highly relaxing evening experimenting with watercolors. The sunset landscape turned out better than expected. It is amazing how focusing on a simple creative task can relieve stress.', 'Peaceful', CURRENT_DATE - INTERVAL '1 day');
