-- GROUPS_TO_BOTS:
UPDATE groups_to_bots 
SET bot_id = 5
WHERE group_id = 2;

DELETE FROM groups_to_bots WHERE bot_id = 13;
--------------------------

-- LIKES:
DELETE FROM likes WHERE user_id = 5;
--------------------------

-- COMMENTS
UPDATE comments 
SET text = 'That is sick! :D' 
WHERE user_id = 4;

DELETE FROM comments WHERE user_id = 5;
--------------------------

-- POST_PHOTOS:
UPDATE post_photos 
SET photo_url = 'http://dummyimage.com/448x314.png/dddddd/000000' 
WHERE post_id = 19;

DELETE FROM post_photos 
USING posts 
WHERE post_photos.post_id = posts.id AND EXTRACT(YEAR FROM posts.creation_date) < 2011;
--------------------------

-- POSTS:
UPDATE posts 
SET title = 'Look at this baby sleeping :)' 
WHERE id = 11;

DELETE FROM posts WHERE owner_id = 5;
--------------------------

-- BOTS:
UPDATE bots 
SET description = 'Find the best hotel deals in seconds with the Eddy Travels AI assistant!'
WHERE nickname = 'Eddy Travels';

DELETE FROM bots WHERE name = 'Yandex.Translate';
--------------------------

-- GROUPS:
UPDATE groups 
SET name = 'NotLikeMe'
WHERE name = 'me_irl';

-- IN ORDER TO PROPERLY DELETE DATA ABOUT
-- GROUP AND TO NOT BREAK SOMETHING WE HAVE
-- TO MAKE SEVERAL STEPS AND DELETE FROM
-- SEVERAL TABLES.

DELETE FROM groups_to_bots 
USING groups
WHERE groups.id = groups_to_bots.group_id AND groups.name LIKE 'Get%';

DELETE FROM likes 
USING posts, groups
WHERE likes.post_id = posts.id AND posts.owner_id = groups.id AND groups.name LIKE 'Get%';

DELETE FROM posts
USING groups
WHERE posts.owner_id = groups.id AND groups.name LIKE 'Get%';

DELETE FROM users_to_groups
USING groups
WHERE users_to_groups.group_id = groups.id AND groups.name LIKE 'Get%';

DELETE FROM groups WHERE name LIKE 'Get%';
--------------------------

-- REPORTS:
UPDATE reports 
SET note = 'This man is a racist!'
WHERE id = 17;

DELETE FROM reports WHERE user_id = 5;
--------------------------

-- MESSAGE_ATTACHMENTS:
UPDATE message_attachments 
SET photo_url = 'http://dummyimage.com/403x447.bmp/cc0000/ffffff' 
WHERE message_id = 22;

DELETE FROM message_attachments 
USING messages
WHERE message_attachments.message_id = messages.id AND (messages.sender_id = 5 OR messages.receiver_id = 5);
--------------------------

-- MESSAGES:
UPDATE messages 
SET text = 'Damn it is so cringey to be there tonight' 
WHERE id = 8;

DELETE FROM message_attachments 
USING messages
WHERE message_attachments.message_id = messages.id AND (messages.sender_id = 5 OR messages.receiver_id = 5);

DELETE FROM messages WHERE sender_id = 5 OR receiver_id = 5;
--------------------------

-- USERS:
UPDATE users
SET avatar_url = 'https://robohash.org/culpavitaeea.bmp?size=128x128&set=set1' 
WHERE id = 3;

-- IN ORDER TO PROPERLY DELETE DATA ABOUT
-- USER AND TO NOT BREAK SOMETHING WE HAVE
-- TO MAKE SEVERAL STEPS AND DELETE FROM
-- SEVERAL TABLES.

DELETE FROM message_attachments
USING messages
WHERE message_attachments.message_id = messages.id 
AND messages.sender_id IN (
	SELECT users.id
	FROM users
	WHERE users.email LIKE '%@yandex.ru'
) OR messages.receiver_id IN (
	SELECT users.id
	FROM users
	WHERE users.email LIKE '%@yandex.ru'
);

DELETE FROM messages
WHERE messages.sender_id IN (
	SELECT users.id
	FROM users
	WHERE users.email LIKE '%@yandex.ru'
) OR messages.receiver_id IN (
	SELECT users.id
	FROM users
	WHERE users.email LIKE '%@yandex.ru'
);

DELETE FROM users_to_groups
WHERE users_to_groups.user_id IN (
	SELECT users.id
	FROM users
	WHERE users.email LIKE '%@yandex.ru'
);

DELETE FROM likes
WHERE likes.user_id IN (
	SELECT users.id
	FROM users
	WHERE users.email LIKE '%@yandex.ru'
);

DELETE FROM users WHERE email LIKE '%@yandex.ru';
--------------------------
