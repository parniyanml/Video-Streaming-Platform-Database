# Video Streaming Platform Database

## Overview

This repository contains the comprehensive database design and implementation for a video streaming platform analogous to YouTube. The project demonstrates a robust relational database architecture capable of handling users, channels, videos, live streams, playlists, and complex social interactions.

The implementation utilizes advanced SQL features, including Entity-Relationship (ER) modeling, Stored Procedures, Triggers, User-Defined Functions, and Views to enforce business logic, data integrity, and analytical reporting.

## Features

* **User Management:** Handles user registration, authentication, profile updates, and premium subscription plans.
* **Content Management:** efficient storage for videos, channels, playlists, and timestamps.
* **Live Streaming:** Support for live stream scheduling and real-time chat message storage.
* **Engagement System:** Complex interaction tracking including subscriptions, likes/dislikes, comments, replies, and watch history.
* **Automated Auditing:** Trigger-based logging for critical actions such as video deletions, user profile updates, and like count tracking.
* **Recommendation Engine:** Logic to calculate video popularity scores and generate personalized user recommendations.
* **Analytics & Reporting:** Pre-built views for identifying trending content, fastest-growing channels, and user engagement metrics.

## Database Schema

The database is designed using relational principles, incorporating weak entities and appropriate foreign key constraints. The core tables include:

### Core Entities
* **Users:** Stores account credentials, demographic data, and contact information.
* **Channels:** Represents user-owned channels with aggregated metrics (subscribers, views).
* **Videos:** Central content table containing metadata, metrics, and upload details.
* **PremiumPlans:** Manages subscription start and expiration dates.

### Content & Organization
* **Playlists:** User-curated collections of videos.
* **PlaylistVideos:** Association table linking videos to playlists.
* **Timestamps:** Bookmarks/chapters within specific videos.
* **Streams:** Manages start and end times for live broadcasts.

### Interactions
* **Subscriptions:** Tracks user subscriptions to channels with notification preferences.
* **History:** detailed logs of user watch history including checkpoint times.
* **Comments:** User comments on videos.
* **Reactions:** Likes or dislikes on comments.
* **InChatMessages:** Real-time messages sent during live streams.

### Logs & Audits
* **UserUpdateLog:** Tracks changes to sensitive user data (email/name).
* **VideoDeletionLog:** Archives metadata of deleted videos for recovery or auditing.
* **VideoLikesLog:** Tracks changes in video like counts over time.

## Programmability

The project heavily utilizes database programmability to abstract logic from the application layer.

### Stored Procedures
Procedures handle transactional operations and complex business logic:
* `AddVideoToChannel`: Inserts video metadata and updates channel statistics.
* `RecommendVideosForUser`: Generates a personalized list of videos based on viewing history and popularity algorithms.
* `StartLiveStream` / `EndLiveStream`: Manages the lifecycle of a broadcast.
* `AddPremiumSubscription`: Calculates expiration dates and updates user status.
* `ResetUserPassword`: Securely updates user credentials.

### Triggers
Triggers ensure data consistency and automate side effects:
* `trg_IncreaseSubscribersCount`: Automatically updates channel subscriber counts upon new subscriptions.
* `trg_ValidatePhoneNumber`: Enforces format constraints on user phone numbers.
* `trg_PreventChannelDeletion`: Prevents accidental deletion of channels that still contain active videos.
* `trg_LogUserUpdates`: Automatically records changes to user profiles in the audit log.
* `trg_CalculateVideoPopularity`: Maintains data integrity for engagement metrics on insert/update.

### User-Defined Functions
Functions encapsulate reusable calculations:
* `dbo.GetVideoPopularityScore`: complex algorithm weighting views (40%), likes (30%), comments (20%), and recency.
* `dbo.CheckPremiumStatus`: Determines if a user has an active subscription.
* `dbo.GetChannelRevenue`: Estimates revenue based on view counts and CPM rates.
* `dbo.GetInactiveUsers`: Identifies users with no activity in the last 30 days.

### Views
Views provide simplified interfaces for complex joins and reporting:
* `TrendingVideos`: Filters and sorts videos uploaded in the last 7 days by popularity score.
* `ChannelPerformanceSummary`: Aggregates total views, likes, and engagement rates for channels.
* `UserWatchHistory`: Combines user data, video metadata, and watch timestamps into a readable format.
* `FastestGrowingChannels`: Calculates daily growth rates based on join date and subscriber count.

## Files Included

* `Implementation.sql`: The complete SQL script containing DDL (schema creation) and DML (data insertion, logic implementation).
* `ERD.pdf`: The Entity-Relationship Diagram visualizing the database structure.
* `Documentation.pdf`: Detailed documentation of the project requirements, schema explanations, and logic descriptions.

## Getting Started

1.  Ensure you have a SQL Server instance running (e.g., Microsoft SQL Server).
2.  Open `Implementation.sql` in a tool like SQL Server Management Studio (SSMS) or Azure Data Studio.
3.  Execute the script to build the schema, populate seed data, and create all programmable objects.
4.  Use the provided Stored Procedures to interact with the data (e.g., `EXEC AddVideoToChannel ...`).

## Database Design Principles

This project adheres to strict database design principles:
* **Normalization:** Tables are normalized to reduce redundancy.
* **Weak Entities:** Correct handling of dependent entities (e.g., Timestamps depend on Videos).
* **Data Integrity:** extensive use of Primary Keys, Foreign Keys, and Check Constraints (e.g., restricting Gender or Reaction types).
* **Performance:** usage of computed columns and indexed views for high-read scenarios.

## Credits

**Project By:** Parniyan Malekzadeh
**Supervisor:** Dr. Basiri
**Institution:** Isfahan University of Technology
