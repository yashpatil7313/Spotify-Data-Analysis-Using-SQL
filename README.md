# 🎵 Spotify Data Analysis using SQL

## 📌 Project Overview

This project focuses on analyzing a Spotify dataset using **MySQL**.  
It covers data cleaning, basic to advanced SQL queries, and real-world analytical problems using:

- Aggregations
- Subqueries
- GROUP BY & HAVING
- Window Functions
- CTE (Common Table Expressions)
- Ranking Functions
- Cumulative Calculations

This project demonstrates strong SQL fundamentals and intermediate-to-advanced querying skills.

---

## 🗂 Database Information

**Database Name:** `spotify_db`  
**Main Table:** `spotify` / `cleaned_dataset_data`

The dataset includes information about:
- Artist
- Track
- Album
- Energy, Danceability, Liveness
- Views, Likes, Comments
- Streams (Spotify & YouTube)
- Official Video & Licensing Info

---

## 🧹 Data Cleaning Performed

- Removed tracks with zero duration
- Checked distinct values for categorical columns
- Validated boolean columns
- Handled NULL values using `COALESCE()`

---

## 📊 SQL Concepts Used

### 🔹 Basic Queries
- Filtering using `WHERE`
- Aggregate functions (`SUM`, `AVG`, `COUNT`, `MAX`, `MIN`)
- Sorting using `ORDER BY`
- Grouping using `GROUP BY`

### 🔹 Intermediate Queries
- Subqueries
- Conditional Aggregation using `CASE`
- Comparing platform streams (Spotify vs YouTube)
- Album-level analytics

### 🔹 Advanced Queries
- CTE (WITH clause)
- Window Functions
- `DENSE_RANK()`
- Partitioning using `PARTITION BY`
- Cumulative Sum using `SUM() OVER()`
- Energy-to-Liveness ratio calculation

---

## 🚀 Key Business Insights Generated

- Top 3 most viewed tracks per artist
- Tracks streamed more on Spotify than YouTube
- Albums with highest energy variation
- Tracks with above-average liveness
- Cumulative likes ordered by views

---

## 🛠 Tools Used

- MySQL
- SQL Window Functions
- GitHub for version control

---

## 🎯 Learning Outcome

Through this project, I strengthened my understanding of:

- Writing optimized SQL queries
- Handling analytical problems
- Using window functions for ranking
- Structuring real-world SQL projects
- Preparing portfolio-ready SQL work

---

## 👨‍💻 Author

**Yash Patil**  
Aspiring Data Engineer | SQL & Python Learner  
Goal: Becoming Data Engineer by 2027 🚀

---

⭐ If you found this project useful, feel free to star the repository!
