/*
==============================================================
PROJECT TITLE : Spotify Data Analysis using Advanced SQL
DATABASE      : MySQL
LEVEL         : Beginner to Advanced
AUTHOR        : Yash Patil
GOAL          : Practice Aggregations, Subqueries, CTE,
                Window Functions & Data Cleaning
==============================================================
*/

-- ==========================================================
-- 1️⃣ DATABASE SETUP
-- ==========================================================

CREATE DATABASE IF NOT EXISTS spotify_db;
USE spotify_db;

-- Drop table if already exists
DROP TABLE IF EXISTS spotify;

-- Create main table structure
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- ==========================================================
-- 2️⃣ DATA CLEANING
-- ==========================================================

-- Remove tracks with zero duration
SET SQL_SAFE_UPDATES = 0;

DELETE FROM cleaned_dataset_data
WHERE duration_min = 0;

-- ==========================================================
-- 3️⃣ BASIC ANALYSIS (Easy Level)
-- ==========================================================

-- Q1: Tracks with more than 1 Billion streams
SELECT track, stream
FROM cleaned_dataset_data
WHERE stream > 1000000000;

-- Q2: List all albums with their respective artists
SELECT DISTINCT album, artist
FROM cleaned_dataset_data
ORDER BY album;

-- Q3: Total comments for licensed tracks
SELECT SUM(comments) AS total_comments
FROM cleaned_dataset_data
WHERE licensed = TRUE;

-- Q4: Tracks that belong to album type 'single'
SELECT track, album
FROM cleaned_dataset_data
WHERE album_type = 'single';

-- Q5: Total number of tracks by each artist
SELECT artist,
       COUNT(*) AS total_tracks
FROM cleaned_dataset_data
GROUP BY artist
ORDER BY total_tracks DESC;

-- ==========================================================
-- 4️⃣ INTERMEDIATE ANALYSIS
-- ==========================================================

-- Q6: Average danceability per album
SELECT album,
       AVG(danceability) AS avg_danceability
FROM cleaned_dataset_data
GROUP BY album
ORDER BY avg_danceability DESC;

-- Q7: Top 5 tracks with highest energy
SELECT track,
       energy
FROM cleaned_dataset_data
ORDER BY energy DESC
LIMIT 5;

-- Q8: Tracks with views & likes where official video = TRUE
SELECT track,
       SUM(views) AS total_views,
       SUM(likes) AS total_likes
FROM cleaned_dataset_data
WHERE official_video = TRUE
GROUP BY track;

-- Q9: Total views per album
SELECT album,
       SUM(views) AS total_album_views
FROM cleaned_dataset_data
GROUP BY album
ORDER BY total_album_views DESC;

-- Q10: Tracks streamed more on Spotify than YouTube
WITH platform_streams AS (
    SELECT 
        track,
        COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS youtube_streams,
        COALESCE(SUM(CASE WHEN most_played_on = 'spotify' THEN stream END),0) AS spotify_streams
    FROM cleaned_dataset_data
    GROUP BY track
)

SELECT *
FROM platform_streams
WHERE spotify_streams > youtube_streams
AND spotify_streams <> 0;

-- ==========================================================
-- 5️⃣ ADVANCED ANALYSIS
-- ==========================================================

-- Q11: Top 3 most viewed tracks per artist (Window Function)
WITH ranking_artist AS (
    SELECT
        artist,
        track,
        SUM(views) AS total_views,
        DENSE_RANK() OVER(
            PARTITION BY artist 
            ORDER BY SUM(views) DESC
        ) AS artist_rank
    FROM cleaned_dataset_data
    GROUP BY artist, track
)

SELECT *
FROM ranking_artist
WHERE artist_rank <= 3
ORDER BY artist, artist_rank;

-- Q12: Tracks where liveness is above overall average
SELECT track,
       artist,
       liveness
FROM cleaned_dataset_data
WHERE liveness > (
    SELECT AVG(liveness) 
    FROM cleaned_dataset_data
);

-- Q13: Difference between highest and lowest energy per album
WITH energy_cte AS (
    SELECT album,
           MAX(energy) AS highest_energy,
           MIN(energy) AS lowest_energy
    FROM cleaned_dataset_data
    GROUP BY album
)

SELECT album,
       highest_energy - lowest_energy AS energy_difference
FROM energy_cte
ORDER BY energy_difference DESC;

-- Q14: Tracks where energy-to-liveness ratio > 1.2
SELECT track,
       artist,
       energy,
       liveness,
       (energy / liveness) AS energy_liveness_ratio
FROM cleaned_dataset_data
WHERE liveness <> 0
AND (energy / liveness) > 1.2;

-- Q15: Cumulative sum of likes ordered by views
SELECT track,
       views,
       likes,
       SUM(likes) OVER(ORDER BY views DESC) AS cumulative_likes
FROM cleaned_dataset_data;







