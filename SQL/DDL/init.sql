CREATE TABLE users (
	id INT PRIMARY KEY NOT NULL,
	nickname VARCHAR(64) NOT NULL,
	email VARCHAR(255) NOT NULL,
	avatar_url VARCHAR(512),
	registration_date DATE NOT NULL
);

CREATE TABLE message_attachments (
	id INT PRIMARY KEY NOT NULL,
	photo_url VARCHAR(512) NOT NULL
);

CREATE TABLE messages (
	id INT PRIMARY KEY NOT NULL,
	sender_id INT REFERENCES users(id) NOT NULL,
	receiver_id INT REFERENCES users(id) NOT NULL,
	attachment_id INT REFERENCES message_attachments(id),
	text TEXT NOT NULL,
	creation_date DATE NOT NULL
);

CREATE TABLE reports (
	id INT PRIMARY KEY NOT NULL,
	user_id INT REFERENCES users(id) NOT NULL,
	note TEXT NOT NULL,
	creation_date DATE NOT NULL
);

CREATE TABLE bots (
  	id INT PRIMARY KEY NOT NULL,
  	nickname VARCHAR(255) NOT NULL,
  	description TEXT NOT NULL
);

CREATE TABLE groups (
  	id INT PRIMARY KEY NOT NULL,
  	subscribers_id INT REFERENCES users(id) NOT NULL,
  	posts_id INT REFERENCES posts(id),
  	bots_id INT REFERENCES bots(id),
  	name VARCHAR(255) NOT NULL,
  	description TEXT
);

CREATE TABLE post_photos (
  	id INT PRIMARY KEY NOT NULL,
  	photo_url VARCHAR(512) NOT NULL
);

CREATE TABLE posts (
  	id INT PRIMARY KEY NOT NULL,
  	owner_id INT REFERENCES groups(id) NOT NULL,
  	photo_id INT REFERENCES post_photos(id),
  	text TEXT NOT NULL,
  	title VARCHAR(255) NOT NULL,
  	creation_date DATE NOT NULL
);

CREATE TABLE likes (
	user_id INT REFERENCES users(id),
	post_id INT REFERENCES posts(id),

	PRIMARY KEY (user_id, post_id)
);

CREATE TABLE users_to_groups (
	user_id INT REFERENCES users(id),
	group_id INT REFERENCES groups(id),

	PRIMARY KEY (user_id, group_id)
);

CREATE TABLE groups_to_bots (
	group_id INT REFERENCES groups(id),
	bot_id INT REFERENCES bots(id),

	PRIMARY KEY (group_id, bot_id)
);

CREATE TABLE comments (
	id INT PRIMARY KEY NOT NULL,
	post_id INT REFERENCES posts(id),
	user_id INT REFERENCES users(id),
	text TEXT NOT NULL,
	creation_date DATE NOT NULL
)
