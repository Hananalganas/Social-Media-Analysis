USE social_media;

-- Social Media Database Analysis
-- Hanan Alganas

-- 1. Top 5 most-followed hashtags
SELECT h.hashtag_name, COUNT(*) AS followers
FROM hashtag_follow hf
JOIN hashtags h
    ON hf.hashtag_id = h.hashtag_id
GROUP BY h.hashtag_id, h.hashtag_name
ORDER BY followers DESC
LIMIT 5;


-- 2. Five least active users based on number of posts
SELECT u.username, COUNT(p.post_id) AS total_posts
FROM users u
LEFT JOIN post p
    ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
ORDER BY total_posts ASC
LIMIT 5;


-- 3. Posts ranked by total number of likes
SELECT p.post_id, COUNT(pl.user_id) AS likes
FROM post p
JOIN post_likes pl
    ON p.post_id = pl.post_id
GROUP BY p.post_id
ORDER BY likes DESC;


-- 4. Average number of posts per user
SELECT AVG(post_count) AS average_posts
FROM (
    SELECT COUNT(*) AS post_count
    FROM post
    GROUP BY user_id
) AS t;


-- 5. Users who have never created a post
SELECT u.user_id, u.username
FROM users u
LEFT JOIN post p
    ON u.user_id = p.user_id
WHERE p.post_id IS NULL;
