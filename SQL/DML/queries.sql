-- RETURN ALL USERS THAT OVER THE AGE OF 25:
SELECT first_name, last_name, age, email FROM users WHERE users.age > 25;
--------------------------

-- RETURN ALL USERS WITH NAME THAT STARTS FROM "A":
SELECT first_name, last_name, email FROM users WHERE first_name LIKE 'A%';
--------------------------

-- RETURN AVERAGE AGE OF USERS:
SELECT TO_CHAR(AVG(users.age), '99.9') AS average_age FROM users;
--------------------------

-- RETURN ALL VERIFIED GROUPS:
SELECT * FROM groups WHERE groups.verified;
--------------------------

-- RETURN ALL BOTS CONTAINS "bot" IN THEIR NAMES:
SELECT * FROM bots WHERE LOWER(nickname) LIKE '%bot%';
--------------------------

-- RETURN POSTS THAT WERE MADE IN PREVIOUS YEAR:
SELECT * FROM posts
WHERE EXTRACT(YEAR FROM posts.creation_date) = EXTRACT(YEAR FROM CURRENT_TIMESTAMP) - 1;
--------------------------

-- RETURN AMOUNT OF GROUPS THAT USES EACH BOT:
SELECT bots.nickname, COUNT(bots.nickname)
FROM bots
INNER JOIN groups_to_bots ON bots.id = groups_to_bots.bot_id
INNER JOIN groups ON groups_to_bots.group_id = groups.id
GROUP BY bots.nickname;
--------------------------

-- RETURN NAME OF EVERY BOT ATTACHED TO A GROUP:
SELECT groups.name, bots.nickname
FROM groups
INNER JOIN groups_to_bots ON groups.id = groups_to_bots.group_id
INNER JOIN bots ON groups_to_bots.bot_id = bots.id
ORDER BY name;
--------------------------

-- RETURN USERS WHOSE REGISTRATION YEAR IN PERIOD STARTING FROM 2010 TO 2015:
SELECT users.* FROM users
WHERE EXTRACT(YEAR FROM users.registration_date) BETWEEN 2010 AND 2015;
--------------------------

-- RETURN ONLY POSTS WITH THE PHOTO ATTACHED:
SELECT posts.* FROM posts
INNER JOIN post_photos
ON posts.id = post_photos.post_id
ORDER BY posts.id;
--------------------------

-- RETURN TOTAL AMOUNT OF MESSAGES WITH ATTACHMENTS:
SELECT COUNT(*) AS messages_with_attachments FROM messages
INNER JOIN message_attachments 
ON messages.id = message_attachments.message_id;
--------------------------

-- RETURN ALL POSTS WITH MORE THAN 1 COMMENT:
SELECT posts.* FROM posts
INNER JOIN comments ON posts.id = comments.post_id
GROUP BY posts.id
HAVING COUNT(*) > 1;
--------------------------