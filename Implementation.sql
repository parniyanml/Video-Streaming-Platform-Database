CREATE TABLE Users (
    UserID INT identity PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PhoneNumber VARCHAR(15),
    EmailAddress VARCHAR(100) UNIQUE,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(100),
    Gender VARCHAR(10) check (Gender in('Male', 'Female', 'Other')),
    BirthDate DATE
);


CREATE TABLE PremiumPlans (
    PremiumID INT identity PRIMARY KEY,
    UserID INT,
    StartDate DATE,
    ExpirationDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE Channels (
    ChannelID INT identity PRIMARY KEY,
    UserID INT,
    SubscribersCount INT DEFAULT 0,
    TotalViews INT DEFAULT 0,
    VideosCount INT DEFAULT 0,
    Description NVARCHAR(MAX),
    Region VARCHAR(50),
    DateJoined DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE Videos (
    VideoID INT identity PRIMARY KEY,
    ChannelID INT,
    Title VARCHAR(255),
    Description TEXT,
    Duration TIME,
    UploadDate DATE,
    Views INT DEFAULT 0,
    LikesCount INT DEFAULT 0,
    CommentsCount INT DEFAULT 0,
    FOREIGN KEY (ChannelID) REFERENCES Channels(ChannelID)
);


CREATE TABLE Timestamps (
    TimestampID INT identity PRIMARY KEY,
    VideoID INT,
    TimeOnVideo TIME,
    Title VARCHAR(255),
    FOREIGN KEY (VideoID) REFERENCES Videos(VideoID)
);


CREATE TABLE History (
    HistoryID INT identity PRIMARY KEY,
    UserID INT,
    VideoID INT,
    WatchDate DATE,
    CheckpointTime TIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (VideoID) REFERENCES Videos(VideoID)
);


CREATE TABLE Subscriptions (
    SubscriptionID INT identity PRIMARY KEY,
    UserID INT,
    ChannelID INT,
    NotificationType VARCHAR(11) check(NotificationType in ('All', 'Recommended', 'None')),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ChannelID) REFERENCES Channels(ChannelID)
);


CREATE TABLE Playlists (
    PlaylistID INT identity PRIMARY KEY,
    UserID INT,
    Name VARCHAR(255),
    IsPublic bit,
    LastModified DATE,
    VideoCount INT DEFAULT 0,
    Views INT DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE PlaylistVideos (
    PlaylistVideoID INT identity PRIMARY KEY,
    PlaylistID INT,
    VideoID INT,
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
    FOREIGN KEY (VideoID) REFERENCES Videos(VideoID)
);


CREATE TABLE Streams (
    StreamID INT identity PRIMARY KEY,
    ChannelID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    FOREIGN KEY (ChannelID) REFERENCES Channels(ChannelID)
);


CREATE TABLE InChatMessages (
    MessageID INT identity PRIMARY KEY,
    StreamID INT,
    UserID INT,
    Content TEXT,
    SentTime DATETIME,
    FOREIGN KEY (StreamID) REFERENCES Streams(StreamID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE Comments (
    CommentID INT identity PRIMARY KEY,
    VideoID INT,
    UserID INT,
    Content TEXT,
    PostedTime DATETIME,
    LikesCount INT DEFAULT 0,
    RepliesCount INT DEFAULT 0,
    FOREIGN KEY (VideoID) REFERENCES Videos(VideoID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE Reactions (
    ReactionID INT identity PRIMARY KEY,
    CommentID INT,
    UserID INT,
    ReactionType VARCHAR(10) check(ReactionType in('Like', 'Dislike')),
    ReactionTime DATETIME,
    FOREIGN KEY (CommentID) REFERENCES Comments(CommentID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


INSERT INTO Users (FirstName, LastName, PhoneNumber, EmailAddress, Username, Password, Gender, BirthDate)
VALUES
('Ali', 'Ahmadi', '09121234567', 'ali.ahmadi@gmail.com', 'ali123', 'password123', 'Male', '1990-05-15'),
('Sara', 'Hosseini', '09139876543', 'sara.hosseini@yahoo.com', 'sara_h', 'passw0rd', 'Female', '1995-11-20'),
('Reza', 'Moradi', '09131231234', 'reza.moradi@hotmail.com', 'reza_m', 'mysecurepassword', 'Male', '1988-07-30'),
('Niloofar', 'Shirazi', '09124567890', 'niloofar.shirazi@gmail.com', 'niloofar_s', 'nilo123', 'Female', '1992-03-12'),
('Mehdi', 'Karimi', '09124567891', 'mehdi.karimi@gmail.com', 'mehdi_k', 'secureMehdi123', 'Male', '1993-02-18'),
('Fatemeh', 'Azimi', '09139876544', 'fatemeh.azimi@yahoo.com', 'fatemeh_az', 'strongpassword', 'Female', '1998-09-12'),
('Hamed', 'Rostami', '09121234568', 'hamed.rostami@hotmail.com', 'hamed_r', 'mysecure123', 'Male', '1987-06-05'),
('Shirin', 'Ramezani', '09131231235', 'shirin.ramezani@gmail.com', 'shirin_r', 'mypassword', 'Female', '1990-10-30'),
('Farhad', 'Jafari', '09131231236', 'farhad.jafari@gmail.com', 'farhad_j', 'farhadpass', 'Male', '1991-12-25'),
('Parisa', 'Rahimi', '09123456789', 'parisa.rahimi@gmail.com', 'parisa_r', 'secureParisa!', 'Female', '1996-04-10'),
('Arman', 'Taheri', '09134567890', 'arman.taheri@yahoo.com', 'arman_t', 'armansafe123', 'Male', '1992-09-15'),
('Leila', 'Kazemi', '09145678901', 'leila.kazemi@outlook.com', 'leila_k', 'leilapass456', 'Female', '1998-03-22'),
('Morteza', 'Ebrahimi', '09156789012', 'morteza.ebrahimi@gmail.com', 'morteza_e', 'secureMorteza!', 'Male', '1989-12-05'),
('Zahra', 'Amini', '09167890123', 'zahra.amini@yahoo.com', 'zahra_a', 'zahrapass123', 'Female', '1993-07-30');


INSERT INTO PremiumPlans (UserID, StartDate, ExpirationDate)
VALUES
(1, '2024-11-01', '2024-12-01'),
(2, '2024-10-15', '2024-12-15'),
(5, '2024-09-01', '2024-11-01'),
(6, '2024-07-20', '2024-12-20'),
(7, '2024-08-15', '2024-10-15'),
(10, '2024-12-01', '2025-01-01'),
(11, '2024-10-20', '2024-12-20'),
(12, '2024-11-15', '2025-02-15'),
(13, '2024-09-25', '2024-12-25'),
(14, '2024-07-10', '2024-10-10');


INSERT INTO Channels (UserID, SubscribersCount, TotalViews, VideosCount, Description, Region, DateJoined)
VALUES
(1, 1500, 45000, 12, 'Ali’s Tech Reviews', 'Tehran', '2022-06-10'),
(2, 3200, 120000, 25, 'Sara’s Lifestyle', 'Mashhad', '2021-08-15'),
(3, 800, 25000, 7, 'Reza’s Cooking Tutorials', 'Isfahan', '2023-01-20'),
(4, 500, 15000, 5, 'Niloofar’s Art Journey', 'Shiraz', '2022-11-05'),
(5, 4000, 180000, 40, 'Mehdi’s Gaming Zone', 'Tehran', '2020-12-01'),
(6, 2500, 90000, 20, 'Fatemeh’s Travel Diary', 'Tabriz', '2021-05-10'),
(7, 1100, 36000, 15, 'Hamed’s Fitness Tips', 'Mashhad', '2022-03-18'),
(8, 1700, 52000, 22, 'Shirin’s Book Reviews', 'Shiraz', '2023-01-01'),
(9, 3500, 150000, 50, 'Farhad’s Coding Academy', 'Isfahan', '2020-07-25'),
(10, 2000, 75000, 18, 'Parisa’s Makeup Tutorials', 'Tehran', '2021-11-11'),
(11, 500, 20000, 8, 'Arman’s Photography Tips', 'Isfahan', '2023-02-10'),
(12, 1500, 60000, 12, 'Leila’s Food Adventures', 'Mashhad', '2022-08-05'),
(13, 800, 30000, 5, 'Morteza’s Life Hacks', 'Shiraz', '2023-03-20'),
(14, 1000, 50000, 10, 'Zahra’s Science Channel', 'Tabriz', '2020-05-30');


INSERT INTO Videos (ChannelID, Title, Description, Duration, UploadDate, Views, LikesCount, CommentsCount)
VALUES
(1, 'Introduction to AI', 'Basics of AI concepts.', '00:15:30', '2023-11-01', 500, 50, 10),
(2, 'Daily Vlog', 'A day in my life.', '00:10:45', '2023-11-05', 1500, 120, 25),
(3, 'How to Cook Pasta', 'Step by step guide.', '00:20:00', '2023-11-10', 800, 60, 15),
(1, 'Advanced AI Techniques', 'Exploring deep learning and neural networks.', '00:25:45', '2023-11-15', 1200, 200, 35),
(2, 'Healthy Breakfast Ideas', 'Quick and easy breakfast recipes.', '00:12:30', '2023-11-18', 950, 85, 20),
(3, 'Baking a Cake', 'Delicious chocolate cake recipe.', '00:18:00', '2023-11-20', 700, 65, 18),
(4, 'Painting Tutorial', 'Learn how to paint landscapes.', '00:22:15', '2023-11-21', 300, 40, 10),
(2, 'Travel Vlog: Paris', 'Exploring the city of lights.', '00:30:00', '2023-11-22', 1700, 250, 50),
(1, 'Building a Chatbot', 'Step-by-step guide to build chatbots.', '00:35:00', '2023-11-23', 1300, 220, 45),
(4, 'Art Inspiration', 'Creative ideas for art projects.', '00:15:00', '2023-11-24', 350, 55, 12),
(5, 'Top 10 PC Games of 2023', 'A review of the top games for PC.', '00:20:45', '2023-10-01', 30000, 1500, 350),
(5, 'Best Gaming Gear', 'A guide to the best gaming accessories.', '00:15:30', '2023-09-15', 20000, 1200, 300),
(5, 'Pro Tips for FPS Games', 'Improve your shooting skills.', '00:25:00', '2023-08-10', 15000, 800, 250),
(6, 'Exploring Istanbul', 'A tour through the beautiful city.', '00:18:00', '2023-09-20', 22000, 1800, 400),
(6, 'Top 5 Beaches in Thailand', 'A guide to the most scenic beaches.', '00:22:45', '2023-10-05', 18000, 1500, 350),
(6, 'Packing Tips for Travelers', 'How to pack smart for trips.', '00:12:30', '2023-07-15', 12000, 1000, 200),
(7, 'Full Body Workout', 'A 30-minute workout for everyone.', '00:30:00', '2023-08-25', 25000, 1700, 400),
(7, 'Best Diets for Weight Loss', 'Learn about effective diets.', '00:20:15', '2023-09-10', 20000, 1400, 350),
(7, 'Stretching Tips', 'Prevent injuries with these tips.', '00:10:00', '2023-07-05', 15000, 1000, 250),
(8, 'Top 5 Mystery Novels', 'The best mystery novels to read.', '00:15:45', '2023-10-12', 18000, 1200, 300),
(8, 'Fantasy Books You Shouldn’t Miss', 'A guide to must-read fantasy books.', '00:20:30', '2023-09-25', 15000, 1000, 250),
(8, 'How to Read More', 'Tips for building a reading habit.', '00:10:15', '2023-08-05', 12000, 800, 200),
(9, 'Intro to Python Programming', 'Basics of Python for beginners.', '00:25:00', '2023-09-15', 50000, 3000, 700),
(9, 'Advanced JavaScript Techniques', 'Master JavaScript with these tips.', '00:30:00', '2023-08-20', 40000, 2500, 600),
(9, 'Building Your First Website', 'Step-by-step guide for beginners.', '00:20:30', '2023-07-10', 30000, 2000, 500),
(10, 'Top 5 Makeup Products', 'A review of my favorite makeup items.', '00:15:00', '2023-12-01', 5000, 300, 50),
(11, 'Photography Basics', 'Learn the essentials of photography.', '00:20:00', '2023-10-01', 1200, 100, 20),
(12, 'Homemade Pizza Recipe', 'A delicious and easy recipe for pizza.', '00:18:30', '2023-11-15', 3000, 200, 35),
(13, 'How to Organize Your Desk', 'Tips for a tidy workspace.', '00:12:45', '2023-09-20', 900, 80, 15),
(14, 'Fun Science Experiments', 'Easy experiments for kids.', '00:25:30', '2023-08-05', 4000, 250, 60);


INSERT INTO Timestamps (VideoID, TimeOnVideo, Title)
VALUES
(1, '00:02:30', 'Introduction to AI concepts'),
(1, '00:10:00', 'Key applications of AI'),
(2, '00:05:15', 'Morning routine tips'),
(3, '00:08:00', 'Cooking pasta preparation'),
(4, '00:20:00', 'Neural network architecture overview'),
(5, '00:09:00', 'Healthy breakfast idea 1'),
(6, '00:05:30', 'Mixing ingredients for cake'),
(7, '00:10:30', 'Basic landscape painting techniques'),
(8, '00:15:00', 'Exploring Paris landmarks');


INSERT INTO History (UserID, VideoID, WatchDate, CheckpointTime)
VALUES
(1, 1, '2023-11-11', '00:10:00'),
(2, 2, '2023-11-12', '00:05:30'),
(1, 3, '2023-11-14', '00:15:00'),
(2, 1, '2023-11-15', '00:08:00'),
(3, 2, '2023-11-16', '00:10:45'),
(4, 3, '2023-11-17', '00:18:30'),
(5, 1, '2023-11-18', '00:12:00'),
(6, 2, '2023-11-19', '00:07:15'),
(7, 3, '2023-11-20', '00:20:00'),
(8, 1, '2023-11-21', '00:05:00'),
(9, 2, '2023-11-22', '00:11:00'),
(10, 1, '2023-12-10', '00:05:00'),
(11, 2, '2023-11-22', '00:10:00'),
(12, 3, '2023-11-30', '00:15:30'),
(13, 4, '2023-11-25', '00:08:45'),
(14, 5, '2023-12-05', '00:20:00');


INSERT INTO Subscriptions (UserID, ChannelID, NotificationType)
VALUES
(1, 2, 'All'),
(2, 1, 'Recommended'),
(10, 2, 'All'),
(11, 5, 'Recommended'),
(12, 6, 'None'),
(13, 8, 'All'),
(14, 9, 'Recommended');


INSERT INTO Playlists (UserID, Name, IsPublic, LastModified, VideoCount, Views)
VALUES
(1, 'Favorite AI Videos', 1, '2023-11-15', 2, 100),
(2, 'Cooking Tutorials', 0, '2023-11-10', 1, 50),
(10, 'Beauty Tips', 1, '2023-12-01', 2, 500),
(11, 'Photography Masterclass', 0, '2023-11-15', 3, 300);


INSERT INTO PlaylistVideos (PlaylistID, VideoID)
VALUES
(1, 1),
(1, 3),
(2, 3),
(3, 1),
(3, 2),
(4, 3),
(4, 4),
(4, 5);


INSERT INTO Streams (ChannelID, StartTime, EndTime)
VALUES
(1, '2023-11-18 20:00:00', '2023-11-18 22:00:00'),
(2, '2023-11-20 19:00:00', '2023-11-20 21:00:00'),
(3, '2023-11-15 18:30:00', '2023-11-15 20:00:00'),
(4, '2023-11-22 20:00:00', '2023-11-22 22:00:00'),
(5, '2023-11-25 21:00:00', '2023-11-25 23:30:00');


INSERT INTO InChatMessages (StreamID, UserID, Content, SentTime)
VALUES
(1, 2, 'This is amazing!', '2023-11-18 20:05:00'),
(1, 3, 'Can you explain more?', '2023-11-18 20:06:30'),
(2, 3, 'This is such a fun vlog!', '2023-11-20 19:15:00'),
(3, 4, 'Amazing cooking tips!', '2023-11-15 18:45:00'),
(4, 6, 'Beautiful artwork!', '2023-11-22 20:30:00'),
(5, 7, 'I love gaming content!', '2023-11-25 21:15:00');


INSERT INTO Comments (VideoID, UserID, Content, PostedTime, LikesCount, RepliesCount)
VALUES
(1, 1, 'Great video!', '2023-11-11 10:00:00', 10, 2),
(1, 2, 'Very informative.', '2023-11-11 12:30:00', 5, 0),
(2, 3, 'This vlog is so inspiring!', '2023-11-05 14:30:00', 15, 3),
(3, 4, 'I’ll try this recipe!', '2023-11-10 16:00:00', 20, 5),
(5, 6, 'Amazing review!', '2023-10-01 18:45:00', 100, 20),
(6, 7, 'I’ve been to Istanbul too!', '2023-09-20 12:00:00', 90, 15);


INSERT INTO Reactions (CommentID, UserID, ReactionType, ReactionTime)
VALUES
(1, 2, 'Like', '2023-11-11 10:30:00'),
(1, 3, 'Like', '2023-11-11 11:00:00'),
(2, 4, 'Like', '2023-11-05 15:00:00'),
(3, 5, 'Like', '2023-11-10 17:00:00'),
(4, 6, 'Dislike', '2023-10-01 19:00:00'),
(1, 7, 'Like', '2023-09-20 13:00:00');





CREATE TRIGGER trg_IncreaseSubscribersCount
ON Subscriptions
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        UPDATE Channels
        SET SubscribersCount = SubscribersCount + 1
        WHERE ChannelID IN (SELECT ChannelID FROM inserted);
    END;
END;


CREATE TRIGGER trg_DecreaseSubscribersCount
ON Subscriptions
AFTER DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        UPDATE Channels
        SET SubscribersCount = SubscribersCount - 1
        WHERE ChannelID IN (SELECT ChannelID FROM deleted);
    END;
END;


CREATE TRIGGER UpdateVideosViewsAfterView
ON History
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        UPDATE Videos
        SET Views = Views + 1
        WHERE VideoID IN (SELECT DISTINCT VideoID FROM inserted);

        UPDATE Playlists
        SET Views = Views + 1
        WHERE PlaylistID IN (
            SELECT DISTINCT P.PlaylistID
            FROM PlaylistVideos PV
            INNER JOIN Playlists P ON P.PlaylistID = PV.PlaylistID
            WHERE PV.VideoID IN (SELECT DISTINCT VideoID FROM inserted)
        );
    END;
END;


CREATE TRIGGER UpdateVideoCountAfterInsert
ON Videos
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        UPDATE Channels
        SET VideosCount = VideosCount + 1
        WHERE ChannelID IN (SELECT DISTINCT ChannelID FROM inserted);
    END;
END;


CREATE TRIGGER trg_CalculateVideoPopularity
ON Videos
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        UPDATE Videos
        SET Views = ISNULL(Views, 0), 
            LikesCount = ISNULL(LikesCount, 0), 
            CommentsCount = ISNULL(CommentsCount, 0)
        WHERE VideoID IN (SELECT VideoID FROM inserted);
    END;
END;


CREATE TRIGGER trg_LogDeletedVideos
ON Videos
AFTER DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO VideoDeletionLog (VideoID, ChannelID, Title, DeletedAt)
        SELECT VideoID, ChannelID, Title, GETDATE()
        FROM deleted;
    END;
END;

CREATE TABLE VideoDeletionLog (
    LogID INT IDENTITY PRIMARY KEY,
    VideoID INT,
    ChannelID INT,
    Title VARCHAR(255),
    DeletedAt DATETIME
);


CREATE TRIGGER trg_PreventChannelDeletion
ON Channels
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Videos 
        WHERE ChannelID IN (SELECT ChannelID FROM deleted)
    )
    BEGIN
        RAISERROR ('Cannot delete channel with existing videos.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM Channels
        WHERE ChannelID IN (SELECT ChannelID FROM deleted);
    END;
END;


CREATE TRIGGER trg_UpdatePlaylistPopularity
ON PlaylistVideos
AFTER INSERT, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted) OR EXISTS (SELECT 1 FROM deleted)
    BEGIN
        UPDATE Playlists
        SET Views = ISNULL((SELECT SUM(V.Views)
                            FROM PlaylistVideos PV
                            INNER JOIN Videos V ON PV.VideoID = V.VideoID
                            WHERE PV.PlaylistID = Playlists.PlaylistID), 0),
            VideoCount = ISNULL((SELECT COUNT(*)
                                 FROM PlaylistVideos PV
                                 WHERE PV.PlaylistID = Playlists.PlaylistID), 0)
        WHERE PlaylistID IN (
            SELECT PlaylistID FROM inserted
            UNION
            SELECT PlaylistID FROM deleted
        );
    END;
END;


CREATE TRIGGER trg_ValidatePhoneNumber
ON Users
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
    FROM inserted
    WHERE PhoneNumber NOT LIKE '0%'
        OR LEN(PhoneNumber) > 15
        OR PhoneNumber LIKE '%[^0-9]%'    
    )
    BEGIN
        RAISERROR('Invalid phone number format. It must contain only digits and be at most 15 characters.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Users
            (FirstName, LastName, PhoneNumber, EmailAddress, Username, Password, Gender, BirthDate)
        SELECT FirstName, LastName, PhoneNumber, EmailAddress, Username, Password, Gender, BirthDate
        FROM inserted;
    END
END;


CREATE TRIGGER trg_PreventInvalidChannelForVideo
ON Videos
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
    FROM inserted I
        LEFT JOIN Channels C ON I.ChannelID = C.ChannelID
    WHERE C.ChannelID IS NULL
    )
    BEGIN
        RAISERROR ('Cannot insert video for a non-existent channel.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Videos
            (ChannelID, Title, Description, Duration, UploadDate, Views, LikesCount, CommentsCount)
        SELECT ChannelID, Title, Description, Duration, UploadDate, Views, LikesCount, CommentsCount
        FROM inserted
    END
END;


CREATE TRIGGER trg_LogUserUpdates
ON Users
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO UserUpdateLog (UserID, OldEmail, NewEmail, OldName, NewName, UpdatedAt)
        SELECT
            d.UserID,
            d.EmailAddress AS OldEmail,
            i.EmailAddress AS NewEmail,
            CONCAT(d.FirstName, ' ', d.LastName) AS OldName,
            CONCAT(i.FirstName, ' ', i.LastName) AS NewName,
            GETDATE()
        FROM deleted d
        INNER JOIN inserted i ON d.UserID = i.UserID
        WHERE d.EmailAddress <> i.EmailAddress
           OR CONCAT(d.FirstName, ' ', d.LastName) <> CONCAT(i.FirstName, ' ', i.LastName);
    END;
END;

CREATE TABLE UserUpdateLog (
    LogID INT IDENTITY PRIMARY KEY,
    UserID INT,
    OldEmail VARCHAR(255),
    NewEmail VARCHAR(255),
    OldName VARCHAR(255),
    NewName VARCHAR(255),
    UpdatedAt DATETIME
);


CREATE TRIGGER trg_PreventEmptyComments
ON Comments
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE LTRIM(RTRIM(CAST(Content AS NVARCHAR(MAX)))) = ''
    )
    BEGIN
        RAISERROR ('Comment content cannot be empty.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Comments (VideoID, UserID, Content, PostedTime, LikesCount, RepliesCount)
        SELECT VideoID, UserID, Content, PostedTime, LikesCount, RepliesCount
        FROM inserted;
    END;
END;


CREATE TRIGGER trg_LogVideoLikes
ON Videos
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO VideoLikesLog (VideoID, OldLikesCount, NewLikesCount, UpdatedAt)
        SELECT d.VideoID, d.LikesCount AS OldLikesCount, i.LikesCount AS NewLikesCount, GETDATE()
        FROM deleted d
        INNER JOIN inserted i ON d.VideoID = i.VideoID
        WHERE d.LikesCount <> i.LikesCount;
    END;
END;

CREATE TABLE VideoLikesLog (
    LogID INT IDENTITY PRIMARY KEY,
    VideoID INT,
    OldLikesCount INT,
    NewLikesCount INT,
    UpdatedAt DATETIME
);


CREATE TRIGGER trg_PreventDuplicateLikes
ON Reactions
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE EXISTS (
            SELECT 1
            FROM Reactions r
            WHERE r.CommentID = i.CommentID AND r.UserID = i.UserID AND r.ReactionType = 'Like'
        )
    )
    BEGIN
        RAISERROR ('User has already liked this comment.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Reactions (CommentID, UserID, ReactionType, ReactionTime)
        SELECT CommentID, UserID, ReactionType, ReactionTime
        FROM inserted;
    END;
END;





INSERT INTO Subscriptions (UserID, ChannelID, NotificationType)
VALUES (1, 3, 'All');

DELETE FROM Subscriptions WHERE UserID = 1 AND ChannelID = 3;

INSERT INTO Videos (ChannelID, Title, Description, Duration, UploadDate, Views, LikesCount, CommentsCount)
VALUES (1, 'New Video Test', 'Description of new video.', '00:10:00', '2024-01-01', 100, 10, 5);

DELETE FROM Channels WHERE ChannelID = 1;

INSERT INTO PlaylistVideos (PlaylistID, VideoID)
VALUES (1, 2);

SELECT * FROM VideoDeletionLog;
SELECT * FROM Channels WHERE ChannelID = 1;
SELECT * FROM Playlists WHERE PlaylistID = 1;

INSERT INTO Users
    (FirstName, LastName, PhoneNumber, EmailAddress, Username, Password, Gender, BirthDate)
VALUES
    ('Sara', 'Karimi', '09123A5678', 'sara@example.com', 'sara_karimi', 'Pass1234', 'Female', '1998-03-10');


INSERT INTO Videos
    (ChannelID, Title, Description, Duration, UploadDate, Views, LikesCount, CommentsCount)
VALUES
    (12, 'Building Your First Website', 'Step-by-step guide for beginners.', '00:20:30', '2023-07-10', 30000, 2000, 500);

INSERT INTO History (UserID, VideoID, WatchedAt)
VALUES (1, 2, GETDATE());
SELECT Views FROM Videos WHERE VideoID = 2;
SELECT Views FROM Playlists WHERE PlaylistID IN (
    SELECT PlaylistID FROM PlaylistVideos WHERE VideoID = 2
);

INSERT INTO Videos (ChannelID, Title, Description, Duration, UploadDate, Views, LikesCount, CommentsCount)
VALUES (2, 'Another Test Video', 'Testing Video Count Update', '00:05:00', GETDATE(), 0, 0, 0);
SELECT VideosCount FROM Channels WHERE ChannelID = 2;

UPDATE Videos
SET Views = 200, LikesCount = 20, CommentsCount = 10
WHERE VideoID = 2;
SELECT Views, LikesCount, CommentsCount FROM Videos WHERE VideoID = 2;

DELETE FROM Videos WHERE VideoID = 2;
SELECT * FROM VideoDeletionLog WHERE VideoID = 2;

DELETE FROM Channels WHERE ChannelID = 2;

DELETE FROM PlaylistVideos WHERE PlaylistID = 1 AND VideoID = 2;
SELECT Views, VideoCount FROM Playlists WHERE PlaylistID = 1;





CREATE FUNCTION dbo.CheckPremiumStatus
(
    @UserID INT
)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Status NVARCHAR(50);

    SELECT 
        @Status = CASE 
                    WHEN ExpirationDate IS NULL THEN 'No Subscription'
                    WHEN ExpirationDate > GETDATE() THEN 'Active'
                    ELSE 'Expired'
                  END
    FROM 
        PremiumPlans
    WHERE 
        UserID = @UserID;

    RETURN ISNULL(@Status, 'No Subscription');
END;


CREATE FUNCTION dbo.GetChannelPerformance
(
    @ChannelID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        C.ChannelID,
        C.Description AS ChannelName,
        COUNT(V.VideoID) AS TotalVideos,
        SUM(V.Views) AS TotalViews,
        SUM(V.LikesCount) AS TotalLikes,
        SUM(V.CommentsCount) AS TotalComments,
        AVG(CAST(V.Views AS FLOAT)) AS AvgVideoViews,
        DATEDIFF(DAY, C.DateJoined, GETDATE()) AS DaysSinceJoined
    FROM 
        Channels C
    LEFT JOIN 
        Videos V ON C.ChannelID = V.ChannelID
    WHERE 
        C.ChannelID = @ChannelID
    GROUP BY 
        C.ChannelID, C.Description, C.DateJoined
);


CREATE FUNCTION dbo.GetTopVideosByChannel
(
    @ChannelID INT,
    @TopN INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@TopN)
        V.VideoID,
        V.Title,
        V.Views,
        V.LikesCount,
        V.CommentsCount,
        V.UploadDate,
        (V.Views + V.LikesCount * 2 + V.CommentsCount * 3) AS PopularityScore
    FROM 
        Videos V
    WHERE 
        V.ChannelID = @ChannelID
    ORDER BY 
        PopularityScore DESC
);


CREATE FUNCTION dbo.GetVideoPopularityScore
(
    @VideoID INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Views INT;
    DECLARE @Likes INT;
    DECLARE @Comments INT;
    DECLARE @DaysSinceUpload INT;
    DECLARE @PopularityScore FLOAT;

    
    SELECT 
        @Views = Views,
        @Likes = LikesCount,
        @Comments = CommentsCount,
        @DaysSinceUpload = DATEDIFF(DAY, UploadDate, GETDATE())
    FROM 
        Videos
    WHERE 
        VideoID = @VideoID;

    SET @PopularityScore = 
        ISNULL(@Views, 0) * 0.4 + 
        ISNULL(@Likes, 0) * 0.3 + 
        ISNULL(@Comments, 0) * 0.2 + 
        CASE 
            WHEN @DaysSinceUpload < 7 THEN 20
            WHEN @DaysSinceUpload < 30 THEN 10 
            ELSE 0 
        END;

    RETURN ISNULL(@PopularityScore, 0);
END;


CREATE FUNCTION dbo.GetTopRecommendedVideos
(
    @UserID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5 
        V.VideoID,
        V.Title,
        V.Description,
        V.UploadDate,
        V.Views,
        V.LikesCount,
        V.CommentsCount,
        dbo.GetVideoPopularityScore(V.VideoID) AS PopularityScore
    FROM 
        Videos V
    WHERE 
        V.VideoID NOT IN (
            SELECT H.VideoID 
            FROM History H 
            WHERE H.UserID = @UserID
        ) 
    ORDER BY 
        dbo.GetVideoPopularityScore(V.VideoID) DESC 
);


CREATE FUNCTION dbo.GetPlaylistPopularityScore
(
    @PlaylistID INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Views INT;
    DECLARE @VideoCount INT;
    DECLARE @PopularityScore FLOAT;

    SELECT 
        @Views = Views,
        @VideoCount = VideoCount
    FROM 
        Playlists
    WHERE 
        PlaylistID = @PlaylistID;

    SET @PopularityScore = ISNULL(@Views, 0) * 0.6 + ISNULL(@VideoCount, 0) * 0.4;
    RETURN ISNULL(@PopularityScore, 0);
END;


CREATE FUNCTION dbo.GetActivePremiumUsers()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        U.UserID,
        U.Username,
        P.StartDate,
        P.ExpirationDate
    FROM 
        Users U
    INNER JOIN 
        PremiumPlans P ON U.UserID = P.UserID
    WHERE 
        P.ExpirationDate > GETDATE()
);


CREATE FUNCTION dbo.GetTotalVideosWatchedByUser
(
    @UserID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalVideos INT;

    SELECT 
        @TotalVideos = COUNT(DISTINCT VideoID)
    FROM 
        History
    WHERE 
        UserID = @UserID;

    RETURN ISNULL(@TotalVideos, 0);
END;


CREATE FUNCTION dbo.GetUserEngagementPercentage
(
    @VideoID INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Views INT, @Likes INT, @Comments INT, @Engagement FLOAT;

    SELECT 
        @Views = ISNULL(Views, 0),
        @Likes = ISNULL(LikesCount, 0),
        @Comments = ISNULL(CommentsCount, 0)
    FROM 
        Videos
    WHERE 
        VideoID = @VideoID;

    SET @Engagement = 
        CASE 
            WHEN @Views = 0 THEN 0 
            ELSE ((@Likes + @Comments) * 100.0) / @Views 
        END;

    RETURN @Engagement;
END;


CREATE FUNCTION dbo.GetInactiveUsers()
RETURNS TABLE
AS
RETURN
(
    SELECT
        U.UserID,
        U.Username,
        MAX(H.WatchDate) AS LastActivityDate
    FROM
        Users U
    LEFT JOIN
        History H ON U.UserID = H.UserID
    GROUP BY
        U.UserID, U.Username
    HAVING
        MAX(H.WatchDate) < DATEADD(DAY, -30, GETDATE()) OR MAX(H.WatchDate) IS NULL
);


CREATE FUNCTION dbo.GetChannelRevenue
(
    @ChannelID INT,
    @RevenuePerView FLOAT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @TotalViews INT, @Revenue FLOAT;

    SELECT 
        @TotalViews = SUM(ISNULL(Views, 0))
    FROM 
        Videos
    WHERE 
        ChannelID = @ChannelID;

    SET @Revenue = @TotalViews * @RevenuePerView;

    RETURN ISNULL(@Revenue, 0);
END;


CREATE FUNCTION dbo.GetBestUploadTime()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 100 PERCENT
        DATEPART(HOUR, H.WatchDate) AS HourOfDay,
        COUNT(*) AS ViewsCount
    FROM
        History H
    GROUP BY
        DATEPART(HOUR, H.WatchDate)
    ORDER BY
        ViewsCount DESC
);


CREATE FUNCTION dbo.GetAverageWatchTimeByUser
(
    @UserID INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @TotalWatchTime INT, @TotalVideos INT, @AvgWatchTime FLOAT;

    SELECT
        @TotalWatchTime = SUM(DATEDIFF(SECOND, '00:00:00', CheckpointTime)),
        @TotalVideos = COUNT(*)
    FROM
        History
    WHERE
        UserID = @UserID;

    SET @AvgWatchTime =
        CASE
            WHEN @TotalVideos = 0 THEN 0
            ELSE CAST(@TotalWatchTime AS FLOAT) / @TotalVideos
        END;

    RETURN ISNULL(@AvgWatchTime, 0);
END;


CREATE FUNCTION dbo.GetTopChannelsByViews
(
    @TopN INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@TopN)
        C.ChannelID,
        C.Description AS ChannelName,
        SUM(V.Views) AS TotalViews
    FROM 
        Channels C
    LEFT JOIN 
        Videos V ON C.ChannelID = V.ChannelID
    GROUP BY 
        C.ChannelID, C.Description
    ORDER BY 
        TotalViews DESC
);





SELECT dbo.CheckPremiumStatus(1) AS PremiumStatus;

SELECT * FROM dbo.GetChannelPerformance(3);

SELECT * FROM dbo.GetTopVideosByChannel(2, 1);

SELECT dbo.GetVideoPopularityScore(2) AS PopularityScore;

SELECT * FROM dbo.GetTopRecommendedVideos(1);

SELECT dbo.GetPlaylistPopularityScore(1) AS PopularityScore;

SELECT *  FROM dbo.GetActivePremiumUsers();

SELECT dbo.GetTotalVideosWatchedByUser(2) AS TotalVideosWatched;

SELECT dbo.GetUserEngagementPercentage(2) AS EngagementPercentage;

SELECT * FROM dbo.GetInactiveUsers();

SELECT dbo.GetChannelRevenue(3, 0.02) AS ChannelRevenue;

SELECT * FROM dbo.GetBestUploadTime();

SELECT dbo.GetAverageWatchTimeByUser(2) AS AvgWatchTime;

SELECT * FROM dbo.GetTopChannelsByViews(5);





CREATE VIEW View_PlaylistVideos AS
SELECT 
	p.UserID,
    p.PlaylistID,
    p.Name AS PlaylistName,
    p.IsPublic,
    p.LastModified,
    p.Views AS PlaylistViews,
    v.VideoID,
    v.Title AS VideoTitle,
    v.Description AS VideoDescription,
    v.Duration,
    v.UploadDate,
    v.Views AS VideoViews
FROM 
    Playlists p
JOIN 
    PlaylistVideos pv ON p.PlaylistID = pv.PlaylistID
JOIN 
    Videos v ON pv.VideoID = v.VideoID;


CREATE VIEW User_Following_Cahnnels AS
SELECT 
	U.UserID,
	U.Username,
	C.Description
FROM Subscriptions S join Users U on S.UserID = U.UserID
join Channels C on C.ChannelID = S.ChannelID


CREATE VIEW UserWatchHistory AS
SELECT 
    H.UserID,
    U.Username,
    V.Title AS VideoTitle,
    C.Description AS ChannelName,
    P.Name AS PlaylistName,
    H.WatchDate,
    H.CheckpointTime,
    V.Views AS VideoViews,
    dbo.GetVideoPopularityScore(V.VideoID) AS PopularityScore
FROM History H
INNER JOIN Videos V ON H.VideoID = V.VideoID
INNER JOIN Channels C ON V.ChannelID = C.ChannelID
LEFT JOIN PlaylistVideos PV ON PV.VideoID = V.VideoID
LEFT JOIN Playlists P ON PV.PlaylistID = P.PlaylistID
INNER JOIN Users U ON H.UserID = U.UserID;


CREATE VIEW ChannelPerformanceSummary AS
SELECT 
    C.ChannelID,
    C.Description AS ChannelName,
    C.Region,
    C.DateJoined,
    COUNT(V.VideoID) AS TotalVideos,
    SUM(V.Views) AS TotalViews,
    SUM(V.LikesCount) AS TotalLikes,
    SUM(V.CommentsCount) AS TotalComments,
    AVG(CAST(V.Views AS FLOAT)) AS AvgVideoViews,
    DATEDIFF(DAY, C.DateJoined, GETDATE()) AS DaysSinceJoined
FROM Channels C
LEFT JOIN Videos V ON C.ChannelID = V.ChannelID
GROUP BY C.ChannelID, C.Description, C.Region, C.DateJoined;


CREATE VIEW ActivePremiumUsers AS
SELECT 
    U.UserID,
    U.Username,
    P.StartDate,
    P.ExpirationDate,
    CASE 
        WHEN P.ExpirationDate > GETDATE() THEN 'Active'
        ELSE 'Expired'
    END AS PremiumStatus
FROM Users U
INNER JOIN PremiumPlans P ON U.UserID = P.UserID
WHERE P.ExpirationDate IS NOT NULL;


CREATE VIEW RecommendedVideos AS
SELECT 
    U.UserID,
    U.Username,
    V.VideoID,
    V.Title AS VideoTitle,
    V.Description,
    V.Views,
    V.LikesCount,
    V.CommentsCount,
    dbo.GetVideoPopularityScore(V.VideoID) AS PopularityScore
FROM Users U
CROSS APPLY dbo.GetTopRecommendedVideos(U.UserID) AS Recommended
JOIN Videos V ON Recommended.VideoID = V.VideoID;


CREATE VIEW MostActiveUsers AS
SELECT 
    U.UserID,
    U.Username,
    COUNT(DISTINCT H.HistoryID) AS VideosWatched,
    COUNT(DISTINCT C.CommentID) AS CommentsMade,
    COUNT(DISTINCT R.ReactionID) AS ReactionsGiven,
    (COUNT(DISTINCT H.HistoryID) + COUNT(DISTINCT C.CommentID) + COUNT(DISTINCT R.ReactionID)) AS TotalInteractions
FROM 
    Users U
LEFT JOIN 
    History H ON U.UserID = H.UserID
LEFT JOIN 
    Comments C ON U.UserID = C.UserID
LEFT JOIN 
    Reactions R ON U.UserID = R.UserID
GROUP BY 
    U.UserID, U.Username;


CREATE VIEW AdvancedVideoPerformance AS
SELECT 
    V.VideoID,
    V.Title,
    V.Description,
    V.UploadDate,
    V.Views,
    V.LikesCount,
    V.CommentsCount,
    dbo.GetVideoPopularityScore(V.VideoID) AS PopularityScore,
    CASE 
        WHEN DATEDIFF(DAY, V.UploadDate, GETDATE()) <= 7 THEN 'Trending'
        WHEN DATEDIFF(DAY, V.UploadDate, GETDATE()) <= 30 THEN 'New'
        ELSE 'Archived'
    END AS VideoStatus
FROM 
    Videos V;


CREATE VIEW FastestGrowingChannels AS
SELECT
    C.ChannelID,
    C.Description AS ChannelName,
    C.SubscribersCount,
    C.TotalViews,
    COUNT(V.VideoID) AS TotalVideos,
    DATEDIFF(DAY, C.DateJoined, GETDATE()) AS DaysSinceJoined,
    (C.SubscribersCount / NULLIF(DATEDIFF(DAY, C.DateJoined, GETDATE()), 0)) AS GrowthRatePerDay
FROM
    Channels C
LEFT JOIN
    Videos V ON C.ChannelID = V.ChannelID
WHERE
    DATEDIFF(DAY, C.DateJoined, GETDATE()) > 0
GROUP BY
    C.ChannelID, C.Description, C.SubscribersCount, C.TotalViews, C.DateJoined;


CREATE VIEW PremiumUsersPerformance AS
SELECT 
    U.UserID,
    U.Username,
    P.StartDate,
    P.ExpirationDate,
    COUNT(DISTINCT H.HistoryID) AS VideosWatched,
    COUNT(DISTINCT C.CommentID) AS CommentsMade,
    COUNT(DISTINCT R.ReactionID) AS ReactionsGiven,
    dbo.GetTotalVideosWatchedByUser(U.UserID) AS TotalWatchedVideos,
    CASE 
        WHEN P.ExpirationDate > GETDATE() THEN 'Active'
        ELSE 'Expired'
    END AS PremiumStatus
FROM 
    Users U
LEFT JOIN 
    PremiumPlans P ON U.UserID = P.UserID
LEFT JOIN 
    History H ON U.UserID = H.UserID
LEFT JOIN 
    Comments C ON U.UserID = C.UserID
LEFT JOIN 
    Reactions R ON U.UserID = R.UserID
GROUP BY 
    U.UserID, U.Username, P.StartDate, P.ExpirationDate;


CREATE VIEW TrendingVideos AS
SELECT 
    V.VideoID,
    V.Title,
    V.Description,
    V.UploadDate,
    V.Views,
    V.LikesCount,
    V.CommentsCount,
    dbo.GetVideoPopularityScore(V.VideoID) AS PopularityScore,
    DATEDIFF(DAY, V.UploadDate, GETDATE()) AS DaysSinceUpload
FROM 
    Videos V
WHERE 
    DATEDIFF(DAY, V.UploadDate, GETDATE()) <= 7;


CREATE VIEW PlaylistEngagement AS
SELECT 
    P.PlaylistID,
    P.Name AS PlaylistName,
    P.UserID,
    U.Username AS PlaylistOwner,
    P.Views AS TotalViews,
    COUNT(DISTINCT H.HistoryID) AS TotalTimesWatched,
    COUNT(DISTINCT C.CommentID) AS TotalCommentsOnVideos,
    dbo.GetPlaylistPopularityScore(P.PlaylistID) AS PopularityScore
FROM 
    Playlists P
LEFT JOIN 
    PlaylistVideos PV ON P.PlaylistID = PV.PlaylistID
LEFT JOIN 
    History H ON PV.VideoID = H.VideoID
LEFT JOIN 
    Comments C ON PV.VideoID = C.VideoID
LEFT JOIN 
    Users U ON P.UserID = U.UserID
GROUP BY 
    P.PlaylistID, P.Name, P.UserID, U.Username, P.Views;


CREATE VIEW RecentActivitySummary AS
SELECT
    H.UserID,
    U.Username,
    V.VideoID,
    V.Title AS VideoTitle,
    H.WatchDate,
    C.CommentID,
    C.Content AS CommentText,
    R.ReactionID,
    R.ReactionType,
    CASE
        WHEN H.WatchDate IS NOT NULL THEN 'Watched Video'
        WHEN C.CommentID IS NOT NULL THEN 'Commented'
        WHEN R.ReactionID IS NOT NULL THEN 'Reacted'
    END AS ActivityType
FROM
    Users U
LEFT JOIN
    History H ON U.UserID = H.UserID
LEFT JOIN
    Comments C ON U.UserID = C.UserID
LEFT JOIN
    Reactions R ON U.UserID = R.UserID
LEFT JOIN
    Videos V ON H.VideoID = V.VideoID
             OR C.VideoID = V.VideoID
             OR EXISTS (
                 SELECT 1
                 FROM Comments C2
                 WHERE C2.CommentID = R.CommentID AND C2.VideoID = V.VideoID
             )
WHERE
    H.WatchDate >= DATEADD(DAY, -30, GETDATE())
    OR C.PostedTime >= DATEADD(DAY, -30, GETDATE())
    OR R.ReactionTime >= DATEADD(DAY, -30, GETDATE());





SELECT * FROM View_PlaylistVideos WHERE UserID = 2

SELECT * FROM User_Following_Cahnnels WHERE UserID = 1

SELECT * FROM UserWatchHistory WHERE UserID = 1;

SELECT * FROM ChannelPerformanceSummary;

SELECT * FROM ActivePremiumUsers;

SELECT * FROM RecommendedVideos WHERE UserID = 1;

SELECT * FROM MostActiveUsers WHERE TotalInteractions > 10 ORDER BY TotalInteractions;

SELECT * FROM AdvancedVideoPerformance WHERE VideoStatus = 'Trending' ORDER BY PopularityScore;

SELECT * FROM FastestGrowingChannels WHERE GrowthRatePerDay > 10 ORDER BY GrowthRatePerDay;

SELECT * FROM PremiumUsersPerformance WHERE PremiumStatus = 'Active';

SELECT * FROM TrendingVideos  WHERE DaysSinceUpload <= 7  ORDER BY PopularityScore DESC;

SELECT * FROM PlaylistEngagement  WHERE PopularityScore > 50  ORDER BY TotalTimesWatched DESC;

SELECT * FROM RecentActivitySummary  WHERE ActivityType = 'Watched Video'  AND WatchDate >= DATEADD(DAY, -7, GETDATE()) ORDER BY WatchDate DESC;





CREATE PROCEDURE AddVideoToChannel
    @ChannelID INT,
    @Title VARCHAR(255),
    @Description TEXT,
    @Duration TIME,
    @UploadDate DATE
AS
BEGIN
    INSERT INTO Videos (ChannelID, Title, Description, Duration, UploadDate, Views, LikesCount, CommentsCount)
    VALUES (@ChannelID, @Title, @Description, @Duration, @UploadDate, 0, 0, 0);

    UPDATE Channels
    SET VideosCount = VideosCount + 1
    WHERE ChannelID = @ChannelID;
END;


CREATE PROCEDURE RemoveUserSubscription
    @UserID INT,
    @ChannelID INT
AS
BEGIN
    DELETE FROM Subscriptions
    WHERE UserID = @UserID AND ChannelID = @ChannelID;

    UPDATE Channels
    SET SubscribersCount = SubscribersCount - 1
    WHERE ChannelID = @ChannelID;
END;


CREATE PROCEDURE RecommendVideosForUser
    @UserID INT,
    @TopN INT
AS
BEGIN
    SELECT TOP (@TopN)
        TV.VideoID,
        TV.Title,
        TV.Description,
        TV.UploadDate,
        TV.Views,
        TV.LikesCount,
        TV.CommentsCount,
		TV.PopularityScore
    FROM dbo.GetTopRecommendedVideos(@UserID) AS TV
    ORDER BY TV.PopularityScore DESC;
END;


CREATE PROCEDURE AddCommentToVideo
    @VideoID INT,
    @UserID INT,
    @Content TEXT
AS
BEGIN
    INSERT INTO Comments (VideoID, UserID, Content, PostedTime, LikesCount, RepliesCount)
    VALUES (@VideoID, @UserID, @Content, GETDATE(), 0, 0);
END;


CREATE PROCEDURE DeleteComment
    @CommentID INT
AS
BEGIN
    DELETE FROM Reactions WHERE CommentID = @CommentID;
    DELETE FROM Comments WHERE CommentID = @CommentID;
END;


CREATE PROCEDURE AddReactionToComment
    @CommentID INT,
    @UserID INT,
    @ReactionType VARCHAR(10)
AS
BEGIN
    INSERT INTO Reactions (CommentID, UserID, ReactionType, ReactionTime)
    VALUES (@CommentID, @UserID, @ReactionType, GETDATE());
END;


CREATE PROCEDURE AddVideoToPlaylist
    @PlaylistID INT,
    @VideoID INT
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM PlaylistVideos 
        WHERE PlaylistID = @PlaylistID AND VideoID = @VideoID
    )
    BEGIN
        INSERT INTO PlaylistVideos (PlaylistID, VideoID)
        VALUES (@PlaylistID, @VideoID);

        UPDATE Playlists
        SET VideoCount = VideoCount + 1
        WHERE PlaylistID = @PlaylistID;
    END;
END;


CREATE PROCEDURE StartLiveStream
    @ChannelID INT
AS
BEGIN
    INSERT INTO Streams (ChannelID, StartTime, EndTime)
    VALUES (@ChannelID, GETDATE(), NULL);
END;


CREATE PROCEDURE EndLiveStream
    @StreamID INT
AS
BEGIN
    UPDATE Streams
    SET EndTime = GETDATE()
    WHERE StreamID = @StreamID;
END;


CREATE PROCEDURE AddPremiumSubscription
    @UserID INT,
    @StartDate DATE,
    @DurationInMonths INT
AS
BEGIN
    DECLARE @ExpirationDate DATE;
    SET @ExpirationDate = DATEADD(MONTH, @DurationInMonths, @StartDate);

    INSERT INTO PremiumPlans (UserID, StartDate, ExpirationDate)
    VALUES (@UserID, @StartDate, @ExpirationDate);
END;


CREATE PROCEDURE RemoveVideoFromPlaylist
    @PlaylistID INT,
    @VideoID INT
AS
BEGIN
    DELETE FROM PlaylistVideos
    WHERE PlaylistID = @PlaylistID AND VideoID = @VideoID;

    UPDATE Playlists
    SET VideoCount = VideoCount - 1
    WHERE PlaylistID = @PlaylistID;
END;


CREATE PROCEDURE FetchUserRecommendations
    @UserID INT,
    @MaxResults INT
AS
BEGIN
    SELECT TOP (@MaxResults)
        V.VideoID,
        V.Title,
        V.Description,
        V.Views,
        V.LikesCount,
        dbo.GetVideoPopularityScore(V.VideoID) AS PopularityScore
    FROM dbo.GetTopRecommendedVideos(@UserID) AS TV
    JOIN Videos V ON TV.VideoID = V.VideoID
    ORDER BY PopularityScore DESC;
END;


CREATE PROCEDURE ResetUserPassword
    @UserID INT,
    @NewPasswordHash VARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET Password = @NewPasswordHash
    WHERE UserID = @UserID;
END;





EXEC AddVideoToChannel 
    @ChannelID = 1,
    @Title = 'New Video Title',
    @Description = 'This is a test description.',
    @Duration = '00:15:00',
    @UploadDate = '2023-12-01';

EXEC RemoveUserSubscription 
    @UserID = 1, 
    @ChannelID = 2;

EXEC RecommendVideosForUser 
    @UserID = 1, 
    @TopN = 5;

EXEC AddCommentToVideo 
    @VideoID = 1, 
    @UserID = 2, 
    @Content = 'This video is awesome!';

EXEC DeleteComment 
    @CommentID = 1;

EXEC AddReactionToComment 
    @CommentID = 2, 
    @UserID = 3, 
    @ReactionType = 'Like';

EXEC AddVideoToPlaylist 
    @PlaylistID = 1, 
    @VideoID = 4;

EXEC StartLiveStream 
    @ChannelID = 3;

EXEC EndLiveStream 
    @StreamID = 1;

EXEC AddPremiumSubscription
    @UserID = 1,
    @StartDate = '2023-12-01',
    @DurationInMonths = 6;

EXEC RemoveVideoFromPlaylist
    @PlaylistID = 1,
    @VideoID = 4;

EXEC FetchUserRecommendations
    @UserID = 1,
    @MaxResults = 5;

EXEC ResetUserPassword
    @UserID = 1,
    @NewPasswordHash = 'new_password_hash_example';
