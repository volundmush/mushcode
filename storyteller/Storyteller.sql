CREATE TABLE IF NOT EXISTS vol_story_templates (
	template_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	template_name VARCHAR(30) NOT NULL,
	template_x_name VARCHAR(30) NULL,
	template_y_name VARCHAR(30) NULL,
	template_z_name VARCHAR(30) NULL,
	template_playable TINYINT UNSIGNED NOT NULL DEFAULT 1,
	template_sort TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(template_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

/*
Template Ids over 100 are reserved for System use. They aren't Playable Templates.
*/

CREATE TABLE IF NOT EXISTS vol_story_x_splats (
	x_splat_id INT UNSIGNED NOT NULL,
	template_id TINYINT UNSIGNED NOT NULL,
	x_splat_name VARCHAR(30),
	PRIMARY KEY(x_splat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_story_y_splats (
	y_splat_id INT UNSIGNED NOT NULL,
	template_id TINYINT UNSIGNED NOT NULL,
	y_splat_name VARCHAR(30),
	PRIMARY KEY(y_splat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_story_z_splats (
	z_splat_id TINYINT UNSIGNED NOT NULL,
	template_id TINYINT UNSIGNED NOT NULL,
	z_splat_name VARCHAR(30),
	PRIMARY KEY(z_splat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_story_personas (
	persona_id INT UNSIGNED NOT NULL,
	template_id TINYINT UNSIGNED NOT NULL DEFAULT 1,
	persona_parent INT UNSIGNED NULL,
	x_splat_id TINYINT UNSIGNED NULL,
	y_splat_id TINYINT UNSIGNED NULL,
	z_splat_id TINYINT UNSIGNED NULL,
	PRIMARY KEY(persona_id),
	FOREIGN KEY(persona_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(template_id) REFERENCES vol_story_templates(template_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(persona_parent) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_personas AS
	SELECT p.persona_id,e.character_name as persona_name,e.character_objid as persona_objid,p.persona_parent,p.template_id,t.template_name,t.template_x_name,p.x_splat_id,x.x_splat_name,t.template_y_name,p.y_splat_id,y.y_splat_name,t.template_z_name,p.z_splat_id,z.z_splat_name,t.template_sort,e.character_is_deleted,e.character_is_approved,e.character_date_approved,e.character_date_approved_secs FROM vol_story_personas AS p LEFT JOIN volv_character AS e ON e.character_id=p.persona_id LEFT JOIN vol_story_templates AS t ON p.template_id=t.template_id LEFT JOIN vol_story_x_splats AS x ON p.x_splat_id=x.x_splat_id LEFT JOIN vol_story_y_splats AS y ON p.y_splat_id=y.y_splat_id LEFT JOIN vol_story_z_splats AS z ON p.z_splat_id=z.z_splat_id;

CREATE OR REPLACE VIEW volv_story_personas_template_census AS
	SELECT template_id,template_name,template_sort,GROUP_CONCAT(persona_name ORDER BY persona_name SEPARATOR '|') AS persona_names,GROUP_CONCAT(persona_id ORDER BY persona_name SEPARATOR '|') AS persona_ids,GROUP_CONCAT(CONCAT_WS('/',persona_id,persona_name) ORDER BY persona_name SEPARATOR '|') AS persona_combo FROM volv_story_personas WHERE character_is_approved=1 AND character_is_deleted=0 GROUP BY template_id ORDER BY template_sort;

CREATE OR REPLACE VIEW volv_story_personas_template_census_x AS
	SELECT template_id,template_name,template_sort,template_x_name,x_splat_id,x_splat_name,GROUP_CONCAT(persona_name ORDER BY persona_name SEPARATOR '|') AS persona_names,GROUP_CONCAT(persona_id ORDER BY persona_name SEPARATOR '|') AS persona_ids,GROUP_CONCAT(CONCAT_WS('/',persona_id,persona_name) ORDER BY persona_name SEPARATOR '|') AS persona_combo FROM volv_story_personas WHERE character_is_approved=1 AND character_is_deleted=0 GROUP BY template_id,x_splat_id ORDER BY template_sort,x_splat_id;

CREATE TABLE IF NOT EXISTS vol_story_fields (
	field_id TINYINT UNSIGNED NOT NULL,
	template_id TINYINT UNSIGNED NOT NULL,
	field_name VARCHAR(20) NOT NULL UNIQUE,
	PRIMARY KEY(field_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_story_persona_field (
	persona_id INT UNSIGNED NOT NULL,
	field_id TINYINT UNSIGNED NOT NULL,
	field_answer VARCHAR(40),
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(persona_id,field_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_persona_field AS
	SELECT p.persona_id,p.field_id,f.field_name,p.field_answer FROM vol_story_persona_field AS p LEFT JOIN vol_story_fields AS f ON p.field_id=f.field_id;

CREATE TABLE IF NOT EXISTS vol_story_stats_categories (
	stat_category_id TINYINT UNSIGNED NOT NULL,
	stat_category_name VARCHAR(20) UNIQUE,
	stat_category_custom TINYINT UNSIGNED NOT NULL DEFAULT 0,
	stat_category_specialties TINYINT UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_story_stats (
	stat_category_id TINYINT UNSIGNED NOT NULL,
	stat_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	stat_sort INT UNSIGNED NOT NULL DEFAULT 0,
	stat_name VARCHAR(40) UNIQUE,
	PRIMARY KEY(stat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1000000;

CREATE OR REPLACE VIEW volv_story_stats AS
	SELECT s.stat_id,s.stat_name,s.stat_sort,s.stat_category_id,c.stat_category_name,c.stat_category_custom,c.stat_category_specialties FROM vol_story_stats AS s LEFT JOIN vol_story_stats_categories AS c ON s.stat_category_id=c.stat_category_id;

CREATE TABLE IF NOT EXISTS vol_story_persona_stats (
	persona_stat_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	persona_id INT UNSIGNED NOT NULL,
	stat_id INT UNSIGNED NOT NULL,
	stat_value TINYINT UNSIGNED NOT NULL DEFAULT 0,
	stat_flags_1 TINYINT UNSIGNED NOT NULL DEFAULT 0,
	stat_flags_2 TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(persona_stat_id),
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(persona_id,stat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_persona_stats AS
	SELECT p.persona_stat_id,p.persona_id,s.*,p.stat_value,p.stat_flags_1,p.stat_flags_2 FROM vol_story_persona_stats AS p LEFT JOIN volv_story_stats AS s ON p.stat_id=s.stat_id;

CREATE TABLE IF NOT EXISTS vol_story_persona_stats_specialties (
	persona_specialty_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	persona_id INT UNSIGNED NOT NULL,
	stat_id INT UNSIGNED NOT NULL,
	specialty_name VARCHAR(80),
	specialty_value TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(persona_specialty_id),
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(persona_id,stat_id,specialty_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_persona_stats_specialties AS
	SELECT sp.specialty_name,sp.specialty_value,sp.persona_id,sp.persona_specialty_id,s.* FROM vol_story_persona_stats_specialties AS sp LEFT JOIN volv_story_stats AS s ON sp.stat_id=s.stat_id;

CREATE TABLE IF NOT EXISTS vol_story_merit_categories (
	merit_category_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	merit_category_name VARCHAR(80) UNIQUE,
	merit_category_custom INT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(merit_category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_story_merits (
	merit_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	merit_category_id INT UNSIGNED NOT NULL,
	merit_name VARCHAR(80),
	merit_require_context TINYINT UNSIGNED NOT NULL DEFAULT 1,
	PRIMARY KEY(merit_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1000000;

CREATE OR REPLACE VIEW volv_story_merits AS
	SELECT m.merit_category_id,c.merit_category_name,c.merit_category_custom,m.merit_id,m.merit_name FROM vol_story_merits AS m LEFT JOIN vol_story_merit_categories AS c ON m.merit_category_id=c.merit_category_id;

CREATE TABLE IF NOT EXISTS vol_story_persona_merits (
	persona_merit_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	persona_id INT UNSIGNED NOT NULL,
	merit_id INT UNSIGNED NOT NULL,
	merit_context VARCHAR(255) NULL,
	merit_description TEXT NULL,
	merit_notes TEXT NULL,
	merit_value TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(persona_merit_id),
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON DELETE CASCADE ON UPDATE CASCADE,
	UNIQUE(persona_id,merit_id,merit_context)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_persona_merits AS
	SELECT p.persona_merit_id,p.persona_id,m.*,p.merit_context,p.merit_description,p.merit_notes,p.merit_value FROM vol_story_persona_merits AS p LEFT JOIN volv_story_merits AS m ON p.merit_id=m.merit_id;

CREATE TABLE IF NOT EXISTS vol_story_persona_merits_wordpowers (
	persona_merit_wordpower_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	persona_merit_id INT UNSIGNED NOT NULL,
	merit_wordpower_name VARCHAR(255) NOT NULL,
	merit_wordpower_purchases TINYINT UNSIGNED NOT NULL DEFAULT 1,
	merit_wordpower_flags_1 TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(persona_merit_wordpower_id),
	UNIQUE(persona_merit_id,merit_wordpower_name)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
	
CREATE OR REPLACE VIEW volv_story_persona_merits_wordpowers AS
	SELECT p.persona_merit_wordpower_id,m.*,p.merit_wordpower_name,p.merit_wordpower_purchases,p.merit_wordpower_flags_1 FROM vol_story_persona_merits_wordpowers AS p LEFT JOIN volv_story_persona_merits AS m ON p.persona_merit_id=m.persona_merit_id;

CREATE OR REPLACE VIEW volv_story_persona_merits_wordpowers_categories AS
	SELECT DISTINCT persona_id,persona_merit_id,merit_name,merit_context FROM volv_story_persona_merits_wordpowers;

CREATE TABLE IF NOT EXISTS vol_story_wordpower (
	wordpower_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	template_id TINYINT UNSIGNED NOT NULL,
	stat_id INT UNSIGNED NOT NULL,
	wordpower_name VARCHAR(80) NOT NULL,
	PRIMARY KEY(wordpower_id),
	UNIQUE(template_id,stat_id,wordpower_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_wordpower AS
	SELECT w.wordpower_id,w.wordpower_name,w.template_id,t.template_name,t.template_sort,w.stat_id,s.stat_name FROM vol_story_wordpower AS w LEFT JOIN vol_story_templates AS t ON w.template_id=t.template_id LEFT JOIN vol_story_stats AS s ON w.stat_id=s.stat_id;

CREATE TABLE IF NOT EXISTS vol_story_persona_wordpower (
	persona_id INT UNSIGNED NOT NULL,
	wordpower_id INT UNSIGNED NOT NULL,
	wordpower_purchases TINYINT UNSIGNED NOT NULL DEFAULT 1,
	wordpower_flags_1 TINYINT UNSIGNED NOT NULL DEFAULT 0,
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON DELETE CASCADE ON UPDATE CASCADE,
	UNIQUE(persona_id,wordpower_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_persona_wordpower AS
	SELECT p.persona_id,w.*,p.wordpower_purchases,p.wordpower_flags_1 FROM vol_story_persona_wordpower AS p LEFT JOIN volv_story_wordpower AS w ON p.wordpower_id=w.wordpower_id;

CREATE OR REPLACE VIEW volv_story_persona_wordpower_templates AS
	SELECT DISTINCT persona_id,template_id,template_name FROM volv_story_persona_wordpower;
	
CREATE OR REPLACE VIEW volv_story_persona_wordpower_stats AS
	SELECT DISTINCT persona_id,template_id,template_name,stat_id,stat_name FROM volv_story_persona_wordpower;
	
CREATE TABLE IF NOT EXISTS vol_story_pools_categories (
	pool_category_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	pool_category_name VARCHAR(20) NOT NULL UNIQUE,
	PRIMARY KEY(pool_category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
	
CREATE TABLE IF NOT EXISTS vol_story_pools (
	pool_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	pool_category_id TINYINT UNSIGNED NOT NULL,
	pool_name VARCHAR(20) NOT NULL UNIQUE,
	pool_unit_name VARCHAR(20) NOT NULL,
	pool_single_name VARCHAR(20) NOT NULL DEFAULT "Point",
	pool_plural_name VARCHAR(20) NOT NULL DEFAULT "Points",
	pool_sort TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(pool_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_pools AS
	SELECT p.*,c.pool_category_name FROM vol_story_pools AS p LEFT JOIN vol_story_pools_categories AS c ON p.pool_category_id=c.pool_category_id ORDER BY p.pool_sort;

CREATE TABLE IF NOT EXISTS vol_story_persona_pools (
	persona_pool_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	persona_id INT UNSIGNED NOT NULL,
	pool_id TINYINT UNSIGNED NOT NULL,
	pool_current INT UNSIGNED NOT NULL DEFAULT 0,
	pool_maximum INT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(persona_pool_id),
	UNIQUE(persona_id,pool_id),
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
	
CREATE OR REPLACE VIEW volv_story_persona_pools AS
	SELECT p.persona_pool_id,p.persona_id,po.*,p.pool_current,p.pool_maximum FROM vol_story_persona_pools AS p LEFT JOIN volv_story_pools AS po ON p.pool_id=po.pool_id ORDER BY po.pool_sort;
	
CREATE TABLE IF NOT EXISTS vol_story_persona_pools_commits (
	persona_commit_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	persona_pool_id INT UNSIGNED NOT NULL,
	commit_name VARCHAR(255) NOT NULL,
	commit_amount INT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(persona_commit_id),
	UNIQUE(persona_pool_id,commit_name),
	FOREIGN KEY(persona_pool_id) REFERENCES vol_story_persona_pools(persona_pool_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_persona_pools_commits AS
	SELECT c.persona_commit_id,p.*,c.commit_name,c.commit_amount FROM vol_story_persona_pools_commits AS c LEFT JOIN volv_story_persona_pools AS p ON c.persona_pool_id=p.persona_pool_id;
	
CREATE TABLE IF NOT EXISTS vol_story_xp (
	xp_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	xp_name VARCHAR(30) UNIQUE,
	xp_sort TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(xp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_story_persona_xp (
	persona_xp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	xp_id TINYINT UNSIGNED NOT NULL,
	persona_id INT UNSIGNED NOT NULL,
	xp_amount DECIMAL(7,3),
	admin_id INT UNSIGNED NOT NULL,
	xp_reason TEXT,
	xp_date DATETIME NOT NULL,
	xp_display_num INT UNSIGNED NOT NULL,
	PRIMARY KEY(persona_xp_id),
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(xp_id) REFERENCES vol_story_xp(xp_id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(xp_id,persona_id,xp_display_num)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_persona_xp AS
	SELECT px.*,UNIX_TIMESTAMP(px.xp_date) AS xp_date_secs,p.persona_name,p.persona_objid,x.xp_name,x.xp_sort,e.entity_name AS admin_name,e.entity_objid AS admin_objid FROM vol_story_persona_xp AS px LEFT JOIN vol_story_xp AS x ON px.xp_id=x.xp_id LEFT JOIN volv_story_personas AS p ON px.persona_id=p.persona_id LEFT JOIN vol_entity AS e ON px.admin_id=e.entity_id ORDER BY x.xp_sort;

CREATE OR REPLACE VIEW volv_story_persona_xp_totals AS
  SELECT x.xp_id,x.xp_name,x.xp_sort,x.persona_id,x.persona_objid,x.persona_name,MAX(IF(x.xp_display_num,x.xp_display_num,1))+1 AS next_display_num,SUM(IF(x.xp_amount>0,x.xp_amount,0)) AS xp_gained,ABS(SUM(IF(x.xp_amount<0,x.xp_amount,0))) AS xp_spent,SUM(x.xp_amount) AS xp_current
  FROM volv_story_persona_xp AS x
  GROUP BY x.xp_id,x.persona_id ORDER BY x.persona_name,x.xp_sort;
  
DROP PROCEDURE IF EXISTS volp_story_xp;
DELIMITER $$
CREATE PROCEDURE volp_story_xp(IN in_persona_id INT UNSIGNED,IN in_xp_id TINYINT UNSIGNED,IN in_xp_amount DECIMAL(7,3),IN in_xp_reason TEXT,IN in_admin_id INT UNSIGNED)
  BEGIN
    DECLARE next_num INT UNSIGNED;
    DECLARE new_persona_xp_id INT UNSIGNED;
    SELECT next_display_num INTO next_num FROM volv_story_persona_xp_totals WHERE persona_id=in_persona_id AND xp_id=in_xp_id;
    IF next_num IS NULL THEN
      SET next_num=1;
    END IF;
    INSERT INTO vol_story_persona_xp(persona_id,xp_id,xp_display_num,xp_amount,admin_id,xp_reason,xp_date) VALUES (in_persona_id,in_xp_id,next_num,in_xp_amount,in_admin_id,in_xp_reason,UTC_TIMESTAMP());
    SET new_persona_xp_id=LAST_INSERT_ID();
    SELECT new_persona_xp_id;
  END $$
DELIMITER ;

CREATE TABLE IF NOT EXISTS vol_story_rec (
	rec_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	source_id INT UNSIGNED NOT NULL,
	persona_id INT UNSIGNED NOT NULL,
	xp_id TINYINT UNSIGNED NOT NULL,
	rec_amount DECIMAL(7,3),
	rec_reason TEXT,
	rec_submit_date DATETIME,
	rec_status TINYINT UNSIGNED NOT NULL DEFAULT 0,
	rec_approve_date DATETIME,
	rec_approve_amount DECIMAL(7,3),
	admin_id INT UNSIGNED NULL,
	persona_xp_id INT UNSIGNED NULL,
	PRIMARY KEY(rec_id),
	FOREIGN KEY(source_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(admin_id) REFERENCES vol_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(xp_id) REFERENCES vol_story_xp(xp_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(persona_xp_id) REFERENCES vol_story_persona_xp(persona_xp_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_story_rec AS
	SELECT r.*,UNIX_TIMESTAMP(r.rec_submit_date) AS rec_submit_date_secs,UNIX_TIMESTAMP(r.rec_approve_date) AS rec_approve_date_secs,s.entity_name AS source_name,s.entity_objid AS source_objid,p.persona_name,p.persona_objid,x.xp_name,x.xp_sort,a.entity_name AS admin_name,a.entity_objid AS admin_objid FROM vol_story_rec AS r LEFT JOIN vol_entity AS s ON s.entity_id=r.source_id LEFT JOIN volv_story_personas AS p ON p.persona_id=r.persona_id LEFT JOIN vol_story_xp AS x ON x.xp_id=r.xp_id LEFT JOIN vol_entity AS a ON a.entity_id=r.admin_id;