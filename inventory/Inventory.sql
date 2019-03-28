CREATE TABLE IF NOT EXISTS vol_inv_category (
    category_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(40) NOT NULL UNIQUE,
    PRIMARY KEY(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_inv_item (
    item_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    item_name VARCHAR(120) NOT NULL,
    item_stackable BOOLEAN NOT NULL DEFAULT 0,
    item_value INT UNSIGNED NOT NULL DEFAULT 0,
    item_weight INT UNSIGNED NOT NULL DEFAULT 0,
    item_strength_req INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY(item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS vol_inv_item_log (
    log_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    item_id INT UNSIGNED NOT NULL,
    log_type TINYINT UNSIGNED NOT NULL DEFAULT 0,
    log_date DATETIME NOT NULL,
    log_text TEXT,
    PRIMARY KEY(log_id),
    FOREIGN KEY(item_id) REFERENCES vol_inv_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX(item_id,log_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

-- LOG TYPES:
-- 0: Created at chargen.
-- 1: Bought
-- 2: Sold
-- 3: Modified
-- 4: Modification removed.

CREATE TABLE IF NOT EXISTS vol_inv_item_category (
    itemcat_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    item_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(itemcat_id),
    FOREIGN KEY(item_id) REFERENCES vol_inv_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(category_id) REFERENCES vol_inv_category(category_id) ON UPDATE CASCADE ON DELETE CASCADE,
    UNIQUE(item_id,category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_inv_item_category_agg AS
    SELECT i.item_id,GROUP_CONCAT(c.category_id ORDER BY c.category_name) AS category_ids,GROUP_CONCAT(c.category_name ORDER BY c.category_name SEPARATOR '|') AS category_names FROM vol_inv_item_category AS i LEFT JOIN vol_inv_category ON i.category_id=c.category_id GROUP BY i.item_id;

CREATE TABLE IF NOT EXISTS vol_inv_persona (
    inv_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    persona_id INT UNSIGNED NOT NULL,
    item_id INT UNSIGNED NOT NULL,
    inv_quantity INT UNSIGNED NOT NULL DEFAULT 1,
    inv_alias VARCHAR(120) NULL,
    PRIMARY KEY(inv_id),
    FOREIGN KEY(persona_id) REFERENCES vol_story_personas(persona_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(item_id) REFERENCES vol_inv_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS volv_inv_persona_mods (
    mod_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    inv_id INT UNSIGNED NOT NULL,
    mod_text TEXT NOT NULL,
    PRIMARY KEY(mod_id),
    FOREIGN KEY(inv_id) REFERENCES vol_inv_persona(inv_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE OR REPLACE VIEW volv_inv_persona AS
    SELECT i.inv_id AS inv_id,i.persona_id AS persona_id,i.item_id AS item_id,i.inv_quantity AS inv_quantity,i.inv_alias AS inv_alias,i2.item_name AS item_name,i2.item_value AS item_value,i2.item_weight AS item_weight,c.category_ids,c.category_names FROM vol_inv_persona AS i LEFT JOIN vol_inv_item AS i2 ON i.item_id=i2.item_id LEFT JOIN volv_inv_item_category_agg ON i.item_id=c.item_id

