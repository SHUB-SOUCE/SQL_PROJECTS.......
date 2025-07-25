--  Create the Database
CREATE DATABASE IF NOT EXISTS SocialMediaAnalytics;

USE SocialMediaAnalytics;

-- TABLE CREATION:

-- USERS TABLE
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    JoinDate DATE NOT NULL,
    UserRole ENUM('Creator', 'Audience') NOT NULL  -- Distinguish content creators vs engagers
);


-- POSTS TABLE
CREATE TABLE Posts (
    PostID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Content TEXT NOT NULL,
    PostDate DATETIME NOT NULL,
    LikeCount INT DEFAULT 0,          -- Count of likes on the post
    CommentCount INT DEFAULT 0,       -- Count of comments on the post
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);


-- Likes Table
CREATE TABLE Likes (
    LikeID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    PostID INT,
    LikeDate DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE
);


-- Comments Table
CREATE TABLE Comments (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    PostID INT,
    CommentText TEXT NOT NULL,
    CommentDate DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE
);

-- TRIGGERS:

-- Trigger 1:  Increment LikeCount on INSERT

DELIMITER $$

CREATE TRIGGER trg_increment_likecount
AFTER INSERT ON Likes
FOR EACH ROW
BEGIN
    UPDATE Posts
    SET LikeCount = LikeCount + 1
    WHERE PostID = NEW.PostID;
END$$

DELIMITER ;
 -- Trigger 2: : Decrement LikeCount on DELETE

DELIMITER $$

CREATE TRIGGER trg_decrement_likecount
AFTER DELETE ON Likes
FOR EACH ROW
BEGIN
    UPDATE Posts
    SET LikeCount = LikeCount - 1
    WHERE PostID = OLD.PostID;
END$$

DELIMITER ;

-- Trigger 3:Increment CommentCount on INSERT
DELIMITER $$

CREATE TRIGGER trg_increment_commentcount
AFTER INSERT ON Comments
FOR EACH ROW
BEGIN
    UPDATE Posts
    SET CommentCount = CommentCount + 1
    WHERE PostID = NEW.PostID;
END$$

DELIMITER ;


-- Trigger 4:Decrement CommentCount on DELETE
 
DELIMITER $$

CREATE TRIGGER trg_decrement_commentcount
AFTER DELETE ON Comments
FOR EACH ROW
BEGIN
    UPDATE Posts
    SET CommentCount = CommentCount - 1
    WHERE PostID = OLD.PostID;
END$$

DELIMITER ;


-- RECORDS INSERTION:


-- USERS 
INSERT INTO Users (UserID, UserName, Email, JoinDate, UserRole) VALUES
(1, 'AliceTech', 'alice@example.com', '2021-05-10', 'Creator'),
(2, 'BobViewer', 'bob@example.com', '2022-03-15', 'Audience'),
(3, 'CathyChef', 'cathy@example.com', '2020-08-22', 'Creator'),
(4, 'DanTravel', 'dan@example.com', '2023-01-05', 'Audience'),
(5, 'EveSEO', 'eve@example.com', '2019-11-30', 'Creator'),
(6, 'FrankFoodie', 'frank@example.com', '2021-02-14', 'Audience'),
(7, 'GraceCoder', 'grace@example.com', '2022-12-01', 'Audience'),
(8, 'HenryCrypto', 'henry@example.com', '2024-01-20', 'Creator'),
(9, 'IvyPoet', 'ivy@example.com', '2020-09-25', 'Creator'),
(10, 'JackQuick', 'jack@example.com', '2023-07-18', 'Audience');



-- POSTS
INSERT INTO Posts (PostID, UserID, Content, PostDate, LikeCount, CommentCount) VALUES
(1, 1, 'Top 5 AI tools to boost productivity!', '2024-04-14 10:00:00', 2, 1),
(2, 3, 'A day in Tokyo – my Japan travel vlog.', '2024-05-10 19:00:00', 1, 1),
(3, 5, 'SEO tips for new bloggers – part 1', '2024-03-05 14:30:00', 1, 1),
(4, 6, '10 Quick meals under 15 minutes!', '2024-06-01 11:45:00', 1, 1),
(5, 9, 'My latest poem: “Echoes of Silence”', '2024-02-28 19:30:00', 1, 1),
(6, 1, 'React vs Angular – A 2025 Comparison', '2025-01-04 08:00:00', 0,0),
(7, 8, 'Crypto market: What’s happening in July?', '2024-07-01 10:30:00', 2, 1),
(8,3, 'Exploring Ladakh – Epic drone shots!', '2025-07-01 12:00:00', 2, 1),
(9,6, 'ChatGPT vs Gemini AI – Who wins?', '2025-07-10 09:30:00', 1, 2),
(10,9, 'July Coding Challenge: 30 days of JS!', '2025-07-15 20:00:00', 3, 2),
(11,2, 'Productivity Hacks for Remote Workers', '2025-07-05 11:15:00', 2, 0);



-- LIKES
INSERT INTO Likes (LikeID, UserID, PostID, LikeDate) VALUES
(1, 2, 1, '2024-04-15 12:00:00'),
(2, 4, 1, '2024-04-15 12:10:00'),
(3, 7, 2, '2024-05-10 20:00:00'),
(4, 2, 3, '2024-03-05 15:00:00'),
(5, 10, 4, '2024-06-01 12:30:00'),
(6, 2, 5, '2024-02-28 20:00:00'),
(8, 7, 7, '2024-07-01 11:00:00'),
(9, 10, 7, '2024-07-01 11:10:00'),
(10,1, 8, '2025-07-02 08:00:00'),
(11,4, 8, '2025-07-03 12:30:00'),
(12,7, 9, '2025-07-10 11:00:00'),
(13,2, 10, '2025-07-15 21:00:00'),
(14,5, 10, '2025-07-16 10:45:00'),
(15,6, 10, '2025-07-17 08:20:00'),
(16,1, 11, '2025-07-06 09:00:00'),
(17,3, 11, '2025-07-07 10:15:00');


-- COMMENTS
INSERT INTO Comments (CommentID, UserID, PostID, CommentText, CommentDate) VALUES
(1, 2, 1, 'Really useful AI tools, thanks!', '2024-04-15 13:00:00'),
(2, 4, 2, 'Loved your Japan vlog, amazing edits!', '2024-05-10 21:30:00'),
(3, 7, 3, 'SEO tips are gold, appreciate this post.', '2024-03-05 16:20:00'),
(4, 10, 4, 'Quick meals are lifesavers. Subscribed!', '2024-06-01 13:15:00'),
(5, 2, 5, 'Beautiful poetry! Very touching.', '2024-02-28 21:00:00'),
(7, 4, 7, 'Thanks for making crypto simple!', '2024-07-01 12:30:00'),
(8,5, 8, 'Incredible view! Loved the angles.', '2025-07-03 14:00:00'),
(9,6, 9, 'ChatGPT nailed it this time!', '2025-07-10 12:00:00'),
(10,3, 10, 'Interesting take, would love a follow-up.', '2025-07-11 08:45:00'),
(11,8, 11, 'I’m joining the challenge!', '2025-07-15 22:00:00'),
(12,10, 11, 'Can we get beginner-friendly topics too?', '2025-07-16 09:30:00');




-- QUERIES:

-- 1. View: Top 5 Most Liked Posts (All-Time)

CREATE VIEW TopLikedPosts AS
SELECT 
    P.PostID,
    P.Content,
    U.UserName AS Creator,
    P.LikeCount
FROM Posts P
JOIN Users U ON P.UserID = U.UserID
ORDER BY P.LikeCount DESC
LIMIT 5;

Select * from TopLikedPosts;

-- 2. View: Engagement Score Per Post (Likes + Comments)

CREATE VIEW PostEngagementScore AS
SELECT 
    P.PostID,
    P.Content,
    U.UserName AS Creator,
    P.LikeCount,
    P.CommentCount,
    (P.LikeCount + P.CommentCount) AS EngagementScore
FROM Posts P
JOIN Users U ON P.UserID = U.UserID
ORDER BY EngagementScore DESC;

select * from PostEngagementScore;

-- 3. Procedure: Get Monthly Engagement Report

DELIMITER //

CREATE PROCEDURE GetMonthlyEngagement(IN targetYear INT, IN targetMonth INT)
BEGIN
    SELECT 
        P.PostID,
        P.Content,
        U.UserName AS Creator,
        COUNT(DISTINCT L.LikeID) AS Likes,
        COUNT(DISTINCT C.CommentID) AS Comments
    FROM Posts P
    LEFT JOIN Likes L ON P.PostID = L.PostID AND MONTH(L.LikeDate) = targetMonth AND YEAR(L.LikeDate) = targetYear
    LEFT JOIN Comments C ON P.PostID = C.PostID AND MONTH(C.CommentDate) = targetMonth AND YEAR(C.CommentDate) = targetYear
    JOIN Users U ON P.UserID = U.UserID
    GROUP BY P.PostID, P.Content, U.UserName
    ORDER BY Likes + Comments DESC;
END //

DELIMITER ;

CALL GetMonthlyEngagement(2024, 6);


-- 4. Function: Get Total Engagement for a Given Post

DELIMITER //

CREATE FUNCTION GetPostEngagement(postID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT LikeCount + CommentCount INTO total
    FROM Posts
    WHERE PostID = postID;
    RETURN total;
END //

DELIMITER ;

SELECT GetPostEngagement(2) AS Engagement;

-- 5. Query: Top 3 Active Engagers (Users who liked or commented most)

SELECT 
    U.UserID,
    U.UserName,
    COUNT(L.LikeID) + COUNT(C.CommentID) AS TotalInteractions
FROM Users U
LEFT JOIN Likes L ON U.UserID = L.UserID
LEFT JOIN Comments C ON U.UserID = C.UserID
GROUP BY U.UserID, U.UserName
ORDER BY TotalInteractions DESC
LIMIT 3;
--  6. View: Recent Posts With Engagement Trend

CREATE VIEW RecentEngagementTrends AS
SELECT 
    P.PostID,
    P.Content,
    P.PostDate,
    P.LikeCount,
    P.CommentCount,
    (P.LikeCount + P.CommentCount) AS TotalEngagement
FROM Posts P
WHERE P.PostDate >= CURDATE() - INTERVAL 30 DAY
ORDER BY P.PostDate DESC; 
select * from  RecentEngagementTrends;

-- 7. Query: Creator-wise Engagement Summary

SELECT 
    U.UserID,
    U.UserName,
    COUNT(P.PostID) AS TotalPosts,
    SUM(P.LikeCount) AS TotalLikes,
    SUM(P.CommentCount) AS TotalComments,
    SUM(P.LikeCount + P.CommentCount) AS TotalEngagement
FROM Users U
JOIN Posts P ON U.UserID = P.UserID
WHERE U.UserRole = 'Creator'
GROUP BY U.UserID, U.UserName
ORDER BY TotalEngagement DESC;

-- 8. Query: Posts That Got No Comments or Likes

SELECT 
    P.PostID,
    P.Content,
    U.UserName AS Creator,
    P.LikeCount,
    P.CommentCount
FROM Posts P
JOIN Users U ON P.UserID = U.UserID
WHERE P.LikeCount = 0 AND P.CommentCount = 0;



