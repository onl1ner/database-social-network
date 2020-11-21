-- RETURN A USER WITH THE MAXIMUM NUMBER OF COMMENTS:
SELECT users.id, users.first_name, users.last_name, users.email, comms.count AS highest_amount
FROM users
INNER JOIN (
	SELECT comments.user_id AS id, COUNT(comments.user_id) AS count
	FROM comments
	GROUP BY comments.user_id
	-- CHECKING IF COUNT IS EQUAL TO THE MAXIMUM.
	HAVING COUNT(comments.user_id) = (
		-- AFTER GETTING THE COUNT OF COMMENTS
		-- WE DETERMINING THE MAXIMUM BY USING
		-- "MAX" AGGREGATE FUNCTION.
		SELECT MAX(total.count) 
		FROM (
			-- WE ARE GETTING THE COUNT OF COMMENTS
			-- OF EACH USER COMMENTED.
			SELECT COUNT(*) AS count
			FROM comments
			GROUP BY user_id
		) total
	)
) comms
ON users.id = comms.id
--------------------------

-- RETURN AMOUNT OF SENT AND RECEIVED MESSAGES FOR EACH USER:
SELECT users.nickname, users.first_name, users.last_name, sent.count AS sent, received.count AS received
FROM users
-- FIRSTLY COUNTING AMOUNT OF SENT MESSAGES BY
-- USING SUBQUERY AND "COUNT" AGGREGATE FUNCTION.
INNER JOIN (
	SELECT users.id AS id, COUNT(*) AS count FROM users
	INNER JOIN messages ON users.id = messages.sender_id
	GROUP BY users.id
) sent
ON users.id = sent.id
-- DOING THE SAME THING BUT NOW CHECKING IF
-- USER ID MATCHES WITH RECEIVER ID.
INNER JOIN (
	SELECT users.id AS id, COUNT(*) AS count FROM users
	INNER JOIN messages ON users.id = messages.receiver_id
	GROUP BY users.id
) received
ON users.id = received.id;
--------------------------

-- RETURN TOP-5 REPORTED USERS:
SELECT users.id, users.nickname, users.email, reports.count AS reports_count
FROM users
-- COUNTING THE AMOUNT OF REPORTS 
-- FOR EACH USER.
INNER JOIN (
	SELECT users.id AS id, COUNT(*) AS count FROM users
	INNER JOIN reports ON users.id = reports.user_id
	GROUP by users.id
) reports
ON users.id = reports.id
-- THEN ORDERING THEM IN DESCENDING
-- ORDER AND LIMITING THE QUERY BY 5.
ORDER BY reports.count DESC
LIMIT 5;
--------------------------

-- RETURN AMOUNT OF LIKES OF EACH POST
-- ORDERED IN DESCENDING ORDER:
SELECT posts.id, posts.title, like_counter.count AS like_count
FROM posts
INNER JOIN (
	SELECT posts.id AS post_id, COUNT(*) AS count
	FROM posts 
	INNER JOIN likes ON posts.id = likes.post_id
	GROUP BY posts.id
) like_counter
ON posts.id = like_counter.post_id
ORDER BY like_counter.count DESC
--------------------------

-- RETURN ALL GROUPS THAT POSTED MORE 
-- THAN 1 POST IN DESCENDING ORDER:
SELECT groups.*, post_counter.count AS post_count
FROM groups
-- JOINING RETURNED TABLE TO
-- RETURN EVERYTHING ABOUT GROUP
-- AND THEIR POST COUNT.
INNER JOIN (
	-- COUNTING THE AMOUNT OF POSTS
	-- HAVING THIS COUNT MORE THAN 1.
	SELECT groups.id AS group_id, COUNT(*) AS count
	FROM groups
	INNER JOIN posts ON groups.id = posts.owner_id
	GROUP BY groups.id
	HAVING COUNT(*) > 1
) post_counter
ON groups.id = post_counter.group_id
ORDER BY post_counter.count DESC;
--------------------------

-- RETURN COUNT OF MESSAGES WITH ATTACHMENTS 
-- FROM EACH USER IN DESCENDING ORDER:
SELECT users.nickname, message_with_attachment.count
FROM users
-- JOINING RETURNED TABLE TO
-- RETURN ONLY USER NICKNAME.
INNER JOIN (
	-- COUNTING THE AMOUNT OF MESSAGES
	-- WITH ATTACHMENTS FROM EACH USER.
	SELECT users.id AS user_id, COUNT(*) AS count
	FROM users
	INNER JOIN messages ON users.id = messages.sender_id
	INNER JOIN message_attachments ON messages.id = message_attachments.message_id
	GROUP BY users.id
) message_with_attachment
ON users.id = message_with_attachment.user_id
ORDER BY message_with_attachment.count DESC;
--------------------------

-- RETURN TOTAL AMOUNT OF GAINED LIKES
-- FOR EACH GROUP IN DESCENDING ORDER:
SELECT groups.id, groups.name, posted.like_total
FROM groups
-- JOINING RETURNED TABLE TO
-- RETURN GROUP ID AND GROUP NAME.
INNER JOIN (
	-- COUNTING THE AMOUNT OF LIKES
	-- FOR EACH GROUP, GROUPING 
	-- THE POSTS BY THEIR OWNER'S ID.
	SELECT posts.owner_id AS owner_id, COUNT(*) AS like_total
	FROM posts
	INNER JOIN likes ON posts.id = likes.post_id
	GROUP BY posts.owner_id
) posted
ON groups.id = posted.owner_id
ORDER BY posted.like_total DESC;
--------------------------

-- RETURN FOR EACH GROUP AMOUNT OF
-- SUBSCRIBERS THAT OLDER THAN 18:
SELECT groups.*, adult_counter.count AS adult_count
FROM groups
-- JOINING RETURNED TABLE TO
-- RETURN ALL INFORMATION ABOUT THE GROUP.
INNER JOIN (
	-- COUNTING THE AMOUNT OF SUBSCRIBERS
	-- OLDER THAN 18 FOR EACH GROUP.
	SELECT users_to_groups.group_id AS group_id, COUNT(*) AS count
	FROM users_to_groups
	INNER JOIN (
		-- SELECTING ALL USERS THAT OLDER THAN 18.
		SELECT users.id AS id
		FROM users
		WHERE users.age > 18
	) adult 
	ON users_to_groups.user_id = adult.id
	GROUP BY users_to_groups.group_id
) adult_counter
ON groups.id = adult_counter.group_id
--------------------------
