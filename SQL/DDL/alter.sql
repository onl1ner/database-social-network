-- ALTERING USERS TABLE:
ALTER TABLE users ADD COLUMN age INT;
ALTER TABLE users ADD COLUMN first_name VARCHAR(255);
ALTER TABLE users ADD COLUMN last_name VARCHAR(255);
ALTER TABLE users ALTER COLUMN age SET NOT NULL;

-- ALTERING GROUPS TABLE:
ALTER TABLE groups ADD COLUMN verified BOOL;
ALTER TABLE groups DROP COLUMN subscribers_id;
ALTER TABLE groups DROP COLUMN posts_id;
ALTER TABLE groups DROP COLUMN bots_id;

-- ALTERING MESSAGE_ATTACHMENTS TABLE:
ALTER TABLE message_attachments ADD COLUMN message_id INT;
ALTER TABLE message_attachments ALTER COLUMN message_id SET NOT NULL;
ALTER TABLE message_attachments ADD FOREIGN KEY (message_id) REFERENCES messages(id);

-- ALTERING POST_PHOTOS TABLE:
ALTER TABLE post_photos ADD COLUMN post_id INT;
ALTER TABLE post_photos ALTER COLUMN post_id SET NOT NULL;
ALTER TABLE post_photos ADD FOREIGN KEY (post_id) REFERENCES posts(id);

-- ALTERING POSTS TABLE:
ALTER TABLE posts DROP COLUMN photo_id;

-- ALTERING MESSAGES TABLE:
ALTER TABLE messages DROP COLUMN attachment_id;

-- ALTERING COMMENTS TABLE:
ALTER TABLE comments ALTER COLUMN post_id SET NOT NULL;
ALTER TABLE comments ALTER COLUMN user_id SET NOT NULL;
