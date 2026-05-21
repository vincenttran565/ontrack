# 🗄️ OnTrack Database Setup Guide

This guide describes how to configure your **Neon PostgreSQL** database instance, initialize the tables, and load the development seed data.

---

## 🚀 Step 1: Create a Neon Database Instance

1. Go to [Neon.tech](https://neon.tech/) and sign up / log in.
2. Click **Create Project**.
3. Name your project (e.g., `ontrack-db`).
4. Select the PostgreSQL version (v15 or v16 recommended) and your preferred region.
5. Click **Create Project**.
6. Save your **Database Connection String** (it will look similar to this):
   ```text
postgresql://neondb_owner:npg_nqy84cBXuMKt@ep-long-hill-aqepi51g.c-8.us-east-1.aws.neon.tech/neondb?sslmode=require
   ```

---

## 🛠️ Step 2: Initialize the Database Schema

You can execute the SQL queries directly using Neon's online SQL Editor or any database GUI tool (e.g., pgAdmin, DBeaver, or VS Code SQL tools).

### Option A: Using the Neon Web Console (Easiest)
1. In the Neon Console sidebar, click on **SQL Editor**.
2. Copy the entire contents of [schema.sql](file:///c:/Users/vince/git/ontrack/ontrack/database/schema.sql).
3. Paste it into the Neon SQL Editor and click **Run**.
4. (Optional) Create a new tab in the SQL Editor, copy the contents of [seed.sql](file:///c:/Users/vince/git/ontrack/ontrack/database/seed.sql), paste it, and click **Run** to load test data.

### Option B: Using the PostgreSQL CLI (`psql`)
If you have `psql` installed locally, you can run the files directly from your terminal:
```bash
# Execute schema setup
psql "your-neon-connection-string" -f database/schema.sql

# Execute seed data population (optional)
psql "your-neon-connection-string" -f database/seed.sql
```

---

## ⚙️ Step 3: Configure Spring Boot (Backend Connection)

Once the tables are created, you will configure your Spring Boot backend to point to your Neon database. 

Create a file named `src/main/resources/application.yml` (or `.properties`) inside your Spring Boot project and configure the datasource:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://ep-cool-snowflake-123456.us-east-2.aws.neon.tech/neondb?sslmode=require
    username: YOUR_NEON_USERNAME
    password: YOUR_NEON_PASSWORD
    driver-class-name: org.postgresql.Driver
  jpa:
    database-platform: org.hibernate.dialect.PostgreSQLDialect
    hibernate:
      ddl-auto: validate # Use 'validate' since we are manually running migration scripts
    show-sql: true
    properties:
      hibernate:
        format_sql: true
```

> [!TIP]
> In production environments (like Render), you should use environment variables rather than hardcoding credentials:
> - `SPRING_DATASOURCE_URL`: `jdbc:postgresql://<neon-host>/neondb?sslmode=require`
> - `SPRING_DATASOURCE_USERNAME`: `<username>`
> - `SPRING_DATASOURCE_PASSWORD`: `<password>`
