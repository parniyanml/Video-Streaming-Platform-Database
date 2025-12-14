# Video Streaming Platform Database Design 🎥

This repository contains the complete **Relational Database Design** and SQL implementation for a video streaming service similar to YouTube. This project was developed as part of the Database Laboratory course at **Isfahan University of Technology (IUT)**.

**Author:** Parniyan Malekzadeh
**Tech Stack:** SQL (T-SQL), ER Modeling

## 📄 Project Overview
The goal of this project was to design a robust and scalable backend database schema capable of handling user interactions, multimedia content, and subscription models. The system manages entities such as Users, Channels, Videos, Playlists, and Premium Subscriptions.

## 📊 Entity-Relationship Diagram (ERD)
The database follows a normalized relational model. Key relationships include:
* **One-to-Many:** Users -> Channels, Channels -> Videos.
* **Many-to-Many:** Users <-> Channels (Subscriptions), Videos <-> Playlists.

> *[View the full ER Diagram (PDF)](docs/Database_ER_Diagram.pdf)*

## 🛠️ Key Features & Implementation

### 1. Core Schema
The database includes comprehensive tables for:
* **Content Management:** `Videos`, `Channels`, `Playlists`, `Timestamps`.
* **User Management:** `Users`, `PremiumPlans`, `History`, `Subscriptions`.
* **Social Interaction:** `Comments`, `Reactions` (Likes/Dislikes), `InChatMessages`.

### 2. Advanced SQL Logic
The project implements complex logic using Stored Procedures and Triggers:
* **Recommendation Engine:** A stored procedure `RecommendVideosForUser` that suggests content based on user history and popularity.
* **Content Operations:** Procedures like `AddVideoToChannel`, `AddVideoToPlaylist`, and `StartLiveStream`.
* **Subscription Management:** Logic to handle user subscriptions (`RemoveUserSubscription`) and premium plan validity.
* **Security:** Password management procedures (`ResetUserPassword`).

## 📂 Repository Structure
* `sql/`: Contains the `.sql` script for creating tables, views, triggers, and stored procedures.
* `docs/`: Detailed documentation of the database schema, functional dependencies, and design decisions.

---
*Note: This project demonstrates proficiency in SQL Server development and database normalization principles.*
