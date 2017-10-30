-- SQL-spørringer


-- Spørring 3
SELECT Count(Subscription.UserID), ui.UserName FROM Subscription
INNER JOIN UserInfo AS UI ON Subscription.UserID = UI.UserID
GROUP BY UI.UserID;