# SQL_PROJECTS

## SQL_PROJECT1

## Personal Finance Tracker

This project is a SQL-based personal finance management system. It tracks income, expenses, budgets, recurring bills, and savings goals using a normalized relational database.

###  Features
- Manage multiple users and accounts
- Record income and expenses with tags
- Set budgets and compare with actual spend
- Track savings goal progress
- Alerts for low balances and upcoming payments
- Monthly trends using window functions

###  Tables Used
- Users, Accounts, Transactions, Tags
- Categories, Budgets, RecurringTransactions
- TransactionTags, SavingsGoals

###  SQL Concepts
- Joins, Subqueries, Grouping, CASE
- Window Functions (`LAG()`)
- Views and Foreign Keys

### Tools
- MySQL Workbench 8.x  
- SQL (DDL, DML, Aggregation, Analytics)

### Output
Includes 9 optimized SQL queries with real-world applications like:
- Budget vs Expense Check
- Monthly Summary
- Savings Risk Detection
- Trend Analysis

---



## SQL_PROJECT2
## Social Media Analytics Backend 

This project provides a complete SQL-based backend system designed to track and analyze user engagement on a social media platform. It includes realistic schema design, populated data, and advanced SQL logic such as views, stored procedures, and triggers.

---

### Project Objectives

- Simulate a real-world social media backend with users, posts, likes, and comments.
- Analyze post-level and user-level engagement across multiple years.
- Generate insights using SQL views, functions, and stored procedures.
- Maintain data integrity and automate updates using triggers.

---

### Database Schema

#### Tables:
- Users: Contains user profiles and join dates.
- Posts: Stores post content along with like and comment counters.
- Likes: Tracks likes on posts including user and timestamp.
- Comments: Records comments on posts with user and timestamp.

#### Relationships:
- One-to-many relationships from Users to Posts, and from Posts to Likes/Comments.
- Foreign keys with ON DELETE CASCADE for referential integrity.

---

### Features

- Realistic user and post activity spanning from 2020 to 2025.
- Triggers automatically update like and comment counts when a like or comment is added or deleted.
- Stored Procedure: `GetMonthlyEngagement(year, month)` returns detailed monthly engagement reports.
- Function: `GetPostEngagement(PostID)` calculates a combined engagement score.
- Views:
  - TopLikedPosts: Displays posts ranked by number of likes.
  - PostEngagementScore: Shows engagement scores for each post.
  - RecentEngagementTrends: Tracks engagement over time.
  - TopEngagers: Highlights users who interact the most.
  - CreatorEngagementStats: Summarizes user contribution and impact.

---

### Example Queries

```sql
-- View: Top 5 Most Liked Posts
SELECT * FROM TopLikedPosts LIMIT 5;

-- Monthly Engagement Report
CALL GetMonthlyEngagement(2025, 6);

-- Engagement Score of Post ID 1
SELECT GetPostEngagement(1) AS EngagementScore;

```
## CREATED BY SHUBHDEEP


