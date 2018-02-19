--
CREATE TABLE IF NOT EXISTS vol_entity (
	entity_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	entity_type TINYINT UNSIGNED NOT NULL,
	entity_name VARCHAR(255) NULL,
	entity_objid VARCHAR(30) NULL,
	PRIMARY KEY(entity_id),
	UNIQUE(entity_objid),
	INDEX(entity_name, entity_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

/*
entity_type enumeration:
0 - Account.
1 - Character.
2 - Theme.
3 - Job Bucket
4 - BBS Board.
5 - Group.
6 - Group Rank.
7 - Group Membership.
8 - District.
9 - Combat System Entity.

100+ - Game-specific implementations.
*/

CREATE TABLE IF NOT EXISTS vol_lockname (
	lock_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	lock_name VARCHAR(50) NOT NULL,
	PRIMARY KEY(lock_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_lock (
	entity_id INT UNSIGNED NOT NULL,
	lock_id TINYINT UNSIGNED NOT NULL,
	lock_definition VARCHAR(255) NOT NULL,
	PRIMARY KEY(entity_id,lock_id),
	FOREIGN KEY(entity_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(lock_id) REFERENCES vol_lockname(lock_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE OR REPLACE VIEW volv_lock AS
	SELECT l.entity_id,l.lock_id,ln.lock_name,l.lock_definition
	FROM vol_lock AS l LEFT JOIN vol_lockname AS ln ON l.lock_id=ln.lock_id;

-- Procedure for Inserting/Getting Characters!
DROP PROCEDURE IF EXISTS volp_lock;
DELIMITER $$
CREATE PROCEDURE volp_lock(IN in_entity_id INT UNSIGNED,IN in_lock_name VARCHAR(50),in_lock_definition VARCHAR(255))
	BEGIN
		DECLARE found_lock_id TINYINT UNSIGNED;
		SELECT lock_id INTO found_lock_id FROM vol_lockname WHERE lock_name=in_lock_name;
		IF found_lock_id IS NULL THEN
			INSERT INTO vol_lockname(lock_name) VALUES (in_lock_name);
			SET found_lock_id=LAST_INSERT_ID();
		ELSE
			INSERT INTO vol_lock (entity_id,lock_id,lock_definition) VALUES (in_entity_id,found_lock_id,in_lock_definition) ON DUPLICATE KEY UPDATE lock_definition=VALUES(lock_definition);
		END IF;
		SELECT found_lock_id;
	END$$
DELIMITER ;

CREATE TABLE IF NOT EXISTS vol_account (
	account_id INT UNSIGNED NOT NULL,
	account_email VARCHAR(400) NULL DEFAULT NULL,
	account_date_created DATETIME NULL,
	account_disabled BOOLEAN NOT NULL DEFAULT 0,
	account_date_activity DATETIME NULL,
	PRIMARY KEY(account_id),
	FOREIGN KEY(account_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	INDEX(account_date_activity)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE OR REPLACE VIEW volv_account AS
	SELECT a.account_id,e.entity_name AS account_name,e.entity_objid AS account_objid,a.account_email,a.account_disabled,UNIX_TIMESTAMP(a.account_date_created) AS account_date_created,UNIX_TIMESTAMP(a.account_date_activity) AS account_date_activity
	FROM vol_account AS a LEFT JOIN vol_entity AS e ON a.account_id=e.entity_id
	ORDER BY account_date_created;

CREATE TABLE IF NOT EXISTS vol_theme (
	theme_id INT UNSIGNED NOT NULL,
	theme_description TEXT NULL,
	theme_description_render TEXT NULL DEFAULT NULL,
	PRIMARY KEY(theme_id),
	FOREIGN KEY(theme_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_theme AS
	SELECT t.theme_id,e.entity_name AS theme_name,t.theme_description
	FROM vol_theme AS t LEFT JOIN vol_entity AS e ON t.theme_id=e.entity_id
	ORDER BY theme_name;

DROP PROCEDURE IF EXISTS volp_theme;
DELIMITER $$
CREATE PROCEDURE volp_theme(IN in_theme_name VARCHAR(60),IN in_theme_description TEXT)
	BEGIN
		DECLARE found_theme_id INT UNSIGNED;
		SELECT theme_id INTO found_theme_id FROM volv_theme WHERE theme_name=in_theme_name;
		IF found_theme_id IS NULL THEN
			INSERT INTO vol_entity(entity_type,entity_name) VALUES (2,in_theme_name);
			SET found_theme_id=LAST_INSERT_ID();
			INSERT INTO vol_theme(theme_id,theme_description) VALUES (found_theme_id,in_theme_description);
		ELSE
			UPDATE vol_theme SET theme_description=in_theme_description WHERE theme_id=found_theme_id;
			UPDATE vol_entity SET entity_name=in_theme_name WHERE entity_id=found_theme_id;
		END IF;
		SELECT found_theme_id;
	END$$
DELIMITER ;

CREATE TABLE IF NOT EXISTS vol_character (
	character_id INT UNSIGNED NOT NULL,
	character_is_deleted BOOLEAN NOT NULL DEFAULT 0,
	character_alt TINYINT UNSIGNED NOT NULL DEFAULT 0,
	account_id INT UNSIGNED NULL,
	character_date_created DATETIME NULL,
	character_date_activity DATETIME NULL DEFAULT NULL,
	character_date_approved DATETIME NULL DEFAULT NULL,
	character_status VARCHAR(25) NULL DEFAULT NULL,
	character_is_guest BOOLEAN DEFAULT FALSE,
	character_is_approved BOOLEAN DEFAULT FALSE,
	PRIMARY KEY(character_id),
	FOREIGN KEY(character_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(account_id) REFERENCES vol_account(account_id) ON UPDATE CASCADE ON DELETE SET NULL,
	INDEX(character_date_activity),
	INDEX(account_id,character_alt)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_character AS
	SELECT c.character_id,e.entity_name AS character_name,e.entity_objid AS character_objid,c.character_is_deleted,c.account_id,c.character_alt,c.character_date_created,UNIX_TIMESTAMP(c.character_date_created) AS character_date_created_secs,c.character_date_activity,UNIX_TIMESTAMP(c.character_date_activity) AS character_date_activity_secs,c.character_date_approved,UNIX_TIMESTAMP(c.character_date_approved) AS character_date_approved_secs,c.character_status,c.character_is_guest
	FROM vol_character AS c LEFT JOIN vol_entity AS e ON e.entity_id=c.character_id;

CREATE OR REPLACE VIEW volv_account_characters AS
	SELECT a.*,c.character_is_deleted AS old_characters,GROUP_CONCAT(c.character_id ORDER BY c.character_name SEPARATOR ' ') AS character_ids,GROUP_CONCAT(c.character_name ORDER BY c.character_date_activity SEPARATOR '|') AS character_names,GROUP_CONCAT(c.character_objid ORDER BY c.character_date_activity SEPARATOR ' ') AS character_objids,count(c.character_objid) AS characters_active
	FROM volv_character AS c LEFT JOIN volv_account AS a ON c.account_id=a.account_id
	GROUP BY a.account_id,c.character_is_deleted
	ORDER BY a.account_date_activity;

CREATE TABLE IF NOT EXISTS vol_approve (
	approve_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	character_id INT UNSIGNED NOT NULL,
	approver_id INT UNSIGNED NOT NULL,
	approve_action BOOLEAN NOT NULL,
	approve_date DATETIME NOT NULL,
	approve_text TEXT NULL DEFAULT NULL,
	PRIMARY KEY(approve_id),
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(approver_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE,
	INDEX(character_id,approve_action),
	INDEX(approver_id,approve_action)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_approve AS
	SELECT a.approve_id,c.*,a.approver_id,c1.character_objid AS approver_objid,c1.character_name AS approver_name,a.approve_action,a.approve_date,UNIX_TIMESTAMP(a.approve_date) AS approve_date_secs,a.approve_text
	FROM vol_approve AS a LEFT JOIN volv_character AS c ON a.character_id=c.character_id LEFT JOIN volv_character AS c1 ON c1.character_id=a.approver_id
	ORDER BY a.approve_id;

DROP PROCEDURE IF EXISTS volp_approve;
DELIMITER $$
CREATE PROCEDURE volp_approve(IN in_character_id INT UNSIGNED,IN in_approver_id INT UNSIGNED,IN in_approve_action BOOLEAN,IN in_approve_text TEXT)
	BEGIN
		INSERT INTO vol_approve (character_id,approver_id,approve_action,approve_date,approve_text) VALUES (in_character_id,in_approver_id,in_approve_action,UTC_TIMESTAMP(),in_approve_text);
		UPDATE vol_character SET character_is_approved=in_approve_action WHERE character_id=in_character_id;
		SELECT LAST_INSERT_ID();
	END$$
DELIMITER ;

CREATE TABLE IF NOT EXISTS vol_field (
	field_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	entity_id INT UNSIGNED NOT NULL,
	field_type TINYINT UNSIGNED NOT NULL,
	field_name VARCHAR(255),
	field_text TEXT NULL,
	field_text_render TEXT NULL DEFAULT NULL,
	field_date_modified DATETIME NULL,
	author_id INT UNSIGNED NOT NULL,
	PRIMARY KEY(field_id),
	FOREIGN KEY(entity_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(author_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(entity_id,field_type,field_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_field_lock (
	field_id MEDIUMINT UNSIGNED NOT NULL,
	locker_id INT UNSIGNED NOT NULL,
	locked_date DATETIME NOT NULL,
	PRIMARY KEY(field_id),
	FOREIGN KEY(field_id) REFERENCES vol_field(field_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(locker_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

DROP PROCEDURE IF EXISTS volp_field;
DELIMITER $$
CREATE PROCEDURE volp_field(IN in_entity_id INT UNSIGNED,IN in_field_type TINYINT UNSIGNED,IN in_field_name VARCHAR(255),IN in_field_text TEXT,IN in_author_id INT UNSIGNED)
	BEGIN
		DECLARE found_field_id MEDIUMINT UNSIGNED;
		SELECT field_id INTO found_field_id FROM vol_field WHERE entity_id=in_entity_id AND field_type=in_field_type AND field_name=in_field_name;
		IF found_field_id IS NULL THEN
			INSERT INTO vol_field(entity_id,field_type,field_name,field_text,field_date_modified,author_id) VALUES (in_entity_id,in_field_type,in_field_name,in_field_text,UTC_TIMESTAMP(),in_author_id);
			SET found_field_id=LAST_INSERT_ID();
		ELSE
			UPDATE vol_field SET field_text=in_field_text,field_name=in_field_name,field_date_modified=UTC_TIMESTAMP(),author_id=in_author_id WHERE field_id=found_field_id;
		END IF;
		SELECT found_field_id;
	END$$
DELIMITER ;

CREATE OR REPLACE VIEW volv_infofile AS
	SELECT i.field_id AS info_id,i.field_type AS info_type,i.field_name AS info_name,i.field_text AS info_text,i.field_date_modified AS info_date_modified,UNIX_TIMESTAMP(i.field_date_modified) AS info_date_modified_secs,e.entity_id AS owner_id,e.entity_name AS owner_name,e.entity_objid AS owner_objid,l.locker_id,e2.entity_name AS locker_name,e2.entity_objid AS locker_objid,l.locked_date,UNIX_TIMESTAMP(l.locked_date) AS locked_date_secs,e3.entity_name as author_name,e3.entity_objid AS author_objid	FROM vol_field AS i LEFT JOIN vol_entity AS e ON i.entity_id=e.entity_id LEFT JOIN vol_field_lock AS l ON i.field_id=l.field_id LEFT JOIN vol_entity AS e2 ON e2.entity_id=l.locker_id LEFT JOIN vol_entity AS e3 ON e3.entity_id=i.author_id
	ORDER BY i.entity_id,i.field_type,i.field_name;


/*
field_type enumeration:
0 - Multidescer.
1 - Info files or other primary purpose per entity_id's entity_type.
2 - Private Info files for +info system.
2-99 - Reserved for Volund's usage.
100-255 - Game-specific implementations.
*/

CREATE OR REPLACE VIEW volv_multidescer AS
	SELECT f.field_id AS desc_id,f.field_name AS desc_name,f.field_text AS desc_text,f.field_date_modified AS desc_date_modified,UNIX_TIMESTAMP(f.field_date_modified) AS desc_date_modified_secs,c.*
	FROM vol_field AS f LEFT JOIN volv_character AS c ON f.entity_id=c.character_id
	WHERE c.character_id IS NOT NULL AND f.field_type=0
	ORDER BY c.character_name,f.field_name;

CREATE TABLE IF NOT EXISTS vol_tag (
	tag_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	tag_type TINYINT UNSIGNED NOT NULL,
	tag_name VARCHAR(254) NOT NULL,
	tag_description TEXT,
	PRIMARY KEY(tag_id),
	UNIQUE(tag_type,tag_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

/*
tag_type enumeration:
0 - Finger field names.
1 - Theme Member Types (FC, OC, EFC, etc)
2 - Character Status types (Open, Played, Closing, etc)
3 - Group Permissions.
4-99 - Reserved for Volund's usage.
100-255 - Game-specific implementations.
*/

DROP PROCEDURE IF EXISTS volp_tag;
DELIMITER $$
CREATE PROCEDURE volp_tag(IN in_tag_type TINYINT UNSIGNED,IN in_tag_name VARCHAR(254),IN in_tag_description TEXT)
	BEGIN
		DECLARE found_tag_id MEDIUMINT UNSIGNED;
		SELECT tag_id INTO found_tag_id FROM vol_tag WHERE tag_type=in_tag_type AND tag_name=in_tag_name;
		IF found_tag_id IS NULL THEN
			INSERT INTO vol_tag(tag_type,tag_name,tag_description) VALUES (in_tag_type,in_tag_name,in_tag_description);
			SET found_tag_id=LAST_INSERT_ID();
		ELSE
			UPDATE vol_tag SET tag_name=in_tag_name,tag_description=in_tag_description WHERE tag_id=found_tag_id;
		END IF;
		SELECT found_tag_id;
	END$$
DELIMITER ;

CREATE TABLE IF NOT EXISTS vol_trait (
	entity_id INT UNSIGNED NOT NULL,
	tag_id SMALLINT UNSIGNED NOT NULL,
	trait_contents TEXT,
	PRIMARY KEY(entity_id,tag_id),
	FOREIGN KEY(entity_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(tag_id) REFERENCES vol_tag(tag_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS vol_tmember (
	character_id INT UNSIGNED NOT NULL,
	theme_id INT UNSIGNED NOT NULL,
	tmember_type VARCHAR(10) NULL DEFAULT NULL,
	PRIMARY KEY(character_id,theme_id),
	INDEX(tmember_type),
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(theme_id) REFERENCES vol_theme(theme_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE OR REPLACE VIEW volv_theme_member AS
	SELECT t.theme_id,t.theme_name,tm.tmember_type,c.*
	FROM vol_tmember AS tm LEFT JOIN volv_character AS c ON tm.character_id=c.character_id LEFT JOIN volv_theme AS t ON t.theme_id=tm.theme_id
	WHERE c.character_is_deleted=0
	ORDER BY t.theme_name,c.character_name;

CREATE OR REPLACE VIEW volv_theme_agg AS
	SELECT theme_id,theme_name,GROUP_CONCAT(character_objid ORDER BY character_name SEPARATOR ' ') AS theme_member_objids,GROUP_CONCAT(character_name ORDER BY character_name SEPARATOR '|') AS theme_member_names
	FROM volv_theme_member GROUP BY theme_id;

CREATE OR REPLACE VIEW volv_theme_magg AS
	SELECT character_id,character_name,character_objid,GROUP_CONCAT(theme_id ORDER BY theme_name SEPARATOR ' ') as character_theme_ids,GROUP_CONCAT(theme_name ORDER BY theme_name SEPARATOR '|') AS character_theme_names,GROUP_CONCAT(tmember_type ORDER BY theme_name SEPARATOR '|') AS theme_name_tags,COUNT(theme_id) AS theme_membership_count
	FROM volv_theme_member GROUP BY character_id;

-- Some miscellaneous SQL Schema...
CREATE TABLE IF NOT EXISTS vol_watch (
	entity_id INT UNSIGNED NOT NULL,
	character_id INT UNSIGNED NOT NULL,
	PRIMARY KEY(entity_id,character_id),
	FOREIGN KEY(entity_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE OR REPLACE VIEW volv_watch AS
	SELECT w.entity_id AS watcher_id,e.entity_objid AS watcher_objid,c.* FROM vol_watch AS w LEFT JOIN volv_character AS c ON c.character_id=w.character_id LEFT JOIN vol_entity AS e ON e.entity_id=w.entity_id AND e.entity_objid IS NOT NULL;
	
-- SQL SCHEMA for the IP login tracker.
CREATE TABLE IF NOT EXISTS vol_ip (
	ip_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	ip_address VARCHAR(39) NOT NULL,
	PRIMARY KEY(ip_id),
	UNIQUE(ip_address)	
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
	
CREATE TABLE IF NOT EXISTS vol_login (
	login_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	character_id INT UNSIGNED NOT NULL,
	login_date DATETIME NOT NULL,
	login_is_success BOOLEAN NOT NULL DEFAULT 0,
	ip_id INT UNSIGNED NOT NULL,
	PRIMARY KEY(login_id),
	INDEX(character_id, login_date, login_is_success),
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(ip_id) REFERENCES vol_ip(ip_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- View that maps login data with the player source and IP address.
CREATE OR REPLACE VIEW volv_login AS 
	SELECT l.login_id,c.*,l.login_date,UNIX_TIMESTAMP(l.login_date) AS login_date_secs,l.login_is_success,i.ip_address
	FROM vol_login AS l LEFT JOIN vol_ip AS i ON l.ip_id=i.ip_id LEFT JOIN volv_character AS c ON l.character_id=c.character_id
	ORDER BY l.login_date;

-- Stored Procedure for inserting new login!
DROP PROCEDURE IF EXISTS volp_login_record;
DELIMITER $$
CREATE PROCEDURE volp_login_record(IN in_character_id INT UNSIGNED,IN in_success BOOL,IN in_ip_address VARCHAR(39))
BEGIN
	DECLARE found_ip_id INT UNSIGNED;
	SELECT ip_id INTO found_ip_id FROM vol_ip WHERE ip_address=in_ip_address;
	IF found_ip_id IS NULL THEN
		INSERT INTO vol_ip(ip_address) VALUES (in_ip_address);
		SET found_ip_id=LAST_INSERT_ID();
	END IF;
	INSERT INTO vol_login(character_id,login_date,login_is_success,ip_id) VALUES (in_character_id,UTC_TIMESTAMP(),in_success,found_ip_id);
	SELECT LAST_INSERT_ID();
END$$
DELIMITER ;

-- Procedure for Inserting/Getting Characters!
DROP PROCEDURE IF EXISTS volp_character;
DELIMITER $$
CREATE PROCEDURE volp_character(IN in_character_objid VARCHAR(30),IN in_character_name VARCHAR(60),IN in_character_csecs INT UNSIGNED,IN in_character_guest BOOLEAN)
BEGIN
	DECLARE found_character_id INT UNSIGNED;
	SELECT character_id INTO found_character_id FROM volv_character WHERE character_objid=in_character_objid;
	IF found_character_id IS NULL THEN
		INSERT INTO vol_entity(entity_type,entity_objid,entity_name) VALUES (1,in_character_objid,in_character_name);
		SET found_character_id=LAST_INSERT_ID();
		INSERT INTO vol_character(character_id,character_date_created,character_is_guest) VALUES (found_character_id,FROM_UNIXTIME(in_character_csecs),in_character_guest);
		SET found_character_id=LAST_INSERT_ID();
	ELSE
		UPDATE vol_entity SET entity_name=in_character_name WHERE entity_id=found_character_id;
		UPDATE vol_character SET character_date_activity=UTC_TIMESTAMP(),character_is_guest=in_character_guest;
	END IF;
	SELECT found_character_id;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_account;
DELIMITER $$
CREATE PROCEDURE volp_account(IN in_account_objid VARCHAR(30),IN in_account_name VARCHAR(254))
BEGIN
	DECLARE found_account_id INT UNSIGNED;
	SELECT account_id INTO found_account_id FROM volv_account WHERE account_objid=in_account_objid;
	IF found_account_id IS NULL THEN
		INSERT INTO vol_entity(entity_type,entity_objid,entity_name) VALUES (0,in_account_objid,in_account_name);
		SET found_account_id=LAST_INSERT_ID();
		INSERT INTO vol_account(account_id,account_date_created) VALUES (found_account_id,UTC_TIMESTAMP());
	ELSE
		UPDATE vol_entity SET entity_name=in_account_name WHERE entity_id=found_account_id;
	END IF;
	SELECT found_account_id;
END$$
DELIMITER ;

-- SQL SCHEMA FOR THE JOB SYSTEM!
CREATE TABLE IF NOT EXISTS vol_bucket (
	bucket_id INT UNSIGNED NOT NULL,
	bucket_due INT UNSIGNED NOT NULL DEFAULT 1209600,
	bucket_is_anonymous BOOLEAN DEFAULT FALSE,
	bucket_description TEXT NULL DEFAULT NULL,
	bucket_description_render TEXT NULL DEFAULT NULL,
	bucket_stats BOOLEAN DEFAULT TRUE,
	PRIMARY KEY(bucket_id),
	FOREIGN KEY(bucket_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE OR REPLACE VIEW volv_bucket AS
	SELECT b.bucket_id,e.entity_name AS bucket_name,b.bucket_due,b.bucket_is_anonymous,b.bucket_description,b.bucket_stats,l.lock_definition AS bucket_post_lock,l2.lock_definition AS bucket_admin_lock,UTC_TIMESTAMP() + INTERVAL bucket_due SECOND AS bucket_new_due
	FROM vol_bucket AS b LEFT JOIN vol_entity AS e ON b.bucket_id=e.entity_id
	LEFT JOIN volv_lock AS l ON l.entity_id=b.bucket_id AND l.lock_name="POST" LEFT JOIN volv_lock AS l2 ON l2.entity_id=b.bucket_id AND l2.lock_name="ADMIN"
	ORDER BY bucket_name;
	
CREATE TABLE IF NOT EXISTS vol_job (
	job_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	job_title VARCHAR(255) NOT NULL,
	bucket_id INT UNSIGNED NOT NULL,
	job_date_created DATETIME NOT NULL,
	job_date_closed DATETIME,
	job_date_due DATETIME,
	job_date_player_activity DATETIME NOT NULL,
	job_date_admin_activity DATETIME NOT NULL,
	job_status TINYINT UNSIGNED DEFAULT 0,
	job_is_anonymous BOOLEAN NOT NULL DEFAULT FALSE,
	INDEX(job_status,job_date_closed),
	PRIMARY KEY(job_id),
	FOREIGN KEY(bucket_id) REFERENCES vol_bucket(bucket_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
	
CREATE TABLE IF NOT EXISTS vol_jlink (
	jlink_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	job_id MEDIUMINT UNSIGNED NOT NULL,
	character_id INT UNSIGNED NOT NULL,
	jlink_type TINYINT UNSIGNED DEFAULT 0,
	jlink_date_check DATETIME,
	PRIMARY KEY(jlink_id),
	UNIQUE(job_id,character_id),
	INDEX(job_id,jlink_type),
	FOREIGN KEY(job_id) REFERENCES vol_job(job_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_jcomment (
	jcomment_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	jlink_id MEDIUMINT UNSIGNED NOT NULL,
	jcomment_date_created DATETIME NOT NULL,
	jcomment_text TEXT NOT NULL,
	jcomment_text_render TEXT NULL DEFAULT NULL,
	jcomment_type TINYINT UNSIGNED DEFAULT 0,
	jcomment_is_visible BOOLEAN NOT NULL DEFAULT TRUE,
	PRIMARY KEY(jcomment_id),
	INDEX(jcomment_is_visible),
	FOREIGN KEY(jlink_id) REFERENCES vol_jlink(jlink_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_jlink AS
	SELECT jl.jlink_id,jl.job_id,jl.jlink_type,jl.jlink_date_check,c.* FROM vol_jlink AS jl LEFT JOIN volv_character AS c ON c.character_id=jl.character_id;

CREATE OR REPLACE VIEW volv_jcharacters AS
	SELECT jl.job_id,GROUP_CONCAT(IF(jl.jlink_type=1,e.entity_objid,NULL) ORDER BY e.entity_name SEPARATOR ' ') AS helper_objids,GROUP_CONCAT(IF(jl.jlink_type=2,e.entity_objid,NULL) ORDER BY e.entity_name SEPARATOR ' ') AS handler_objids,GROUP_CONCAT(IF(jl.jlink_type=3,e.entity_objid,NULL) ORDER BY e.entity_name SEPARATOR ' ') AS owner_objids FROM vol_jlink AS jl LEFT JOIN vol_entity AS e ON e.entity_id=jl.character_id WHERE jl.jlink_type>0 GROUP BY jl.job_id;
	
CREATE OR REPLACE VIEW volv_job AS
	SELECT b.bucket_id,b.bucket_name,b.bucket_post_lock,b.bucket_admin_lock,j.job_id,j.job_title,j.job_date_created,UNIX_TIMESTAMP(j.job_date_created) AS job_date_created_secs,j.job_date_due,UNIX_TIMESTAMP(job_date_due) AS job_date_due_secs,NOW()>j.job_date_due AND j.job_status=0 AS job_is_overdue,(j.job_date_closed IS NOT NULL AND j.job_date_closed>NOW() - INTERVAL 1 WEEK) OR j.job_status=0 AS job_is_recent,j.job_date_closed,UNIX_TIMESTAMP(j.job_date_closed) as job_date_closed_secs,j.job_date_player_activity,UNIX_TIMESTAMP(j.job_date_player_activity) AS job_date_player_activity_secs,j.job_date_admin_activity,UNIX_TIMESTAMP(j.job_date_admin_activity) AS job_date_admin_activity_secs,GREATEST(j.job_date_player_activity,j.job_date_admin_activity) AS job_date_latest_activity,UNIX_TIMESTAMP(GREATEST(j.job_date_player_activity,j.job_date_admin_activity)) AS job_date_latest_activity_secs,job_status,job_is_anonymous,jc.owner_objids,jc.helper_objids,jc.handler_objids,jl.character_name AS owner_name,jl.character_objid AS owner_objid,jl.character_id AS owner_id
	FROM vol_job AS j LEFT JOIN volv_bucket AS b ON b.bucket_id=j.bucket_id LEFT JOIN volv_jcharacters AS jc ON jc.job_id=j.job_id LEFT JOIN volv_jlink AS jl ON jl.job_id=j.job_id AND jl.jlink_type=3
	ORDER BY b.bucket_id,j.job_id;

-- Link comments with their creator data!
CREATE OR REPLACE VIEW volv_jcomment AS 
	SELECT jc.jcomment_id,jl.job_id,jl.jlink_type,jl.character_id as commenter_id,jl.character_name AS commenter_name,jl.character_objid AS commenter_objid,jc.jcomment_text,jc.jcomment_type,jc.jcomment_is_visible,jl.jlink_date_check AS commenter_date_check,UNIX_TIMESTAMP(jl.jlink_date_check) AS commenter_date_check_secs,jc.jcomment_date_created,UNIX_TIMESTAMP(jc.jcomment_date_created) AS jcomment_date_created_secs
	FROM vol_jcomment AS jc LEFT JOIn volv_jlink AS jl ON jl.jlink_id=jc.jlink_id
	ORDER BY jc.jcomment_date_created;

-- And a nice view of all job category status!
CREATE OR REPLACE VIEW volv_bucket_status AS
	SELECT j.bucket_id,sum(j.job_status=0) AS pending_count,sum(j.job_status=1) AS approved_count,sum(j.job_status=2) AS deny_count,sum(j.job_status=3) AS cancel_count,sum(j.job_status=0 AND j.job_date_due<NOW()) AS overdue_count 
	FROM volv_job as j GROUP BY j.bucket_id ORDER BY j.bucket_name;

CREATE OR REPLACE VIEW volv_bucket_list AS
	SELECT b.*,bs.pending_count,bs.approved_count,bs.deny_count,bs.cancel_count,bs.overdue_count FROM volv_bucket AS b LEFT JOIN volv_bucket_status AS bs ON b.bucket_id=bs.bucket_id ORDER by b.bucket_name;
	
-- Stored Procedure to create and manage Jobs.





DROP PROCEDURE IF EXISTS volp_job_bucket;
DELIMITER $$
CREATE PROCEDURE volp_job_bucket(IN in_bucket_name VARCHAR(255))
	BEGIN
		DECLARE found_bucket_id INT UNSIGNED;
		SELECT bucket_id INTO found_bucket_id FROM volv_bucket WHERE bucket_name=in_bucket_name;
		IF found_bucket_id IS NULL THEN
			INSERT INTO vol_entity(entity_type,entity_name) VALUES (3,in_bucket_name);
			SET found_bucket_id=LAST_INSERT_ID();
			INSERT INTO vol_bucket(bucket_id) VALUES (found_bucket_id);
			CALL volp_lock(found_bucket_id,'POST','#TRUE');
			CALL volp_lock(found_bucket_id,'ADMIN','V`ADMIN:>0');
		ELSE
			UPDATE vol_entity SET entity_name=in_bucket_name WHERE entity_id=found_bucket_id;
		END IF;
		SELECT found_bucket_id;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_job_new;
DELIMITER $$
CREATE PROCEDURE volp_job_new(IN in_character_id INT UNSIGNED,IN in_bucket_id INT UNSIGNED,IN in_job_anonymous BOOLEAN,IN in_job_title VARCHAR(255),IN in_job_opening TEXT)
BEGIN
	DECLARE new_link_id,new_job_id,new_comment_id MEDIUMINT UNSIGNED;
	DECLARE bucket_due DATETIME;
	SELECT bucket_new_due INTO bucket_due FROM volv_bucket WHERE bucket_id=in_bucket_id;
	INSERT INTO vol_job (job_title,bucket_id,job_date_created,job_date_player_activity,job_date_admin_activity,job_is_anonymous,job_date_due) VALUES (in_job_title,in_bucket_id,UTC_TIMESTAMP(),UTC_TIMESTAMP(),UTC_TIMESTAMP(),in_job_anonymous,bucket_due);
	SET new_job_id=LAST_INSERT_ID();
	INSERT INTO vol_jlink(job_id,character_id,jlink_type,jlink_date_check) VALUES (new_job_id,in_character_id,3,UTC_TIMESTAMP());
	SET new_link_id=LAST_INSERT_ID();
	INSERT INTO vol_jcomment(jlink_id,jcomment_text,jcomment_date_created,jcomment_type) VALUES (new_link_id,in_job_opening,UTC_TIMESTAMP(),0);
	SET new_comment_id=LAST_INSERT_ID();	
	SELECT new_job_id,new_link_id,new_comment_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_job_promote;
DELIMITER $$
CREATE PROCEDURE volp_job_promote(IN in_character_id INT UNSIGNED,IN in_job_id MEDIUMINT UNSIGNED,IN in_jlink_type TINYINT UNSIGNED)
BEGIN
	DECLARE found_jlink_id MEDIUMINT UNSIGNED;
	SELECT jlink_id INTO found_jlink_id FROM vol_jlink WHERE job_id=in_job_id AND character_id=in_character_id;
	IF found_jlink_id IS NULL THEN
		INSERT INTO vol_jlink(job_id,character_id,jlink_type) VALUES (in_job_id,in_character_id,in_jlink_type);
		SET found_jlink_id=LAST_INSERT_ID();
	ELSE
		UPDATE vol_jlink SET jlink_type=in_jlink_type WHERE jlink_id=found_jlink_id;
	END IF;
	SELECT found_jlink_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_job_comment;
DELIMITER $$
CREATE PROCEDURE volp_job_comment(IN in_character_id INT UNSIGNED,IN in_job_id MEDIUMINT UNSIGNED,IN in_jcomment_text TEXT,IN in_jcomment_type TINYINT UNSIGNED)
BEGIN
	DECLARE found_jlink_id,new_jcomment_id,new_jcomment_visible MEDIUMINT UNSIGNED;
	SELECT jlink_id INTO found_jlink_id FROM vol_jlink WHERE job_id=in_job_id AND character_id=in_character_id;
	IF found_jlink_id IS NULL THEN
		INSERT INTO vol_jlink(job_id,character_id,jlink_type,jlink_date_check) VALUES (in_job_id,in_character_id,0,UTC_TIMESTAMP());
		SET found_jlink_id=LAST_INSERT_ID();
	ELSE
		UPDATE vol_jlink SET jlink_date_check=UTC_TIMESTAMP() WHERE jlink_id=found_jlink_id;
	END IF;
	IF in_jcomment_type=2 THEN
		SET new_jcomment_visible=FALSE;
	ELSE
		SET new_jcomment_visible=TRUE;
	END IF;
	INSERT INTO vol_jcomment(jlink_id,jcomment_date_created,jcomment_text,jcomment_type,jcomment_is_visible) VALUES (found_jlink_id,UTC_TIMESTAMP(),in_jcomment_text,in_jcomment_type,new_jcomment_visible);
	SET new_jcomment_id=LAST_INSERT_ID();
	SELECT new_jcomment_id,new_jcomment_visible;
END $$
DELIMITER ;

-- [switch(%q<ctype>,0,Opened,1,Replied,2,ansi(hr,STAFF COMMENTED),3,Moved,4,Approved,5,Denied,6,Canceled,7,Revived,8,Appointed Handler,9,Appointed Helper,10,Removed Handler,11,Removed Helper,12,Due Date Changed,???)]

--
-- SQL Schema for the Group System!
CREATE TABLE IF NOT EXISTS vol_group_tier (
	group_tier TINYINT UNSIGNED NOT NULL,
	group_is_private BOOLEAN NOT NULL DEFAULT 1,
	tier_name VARCHAR(255) NOT NULL,
	PRIMARY KEY(group_tier,group_is_private),
	UNIQUE(group_is_private,tier_name)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_group (
	group_id INT UNSIGNED NOT NULL,
	group_tier TINYINT UNSIGNED DEFAULT 0,
	group_abbr VARCHAR(10) NULL,
	group_is_private BOOLEAN NOT NULL DEFAULT 1,
	group_parent INT UNSIGNED NULL DEFAULT NULL,
	group_description TEXT NULL DEFAULT NULL,
	group_description_render TEXT NULL DEFAULT NULL,
	PRIMARY KEY(group_id),
	FOREIGN KEY(group_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(group_parent) REFERENCES vol_group(group_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(group_abbr,group_parent),
	INDEX(group_is_private,group_tier)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE OR REPLACE VIEW volv_group AS
	SELECT g.group_id,e.entity_name AS group_name,e.entity_objid AS group_objid,g.group_abbr,g.group_parent,g.group_tier,g.group_is_private,t.tier_name
	FROM vol_group AS g LEFT JOIN vol_entity AS e ON e.entity_id=g.group_id LEFT JOIN vol_group_tier AS t ON t.group_tier=g.group_tier AND g.group_is_private=t.group_is_private
	ORDER BY g.group_is_private,g.group_tier,e.entity_name;

CREATE TABLE IF NOT EXISTS vol_group_rank (
	rank_id INT UNSIGNED NOT NULL,
	group_id INT UNSIGNED NOT NULL,
	group_rank_number SMALLINT UNSIGNED NOT NULL,
	PRIMARY KEY(rank_id),
	FOREIGN KEY(rank_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(group_id) REFERENCES vol_group(group_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(group_id,group_rank_number)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
	
CREATE OR REPLACE VIEW volv_group_rank AS
	SELECT r.rank_id AS group_rank_id,r.group_rank_number,e.entity_name AS group_rank_title,g.group_id,g.group_name,g.group_objid,g.group_abbr,g.group_tier,g.group_is_private,g.tier_name	FROM vol_group_rank AS r LEFT JOIN vol_entity AS e ON r.rank_id=e.entity_id
	LEFT JOIN volv_group AS g ON r.group_id=g.group_id
	WHERE g.group_id IS NOT NULL;

CREATE TABLE IF NOT EXISTS vol_group_member (
	member_id INT UNSIGNED NOT NULL,
	character_id INT UNSIGNED NOT NULL,
	group_id INT UNSIGNED NOT NULL,
	rank_id INT UNSIGNED NULL,
	PRIMARY KEY(member_id),
	FOREIGN KEY(member_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(character_id,group_id),
	FOREIGN KEY(group_id) REFERENCES vol_group(group_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(rank_id) REFERENCES vol_group_rank(rank_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
	
CREATE OR REPLACE VIEW volv_group_member AS
	SELECT m.member_id,m.character_id,c.character_name,c.character_objid,e.entity_name AS group_member_title,m.rank_id AS group_rank_id,r.group_rank_number,e1.entity_name AS group_rank_title,g.group_id,g.group_name,g.group_objid,g.group_abbr,g.group_tier,g.group_is_private,g.tier_name,g.group_parent
	FROM vol_group_member AS m LEFT JOIN vol_entity AS e ON m.member_id=e.entity_id
	LEFT JOIN volv_character AS c ON c.character_id=m.character_id
	LEFT JOIN vol_group_rank AS r ON m.rank_id=r.rank_id
	LEFT JOIN vol_entity AS e1 ON r.rank_id=e1.entity_id
	LEFT JOIN volv_group AS g ON g.group_id=m.group_id
	WHERE c.character_is_deleted=0 AND m.rank_id IS NOT NULL;

CREATE OR REPLACE VIEW volv_group_tiers AS
	SELECT g.group_tier,g.tier_name,g.group_parent,GROUP_CONCAT(g.group_objid ORDER BY g.group_name ASC SEPARATOR ' ') AS group_objids,GROUP_CONCAT(g.group_name ORDER BY g.group_name ASC SEPARATOR '|') AS group_names,g.group_is_private
	FROM volv_group as g
	GROUP BY g.group_is_private,g.group_tier,g.group_parent
	ORDER BY g.group_tier DESC;

CREATE OR REPLACE VIEW volv_group_rankgroups AS
	SELECT group_id,group_objid,group_name,group_rank_number,GROUP_CONCAT(character_objid ORDER BY character_name ASC SEPARATOR ' ') AS character_objids,GROUP_CONCAT(character_name ORDER BY character_name ASC SEPARATOR '|') AS character_names
	FROM volv_group_member
	GROUP BY group_id,group_rank_number
	ORDER BY group_name,group_rank_number;

CREATE OR REPLACE VIEW volv_group_member_tiers AS
	SELECT m.character_id,m.character_objid,m.character_name,m.group_tier,t.tier_name,GROUP_CONCAT(m.group_objid ORDER BY m.group_name ASC SEPARATOR ' ') AS group_objids,m.group_is_private AS group_is_private
	FROM volv_group_member AS m LEFT JOIN vol_group_tier AS t ON t.group_tier=m.group_tier
	WHERE group_objid IS NOT NULL
	GROUP BY m.character_id,m.group_tier
	ORDER BY m.character_name ASC,m.group_tier DESC;

-- Procedures for Group System
DROP PROCEDURE IF EXISTS volp_group;
DELIMITER $$
CREATE PROCEDURE volp_group(IN in_group_objid VARCHAR(30),IN in_group_name VARCHAR(255),IN in_group_tier TINYINT UNSIGNED,IN in_group_private BOOLEAN)
	BEGIN
		DECLARE found_group_id INT UNSIGNED;
		SELECT group_id INTO found_group_id FROM volv_group WHERE group_objid=in_group_objid;
		IF found_group_id IS NULL THEN
			INSERT INTO vol_entity(entity_objid,entity_name,entity_type) VALUES (in_group_objid,in_group_name,5);
			SET found_group_id=LAST_INSERT_ID();
			INSERT INTO vol_group (group_id,group_tier,group_is_private) VALUES (found_group_id,in_group_tier,in_group_private);
		ELSE
			UPDATE vol_entity SET entity_name=in_group_name WHERE entity_id=found_group_id;
		END IF;
		SELECT found_group_id;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_group_division;
DELIMITER $$
CREATE PROCEDURE volp_group_division(IN in_division_objid VARCHAR(30),IN in_division_name VARCHAR(255),IN in_division_parent INT UNSIGNED)
  BEGIN
    DECLARE found_group_id INT UNSIGNED;
    SELECT group_id INTO found_group_id FROM volv_group WHERE group_objid=in_division_objid;
    IF found_group_id IS NULL THEN
      INSERT INTO vol_entity(entity_objid,entity_name,entity_type) VALUES (in_division_objid,in_division_name,5);
      SET found_group_id=LAST_INSERT_ID();
      INSERT INTO vol_group (group_id,group_parent) VALUES (found_group_id,in_division_parent);
    ELSE
      UPDATE vol_entity SET entity_name=in_division_name WHERE entity_id=found_group_id;
    END IF;
    SELECT found_group_id;
  END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_group_rank;
DELIMITER $$
CREATE PROCEDURE volp_group_rank(IN in_group_id INT UNSIGNED,IN in_rank_number SMALLINT UNSIGNED,IN in_rank_title VARCHAR(255))
	BEGIN
		DECLARE found_rank_id INT UNSIGNED;
		SELECT rank_id INTO found_rank_id FROM vol_group_rank WHERE group_id=in_group_id AND group_rank_number=in_rank_number;
		IF found_rank_id IS NULL THEN
			INSERT INTO vol_entity(entity_name,entity_type) VALUES (in_rank_title,6);
			SET found_rank_id=LAST_INSERT_ID();
			INSERT INTO vol_group_rank (rank_id,group_id,group_rank_number) VALUES (found_rank_id,in_group_id,in_rank_number);
		ELSE
			UPDATE vol_entity SET entity_name=in_rank_title WHERE entity_id=found_rank_id;
		END IF;
		SELECT found_rank_id;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_group_member;
DELIMITER $$
CREATE PROCEDURE volp_group_member(IN in_group_id INT UNSIGNED,IN in_character_id INT UNSIGNED)
	BEGIN
		DECLARE found_member_id INT UNSIGNED;
		SELECT member_id INTO found_member_id FROM vol_group_member WHERE group_id=in_group_id AND character_id=in_character_id;
		IF found_member_id IS NULL THEN
			INSERT INTO vol_entity(entity_type) VALUES (7);
			SET found_member_id=LAST_INSERT_ID();
			INSERT INTO vol_group_member (member_id,character_id,group_id) VALUES (found_member_id,in_character_id,in_group_id);
		END IF;
		SELECT found_member_id;
	END $$
DELIMITER ;

-- SQL Schema for the BBS.
CREATE TABLE IF NOT EXISTS vol_board (
	board_id INT UNSIGNED NOT NULL,
	board_number SMALLINT UNSIGNED NOT NULL,
	group_id INT UNSIGNED NULL,
	board_anonymous VARCHAR(100) NULL,
	board_mandatory BOOLEAN NOT NULL DEFAULT 0,
	PRIMARY KEY(board_id),
	FOREIGN KEY(board_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(group_id) REFERENCES vol_group(group_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(group_id,board_number)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS vol_bbpost (
	post_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	board_id INT UNSIGNED NOT NULL,
	post_display_num INT UNSIGNED NOT NULL,
	entity_id INT UNSIGNED NOT NULL,
	post_date_created DATETIME NOT NULL,
	post_date_modified DATETIME NOT NULL,
	post_date_commented DATETIME NOT NULL,
	post_text text NOT NULL,
	post_text_render TEXT NULL DEFAULT NULL,
	post_title VARCHAR(255) NULL,
	post_anonymous BOOLEAN NOT NULL DEFAULT 0,
	PRIMARY KEY(post_id),
	FOREIGN KEY(board_id) REFERENCES vol_board(board_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(entity_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(board_id,post_display_num)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_bbcomment (
	comment_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	post_id INT UNSIGNED NOT NULL,
	comment_display_num INT UNSIGNED NOT NULL,
	entity_id INT UNSIGNED NOT NULL,
	comment_date_created DATETIME NOT NULL,
	comment_date_modified DATETIME NOT NULL,
	comment_text text NOT NULL,
	comment_text_render TEXT NULL DEFAULT NULL,
	comment_anonymous BOOLEAN NOT NULL DEFAULT 0,
	PRIMARY KEY(comment_id),
	FOREIGN KEY(post_id) REFERENCES vol_bbpost(post_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(entity_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(post_id,comment_display_num)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
	
CREATE TABLE IF NOT EXISTS vol_bbread (
	post_id INT UNSIGNED NOT NULL,
	entity_id INT UNSIGNED NOT NULL,
	bbread_date_checked DATETIME NOT NULL,
	FOREIGN KEY(post_id) REFERENCES vol_bbpost(post_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(entity_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(entity_id,post_id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

-- Simple view bridging BB post data.
CREATE OR REPLACE VIEW volv_board AS
	SELECT b.board_id,b.board_number,b.board_anonymous,b.group_id,g.group_objid,g.group_name,CONCAT(IF(g.group_abbr IS NULL,'',g.group_abbr),b.board_number) as board_alias,e.entity_name AS board_name,l1.lock_definition AS board_read_lock,l2.lock_definition AS board_post_lock,l3.lock_definition AS board_admin_lock,b.board_mandatory
	FROM vol_board AS b LEFT JOIN vol_entity AS e ON b.board_id=e.entity_id LEFT JOIN volv_group AS g ON b.group_id=g.group_id LEFT JOIN volv_lock AS l1 ON l1.entity_id=b.board_id AND l1.lock_name="READ" LEFT JOIN volv_lock AS l2 ON l2.entity_id=b.board_id AND l2.lock_name="POST" LEFT JOIN volv_lock AS l3 ON l3.entity_id=b.board_id AND l3.lock_name="ADMIN"
	ORDER BY g.group_abbr,b.board_number;

CREATE OR REPLACE VIEW volv_bbcomment AS 
	SELECT c.comment_id,c.post_id,c.comment_display_num,c.comment_date_created,UNIX_TIMESTAMP(c.comment_date_created) as comment_date_created_secs,c.comment_date_modified,UNIX_TIMESTAMP(c.comment_date_modified) AS comment_date_modified_secs,c.comment_text,c.comment_anonymous,e.entity_id,e.entity_name,e.entity_objid,e.entity_type
	FROM vol_bbcomment AS c LEFT JOIN vol_entity AS e ON c.entity_id=e.entity_id
	ORDER BY c.post_id ASC,c.comment_display_num ASC;
	
CREATE OR REPLACE VIEW volv_bbcomment_stats AS
	SELECT c.post_id,GREATEST(c.comment_date_created,c.comment_date_modified) AS latest_comment_activity,UNIX_TIMESTAMP(GREATEST(c.comment_date_created,c.comment_date_modified)) AS latest_comment_activity_secs,count(c.comment_id) AS comment_count
	FROM volv_bbcomment AS c GROUP BY c.post_id;
	
CREATE OR REPLACE VIEW volv_bbpost AS 
	SELECT p.post_id,p.board_id,p.post_display_num,p.post_date_created,UNIX_TIMESTAMP(p.post_date_created) AS post_date_created_secs,p.post_date_modified,UNIX_TIMESTAMP(p.post_date_modified) AS post_date_modified_secs,p.post_date_commented,UNIX_TIMESTAMP(p.post_date_commented) AS post_date_commented_secs,GREATEST(p.post_date_created,p.post_date_modified,p.post_date_commented) AS post_unread_check,UNIX_TIMESTAMP(GREATEST(p.post_date_created,p.post_date_modified,p.post_date_commented)) AS post_unread_check_secs,p.post_text,p.post_title,p.post_anonymous,e.entity_id,e.entity_name,e.entity_objid,e.entity_type,c.comment_count
	FROM vol_bbpost AS p LEFT JOIN vol_entity AS e ON p.entity_id=e.entity_id
	LEFT JOIN volv_bbcomment_stats AS c ON c.post_id=p.post_id
	ORDER BY p.board_id ASC,p.post_display_num ASC;
	
CREATE OR REPLACE VIEW volv_bb_stats AS 
	SELECT p.board_id,COUNT(post_id) AS post_count,MAX(p.post_display_num)+1 AS next_post_number,MAX(p.post_date_created) AS latest_post_date,UNIX_TIMESTAMP(MAX(p.post_date_created)) AS latest_post_date_secs FROM volv_bbpost AS p
	GROUP BY p.board_id;
	
CREATE OR REPLACE VIEW volv_bb_list AS
	SELECT b.*,bs.next_post_number,bs.latest_post_date,bs.latest_post_date_secs,bs.post_count
	FROM volv_board AS b LEFT JOIN volv_bb_stats AS bs ON b.board_id=bs.board_id
	ORDER BY group_name,board_number;

DROP PROCEDURE IF EXISTS volp_board;
DELIMITER $$
CREATE PROCEDURE volp_board(IN in_board_name VARCHAR(255),IN in_display_number MEDIUMINT UNSIGNED,IN in_group_objid VARCHAR(30))
	BEGIN
		DECLARE found_board_id,found_group_id INT UNSIGNED;
		SELECT group_id INTO found_group_id FROM volv_group WHERE group_objid=in_group_objid;
		IF found_group_id IS NULL THEN
			SET found_group_id=NULL;
		END IF;
		INSERT INTO vol_entity (entity_name,entity_type) VALUES (in_board_name,4);
		SET found_board_id=LAST_INSERT_ID();
		INSERT INTO vol_board (board_id,board_number,group_id) VALUES (found_board_id,in_display_number,found_group_id);
		SELECT found_board_id;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_bbpost;
DELIMITER $$
CREATE PROCEDURE volp_bbpost(IN in_author_id INT UNSIGNED,IN in_board_id INT UNSIGNED,IN in_post_title VARCHAR(80),IN in_post_text TEXT,IN in_post_anonymous BOOLEAN,IN in_account_id INT UNSIGNED)
	BEGIN
		DECLARE new_post_timestamp DATETIME DEFAULT UTC_TIMESTAMP();
		DECLARE new_post_id,new_post_number INT UNSIGNED;
		SELECT next_post_number INTO new_post_number FROM volv_bb_stats WHERE board_id=in_board_id;
		IF new_post_number IS NULL THEN
				SET new_post_number=1;
		END IF;
		INSERT INTO vol_bbpost (board_id,post_display_num,entity_id,post_date_created,post_date_modified,post_date_commented,post_title,post_text,post_anonymous) VALUES (in_board_id,new_post_number,in_author_id,new_post_timestamp,new_post_timestamp,new_post_timestamp,in_post_title,in_post_text,in_post_anonymous);
		SET new_post_id=LAST_INSERT_ID();
		INSERT INTO vol_bbread (post_id,entity_id,bbread_date_checked) VALUES (new_post_id,in_account_id,new_post_timestamp);
		SELECT new_post_id,new_post_number;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_bbcomment;
DELIMITER $$
CREATE PROCEDURE volp_bbcomment(IN in_author_id INT UNSIGNED,IN in_post_id INT UNSIGNED,IN in_comment_text TEXT,IN in_comment_anonymous BOOLEAN,IN in_account_id INT UNSIGNED)
	BEGIN
		DECLARE new_comment_timestamp DATETIME DEFAULT UTC_TIMESTAMP();
		DECLARE new_comment_id,new_comment_number INT UNSIGNED;
    SELECT MAX(comment_display_num)+1 INTO new_comment_number FROM vol_bbcomment WHERE post_id=in_post_id;
    IF new_comment_number IS NULL THEN
        SET new_comment_number=1;
    END IF;
		INSERT INTO vol_bbcomment (post_id,comment_display_num,entity_id,comment_date_created,comment_date_modified,comment_text,comment_anonymous) VALUES (in_post_id,new_comment_number,in_author_id,new_comment_timestamp,new_comment_timestamp,in_comment_text,in_comment_anonymous);
		SET new_comment_id=LAST_INSERT_ID();
		INSERT INTO vol_bbread (post_id,entity_id,bbread_date_checked) VALUES (in_post_id,in_account_id,new_comment_timestamp) ON DUPLICATE KEY UPDATE bbread_date_checked=VALUES(bbread_date_checked);
		SELECT new_comment_id,new_comment_number;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_bbcatchup;
DELIMITER $$
CREATE PROCEDURE volp_bbcatchup(IN in_entity_id INT UNSIGNED,IN in_board_id INT UNSIGNED)
	BEGIN
	DECLARE new_timestamp DATETIME DEFAULT UTC_TIMESTAMP();
	INSERT INTO vol_bbread (post_id,entity_id,bbread_date_checked) SELECT post_id,in_entity_id,new_timestamp FROM vol_bbpost WHERE board_id=in_board_id ON DUPLICATE KEY UPDATE bbread_date_checked=new_timestamp;
  SELECT in_board_id;
	END $$
DELIMITER ;

-- SQL SCHEMA for the Help System
CREATE TABLE IF NOT EXISTS vol_help_category (
	help_category_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	help_category_type TINYINT UNSIGNED NOT NULL DEFAULT 0,
	help_category_name VARCHAR(255) NOT NULL,
	PRIMARY KEY(help_category_id),
	UNIQUE(help_category_type,help_category_name)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_help_file (
	help_file_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	help_category_id MEDIUMINT UNSIGNED NOT NULL,
	help_file_name VARCHAR(255) NOT NULL,
	help_file_date_created DATETIME NOT NULL,
	help_file_date_modified DATETIME NOT NULL,           
	help_file_text TEXT NULL,
	help_file_plaintext TEXT NULL,
	help_file_squished TEXT NULL,
	help_file_text_render TEXT NULL,
	help_file_dbattr BOOLEAN NULL,
	help_file_parent_id MEDIUMINT UNSIGNED NULL,
	PRIMARY KEY(help_file_id),
	FOREIGN KEY(help_category_id) REFERENCES vol_help_category(help_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(help_category_id,help_file_name,help_file_parent_id)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
 
CREATE TABLE IF NOT EXISTS vol_help_read (
	help_file_id MEDIUMINT UNSIGNED NOT NULL,
	character_id INT UNSIGNED NOT NULL,
	help_read_date_checked DATETIME NOT NULL,
	FOREIGN KEY(help_file_id) REFERENCES vol_help_file(help_file_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(help_file_id,character_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_sub_files AS
	SELECT help_file_parent_id AS help_file_id,COUNT(help_file_id) AS sub_file_count
	FROM vol_help_file
	WHERE help_file_parent_id IS NOT NULL
	GROUP BY help_file_parent_id;

CREATE OR REPLACE VIEW volv_help_file AS
	SELECT h.help_file_id,h.help_category_id,h.help_file_name,h.help_file_date_created,UNIX_TIMESTAMP(h.help_file_date_created) AS help_file_date_created_secs,h.help_file_date_modified,UNIX_TIMESTAMP(h.help_file_date_modified) AS help_file_date_modified_secs,h.help_file_text,h.help_file_squished,h.help_file_dbattr,h.help_file_parent_id,c.help_category_type,c.help_category_name
	FROM vol_help_file AS h LEFT JOIN vol_help_category AS c on h.help_category_id=c.help_category_id
	ORDER BY c.help_category_name,h.help_file_name;

CREATE OR REPLACE VIEW volv_help_file_load AS
	SELECT f.help_file_id,f.help_file_name,f.help_category_name,f.help_file_dbattr,f.help_file_text,s.sub_file_count
	FROM volv_help_file AS f LEFT JOIN volv_sub_files AS s ON f.help_file_id=s.help_file_id;
	
CREATE OR REPLACE VIEW volv_help_pile AS
	SELECT help_category_id,COUNT(help_file_id) AS help_count
	FROM vol_help_file
	GROUP BY help_category_id;
	
CREATE OR REPLACE VIEW volv_help_category AS
	SELECT *
	FROM vol_help_category NATURAL JOIN volv_help_pile;

-- Stored Procedures for the Help System
DROP PROCEDURE IF EXISTS volp_help_category;
DELIMITER $$
CREATE PROCEDURE volp_help_category(IN in_help_category_type TINYINT UNSIGNED,IN in_help_category_name VARCHAR(255))
	BEGIN
	DECLARE found_category_id MEDIUMINT UNSIGNED;
	SELECT help_category_id INTO found_category_id FROM vol_help_category WHERE help_category_type=in_help_category_type AND help_category_name=in_help_category_name;
	IF found_category_id IS NULL THEN
		INSERT INTO vol_help_category(help_category_type,help_category_name) VALUES (in_help_category_type,in_help_category_name);
		SET found_category_id=LAST_INSERT_ID();
	ELSE
		UPDATE vol_help_category SET help_category_name=in_help_category_name WHERE help_category_id=found_category_id;
	END IF;
	SELECT found_category_id;
	END $$
DELIMITER ;
	
DROP PROCEDURE IF EXISTS volp_help_file;
DELIMITER $$
CREATE PROCEDURE volp_help_file(IN in_help_category_id MEDIUMINT UNSIGNED,IN in_help_file_name VARCHAR(255))
	BEGIN
	DECLARE found_file_id MEDIUMINT UNSIGNED;
	SELECT help_file_id INTO found_file_id FROM volv_help_file WHERE help_category_id=in_help_category_id AND help_file_name=in_help_file_name;
	IF found_file_id IS NULL THEN
		INSERT INTO vol_help_file(help_category_id,help_file_name,help_file_date_created,help_file_date_modified) VALUES (in_help_category_id,in_help_file_name,UTC_TIMESTAMP(),UTC_TIMESTAMP());
		SET found_file_id=LAST_INSERT_ID();
	ELSE
		UPDATE vol_help_file SET help_file_name=in_help_file_name,help_file_date_modified=UTC_TIMESTAMP() WHERE help_file_id=found_file_id;
	END IF;
	SELECT found_file_id;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS volp_help_sub;
DELIMITER $$
CREATE PROCEDURE volp_help_sub(IN in_parent_id MEDIUMINT UNSIGNED,IN in_help_file_name VARCHAR(255))
	BEGIN
	DECLARE found_file_id MEDIUMINT UNSIGNED;
	DECLARE found_category_id MEDIUMINT UNSIGNED;
	SELECT help_file_id INTO found_file_id FROM volv_help_file WHERE help_file_parent_id=in_parent_id AND help_file_name=in_help_file_name;
		SELECT help_category_id INTO found_category_id FROM volv_help_file WHERE help_file_id=in_parent_id;
	IF found_file_id IS NULL THEN
		INSERT INTO vol_help_file(help_category_id,help_file_name,help_file_date_created,help_file_date_modified,help_file_parent_id) VALUES (found_category_id,in_help_file_name,UTC_TIMESTAMP(),UTC_TIMESTAMP(),in_parent_id);
		SET found_file_id=LAST_INSERT_ID();
	ELSE
		UPDATE vol_help_file SET help_file_name=in_help_file_name,help_file_date_modified=UTC_TIMESTAMP() WHERE help_file_id=found_file_id;
	END IF;
	SELECT found_file_id;
	END $$
DELIMITER ;

-- SQL Schema for Pot, Radio, Group Channels, and normal Channels.
-- source_objid is the Mogrifier for Channels, the Group object for Groups, the Room for Pot.
-- message_type = 0 for Pot, 1 for Group IC, 2 for Group OOC, 3 for Radio, 4 for channels.
CREATE TABLE IF NOT EXISTS vol_messages (
	message_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	message_date_created DATETIME NOT NULL,
	message_type INT UNSIGNED NOT NULL DEFAULT 0,
	message_emit BOOLEAN NOT NULL DEFAULT 0,
	source_objid VARCHAR(40) NOT NULL,
	source_vr VARCHAR(20) NULL,
	source_name VARCHAR(100) NOT NULL,
	speaker_objid VARCHAR(30) NOT NULL,
	speaker_name VARCHAR(100) NOT NULL,
	speaker_title VARCHAR(255) NULL DEFAULT NULL,
	speaker_codename VARCHAR(255) NULL DEFAULT NULL,
	message_contents TEXT,
	message_contents_render TEXT NULL DEFAULT NULL,
	message_summary TEXT NULL,
	message_summary_render TEXT NULL,
	PRIMARY KEY(message_id),
	INDEX(source_objid,message_type,message_date_created)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;


-- SQL SCHEMA FOR THE SCENE SYSTEM
CREATE TABLE IF NOT EXISTS vol_plot (
	plot_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	plot_title VARCHAR(255) UNIQUE,
	plot_pitch TEXT,
	plot_pitch_render TEXT NULL,
	plot_outcome TEXT NULL,
	plot_outcome_render TEXT NULL,
	plot_date_start DATETIME NULL DEFAULT NULL,
	plot_date_end DATETIME NULL DEFAULT NULL,
	INDEX(plot_date_start, plot_date_end),
	INDEX(plot_title),
	PRIMARY KEY(plot_id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_runner (
	runner_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	character_id INT UNSIGNED NOT NULL,
	plot_id INT UNSIGNED NOT NULL,
	runner_type TINYINT UNSIGNED DEFAULT 0,
	PRIMARY KEY(runner_id),
	UNIQUE(character_id,plot_id),
	FOREIGN KEY(plot_id) REFERENCES vol_plot(plot_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_runner AS
	SELECT r.runner_id,r.plot_id,r.runner_type,c.* FROM vol_runner as r LEFT JOIN volv_character AS c ON c.character_id=r.character_id;
	
CREATE OR REPLACE VIEW volv_plot AS
	SELECT p.plot_id,p.plot_title,p.plot_pitch,p.plot_outcome,p.plot_date_start,UNIX_TIMESTAMP(p.plot_date_start) AS plot_date_start_secs,p.plot_date_end,UNIX_TIMESTAMP(p.plot_date_end) AS plot_date_end_secs,r.character_id AS owner_id,r.character_objid AS owner_objid,r.character_name AS owner_name FROM vol_plot AS p LEFT JOIN volv_runner AS r ON r.plot_id=p.plot_id AND r.runner_type=2 ORDER BY p.plot_id;
	
CREATE OR REPLACE VIEW volv_corunners AS
	SELECT plot_id,GROUP_CONCAT(character_objid ORDER BY character_name SEPARATOR ' ') AS corunner_objids,GROUP_CONCAT(character_name ORDER BY character_name SEPARATOR '|') AS corunner_names FROM volv_runner WHERE runner_type=2 GROUP BY plot_id;
	
CREATE OR REPLACE VIEW volv_plot_agg AS
	SELECT p.*,r.corunner_objids,r.corunner_names FROM volv_plot AS p LEFT JOIn volv_corunners AS r ON p.plot_id=r.plot_id;
	
CREATE TABLE IF NOT EXISTS vol_scene (
	scene_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	scene_title VARCHAR(255),
	scene_pitch TEXT NULL,
	scene_outcome TEXT NULL,
	post_id INT UNSIGNED NULL,
	scene_date_created DATETIME,
	scene_date_scheduled DATETIME NULL,
	scene_date_started DATETIME NULL,
	scene_date_finished DATETIME NULL,
	scene_status TINYINT DEFAULT 0,
	scene_log_ooc BOOL NOT NULL DEFAULT FALSE,
	PRIMARY KEY(scene_id),
	FOREIGN KEY(post_id) REFERENCES vol_bbpost(post_id) ON UPDATE CASCADE ON DELETE CASCADE,
	INDEX(scene_date_scheduled,scene_status),
	INDEX(scene_id,scene_title,scene_status)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
	
CREATE TABLE IF NOT EXISTS vol_actor (
	actor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	scene_id INT UNSIGNED NOT NULL,
	character_id INT UNSIGNED NOT NULL,
	actor_type TINYINT UNSIGNED NOT NULL DEFAULT 0,
	actor_status TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(actor_id),
	UNIQUE(scene_id,character_id),
	INDEX(scene_id,character_id,actor_type),
	FOREIGN KEY(scene_id) REFERENCES vol_scene(scene_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

DROP PROCEDURE IF EXISTS volp_actor;
DELIMITER $$
CREATE PROCEDURE volp_actor(IN in_character_id INT UNSIGNED,IN in_scene_id INT UNSIGNED)
	BEGIN
		DECLARE found_actor_id INT UNSIGNED;
		SELECT actor_id INTO found_actor_id FROM volv_actor WHERE character_id=in_character_id AND scene_id=in_scene_id;
		IF found_actor_id IS NULL THEN
			INSERT INTO vol_actor(character_id,scene_id) VALUES (in_character_id,in_scene_id);
			SET found_actor_id=LAST_INSERT_ID();
		END IF;
		SELECT found_actor_id;
	END $$
DELIMITER ;

CREATE OR REPLACE VIEW volv_actor AS
	SELECT a.scene_id,a.actor_id,c.character_id,c.character_name,c.character_objid,a.actor_type,a.actor_status FROM vol_actor AS a LEFT JOIN volv_character AS c ON c.character_id=a.character_id;

CREATE OR REPLACE VIEW volv_scene AS
	SELECT s.scene_id,s.scene_title,s.scene_pitch,s.scene_outcome,s.post_id,s.scene_date_created,UNIX_TIMESTAMP(s.scene_date_created) AS scene_date_created_secs,s.scene_date_scheduled,UNIX_TIMESTAMP(s.scene_date_scheduled) AS scene_date_scheduled_secs,s.scene_date_started,UNIX_TIMESTAMP(s.scene_date_started) AS scene_date_started_secs,s.scene_date_finished,UNIX_TIMESTAMP(s.scene_date_finished) AS scene_date_finished_secs,s.scene_status,s.scene_log_ooc,a.character_id AS runner_id,a.character_name AS runner_name,a.character_objid AS runner_objid
	FROM vol_scene AS s LEFT JOIN volv_actor AS a ON s.scene_id=a.scene_id AND a.actor_type=2
	ORDER BY s.scene_id;
	
CREATE TABLE IF NOT EXISTS vol_action_source (
	source_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	scene_id INT UNSIGNED NOT NULL,
	source_objid VARCHAR(30) NOT NULL,
	source_vr VARCHAR(15) NULL,
	source_name VARCHAR(60) NOT NULL,
	source_type TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(source_id),
	FOREIGN KEY(scene_id) REFERENCES vol_scene(scene_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(scene_id, source_objid, source_vr, source_type)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_action (
	action_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	actor_id INT UNSIGNED NOT NULL,
	source_id INT UNSIGNED NOT NULL,
	action_is_deleted BOOL NOT NULL DEFAULT FALSE,
	action_type TINYINT UNSIGNED DEFAULT 0,
	action_date_created DATETIME NOT NULL,
	action_text TEXT NOT NULL,
	action_text_render TEXT NULL,
	PRIMARY KEY(action_id),
	INDEX(actor_id, action_is_deleted),
	FOREIGN KEY(actor_id) REFERENCES vol_actor(actor_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(source_id) REFERENCES vol_action_source(source_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_action AS
	SELECT a.action_id,ac.actor_id,ac.scene_id,ac.character_id,ac.character_name,ac.character_objid,ac.actor_type,a.source_id,sc.source_objid,sc.source_vr,sc.source_name,sc.source_type,a.action_type,a.action_date_created,UNIX_TIMESTAMP(a.action_date_created) AS action_date_created_secs,a.action_is_deleted,a.action_text
	FROM vol_action AS a LEFT JOIN volv_actor AS ac ON a.actor_id=ac.actor_id LEFT JOIN vol_action_source AS sc ON a.source_id=sc.source_id
	ORDER BY ac.scene_id,a.action_date_created;

CREATE OR REPLACE VIEW volv_action_agg AS
	SELECT actor_id,COUNT(action_id) AS action_count,MAX(action_date_created) AS action_latest FROM volv_action WHERE action_is_deleted=0 GROUP BY actor_id;
	
CREATE OR REPLACE VIEW volv_actor_agg AS
	SELECT a.*,ag.action_count,ag.action_latest,UNIX_TIMESTAMP(ag.action_latest) AS action_latest_secs from volv_actor AS a LEFT JOIN volv_action_agg AS ag ON a.actor_id=ag.actor_id;
	
CREATE OR REPLACE VIEW volv_scene_stats AS
	SELECT scene_id,SUM(action_count) AS action_count,MAX(action_latest) AS action_latest,UNIX_TIMESTAMP(MAX(action_latest)) AS action_latest_secs FROM volv_actor_agg GROUP BY scene_id;

CREATE OR REPLACE VIEW volv_scene_final AS
	SELECT s.*,st.action_count,st.action_latest,st.action_latest_secs FROM volv_scene AS s LEFT JOIN volv_scene_stats AS st ON s.scene_id=st.scene_id;
	
CREATE TABLE IF NOT EXISTS vol_plotlink (
	plot_id INT UNSIGNED NOT NULL,
	scene_id INT UNSIGNED NOT NULL,
	PRIMARY KEY(plot_id,scene_id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
	
CREATE OR REPLACE VIEW volv_plotlink AS
	SELECT p.*,s.* FROM vol_plotlink AS pl LEFT JOIN volv_scene AS s ON s.scene_id=pl.scene_id LEFT JOIN volv_plot AS p ON p.plot_id=pl.plot_id
	ORDER BY p.plot_id,s.scene_id;

CREATE TABLE IF NOT EXISTS vol_scene_partner (
  scene_id INT UNSIGNED NOT NULL,
  partner_slot TINYINT UNSIGNED NOT NULL DEFAULT 0,
  character_id INT UNSIGNED NOT NULL,
  FOREIGN KEY(scene_id) REFERENCES vol_scene(scene_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(character_id) REFERENCES vol_character(character_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE(scene_id,character_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_scene_partner AS
  SELECT p.scene_id,p.partner_slot,c.character_id,c.character_name,c.character_objid FROM vol_scene_partner AS p LEFT JOIN volv_character AS c ON c.character_id=p.character_id ORDER BY p.scene_id,p.partner_slot;

CREATE OR REPLACE VIEW volv_scene_partner_agg AS
  SELECT scene_id,partner_slot,GROUP_CONCAT(character_objid ORDER BY character_name) AS character_objids
  FROM volv_scene_partner GROUP BY scene_id,partner_slot;

-- SQL Schema for the Csys Core 
CREATE TABLE IF NOT EXISTS vol_centity (
	centity_id INT UNSIGNED NOT NULL,
	centity_date_created DATETIME,
	centity_version TINYINT UNSIGNED NOT NULL DEFAULT 0,
	centity_type TINYINT UNSIGNED NOT NULL DEFAULT 0,
	centity_is_deleted BOOL NOT NULL DEFAULT FALSE,
	PRIMARY KEY(centity_id),
	FOREIGN KEY(centity_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	INDEX(centity_version,centity_type,centity_is_deleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_ctrait (
	centity_id INT UNSIGNED NOT NULL,
	trait_id TINYINT UNSIGNED NOT NULL DEFAULT 0,
	trait_type TINYINT UNSIGNED NOT NULL DEFAULT 0,
	trait_value INT SIGNED NOT NULL DEFAULT 0,
	FOREIGN KEY(centity_id) REFERENCES vol_centity(centity_id) ON DELETE CASCADE ON UPDATE CASCADE,
	UNIQUE(centity_id,trait_type,trait_id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_clink (
	clink_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	clink_display_num MEDIUMINT UNSIGNED NOT NULL,
	character_id INT UNSIGNED NOT NULL,
	centity_id INT UNSIGNED NOT NULL,
	clink_approved BOOL NOT NULL DEFAULT FALSE,
	clink_parent MEDIUMINT UNSIGNED NULL,
	PRIMARY KEY(clink_id),
	FOREIGN KEY(centity_id) REFERENCES vol_centity(centity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(clink_parent) REFERENCES vol_clink(clink_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(character_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	INDEX(character_id,clink_display_num,centity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_carmory (
	carmory_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	centity_id INT UNSIGNED NULL,
	clink_id MEDIUMINT UNSIGNED NULL,
	PRIMARY KEY(carmory_id),
	FOREIGN KEY(centity_id) REFERENCES vol_centity(centity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(clink_id) REFERENCES vol_clink(clink_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_cattack (
	cattack_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	carmory_id MEDIUMINT UNSIGNED NOT NULL,
	cattack_name VARCHAR(100) NOT NULL,
	PRIMARY KEY(cattack_id),
	FOREIGN KEY(carmory_id) REFERENCES vol_carmory(carmory_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(carmory_id,cattack_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_cattack_parameter (
	cattack_id MEDIUMINT UNSIGNED NOT NULL,
	cparameter_type TINYINT UNSIGNED NOT NULL,
	cparameter_id TINYINT UNSIGNED NOT NULL,
	cparameter_value SMALLINT SIGNED NOT NULL DEFAULT 0,
	UNIQUE(cattack_id,cparameter_type,cparameter_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;